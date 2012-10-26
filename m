From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap plat header removal for v3.8 merge window,
 part1
Date: Fri, 26 Oct 2012 15:38:49 -0700
Message-ID: <20121026223848.GY11908@atomide.com>
References: <20121019023300.GN30550@atomide.com>
 <201210261402.19759.arnd@arndb.de>
 <20121026170949.GF11908@atomide.com>
 <201210261728.22132.arnd@arndb.de>
 <20121026175537.GL11908@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51508 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966778Ab2JZWi5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 18:38:57 -0400
Content-Disposition: inline
In-Reply-To: <20121026175537.GL11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

* Tony Lindgren <tony@atomide.com> [121026 10:57]:
> * Arnd Bergmann <arnd@arndb.de> [121026 10:30]:
> > 
> > Well, once CONFIG_MULTIPLATFORM gets enabled, the mach/*.h files are
> > not visible to drivers any more, but they are still visible to files
> > in plat-omap if you add a line like
> > 
> > ccflags-$(CONFIG_ARCH_OMAP2) := -I$(srctree)/arch/arm/mach-omap2/include
> > ccflags-$(CONFIG_ARCH_OMAP1) := -I$(srctree)/arch/arm/mach-omap1/include
> > 
> > to arch/arm/plat-omap/Makefile. That is how the other multiplatform
> > Makefiles do it. If a driver writer really wants to cheat, they can of
> > course do the same thing in their directory, but they can also do
> > #include "../../../../arch/arm/mach-omap2/foo.h"
> 
> OK thanks for clarifying that. Sounds like that can be used to
> fix up the relative includes for plat-omap. I'll do some patches
> for that after we have the #include <plat/*.h> and #include <mach/*.h>
> issue sorted out.

Here's a patch for that. It's against what I have queued up in
omap-for-v3.8/cleanup-headers. Does that look OK to you?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Fri, 26 Oct 2012 15:06:40 -0700
Subject: [PATCH] ARM: OMAP: Fix relative includes for plat-omap with ccflags

As suggested by Arnd Bergmann <arnd@arndb.de>, we can keep
these headers local to arch/arm/*omap*/ by modifying the
ccflags in plat/omap/Makefile.

Note that eventually even most of these will go away
as things like SRAM and PRCM become just regular device
drivers.

Also note that this will not fix plat/cpu.h, but that
will be removed anyways as soon as the drivers are
fixed.

While at it, also sort the includes the standard way.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index cd169c3..03b1e80 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-$(CONFIG_ARCH_OMAP) := -I$(srctree)/arch/arm
+
 # Common support
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
 obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 931f3f6..031fa3f 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -24,7 +24,7 @@
 
 #include <mach/hardware.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 28aea55..96b2fa7d 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -21,14 +21,12 @@
 #include <linux/delay.h>
 
 #include <asm/mach-types.h>  /* for machine_is_* */
-
-#include "soc.h"
-
 #include <mach/hardware.h>
 #include <mach/usb.h>   /* for OTG_BASE */
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
+#include "soc.h"
 #include "iomap.h"
 #include "clock.h"
 
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 26e19d3..acd1797 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -26,11 +26,11 @@
 #ifndef __ARCH_ARM_MACH_OMAP1_COMMON_H
 #define __ARCH_ARM_MACH_OMAP1_COMMON_H
 
-#include "../plat-omap/common.h"
 #include <linux/mtd/mtd.h>
 #include <linux/i2c-omap.h>
 
-#include "../plat-omap/i2c.h"
+#include <plat-omap/common.h>
+#include <plat-omap/i2c.h>
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 void omap7xx_map_io(void);
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 645668e..07e6065 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -21,12 +21,11 @@
 
 #include <mach/tc.h>
 #include <mach/mux.h>
-
 #include <mach/omap7xx.h>
 #include <mach/camera.h>
 #include <mach/hardware.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "common.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 32bcbb8..8ee5892e 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -20,10 +20,12 @@
  */
 
 #include <linux/i2c-omap.h>
+
 #include <mach/mux.h>
-#include "soc.h"
 
-#include "../plat-omap/i2c.h"
+#include <plat-omap/i2c.h>
+
+#include "soc.h"
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index b2c2328..d8b0c7d 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -56,7 +56,7 @@
 
 #include <mach/irqs.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "iomap.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 46d9071..1a9d9b9 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-$(CONFIG_ARCH_OMAP) := -I$(srctree)/arch/arm
+
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
@@ -75,7 +77,7 @@ obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
 obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
-AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec) -I$(srctree)/arch/arm
 
 ifeq ($(CONFIG_PM_VERBOSE),y)
 CFLAGS_pm_bus.o				+= -DDEBUG
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 3432f91..9bd6ff4 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -25,7 +25,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index c66276b..ddf2e31 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -33,7 +33,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "soc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 5510d92..4f6e19e 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "clock.h"
 #include "clock3xxx.h"
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index b4938ab..b95c766 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -22,7 +22,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "../plat-omap/common.h"
+#include <plat-omap/common.h>
 
 #include "cm.h"
 #include "cm33xx.h"
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index c925c80..0f461d6 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -34,7 +34,7 @@
 
 #include <asm/proc-fns.h>
 
-#include "../plat-omap/common.h"
+#include <plat-omap/common.h>
 
 #include "i2c.h"
 #include "serial.h"
diff --git a/arch/arm/mach-omap2/i2c.h b/arch/arm/mach-omap2/i2c.h
index 81dbb99..e8b3b72 100644
--- a/arch/arm/mach-omap2/i2c.h
+++ b/arch/arm/mach-omap2/i2c.h
@@ -19,7 +19,7 @@
  *
  */
 
-#include "../plat-omap/i2c.h"
+#include <plat-omap/i2c.h>
 
 #ifndef __MACH_OMAP2_I2C_H
 #define __MACH_OMAP2_I2C_H
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4fadc78..629f7af 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -26,8 +26,7 @@
 #include <asm/mach/map.h>
 
 #include <plat-omap/dma-omap.h>
-
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "omap_hwmod.h"
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index d25845c..d1cc30d 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -25,7 +25,7 @@
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "omap-wakeupgen.h"
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 05c6a59..4ecddad 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -11,8 +11,7 @@
  */
 
 #include <plat-omap/dma-omap.h>
-
-#include "../plat-omap/common.h"
+#include <plat-omap/common.h>
 
 #include "omap_hwmod.h"
 #include "hdq1w.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5b9be73..2446a5e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -23,14 +23,13 @@
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
 
-#include <plat-omap/dma-omap.h>
-
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <plat/dmtimer.h>
 #include <plat/iommu.h>
 
-#include "../plat-omap/common.h"
+#include <plat-omap/common.h>
+#include <plat-omap/dma-omap.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6d17e044..7ff08f8 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -37,8 +37,7 @@
 #include <asm/system_misc.h>
 
 #include <plat-omap/dma-omap.h>
-
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 160fa25..541eda1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -38,9 +38,9 @@
 #include "clockdomain.h"
 #include "powerdomain.h"
 #include <plat/prcm.h>
-#include <plat-omap/dma-omap.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/dma-omap.h>
+#include <plat-omap/sram.h>
 
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 624ade5..5df23da 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -19,7 +19,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "../plat-omap/common.h"
+#include <plat-omap/common.h>
 
 #include "common.h"
 #include "prm33xx.h"
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 6fabbd8..6d96d95 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -24,9 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 
-#include "../plat-omap/common.h"
 #include <plat/prcm.h>
 
+#include <plat-omap/common.h>
+
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 94d4082..e6bb257 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -23,7 +23,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "common.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 3b8bfdf..0012cb9 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,7 +24,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 75afe11..2eeac9f 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -26,7 +26,7 @@
 
 #include <asm/assembler.h>
 
-#include "../plat-omap/sram.h"
+#include <plat-omap/sram.h>
 
 #include "omap34xx.h"
 #include "iomap.h"
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 4bd0ace..90ffae7 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-$(CONFIG_ARCH_OMAP) := -I$(srctree)/arch/arm
+
 # Common support
 obj-y := common.o sram.o dma.o fb.o counter_32k.o
 obj-m :=
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index 5a4678e..a53f09ab0 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -16,7 +16,8 @@
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
-#include "../mach-omap2/debug-devices.h"
+
+#include <mach-omap2/debug-devices.h>
 
 /* Many OMAP development platforms reuse the same "debug board"; these
  * platforms include H2, H3, H4, and Perseus2.
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 49803cc..99f437f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -38,8 +38,8 @@
 
 #include <plat-omap/dma-omap.h>
 
-#include "../mach-omap1/soc.h"
-#include "../mach-omap2/soc.h"
+#include <mach-omap1/soc.h>
+#include <mach-omap2/soc.h>
 
 /*
  * MAX_LOGICAL_DMA_CH_COUNT: the maximum number of logical DMA
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4a0b30a..2cd1b0d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -45,7 +45,7 @@
 
 #include <mach/hardware.h>
 
-#include "../mach-omap2/omap-pm.h"
+#include <mach-omap2/omap-pm.h>
 
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index be6deb7..2c6c266 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -33,8 +33,8 @@
 
 #include <mach/irqs.h>
 
-#include "../mach-omap1/soc.h"
-#include "../mach-omap2/soc.h"
+#include <mach-omap1/soc.h>
+#include <mach-omap2/soc.h>
 
 #include "i2c.h"
 
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 198685b..64e3ebc 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -22,8 +22,8 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 
-#include "../mach-omap2/omap_device.h"
-#include "../mach-omap2/omap-pm.h"
+#include <mach-omap2/omap_device.h>
+#include <mach-omap2/omap-pm.h>
 
 static bool off_mode_enabled;
 static int dummy_context_loss_counter;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 70dcc22..e47a033 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -25,16 +25,14 @@
 
 #include <asm/mach/map.h>
 
-#include "../mach-omap1/soc.h"
-#include "../mach-omap2/soc.h"
+#include <mach-omap1/soc.h>
+#include <mach-omap2/soc.h>
+#include <mach-omap2/iomap.h>
+#include <mach-omap2/prm2xxx_3xxx.h>
+#include <mach-omap2/sdrc.h>
 
 #include "sram.h"
 
-/* XXX These "sideways" includes will disappear when sram.c becomes a driver */
-#include "../mach-omap2/iomap.h"
-#include "../mach-omap2/prm2xxx_3xxx.h"
-#include "../mach-omap2/sdrc.h"
-
 #define OMAP1_SRAM_PA		0x20000000
 #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
 #define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
