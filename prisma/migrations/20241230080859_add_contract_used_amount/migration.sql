-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contract" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "number" TEXT,
    "contractor" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "usedAmount" REAL NOT NULL DEFAULT 0,
    "startDate" DATETIME,
    "endDate" DATETIME,
    "status" TEXT NOT NULL DEFAULT 'PLANNED',
    "contractType" TEXT NOT NULL DEFAULT 'DIRECT',
    "dkCode" TEXT NOT NULL,
    "dkName" TEXT NOT NULL,
    "budgetId" TEXT NOT NULL,
    "kekvId" TEXT NOT NULL,
    "vehicleId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Contract_budgetId_fkey" FOREIGN KEY ("budgetId") REFERENCES "Budget" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Contract_kekvId_fkey" FOREIGN KEY ("kekvId") REFERENCES "KEKV" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Contract_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Contract" ("amount", "budgetId", "contractType", "contractor", "createdAt", "dkCode", "dkName", "endDate", "id", "kekvId", "number", "startDate", "status", "updatedAt", "vehicleId") SELECT "amount", "budgetId", "contractType", "contractor", "createdAt", "dkCode", "dkName", "endDate", "id", "kekvId", "number", "startDate", "status", "updatedAt", "vehicleId" FROM "Contract";
DROP TABLE "Contract";
ALTER TABLE "new_Contract" RENAME TO "Contract";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
