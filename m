From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] ARM: OMAP2/3: Remove L4_WK_OMAP_BASE, L4_PER_OMAP_BASE,
	L4_EMU_BASE, L3_OMAP_BASE
Date: Fri, 22 May 2009 15:39:04 -0700
Message-ID: <20090522223904.31586.95429.stgit@localhost>
References: <20090522223543.31586.44534.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64621 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757428AbZEVWjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 18:39:03 -0400
In-Reply-To: <20090522223543.31586.44534.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

These are not being used right now, and the processor specific
defines should be used instead by any code accessing these registers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/omap34xx.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index cc25733..f8d186a 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -31,13 +31,9 @@
 
 #define L4_34XX_BASE		0x48000000
 #define L4_WK_34XX_BASE		0x48300000
-#define L4_WK_OMAP_BASE		L4_WK_34XX_BASE
 #define L4_PER_34XX_BASE	0x49000000
-#define L4_PER_OMAP_BASE	L4_PER_34XX_BASE
 #define L4_EMU_34XX_BASE	0x54000000
-#define L4_EMU_BASE		L4_EMU_34XX_BASE
 #define L3_34XX_BASE		0x68000000
-#define L3_OMAP_BASE		L3_34XX_BASE
 
 #define OMAP3430_32KSYNCT_BASE	0x48320000
 #define OMAP3430_CM_BASE	0x48004800

