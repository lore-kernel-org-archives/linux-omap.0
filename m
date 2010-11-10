From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 1/3] OMAP: VRAM: improve VRAM error prints
Date: Wed, 10 Nov 2010 11:45:18 +0200
Message-ID: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:30915 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196Ab0KJJnq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 04:43:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Improve the error prints to give more information about the offending
address & size.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/vram.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index fed2a72..bb5ee06 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -554,9 +554,15 @@ void __init omap_vram_reserve_sdram_memblock(void)
 	size = PAGE_ALIGN(size);
 
 	if (paddr) {
-		if ((paddr & ~PAGE_MASK) ||
-		    !memblock_is_region_memory(paddr, size)) {
-			pr_err("Illegal SDRAM region for VRAM\n");
+		if (paddr & ~PAGE_MASK) {
+			pr_err("VRAM start address 0x%08x not page aligned\n",
+					paddr);
+			return;
+		}
+
+		if (!memblock_is_region_memory(paddr, size)) {
+			pr_err("Illegal SDRAM region 0x%08x..0x%08x for VRAM\n",
+					paddr, paddr + size - 1);
 			return;
 		}
 
-- 
1.7.1

