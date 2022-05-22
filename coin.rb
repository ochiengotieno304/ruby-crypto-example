require 'sha3'


# BLOCK CLASS
class Block
  attr_accessor :previous_hash, :hash

  def initialize(index, timestamp, data, previous_hash)
    @index = index
    @timestamp = timestamp
    @data = data
    @previous_hash = previous_hash
    @hash = generate_hash()
  end

  # GENERATE BLOCK HASH
  def generate_hash
    return SHA3::Digest::SHA256.new("#{@index} + #{@timestamp} + #{@data} + #{@previous_hash}")
  end
end



# BLOCKCHAIN CLASS
class Blockchain
  def initialize
    @blockchain = [create_genesise_block()]
  end

  # FIRST BLOCK IN CHAIN
  def create_genesise_block
    return Block.new('0', '13/05/2015', 'first block on chain', '0')
  end

  # GET LAST BLOCK IN CHAIN
  def get_last_block
    return @blockchain.last
  end
  
  # ADD NEW BLOCK TO CHAIN
  def add_new_block(new_block)
    new_block.previous_hash = get_last_block.hash
    new_block.hash = new_block.generate_hash
    @blockchain.push(new_block)
  end
end

# TESTING CHAIN INTEGRITY
def validate_chain_integrity
  i = 1
  while i < @blockchain.length
    current_block = @blockchain[i]
    previous_block = @blockchain[i - 1]

    if (current_block.hash != previous_block.generate_hash)
      return false
    end

    if (current_block.previous_hash != previous_block.hash)
      return false
    end
      
    return true
  end
end


ruby_coin = Blockchain.new

ruby_coin.add_new_block (
  Block.new(
    '0', '13/05/2015', 'first block on chain', '0'
  )
)

ruby_coin.add_new_block (
  Block.new(
    '0', '13/05/2015', 'second block on chain', '0'
  )
)

ruby_coin.add_new_block (Block.new(
  "0", "13/05/2015", "third block on chain", "0"
))

puts ruby_coin.get_last_block.hash
puts ruby_coin.get_last_block.previous_hash
