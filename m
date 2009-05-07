From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP2/3: Move define of OMAP2_VA_IC_BASE to be local
	to entry-macro.S
Date: Thu, 07 May 2009 13:42:59 -0700
Message-ID: <20090507204259.7461.59155.stgit@localhost>
References: <20090507203552.7461.35051.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61994 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763330AbZEGUm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:42:59 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=[127.0.0.1])
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1M2AQm-0007U3-8f
	for linux-omap@vger.kernel.org; Thu, 07 May 2009 20:43:00 +0000
In-Reply-To: <20090507203552.7461.35051.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Move define of OMAP2_VA_IC_BASE to be local to entry-macro.S

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/entry-macro.S |    9 ++++++---
 arch/arm/plat-omap/include/mach/omap24xx.h    |    2 --
 arch/arm/plat-omap/include/mach/omap34xx.h    |    1 -
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index 2276f89..33256a0 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -58,11 +58,14 @@
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
-#if defined(CONFIG_ARCH_OMAP24XX)
 #include <mach/omap24xx.h>
-#endif
-#if defined(CONFIG_ARCH_OMAP34XX)
 #include <mach/omap34xx.h>
+
+/* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
+#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
+#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP24XX_IC_BASE)
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
 #endif
 
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
diff --git a/arch/arm/plat-omap/include/mach/omap24xx.h b/arch/arm/plat-omap/include/mach/omap24xx.h
index 10a6413..4ce9b6a 100644
--- a/arch/arm/plat-omap/include/mach/omap24xx.h
+++ b/arch/arm/plat-omap/include/mach/omap24xx.h
@@ -89,13 +89,11 @@
 
 #define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2420_CM_BASE
-#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 
 #elif defined(CONFIG_ARCH_OMAP2430)
 
 #define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2430_CM_BASE
-#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 
 #endif
 
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 4233064..36c99ca 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -86,7 +86,6 @@
 #if defined(CONFIG_ARCH_OMAP3430)
 
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
-#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
 
 #endif
 

