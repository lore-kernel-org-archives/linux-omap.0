From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] REMOVE OMAP LEGACY CODE: Remove omap boot parsing code
Date: Thu,  6 Aug 2009 17:27:57 +0300
Message-ID: <1249568877-4472-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41195 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbZHFO2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 10:28:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Remove left over code for parsing omap boot tags. This is
no longer used.
see commit fc0ef1bfa1353e048e055374a09c75320d22231b

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/plat-omap/common.c |   44 -------------------------------------------
 1 files changed, 0 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index ebcf006..4d32719 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -54,50 +54,6 @@ static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
 	struct omap_board_config_kernel *kinfo = NULL;
 	int i;
 
-#ifdef CONFIG_OMAP_BOOT_TAG
-	struct omap_board_config_entry *info = NULL;
-
-	if (omap_bootloader_tag_len > 4)
-		info = (struct omap_board_config_entry *) omap_bootloader_tag;
-	while (info != NULL) {
-		u8 *next;
-
-		if (info->tag == tag) {
-			if (skip == 0)
-				break;
-			skip--;
-		}
-
-		if ((info->len & 0x03) != 0) {
-			/* We bail out to avoid an alignment fault */
-			printk(KERN_ERR "OMAP peripheral config: Length (%d) not word-aligned (tag %04x)\n",
-			       info->len, info->tag);
-			return NULL;
-		}
-		next = (u8 *) info + sizeof(*info) + info->len;
-		if (next >= omap_bootloader_tag + omap_bootloader_tag_len)
-			info = NULL;
-		else
-			info = (struct omap_board_config_entry *) next;
-	}
-	if (info != NULL) {
-		/* Check the length as a lame attempt to check for
-		 * binary inconsistency. */
-		if (len != NO_LENGTH_CHECK) {
-			/* Word-align len */
-			if (len & 0x03)
-				len = (len + 3) & ~0x03;
-			if (info->len != len) {
-				printk(KERN_ERR "OMAP peripheral config: Length mismatch with tag %x (want %d, got %d)\n",
-				       tag, len, info->len);
-				return NULL;
-			}
-		}
-		if (len_out != NULL)
-			*len_out = info->len;
-		return info->data;
-	}
-#endif
 	/* Try to find the config from the board-specific structures
 	 * in the kernel. */
 	for (i = 0; i < omap_board_config_size; i++) {
-- 
1.6.0.4

