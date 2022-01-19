import { useEffect, useState, useCallback } from 'react';
import './App.css'
import Web3 from 'web3';
import detectEthereumProvider from '@metamask/detect-provider'
import { loadContract } from "./utils/load-contract"

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
    contract: null
  })

  const [account, setAccount] = useState(null)
  const [balance, setBalance] = useState(null)

  useEffect(() => {
    const loadProvider = async () => {
      const provider = await detectEthereumProvider();
      const contract = await loadContract("Faucet", provider)

      if (provider) {
        setWeb3Api({
          web3: new Web3(provider),
          provider,
          contract
        })
      } else {
        console.error("Please install Metamask")
      }
    }

    loadProvider()
  }, [])

  useEffect(() => {
    const getAccounts = async () => {
      const accounts = await web3Api.web3.eth.getAccounts()
      setAccount(accounts[0])
    }

    web3Api.web3 && getAccounts()
  }, [web3Api.web3])

  useEffect(() => {
    const loadBalance = async () => {
      const { contract, web3 } = web3Api
      const balance = await web3.eth.getBalance(contract.address)
      setBalance(web3.utils.fromWei(balance, "ether"))
    }

    web3Api.contract && loadBalance()
  }, [web3Api])

  const addFunds = useCallback(async () => {
    const { contract, web3 } = web3Api
    await contract.addFunds({
      from: account,
      value: web3.utils.toWei("1", "ether")
    })
  }, [web3Api, account])

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">
          <h1>
            <div className='is-flex is-align-items-center'>
              <span className='mr-2'>
                <strong>Account: </strong>
              </span>
              {
                account
                  ? account
                  : (
                    <button
                      className='button is-small'
                      onClick={() => {
                        web3Api.provider.request({ method: "eth_requestAccounts" })
                      }}
                    >
                      Connect Wallet
                    </button>
                  )
              }
            </div>
          </h1>
          <div className="balance-view is-size-2 mb-4">
            Current Balance: <strong>{balance}</strong> ETH
          </div>
          <button className='button is-link mr-2 is-small' onClick={addFunds}>Donate 1 eth</button>
          <button className='button is-primary is-small'>Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
