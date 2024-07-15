#!/bin/bash

BOLD_BLUE='\033[1;34m'
NC='\033[0m'
echo
if ! command -v node &> /dev/null
then
    echo -e "${BOLD_BLUE}Node.js is not installed. Installing Node.js...${NC}"
    echo
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo -e "${BOLD_BLUE}Node.js is already installed.${NC}"
fi
echo
if ! command -v npm &> /dev/null
then
    echo -e "${BOLD_BLUE}npm is not installed. Installing npm...${NC}"
    echo
    sudo apt-get install -y npm
else
    echo -e "${BOLD_BLUE}npm is already installed.${NC}"
fi
echo
echo -e "${BOLD_BLUE}Creating project directory and navigating into it${NC}"
mkdir -p SonicBatchTx
cd SonicBatchTx
echo
echo -e "${BOLD_BLUE}Initializing a new Node.js project${NC}"
echo
npm init -y
echo
echo -e "${BOLD_BLUE}Installing required packages${NC}"
echo
npm install @solana/web3.js chalk bs58
echo
echo -e "${BOLD_BLUE}Prompting for private key${NC}"
echo
read -p "Enter your solana wallet private key: " privkey
echo
echo -e "${BOLD_BLUE}Creating the Node.js script file${NC}"
echo
cat << EOF > zun.mjs
import web3 from "@solana/web3.js";
import chalk from "chalk";
import bs58 from "bs58";

const connection = new web3.Connection("https://devnet.sonic.game", 'confirmed');

const privkey = "$privkey";
const from = web3.Keypair.fromSecretKey(bs58.decode(privkey));
const to = web3.Keypair.generate();

(async () => {
    const transaction = new web3.Transaction().add(
        web3.SystemProgram.transfer({
          fromPubkey: from.publicKey,
          toPubkey: to.publicKey,
          lamports: web3.LAMPORTS_PER_SOL * 0.001,
        }),
      );
    
      
      const txCount = 100;
      for (let i = 0; 
      const interval = setInterval(asyn () => {
       if (i < txcount) {
      const signature = await web3.sendAndConfirmTransaction(
        connection,
        transaction,
        [from],
      );
      i++;
    console.log(chalk.blue('Tx hash :'), signature);
    } else {
    clearinterval(interval);
    }
    }, 60000)
    console.log("");
    const randomDelay = Math.floor(Math.random() * 3) + 1;
    await new Promise(resolve => setTimeout(resolve, randomDelay * 1000));
  }
})();
EOF
echo
echo -e "${BOLD_BLUE}Executing the Node.js script${NC}"
echo
node zun.mjs
echo
