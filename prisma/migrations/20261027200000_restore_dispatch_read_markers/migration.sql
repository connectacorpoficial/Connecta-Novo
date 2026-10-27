-- Restore the previous read-marker state. Conversation filters derive pending
-- replies from message order and never mark messages read when opened.
UPDATE "ChatMessage" AS message
SET "readAt" = NULL
FROM "ChatConversation" AS conversation
WHERE message."conversationId" = conversation.id
  AND message.direction = 'inbound'
  AND conversation."deletedAt" IS NULL
  AND conversation.memory->>'source' = 'mass-message';
