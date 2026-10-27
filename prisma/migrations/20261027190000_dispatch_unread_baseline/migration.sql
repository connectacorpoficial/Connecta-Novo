-- Existing inbound dispatch messages predate local read tracking.
-- Treat them as the baseline; new inbound messages remain unread until opened.
UPDATE "ChatMessage" AS message
SET "readAt" = CURRENT_TIMESTAMP
FROM "ChatConversation" AS conversation
WHERE message."conversationId" = conversation.id
  AND message.direction = 'inbound'
  AND message."readAt" IS NULL
  AND conversation."deletedAt" IS NULL
  AND conversation.memory->>'source' = 'mass-message';
