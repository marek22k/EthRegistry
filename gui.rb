
require "fox16"

class MainWindow < Fox::FXMainWindow
  include Fox
  
  attr_reader :key
  
  def initialize app, cheapeth
    super app, "CheapEth - EthRegistry", :width=>450, :height=>200
    
    @cheapeth = cheapeth
    
    @reg = EthRegistry.new @cheapeth.rpc_client, $contract_addr, nil
    @key = nil
    
    @main_frame = FXVerticalFrame.new self, :opts => LAYOUT_FILL
    @chain_frame = FXVerticalFrame.new @main_frame, :opts => LAYOUT_FILL
    @account_frame = FXVerticalFrame.new @main_frame, :opts => LAYOUT_FILL_X
    @reg_frame = FXHorizontalFrame.new @main_frame, :opts => LAYOUT_FILL_X
    
    @block_label = FXLabel.new @chain_frame, "Current block: #{cheapeth.get_current_block}", :padBottom => 0
    @gas_label = FXLabel.new @chain_frame, "Gas price: #{cheapeth.gas_price}", :padTop => 0
    
    @account_button = FXButton.new @account_frame, "Load account"
    @address_label = FXLabel.new @account_frame, "Address: 0x", :padBottom => 0
    @balance_label = FXLabel.new @account_frame, "Balance: 0.0", :padTop => 0, :padBottom => 0
    @nonce_label = FXLabel.new @account_frame, "Nonce: 0.0", :padTop => 0
    
    @account_button.connect(SEL_COMMAND) {
      load_key
    }
    
    @reg_button = FXButton.new @reg_frame, "Register"
    @get_button = FXButton.new @reg_frame, "Get entry"
    @get_own_button = FXButton.new @reg_frame, "Get own entry"
    
    @reg_button.connect(SEL_COMMAND) {
      register
    }
    
    @get_button.connect(SEL_COMMAND) {
      get
    }
    
    @get_own_button.connect(SEL_COMMAND) {
      get_own
    }
    
  end
  
  def create
    super
    show(Fox::PLACEMENT_SCREEN)
  end
  
  protected
  
  def output_entry entry
    if entry != ""
      FXMessageBox.information self, MBOX_OK, "Result", entry
    else
      FXMessageBox.error self, MBOX_OK, "Not found", "Entry not found or empty"
    end
  end
  
  def get
    addr_dialog = FXInputDialog.new self, "Input address", "Address:"
    res = addr_dialog.execute
    if res == 0
      FXMessageBox.warning self, MBOX_OK, "Error", "Error: No input"
      return false
    end
    
    key_dialog = FXInputDialog.new self, "Input key", "Key:"
    res = key_dialog.execute
    if res == 0
      FXMessageBox.warning self, MBOX_OK, "Error", "Error: No input"
      return false
    end

    output_entry @reg.get(addr_dialog.text, key_dialog.text)
  end
  
  def get_own
    if ! @key
      FXMessageBox.warning self, MBOX_OK, "Error", "Error: Load account first"
    else
      key_dialog = FXInputDialog.new self, "Input key", "Key:"
      res = key_dialog.execute
      if res == 0
        FXMessageBox.warning self, MBOX_OK, "Error", "Error: No input"
        return false
      end

      output_entry @reg.get(@key.address, key_dialog.text)
    end
  end
  
  def register
    if ! @key
      FXMessageBox.warning self, MBOX_OK, "Error", "Error: Load account first"
    else
      key_dialog = FXInputDialog.new self, "Input key", "Key:"
      key_dialog.execute

      value_dialog = FXInputDialog.new self, "Input value", "Value:"
      value_dialog.execute

      tx = @reg.register key_dialog.text, value_dialog.text
      puts "txid: #{tx.id}"
    end
  end
  
  def load_key
    dialog = FXInputDialog.new self, "Private key", "Private key:"
    dialog.execute
    
    priv_key = dialog.text
    
    if priv_key != ""
      Thread.new {
        @account_button.disable

        @key = Eth::Key.new priv: priv_key
        puts "load account #{@key.address}"
        @reg = EthRegistry.new @cheapeth.rpc_client, $contract_addr, @key
        @address_label.text = "Address: #{@key.address}"
        @balance_label.text = "Balance: #{@cheapeth.get_balance_of @key.address}"
        @nonce_label.text = "Nonce: #{@cheapeth.get_nonce_of @key.address}"
        @account_button.enable
      }
    end
  end
end
