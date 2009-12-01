From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 8/9] arm: omap: perseus: kill compile warning on board-perseus2.c
Date: Tue,  1 Dec 2009 20:29:45 +0200
Message-ID: <1259692185-17511-1-git-send-email-felipe.balbi@nokia.com>
References: <20091201155256.GE4348@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33234 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbZLAS3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 13:29:52 -0500
In-Reply-To: <20091201155256.GE4348@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

that address is used by struct map_desc, which expects
an unsigned long instead of a void __iomem *. Fix it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/plat/fpga.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/fpga.h b/arch/arm/plat-omap/include/plat/fpga.h
index db2af50..99edbf8 100644
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
1.6.6.rc0

