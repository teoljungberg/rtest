module Tunit
  module Hooks
    SETUP_HOOKS    = %w(before_setup setup after_setup)
    TEARDOWN_HOOKS = %w(before_teardown teardown after_teardown)

    # Runs before each test
    def setup
    end

    def before_setup
    end

    def after_setup
    end

    # Runs after each test
    def teardown
    end

    def before_teardown
    end

    def after_teardown
    end
  end
end
