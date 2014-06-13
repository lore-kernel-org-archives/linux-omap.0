From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/14] ARM: omap2: fix am43xx dependency on l2x0 cache
Date: Fri, 13 Jun 2014 18:01:04 +0200
Message-ID: <1402675276-538682-3-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53405 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaFMQCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 12:02:01 -0400
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Commit d941f86fad41b ("ARM: l2c: AM43x: add L2 cache support") enabled
the L2 cache support for the am43xx SoC, but caused a build regression
when the driver for that cache controller is disabled:

arch/arm/mach-omap2/built-in.o: In function `am43xx_init_early':
:(.init.text+0xb20): undefined reference to `omap_l2_cache_init'

This did not happen for OMAP4, which has the same call, but enables
the l2x0 driver unconditionally. We could do the same thing for
am43xx, but it seems better to allow turning it off and make the
code work in either case.

This adds an inline wrapper for omap_l2_cache_init for the disabled
case, and removes the 'select' from OMAP4 so it becomes a user
visible option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 arch/arm/mach-omap2/Kconfig          | 1 -
 arch/arm/mach-omap2/common.h         | 7 +++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 59066cf..536a137 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -32,6 +32,7 @@ CONFIG_SOC_OMAP5=y
 CONFIG_SOC_AM33XX=y
 CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
+CONFIG_CACHE_L2X0=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_SMP=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0ba4826..2085b3d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -28,7 +28,6 @@ config ARCH_OMAP4
 	select ARM_CPU_SUSPEND if PM
 	select ARM_ERRATA_720789
 	select ARM_GIC
-	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select OMAP_INTERCONNECT
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index ff02973..a373d50 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -91,7 +91,14 @@ extern void omap3_sync32k_timer_init(void);
 extern void omap3_secure_sync32k_timer_init(void);
 extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
+#ifdef CONFIG_CACHE_L2X0
 int omap_l2_cache_init(void);
+#else
+static inline int omap_l2_cache_init(void)
+{
+	return 0;
+}
+#endif
 extern void omap5_realtime_timer_init(void);
 
 void omap2420_init_early(void);
-- 
1.8.3.2

