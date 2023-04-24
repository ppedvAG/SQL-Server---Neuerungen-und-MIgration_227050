-- Execute a resumable online index create statement with MAXDOP=1
CREATE INDEX IX_Stock_Item_Key2 ON Fact.OrderHistoryExtended ([Customer Key])
WITH (ONLINE = ON, MAXDOP = 1, RESUMABLE = ON);

-- Executing the same command again (see above) after an index operation was paused, resumes automatically the index create operation.

-- Execute a resumable online index creates operation with MAX_DURATION set to 240 minutes. After the time expires, the resumable index create operation is paused.
CREATE INDEX IX_Stock_Item_Key2 ON Fact.OrderHistoryExtended ([City_key])
WITH (ONLINE = ON, RESUMABLE = ON, MAX_DURATION = 1);

-- Pause a running resumable online index creation
ALTER INDEX IX_Stock_Item_Key2 ON Fact.OrderHistoryExtended PAUSE;
ALTER INDEX IX_Stock_Item_Key2 ON Fact.OrderHistoryExtended PAUSE;

-- Resume a paused online index creation
ALTER INDEX IX_Stock_Item_Key2 ON Fact.OrderHistoryExtended RESUME;
ALTER INDEX IX_Stock_Item_Key ON Fact.OrderHistoryExtended RESUME;

-- Abort resumable index create operation which is running or paused
ALTER INDEX IX_Stock_Item_Key2 ON Fact.OrderHistoryExtended ABORT;
ALTER INDEX IX_Stock_Item_Key2 ON Fact.OrderHistoryExtended ABORT;