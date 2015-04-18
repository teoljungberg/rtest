# Stolen from ActiveSupport
# https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/string/strip.rb
class String
  # Strips indentation in heredocs.
  #
  # For example in
  #
  #   if options[:usage]
  #     puts <<-USAGE.strip_heredoc
  #       This command does such and such.
  #
  #       Supported options are:
  #         -h         This message
  #         ...
  #     USAGE
  #   end
  #
  # the user would see the usage message aligned against the left margin.
  #
  # Technically, it looks for the least indented line in the whole string, and removes
  # that amount of leading whitespace.
  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/).min.size
    gsub(/^[ \t]{#{indent}}/, '')
  end
end
