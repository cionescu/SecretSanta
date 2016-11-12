require "permutation"

RSpec.describe Permutation do
  context "permutation_is_identical" do
    it "finds identical permutations" do
      a = [1, 2, 3]
      b = [1, 2, 3]

      expect(subject.permutation_is_identical?(a, b)).to be true
    end
  end
end
