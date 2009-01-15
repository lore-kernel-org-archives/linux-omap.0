From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/10] ARM: OMAP: Fix compile for h3 MMC
Date: Thu, 15 Jan 2009 14:13:26 +0200
Message-ID: <20090115121325.GC4128@atomide.com>
References: <20090112143405.24205.52151.stgit@localhost> <20090112145005.24205.31628.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49822 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbZAOMNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 07:13:25 -0500
Content-Disposition: inline
In-Reply-To: <20090112145005.24205.31628.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Fix compile for h3 MMC

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/board-h3.h b/arch/arm/plat-omap/include/mach/board-h3.h
index 14909dc..1888326 100644
--- a/arch/arm/plat-omap/include/mach/board-h3.h
+++ b/arch/arm/plat-omap/include/mach/board-h3.h
@@ -30,7 +30,9 @@
 /* In OMAP1710 H3 the Ethernet is directly connected to CS1 */
 #define OMAP1710_ETHR_START		0x04000300
 
+#define H3_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
+#	define H3_TPS_GPIO_MMC_PWR_EN	(H3_TPS_GPIO_BASE + 4)
+
 extern void h3_mmc_init(void);
-extern void h3_mmc_slot_cover_handler(void *arg, int state);
 
 #endif /*  __ASM_ARCH_OMAP_H3_H */
