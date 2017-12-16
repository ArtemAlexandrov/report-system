module AuthorizeConcern
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?, :current_user

    before_action :authenticate_user!
  end

  SESSION_AUTH_KEY    = :user_auth_token
  SESSION_EXPIRES_KEY = :expires_at
  SESSION_REDIRECT_TO = :redirect_to

  def signed_in?
    !current_user.nil?
  end

  def current_user
    return unless session_params_present?
    token = current_auth_token
    return unless token.present?
    user = token.user
    if token.expired? || session[SESSION_EXPIRES_KEY] < Time.current
      sign_out
    else
      user
    end
  end

  def current_auth_token
    AuthToken.find_by(value: session[SESSION_AUTH_KEY])
  end

  def sign_in(user, remember_me: false)
    return unless user
    expires_at = Time.current + (remember_me ? 24.hours : 1.year)
    token = user.auth_tokens.create expires_at: expires_at
    session[SESSION_AUTH_KEY] = token.value
    session[SESSION_EXPIRES_KEY] = + expires_at
  end

  def session_params_present?
    session[SESSION_AUTH_KEY] && session[SESSION_EXPIRES_KEY]
  end

  def sign_out
    session[SESSION_AUTH_KEY] = nil
    session[SESSION_EXPIRES_KEY] = nil
    session[SESSION_REDIRECT_TO] = nil
    token.update_attribute(expires_at: Time.now) if (token = current_auth_token).present?
  end

  def authenticate_user!
    session[SESSION_REDIRECT_TO] = request.env['PATH_INFO']
    redirect_to users_auth_path unless signed_in?
  end

  def after_sign_in_path
    session[SESSION_REDIRECT_TO] || root_path
  end

end
