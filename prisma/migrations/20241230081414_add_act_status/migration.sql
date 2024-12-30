-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Act" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "number" TEXT,
    "date" DATETIME,
    "contractId" TEXT NOT NULL,
    "totalAmount" REAL NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Act_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Contract" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Act" ("contractId", "createdAt", "date", "id", "number", "totalAmount", "updatedAt") SELECT "contractId", "createdAt", "date", "id", "number", "totalAmount", "updatedAt" FROM "Act";
DROP TABLE "Act";
ALTER TABLE "new_Act" RENAME TO "Act";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
