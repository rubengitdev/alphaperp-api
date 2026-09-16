-- CreateTable
CREATE TABLE "Market" (
    "id" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "symbol" TEXT NOT NULL,
    "strike" DOUBLE PRECISION NOT NULL,
    "expiry" TIMESTAMP(3) NOT NULL,
    "totalLiquidity" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "premiumAsk" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "optionMint" TEXT,
    "underlyingMint" TEXT,
    "quoteMint" TEXT,
    "type" TEXT NOT NULL DEFAULT 'crypto',
    "pythFeedId" TEXT,
    "isSynthetic" BOOLEAN NOT NULL DEFAULT false,
    "network" TEXT NOT NULL DEFAULT 'devnet',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Market_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OptionPosition" (
    "id" TEXT NOT NULL,
    "ownerAddress" TEXT NOT NULL,
    "marketId" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "positionType" TEXT NOT NULL,
    "network" TEXT NOT NULL DEFAULT 'devnet',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OptionPosition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TradeHistory" (
    "id" TEXT NOT NULL,
    "userAddress" TEXT NOT NULL,
    "marketId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "txSignature" TEXT NOT NULL,
    "network" TEXT NOT NULL DEFAULT 'devnet',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TradeHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SystemLog" (
    "id" TEXT NOT NULL,
    "level" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "environment" TEXT NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SystemLog_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Market_address_key" ON "Market"("address");

-- CreateIndex
CREATE UNIQUE INDEX "TradeHistory_txSignature_key" ON "TradeHistory"("txSignature");

-- AddForeignKey
ALTER TABLE "OptionPosition" ADD CONSTRAINT "OptionPosition_marketId_fkey" FOREIGN KEY ("marketId") REFERENCES "Market"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TradeHistory" ADD CONSTRAINT "TradeHistory_marketId_fkey" FOREIGN KEY ("marketId") REFERENCES "Market"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
