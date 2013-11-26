From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/12 diet] ARM: OMAP2+: Remove legacy mux code
Date: Mon, 25 Nov 2013 17:26:47 -0800
Message-ID: <20131126012647.GB26766@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12330 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab3KZB0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 20:26:51 -0500
Content-Disposition: inline
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

We can now use drivers/pinctrl-single.c instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Here's a diet version of this patch that does not remove the mux*.[ch]
files because it was too big for the mailing lists.

The full version of the patch is available at:

http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/?id=10f4ba76928338e78a63c7f68e5a491bdbc46554

And it also removes the following:

 arch/arm/mach-omap2/mux.c          | 1161 --------------------
 arch/arm/mach-omap2/mux.h          |  355 ------
 arch/arm/mach-omap2/mux34xx.c      | 2061 -------------------------------------
 arch/arm/mach-omap2/mux34xx.h      |  402 -------


diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 66b7218..8e6b0a4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o fb.o gpmc.o timer.o pm.o \
+obj-y := id.o io.o control.o devices.o fb.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
 	 omap_device.o sram.o drm.o
 
@@ -64,9 +64,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap4-restart.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap4-restart.o
 obj-$(CONFIG_SOC_DRA7XX)		+= omap4-restart.o
 
-# Pin multiplexing
-obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
-
 # SMS/SDRC
 obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 240db38..a3040a4 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -69,15 +69,6 @@ static inline int omap4_pm_init(void)
 }
 #endif
 
-#ifdef CONFIG_OMAP_MUX
-int omap_mux_late_init(void);
-#else
-static inline int omap_mux_late_init(void)
-{
-	return 0;
-}
-#endif
-
 extern void omap2_init_common_infrastructure(void);
 
 extern void omap2_sync32k_timer_init(void);
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 86e98c5..6b0c446 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -32,7 +32,6 @@
 
 #include "soc.h"
 #include "dss-common.h"
-#include "mux.h"
 
 #define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index cd22262..88b1d5d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -396,7 +396,6 @@ static void __init omap_hwmod_init_postsetup(void)
 
 static void __init __maybe_unused omap_common_late_init(void)
 {
-	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap_soc_device_init();
 }
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index 828e0db..aaea57c 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -30,7 +30,6 @@
 #include "control.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
-#include "mux.h"
 #include "mmc.h"
 
 /*
