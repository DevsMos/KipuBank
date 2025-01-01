// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title KipuBank
 * @dev Contrato para um banco simples com limite de capacidade
 */
contract KipuBank {
    // Eventos
    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    // Constantes e variáveis imutáveis
    uint256 public constant WITHDRAWAL_LIMIT = 1 ether;
    uint256 public immutable bankCap;

    // Mapeamento de saldos
    mapping(address => uint256) private balances;

    // Erros customizados
    error ExceedsBankCapacity();
    error ExceedsWithdrawalLimit();
    error InsufficientBalance();
    error TransferFailed();

    /**
     * @dev Constructor que define o limite máximo do banco
     * @param _bankCap Limite máximo de ETH que o banco pode armazenar
     */
    constructor(uint256 _bankCap) {
        require(_bankCap > 0, "Bank capacity must be greater than 0");
        bankCap = _bankCap;
    }

    /**
     * @dev Modificador para verificar se o depósito não excede o limite do banco
     * @param _amount Valor a ser depositado
     */
    modifier withinBankCap(uint256 _amount) {
        if (address(this).balance + _amount > bankCap) {
            revert ExceedsBankCapacity();
        }
        _;
    }

    /**
     * @dev Modificador para verificar se o saque está dentro do limite
     * @param _amount Valor a ser sacado
     */
    modifier withinWithdrawalLimit(uint256 _amount) {
        if (_amount > WITHDRAWAL_LIMIT) {
            revert ExceedsWithdrawalLimit();
        }
        if (balances[msg.sender] < _amount) {
            revert InsufficientBalance();
        }
        _;
    }

    /**
     * @dev Função para realizar depósito de ETH
     */
    function deposit() external payable withinBankCap(msg.value) {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    

    /**
     * @dev Função para realizar saque de ETH
     * @param _amount Valor a ser sacado
     */
    function withdraw(uint256 _amount) 
        external 
        withinWithdrawalLimit(_amount) 
    {
        

        balances[msg.sender] -= _amount;
        _safeTransfer(msg.sender, _amount);
        emit Withdrawal(msg.sender, _amount);
    }

    /**
     * @dev Função interna para realizar transferência segura de ETH
     * @param _to Endereço do destinatário
     * @param _amount Valor a ser transferido
     */
    function _safeTransfer(address _to, uint256 _amount) private {
        (bool success, ) = payable(_to).call{value: _amount}("");
        if (!success) {
            revert TransferFailed();
        }
    }

    /**
     * @dev Função para consultar saldo do usuário
     * @param _user Endereço do usuário
     * @return Saldo do usuário
     */
    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }

    /**
     * @dev Função para consultar saldo total do contrato
     * @return Saldo total do contrato
     */
    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev Função para receber ETH
     */
    receive() external payable {
        revert("Use deposit function to send ETH");
    }

    /**
     * @dev Função fallback
     */
    fallback() external payable {
        revert("Invalid transaction");
    }
}