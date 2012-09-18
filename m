From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ARM: OMAP: OMAP_DEBUG_LEDS needs to select LEDS_CLASS
Date: Tue, 18 Sep 2012 11:30:42 +0800
Message-ID: <1347939042.15578.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This fixes below build error when CONFIG_LEDS_CLASS is not set.

  LD      init/built-in.o
arch/arm/plat-omap/built-in.o: In function `fpga_probe':
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
make: *** [vmlinux] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
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
