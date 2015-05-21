From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] omap1 sparse irq support for v4.2
Date: Thu, 21 May 2015 14:11:48 +0200
Message-ID: <80194352.chs4cqVdmg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:59257 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbbEUML4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 08:11:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Wednesday 20 May 2015 15:36:05 Tony Lindgren wrote:
> Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
> to making omap1 support multiarch. After this series we still need to
> make omap1 use the common clock framework and fix up the drivers to not
> rely on includes from mach and plat directories.
> 
> Note that this branch depends on a GPIO driver fix in v4.1-rc3
> d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").
> 

I'm getting lots of build errors in linux-next, which I think are
caused by this series.

Here is my fixup. Unfortunately, this again gets us a little further
from making the drivers standalone, or at least it documents the
dependencies.

	Arnd

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 9525ef9bc6c0..ac9bd88c6b05 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -42,6 +42,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <mach/hardware.h>
 #include <mach/omap7xx.h>
 #include "mmc.h"
 
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 6e6ec93dcbb3..404f3f55726f 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 
+#include <mach/soc.h>
 #include <mach/irqs.h>
 
 #define OMAP1610_GPIO1_BASE		0xfffbe400
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 4612d2506a2d..1bb38a4aec8f 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 
+#include <mach/soc.h>
 #include <mach/irqs.h>
 
 #define OMAP7XX_GPIO1_BASE		0xfffbc000
diff --git a/arch/arm/mach-omap1/iomap.h b/arch/arm/mach-omap1/iomap.h
index f4e2d7a21365..23686204df45 100644
--- a/arch/arm/mach-omap1/iomap.h
+++ b/arch/arm/mach-omap1/iomap.h
@@ -27,6 +27,7 @@
  * Omap1 specific IO mapping
  * ----------------------------------------------------------------------------
  */
+#include <mach/hardware.h>
 
 #define OMAP1_IO_PHYS		0xFFFB0000
 #define OMAP1_IO_SIZE		0x40000
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index d1ac08016f0b..652ba6b9385e 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -22,6 +22,7 @@
 
 #include <asm/mach-types.h>
 
+#include <mach/soc.h>
 #include <mach/mux.h>
 
 #include "pm.h"
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 4118db50d5e8..1f28b5e8d6ca 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -26,6 +26,7 @@
 
 #include <asm/irq.h>
 
+#include <mach/hardware.h>
 #include <mach/mux.h>
 
 #include <mach/usb.h>
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 7502e46165fa..32c8fc0fdc15 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -38,6 +38,10 @@
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/keypad-omap.h>
 
+#ifdef CONFIG_ARCH_OMAP1
+#include <mach/hardware.h>
+#endif
+
 #undef NEW_BOARD_LEARNING_MODE
 
 static void omap_kp_tasklet(unsigned long);
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index c43f74c53cd9..c73297bd7ed4 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -15,6 +15,10 @@
 #include <linux/serial_reg.h>
 #include <linux/dmaengine.h>
 
+#ifdef CONFIG_ARCH_OMAP1
+#include <mach/soc.h>
+#endif
+
 struct uart_8250_dma {
 	int (*tx_dma)(struct uart_8250_port *p);
 	int (*rx_dma)(struct uart_8250_port *p, unsigned int iir);
diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 3af263cc0caa..1c05541bbeee 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -36,6 +36,7 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
+#include <mach/hardware.h>
 #include <mach/mux.h>
 
 #include <mach/usb.h>
diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
index 6efa2591eaa8..4e01fbbeb52f 100644
--- a/drivers/video/fbdev/omap/lcdc.c
+++ b/drivers/video/fbdev/omap/lcdc.c
@@ -30,6 +30,7 @@
 #include <linux/clk.h>
 #include <linux/gfp.h>
 
+#include <mach/hardware.h>
 #include <mach/lcdc.h>
 #include <linux/omap-dma.h>
 
diff --git a/drivers/video/fbdev/omap/sossi.c b/drivers/video/fbdev/omap/sossi.c
index d4e7684e7045..39d9d7050d78 100644
--- a/drivers/video/fbdev/omap/sossi.c
+++ b/drivers/video/fbdev/omap/sossi.c
@@ -27,6 +27,8 @@
 
 #include <linux/omap-dma.h>
 
+#include <mach/hardware.h>
+
 #include "omapfb.h"
 #include "lcdc.h"
 

