From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 8/9] arm: omap: perseus: kill compile warning on board-perseus2.c
Date: Tue,  1 Dec 2009 15:03:54 +0200
Message-ID: <1259672635-12306-9-git-send-email-felipe.balbi@nokia.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22957 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbZLANFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:05:20 -0500
In-Reply-To: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

that address is used by struct map_desc, which expects
an unsigned long instead of a void __iomem *. Fix it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/plat/fpga.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/fpga.h b/arch/arm/plat-omap/include/plat/fpga.h
index 87a87d2..d66164d 100644
--- a/arch/arm/plat-omap/include/plat/fpga.h
+++ b/arch/arm/plat-omap/include/plat/fpga.h
@@ -34,7 +34,7 @@ extern void omap1510_fpga_init_irq(void);
  * ---------------------------------------------------------------------------
  */
 /* maps in the FPGA registers and the ETHR registers */
-#define H2P2_DBG_FPGA_BASE		IOMEM(0xE8000000)	/* VA */
+#define H2P2_DBG_FPGA_BASE		0xE8000000		/* VA */
 #define H2P2_DBG_FPGA_SIZE		SZ_4K			/* SIZE */
 #define H2P2_DBG_FPGA_START		0x04000000		/* PA */
 
-- 
1.6.6.rc0

