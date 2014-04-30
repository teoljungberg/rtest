require_relative '../test_case'
require 'tunit/spec'

module Tunit
  class SpecExpectTest < TestCase
    def test_expect_wraps_up_a_expect_object
      klass = Class.new(Spec) {
        it 'passes' do
          assert_instance_of Spec::Expect, expect(2)
        end
      }

      k = klass.new "test_0001_passes"
      k.run

      assert_equal 1, k.assertions
    end

    def test_expect_must_be_inside_an_it_block
      assert_raises NoMethodError do
        Class.new(Spec) {
          expect(2).to eq 1
        }
      end
    end
  end

  class ExpectTest < TestCase
    def test_initialize_sets_the_value_as_a_proc
      expect = Spec::Expect.new 2

      assert_instance_of Proc, expect.value
      assert_equal 2, expect.value.call
    end

    def test_methods_missing_defines_matchers_depending_on_the_assertions
      tc = self

      klass = Class.new(Spec) {
        it 'passes' do
          tc.assert_equal "assert_match", match.first
        end
      }

      k = klass.new "test_0001_passes"
      k.run
    end

    def test_respond_to_missing_maps_expectation_matchers_to_assertions
      k = Class.new(Spec).new :name

      assert_respond_to k, :eq
      assert_equal "assert_equal", k.eq.first

      refute_respond_to k, :jikes
    end

    def test_methods_missing_fails_if_no_matcher_is_found
      klass = Class.new(Spec) {
        it 'passes' do
          expect(/oo/).to die "foo"
        end
      }

      k = klass.new "test_0001_passes"
      k.run

      assert_instance_of Tunit::NotAnAssertion, k.failure
    end
  end
end
