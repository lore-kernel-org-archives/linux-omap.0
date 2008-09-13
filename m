From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as
 default
Date: Sat, 13 Sep 2008 21:38:06 +0300 (EEST)
Message-ID: <20080913.213806.212873628.Hiroshi.DOYU@nokia.com>
References: <20080913084740.GA7007@frodo>
	<20080913.125342.137248158.Hiroshi.DOYU@nokia.com>
	<20080913.211807.00070439.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44361 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYIMSib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 14:38:31 -0400
In-Reply-To: <20080913.211807.00070439.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: me@felipebalbi.com, x00omar@ti.com, tony@atomide.com

This is the correct one;p

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as default
Date: Sat, 13 Sep 2008 21:18:07 +0300 (EEST)

<snip> 

> Instead, I did small clean-up with FB_OMAP_CONSISTENT_DMA_SIZE;)
> Inlined below:

>From cd35e28092f3830354536c08929d725f5fe99a5e Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Sat, 13 Sep 2008 20:18:11 +0300
Subject: [PATCH 1/1] ARM: OMAP: Clean up FB_OMAP_CONSISTENT_DMA_SIZE

Since this value can be limited by "range" in Kconfig and its
alignment check is done in "consistent.c", unnecessary adjustments are
removed.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/memory.h |    9 +--------
 drivers/video/omap/Kconfig               |    4 ++--
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat-omap/include/mach/memory.h
index 2d80fa2..bb96da2 100644
--- a/arch/arm/plat-omap/include/mach/memory.h
+++ b/arch/arm/plat-omap/include/mach/memory.h
@@ -89,15 +89,8 @@
 
 /* Override the ARM default */
 #ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-
-#if (CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE == 0)
-#undef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-#define CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE 2
-#endif
-
 #define CONSISTENT_DMA_SIZE \
-	(((CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE + 1) & ~1) * 1024 * 1024)
-
+	(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE * SZ_1M)
 #endif
 
 #endif
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 5ebd591..4526a1d 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -77,13 +77,13 @@ config FB_OMAP_BOOTLOADER_INIT
 config FB_OMAP_CONSISTENT_DMA_SIZE
 	int "Consistent DMA memory size (MB)"
 	depends on FB_OMAP
-	range 1 14
+	range 2 14
 	default 2
 	help
 	  Increase the DMA consistent memory size according to your video
 	  memory needs, for example if you want to use multiple planes.
 	  The size must be 2MB aligned.
-	  If unsure say 1.
+	  If unsure say 2.
 
 config FB_OMAP_DMA_TUNE
         bool "Set DMA SDRAM access priority high"
-- 
1.6.0.2.229.g1293c


