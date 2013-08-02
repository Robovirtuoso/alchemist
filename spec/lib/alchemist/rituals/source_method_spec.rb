require 'spec_helper'

describe Alchemist::Rituals::SourceMethod do

  let(:result) { OpenStruct.new(rank: 'Private') }

  let(:result_method1) { :method1 }
  let(:result_method2) { :method2 }

  before do
    result.stub(result_method1)
    result.stub(result_method2)
  end

  context "a valid source object field is given" do

    let(:source_method) { :rank }
    let(:source_value)  { 'Colonel' }

    let(:source) { OpenStruct.new(rank: source_value) }

    context "no block is given" do

      let(:ritual) {
        Alchemist::Rituals::SourceMethod.new(source_method, result_method1, result_method2)
      }

      it 'calls the first result method with the result of the source method' do
        result.should_receive(result_method1).with(source_value)
        ritual.call(source, result)
      end

      it 'calls the second result method with the result of the source method' do
        result.should_receive(result_method2).with(source_value)
        ritual.call(source, result)
      end

    end

    context "a block is given" do

      let(:block) { Proc.new { |value| value.downcase } }

      let(:ritual) {
        Alchemist::Rituals::SourceMethod.new(source_method, result_method1, result_method2, &block)
      }

      it 'calls the first result method with the result of the block' do
        result.should_receive(result_method1).with(source_value.downcase)
        ritual.call(source, result)
      end

      it 'calls the second result method with the result of the block' do
        result.should_receive(result_method1).with(source_value.downcase)
        ritual.call(source, result)
      end

    end

  end

  context "an invalid source object field is given" do

    let(:source_method) { :invalid_field }

    let(:source) { Class.new }

    let(:expected_error) { Alchemist::Errors::InvalidSourceMethod }

    let(:ritual) {
      Alchemist::Rituals::SourceMethod.new(source_method, result_method1, result_method2)
    }

    it "raises an InvalidSourceMethod" do
      expect { ritual.call(source, result) }.to raise_error(expected_error)
    end

  end

end
