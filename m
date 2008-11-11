From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 04/59] omap: namespace cleanup to arch/arm/mach-omap1/board-osk.c
Date: Wed, 12 Nov 2008 00:56:23 +0200
Message-ID: <1226444238-14614-5-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56903 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbYKKW6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:58:08 -0500
In-Reply-To: <1226444238-14614-4-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-osk.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index e506aef..7d8d18a 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -277,9 +277,9 @@ static void __init osk_init_smc91x(void)
 	}
 
 	/* Check EMIFS wait states to fix errors with SMC_GET_PKT_HDR */
-	l = omap_readl(EMIFS_CCS(1));
+	l = __raw_readl(EMIFS_CCS(1));
 	l |= 0x3;
-	omap_writel(l, EMIFS_CCS(1));
+	__raw_writel(l, EMIFS_CCS(1));
 }
 
 static void __init osk_init_cf(void)
@@ -539,9 +539,9 @@ static void __init osk_init(void)
 	 * wrong CS3 memory timings. This mainly leads to CRC
 	 * or similar errors if you use NOR flash (e.g. with JFFS2)
 	 */
-	l = omap_readl(EMIFS_CCS(3));
+	l = __raw_readl(EMIFS_CCS(3));
 	if (l != EMIFS_CS3_VAL)
-		omap_writel(EMIFS_CS3_VAL, EMIFS_CCS(3));
+		__raw_writel(EMIFS_CS3_VAL, EMIFS_CCS(3));
 
 	osk_flash_resource.end = osk_flash_resource.start = omap_cs3_phys();
 	osk_flash_resource.end += SZ_32M - 1;
@@ -549,9 +549,9 @@ static void __init osk_init(void)
 	omap_board_config = osk_config;
 	omap_board_config_size = ARRAY_SIZE(osk_config);
 
-	l = omap_readl(USB_TRANSCEIVER_CTRL);
+	l = __raw_readl(USB_TRANSCEIVER_CTRL);
 	l |= (3 << 1);
-	omap_writel(l, USB_TRANSCEIVER_CTRL);
+	__raw_writel(l, USB_TRANSCEIVER_CTRL);
 
 	/* irq for tps65010 chip */
 	/* bootloader effectively does:  omap_cfg_reg(U19_1610_MPUIO1); */
-- 
1.6.0.2.307.gc427

