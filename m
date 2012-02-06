From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP2: Fix the OMAP2 only build break seen with 2011+ ARM tool-chains
Date: Mon, 6 Feb 2012 15:49:47 +0530
Message-ID: <1328523587-21341-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48390 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab2BFKT7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Feb 2012 05:19:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

With the latest Sourcery G++ Lite 2011.03-41 and latest linaro
tool-chains OMAP2 only build breaks with below error.

arch/arm/mach-omap2/omap-smc.S: Assembler messages:
arch/arm/mach-omap2/omap-smc.S:30: Error: selected processor does not support ARM mode `smc #0'
arch/arm/mach-omap2/omap-smc.S:53: Error: selected processor does not support ARM mode `smc #0'
arch/arm/mach-omap2/omap-smc.S:61: Error: selected processor does not support ARM mode `smc #0'
arch/arm/mach-omap2/omap-smc.S:69: Error: selected processor does not support ARM mode `smc #0'
arch/arm/mach-omap2/omap-smc.S:77: Error: selected processor does not support ARM mode `smc #0'
make[1]: *** [arch/arm/mach-omap2/omap-smc.o] Error 1

OMAP2 devices doesn't have the security support but the security support
was getting built because of OMAP2PLUS. Don't build security code for
OMAP2 devices.

While at it, fix the secure-common line in the Makefile to use tabs
instead of spaces.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile                  |    4 ++--
 arch/arm/plat-omap/include/plat/omap-secure.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fc9b238..bd76394 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,9 +11,9 @@ hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
 					  clkt_dpll.o clkt_clksel.o
-secure-common                          = omap-smc.o omap-secure.o
+secure-common				= omap-smc.o omap-secure.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
 
diff --git a/arch/arm/plat-omap/include/plat/omap-secure.h b/arch/arm/plat-omap/include/plat/omap-secure.h
index 0f14fb7..8c7994c 100644
--- a/arch/arm/plat-omap/include/plat/omap-secure.h
+++ b/arch/arm/plat-omap/include/plat/omap-secure.h
@@ -3,7 +3,7 @@
 
 #include <linux/types.h>
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 extern int omap_secure_ram_reserve_memblock(void);
 #else
 static inline void omap_secure_ram_reserve_memblock(void)
-- 
1.7.4.1

