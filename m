From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.33-rc2+ 12/12] arm: omap: perseus: kill compile warning on board-perseus2.c
Date: Wed, 30 Dec 2009 00:51:32 +0200
Message-ID: <1262127092-14878-13-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50623 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbZL2XBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:01:49 -0500
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>

that address is used by struct map_desc, which expects
an unsigned long instead of a void __iomem *. Fix it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/plat/fpga.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/fpga.h b/arch/arm/plat-omap/include/plat/fpga.h
index f1864a6..023b3eb 100644
--- a/arch/arm/plat-omap/include/plat/fpga.h
+++ b/arch/arm/plat-omap/include/plat/fpga.h
@@ -34,9 +34,9 @@ extern void omap1510_fpga_init_irq(void);
  * ---------------------------------------------------------------------------
  */
 /* maps in the FPGA registers and the ETHR registers */
-#define H2P2_DBG_FPGA_BASE		IOMEM(0xE8000000)	/* VA */
+#define H2P2_DBG_FPGA_BASE		0xE8000000		/* VA */
 #define H2P2_DBG_FPGA_SIZE		SZ_4K			/* SIZE */
-#define H2P2_DBG_FPGA_START		0x04000000		/* PA */
+#define H2P2_DBG_FPGA_START		IOMEM(0x04000000)	/* PA */
 
 #define H2P2_DBG_FPGA_ETHR_START	(H2P2_DBG_FPGA_START + 0x300)
 #define H2P2_DBG_FPGA_FPGA_REV		(H2P2_DBG_FPGA_BASE + 0x10)	/* FPGA Revision */
-- 
1.6.6.35.g1d85d

