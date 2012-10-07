From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] ARM: OMAP: Fix dependency for OMAP_DEBUG_LEDS
Date: Sun, 07 Oct 2012 18:13:25 +0800
Message-ID: <1349604805.6017.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48426 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2JGKNh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Oct 2012 06:13:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3179651pbb.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Oct 2012 03:13:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Bryan Wu <bryan.wu@canonical.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This fixes below build error when CONFIG_LEDS_CLASS is not set.

  LD      init/built-in.o
arch/arm/plat-omap/built-in.o: In function `fpga_probe':
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/built-in.o:arch/arm/plat-omap/debug-leds.c:113: more undefined references to `led_classdev_register' follow
make: *** [vmlinux] Error 1

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/plat-omap/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ca83a76..c262781 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -43,6 +43,7 @@ config OMAP_DEBUG_DEVICES
 
 config OMAP_DEBUG_LEDS
 	def_bool y if NEW_LEDS
+	select LEDS_CLASS
 	depends on OMAP_DEBUG_DEVICES
 
 config POWER_AVS_OMAP
-- 
1.7.9.5



