-- CreateTable
CREATE TABLE "Act" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "number" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "contractId" TEXT NOT NULL,
    "totalAmount" REAL NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Act_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Contract" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ActItem" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "actId" TEXT NOT NULL,
    "specificationId" TEXT NOT NULL,
    "quantity" REAL NOT NULL,
    "serviceCount" INTEGER,
    "amount" REAL NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "ActItem_actId_fkey" FOREIGN KEY ("actId") REFERENCES "Act" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ActItem_specificationId_fkey" FOREIGN KEY ("specificationId") REFERENCES "Specification" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
