-- I have created 4 tables based on the data information that I have generated from the python script. 
CREATE TABLE users (
    active BOOLEAN,
    role VARCHAR(255),
    signUpSource VARCHAR(255),
    state VARCHAR(255),
	userId VARCHAR(255) PRIMARY KEY,
    createdDate TIMESTAMP,
    lastLoginDate TIMESTAMP
);

CREATE TABLE brands (
    barcode BIGINT,
    category VARCHAR(255),
    categoryCode VARCHAR(255),
    name VARCHAR(255),
    topBrand INT,
	brandId VARCHAR(255) PRIMARY KEY,
    cpgId VARCHAR(255),
    cpgRef VARCHAR(255),
    brandCode VARCHAR(255)
);

CREATE TABLE receipts (
    receiptId VARCHAR(255) PRIMARY KEY,
    bonusPointsEarned DECIMAL,
    bonusPointsEarnedReason VARCHAR(255),
    createDate TIMESTAMP,
    dateScanned TIMESTAMP,
    finishedDate TIMESTAMP NULL,
    modifyDate TIMESTAMP,
    pointsAwardedDate TIMESTAMP,
    pointsEarned DOUBLE PRECISION,
    purchaseDate TIMESTAMP,
    purchasedItemCount DECIMAL,
    rewardsReceiptStatus VARCHAR(255),
    totalSpent DECIMAL,
    userId VARCHAR(255)
);


CREATE TABLE itemList (
    barcode VARCHAR(255),
    description TEXT,
    finalPrice DECIMAL,
    itemPrice DECIMAL,
    needsFetchReview BOOLEAN,
    partnerItemId SMALLINT,
    preventTargetGapPoints BOOLEAN,
    quantityPurchased SMALLINT,
    userFlaggedBarcode VARCHAR(255),
    userFlaggedNewItem BOOLEAN,
    userFlaggedPrice VARCHAR(255),
    userFlaggedQuantity DECIMAL,
    needsFetchReviewReason TEXT,
    pointsNotAwardedReason TEXT,
    pointsPayerId VARCHAR(255),
    rewardsGroup VARCHAR(255),
    rewardsProductPartnerId VARCHAR(255),
    userFlaggedDescription TEXT,
    originalMetabriteBarcode VARCHAR(255),
    originalMetabriteDescription TEXT,
    brandCode VARCHAR(255),
    competitorRewardsGroup VARCHAR(255),
    discountedItemPrice VARCHAR(255),
    originalReceiptItemText VARCHAR(255),
    itemNumber VARCHAR(255),
    originalMetabriteQuantityPurchased DECIMAL,
    pointsEarned DECIMAL,
    targetPrice VARCHAR(255),
    competitiveProduct BOOLEAN,
    originalFinalPrice VARCHAR(255),
    originalMetabriteItemPrice VARCHAR(255),
    deleted BOOLEAN,
    priceAfterCoupon VARCHAR(255),
    metabriteCampaignId VARCHAR(255),
    itemId VARCHAR(255)
);

-- What are the top 5 brands by receipts scanned for most recent month?

-- I first checked the latest date, since this isn't the latest data. Then, I wrote the query for the month before that.
SELECT MAX(dateScanned) AS latest_date_scanned
FROM receipts;

-- Since the data gathered from the website is incomplete, there are two ways to go about this. 

-- The first method is to join the brands and itemlist table on barcode, and the receipts and itemlist table on recipt id. 
-- Then, I have printed the brand name and the receipt count
SELECT b.name, COUNT(r.receiptId) AS receipt_count
FROM brands b
JOIN itemList il ON CAST(b.barcode AS VARCHAR(255)) = il.barcode 
JOIN receipts r ON il.itemId = r.receiptId
WHERE r.dateScanned >= '2021-01-01 00:00:00' AND r.dateScanned < '2021-02-01 00:00:00'
GROUP BY b.name
ORDER BY receipt_count DESC
LIMIT 5;

-- The second method is to only use the itemlist and receipts table, as the brandcode also gives the Brand. 
SELECT i.brandcode, COUNT(r.receiptId) AS receipt_count
from itemlist i
JOIN receipts r on i.itemId = r.receiptId
WHERE dateScanned >= '2021-01-01' and dateScanned < '2021-02-01' AND i.brandcode IS NOT NULL
GROUP BY i.brandcode
ORDER BY receipt_count DESC
LIMIT 5;

-- Under ideal conditions, these should both give the saame answer as the brandcode is tied to the brand id.
-- But, since the data gathered is incomplete, it is impossible to get the same output using both methods.

-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

-- Here, I have assumed that 'Accepted' means 'Finished'
-- I have displayed an output of both the receipt status and their average. 
SELECT rewardsReceiptStatus, ROUND(AVG(totalSpent),2) AS average_spent
FROM receipts
WHERE rewardsReceiptStatus IN ('FINISHED', 'REJECTED')
GROUP BY rewardsReceiptStatus
ORDER BY average_spent DESC;

-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- This is similar to the earlier query. I have displayed the sum along with the receipt status
SELECT rewardsReceiptStatus, SUM(purchasedItemCount) AS total_items_purchased
FROM receipts
WHERE rewardsReceiptStatus IN ('FINISHED', 'REJECTED')
GROUP BY rewardsReceiptStatus
ORDER BY total_items_purchased DESC;

-- Which brand has the most spend among users who were created within the past 6 months?
-- Here, I have joined all the tables, as information from each table is required. 
-- I have considered the past 6 months to be 6 months before the latest available date.
SELECT b.name AS brand_name, SUM(il.finalPrice) AS total_spent
FROM users u
JOIN receipts r ON u.userId = r.userId
JOIN itemList il ON r.receiptId = il.itemId
JOIN brands b ON il.barcode = CAST(b.barcode AS VARCHAR(255))
WHERE u.createdDate >= '2020-09-01' AND u.createdDate < '2021-03-01'
GROUP BY b.name
ORDER BY total_spent DESC
LIMIT 1;

-- Which brand has the most transactions among users who were created within the past 6 months?
-- Just like the earlier query, I have used all the available tables.
-- I have considered the past 6 months to be 6 months before the latest available date.
SELECT b.name AS brand_name, COUNT(DISTINCT r.receiptId) AS transaction_count
FROM users u
JOIN receipts r ON u.userId = r.userId
JOIN itemList il ON r.receiptId = il.itemId
JOIN brands b ON il.barcode = CAST(b.barcode AS VARCHAR(255))
WHERE u.createdDate >= '2020-09-01' AND u.createdDate < '2021-03-01'
GROUP BY b.name
ORDER BY transaction_count DESC
LIMIT 1;





