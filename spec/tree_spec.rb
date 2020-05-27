require './bst/tree'

describe Tree do
  array = [10,20,5,15,25,3,7]
  tree = Tree.new([10,20,5,15,25,3,7])
  describe "#level_order" do
    it "returns Lever order of Binary Tree" do
      expect(tree.level_order).to eq([10,5,20,3,7,15,25])
    end
  end
  describe '#depth' do
    it 'Returns depth of whole tree' do
      expect(tree.depth).to eq(3)      
    end
    it 'Returns depth below given node' do
      expect(tree.depth(tree.root.right_child)).to eq(2)
    end
  end
  describe '#balanced?' do
    it 'Returns true if tree is balanced' do
      expect(tree.balanced?).to eq(true)
    end
    it 'Returns false if tree is unbalanced after insertions' do
      tree.insert(30)
      tree.insert(40)
      expect(tree.balanced?).to eq(false)
    end
  end
end
