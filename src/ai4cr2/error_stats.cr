module Ai4cr2
  class ErrorStats
    include ::JSON::Serializable

    # Must init @score, so set it big enough but not too big (so ErrorStats works w/ to/from JSON)
    INITIAL_SCORE = Float64::MAX ** (1.0/16)

    DEFAULT_HISTORY_SIZE = 2

    getter history_size : Int32
    getter distance : Float64
    getter history : Array(Float64)
    getter score : Float64
    getter hist_correct_plot = ["tbd"]

    def initialize(history_size = DEFAULT_HISTORY_SIZE)
      @history_size = case
                      when history_size.nil?
                        DEFAULT_HISTORY_SIZE
                      when history_size < 0
                        raise "Invalid history_size; must be positive."
                      else
                        history_size
                      end

      @distance = -1.0 # Float64::MAX # -1.0
      @history = Array(Float64).new(history_size)

      # lowest score is best; negatives are effectively invalid
      @score = INITIAL_SCORE
    end

    def distance=(value)
      raise "Invalid value" if value < 0.0
      @distance = case
                  when value == Float64::INFINITY
                    # JSON doesn't like Infinity values.
                    Float64::MAX
                  else
                    value
                  end
      update_history

      @distance
    end

    def plot_error_distance_history(
      min = 0.0,
      max = 1.0,
      precision = 2.to_i8,
      in_bw = false,
      prefixed = false,
      reversed = false,
    )
      hist = history.map { |h| h.nan? ? 100.0 : h }
      # hist = history.map { |h| Float64.cap_extremes(h, alt_nan: 100.0, alt_infin_pos: 100.0, alt_infin_neg: 100.0) }

      # charter = AsciiBarCharter.new(min: min, max: max, precision: precision, in_bw: in_bw, inverted_colors: reversed)
      # charter.plot(hist, prefixed)

      p hist
    end

    def update_history_correct_plot(which_correct_plot = "(tbd)")
      if @hist_correct_plot.size < @history_size # - 1
        # Array not 'full' yet, so add latest value to end
        @hist_correct_plot << which_correct_plot
      else
        # Array 'full', so rotate end to front and then put new value at last index
        @hist_correct_plot.rotate!
        @hist_correct_plot[-1] = which_correct_plot
      end

      @hist_correct_plot
    end

    private def update_history
      if @history.size < @history_size # - 1
        # Array not 'full' yet, so add latest value to end
        @history << @distance
      else
        # Array 'full', so rotate end to front and then put new value at last index
        @history.rotate!
        @history[-1] = @distance
      end

      @score = history.map_with_index do |e, i|
        e / (2.0 ** (@history.size - i))
      end.sum

      @history
    end
  end
end
