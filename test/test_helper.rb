require "minitest/autorun"
require "tunit/test"
require "stringio"

require "sample/tests"
require "sample/specs"

module Tunit
  class TestCase < Minitest::Test
    def io
      @io ||= StringIO.new ""
    end

    def teardown
      Runnable.runnables.clear
    end

    private

    def normalize_output output
      output.sub!(/Finished in .*/, "Finished in 0.00")

      output.gsub!(/ = \d+.\d\d s = /, ' = 0.00 s = ')
      output.gsub!(/0x[A-Fa-f0-9]+/, '0xXXX')
      output.gsub!(/ +$/, '')

      output.gsub!(/\[[^\]:]+:\d+\]/, '[FILE:LINE]')
      output.gsub!(/^(\s+)[^:]+:\d+:in/, '\1FILE:LINE:in')

      output
    end
  end
end
