From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 07/59] omap: namespace cleanup to arch/arm/mach-omap1/board-perseus2.c
Date: Wed, 12 Nov 2008 00:56:26 +0200
Message-ID: <1226444238-14614-8-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56950 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYKKW60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:58:26 -0500
In-Reply-To: <1226444238-14614-7-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-perseus2.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index b715917..28423e5 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -274,7 +274,7 @@ static void __init omap_perseus2_map_io(void)
 	/*
 	 * Hold GSM Reset until needed
 	 */
-	omap_writew(omap_readw(OMAP730_DSP_M_CTL) & ~1, OMAP730_DSP_M_CTL);
+	__raw_writew(__raw_readw(OMAP730_DSP_M_CTL) & ~1, OMAP730_DSP_M_CTL);
 
 	/*
 	 * UARTs -> done automagically by 8250 driver
@@ -285,21 +285,21 @@ static void __init omap_perseus2_map_io(void)
 	 */
 
 	/* Flash: CS0 timings setup */
-	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_0);
-	omap_writel(0x00000088, OMAP730_FLASH_ACFG_0);
+	__raw_writel(0x0000fff3, OMAP730_FLASH_CFG_0);
+	__raw_writel(0x00000088, OMAP730_FLASH_ACFG_0);
 
 	/*
 	 * Ethernet support through the debug board
 	 * CS1 timings setup
 	 */
-	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_1);
-	omap_writel(0x00000000, OMAP730_FLASH_ACFG_1);
+	__raw_writel(0x0000fff3, OMAP730_FLASH_CFG_1);
+	__raw_writel(0x00000000, OMAP730_FLASH_ACFG_1);
 
 	/*
 	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
 	 * It is used as the Ethernet controller interrupt
 	 */
-	omap_writel(omap_readl(OMAP730_IO_CONF_9) & 0x1FFFFFFF, OMAP730_IO_CONF_9);
+	__raw_writel(__raw_readl(OMAP730_IO_CONF_9) & 0x1FFFFFFF, OMAP730_IO_CONF_9);
 }
 
 MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
-- 
1.6.0.2.307.gc427

