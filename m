From: jean.pihet@newoldbits.com
Subject: [PATCH] ARM: OMAP: SmartReflex: select CONFIG_POWER_SUPPLY in Kconfig
Date: Thu, 20 Sep 2012 16:36:56 +0200
Message-ID: <1348151816-30248-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56266 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab2ITOhV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 10:37:21 -0400
Received: by wgbdr13 with SMTP id dr13so521395wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 07:37:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Select POWER_SUPPLY from POWER_AVS_OMAP entry in Kconfig.

This avoids the following build problems using a randconfig
that has CONFIG_POWER_SUPPLY not set:

  LD      init/built-in.o
arch/arm/mach-omap2/built-in.o: In function `sr_class3_configure':
arch/arm/mach-omap2/smartreflex-class3.c:44: undefined reference to `sr_configure_errgen'
arch/arm/mach-omap2/built-in.o: In function `sr_class3_disable':
arch/arm/mach-omap2/smartreflex-class3.c:33: undefined reference to `sr_disable_errgen'
arch/arm/mach-omap2/smartreflex-class3.c:35: undefined reference to `sr_disable'
arch/arm/mach-omap2/built-in.o: In function `sr_class3_enable':
arch/arm/mach-omap2/smartreflex-class3.c:28: undefined reference to `sr_enable'
arch/arm/mach-omap2/built-in.o: In function `sr_class3_init':
arch/arm/mach-omap2/smartreflex-class3.c:59: undefined reference to `sr_register_class'
make: *** [vmlinux] Error 1

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index dd36eba..001a795 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -48,6 +48,7 @@ config OMAP_DEBUG_LEDS
 config POWER_AVS_OMAP
 	bool "AVS(Adaptive Voltage Scaling) support for OMAP IP versions 1&2"
 	depends on POWER_AVS && (ARCH_OMAP3 || ARCH_OMAP4) && PM
+	select POWER_SUPPLY
 	help
 	  Say Y to enable AVS(Adaptive Voltage Scaling)
 	  support on OMAP containing the version 1 or
-- 
1.7.7.6

