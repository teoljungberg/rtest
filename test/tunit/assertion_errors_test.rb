require_relative 'test_case'
require 'tunit/assertion_errors'
require 'tunit/test'

module Tunit
  class AssertionErrotunit < TestCase
    def setup
      self.assertion = Assertion.new
    end
    attr_accessor :assertion

    def test_error
      assert_instance_of Assertion, assertion.error
    end

    def test_location
      result       = FailingTest.new.run
      assertion    = result.failure
      exp_location = %r(.*/tunit/test/tunit/test_case.rb:\d{1,})

      assert_match exp_location, assertion.location
    end

    def test_result_code
      assert_equal "F", assertion.result_code
    end

    def test_result_label
      assert_equal "Failure", assertion.result_label
    end
  end

  class EmptyTest < TestCase
    def setup
      self.assertion = Empty.new
    end
    attr_accessor :assertion

    def test_error
      assert_instance_of Empty, assertion.error
    end

    def test_location
      result       = FailingTest.new(:test_empty).run
      assertion    = result.failure
      exp_location = %r(.*/tunit/test/tunit/test_case.rb:\d{1,})

      assert_match exp_location, assertion.location
    end

    def test_location_handles_unnamed_classes
      result = Class.new(Test) {
        def test_empty
        end
      }.new(:test_empty).run

      refute_equal :not_set, result.failure.location
    end

    def test_result_code
      assert_equal "_", assertion.result_code
    end

    def test_result_label
      assert_equal "Empty", assertion.result_label
    end
  end

  class SkipTest < TestCase
    def setup
      self.assertion = Skip.new
    end
    attr_accessor :assertion

    def test_error
      assert_instance_of Skip, assertion.error
    end

    def test_location
      result       = SkippedTest.new.run
      assertion    = result.failure
      exp_location = %r(.*/tunit/test/tunit/test_case.rb:\d{1,})

      assert_match exp_location, assertion.location
    end

    def test_result_code
      assert_equal "S", assertion.result_code
    end

    def test_result_label
      assert_equal "Skipped", assertion.result_label
    end
  end
end