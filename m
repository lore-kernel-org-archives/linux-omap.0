From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 5/5] OMAP: HWMOD: Unify DSS resets for all OMAPs
Date: Fri, 19 Aug 2011 23:30:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108192327470.24016@utopia.booyaka.com>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com> <1312794914-22894-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60908 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab1HTFaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Aug 2011 01:30:11 -0400
In-Reply-To: <1312794914-22894-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, archit@ti.com

Hi Tomi,

On Mon, 8 Aug 2011, Tomi Valkeinen wrote:

> This patch adds a custom DSS reset function used on all OMAP's.
> 
> The function doesn't actually do a reset, it only waits for the reset to
> complete. The reason for this is that on OMAP4 there is no possibility
> to do a SW reset, and on OMAP2/3 doing a SW reset for dss_core resets
> all the other DSS modules also, thus breaking the HWMOD model where
> every DSS module is independent.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

This one doesn't build when !CONFIG_OMAP2_DSS - the following is the 
updated patch.


- Paul

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 19 Aug 2011 17:00:46 -0600
Subject: [PATCH] OMAP: HWMOD: Unify DSS resets for all OMAPs

This patch adds a custom DSS reset function used on all OMAP's.

The function doesn't actually do a reset, it only waits for the reset to
complete. The reason for this is that on OMAP4 there is no possibility
to do a SW reset, and on OMAP2/3 doing a SW reset for dss_core resets
all the other DSS modules also, thus breaking the HWMOD model where
every DSS module is independent.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[paul@pwsan.com: modified to build arch/arm/mach-omap2/display.o
 unconditionally to avoid an error when !CONFIG_OMAP2_DSS]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                       |    5 +--
 arch/arm/mach-omap2/common-board-devices.h         |    4 ++
 arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +
 include/video/omapdss.h                            |    7 ----
 6 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..bf85539 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o
+	 common.o gpio.o dma.o wd_timer.o display.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
@@ -276,7 +276,4 @@ smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
 obj-y					+= $(smsc911x-m) $(smsc911x-y)
 obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
 
-disp-$(CONFIG_OMAP2_DSS)		:= display.o
-obj-y					+= $(disp-m) $(disp-y)
-
 obj-y					+= common-board-devices.o twl-common.o
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index a0b4a428..0aeb74f 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -5,6 +5,8 @@
 
 #define NAND_BLOCK_SIZE	SZ_128K
 
+struct omap_hwmod;
+
 struct mtd_partition;
 struct ads7846_platform_data;
 
@@ -12,4 +14,6 @@ void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		       struct ads7846_platform_data *board_pdata);
 void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
 
+int omap_dss_reset(struct omap_hwmod *);
+
 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index a5b7a23..cdb675a 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -26,6 +26,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
+#include <plat/common.h>
 
 static struct platform_device omap_display_device = {
 	.name          = "omapdss",
@@ -126,3 +127,37 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 
 	return r;
 }
+
+#define MAX_MODULE_SOFTRESET_WAIT	10000
+int omap_dss_reset(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_opt_clk *oc;
+	int c = 0;
+	int i, r;
+
+	if (!(oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)) {
+		pr_err("dss_core: hwmod data doesn't contain reset data\n");
+		return -EINVAL;
+	}
+
+	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
+		if (oc->_clk)
+			clk_enable(oc->_clk);
+
+	omap_test_timeout((omap_hwmod_read(oh, oh->class->sysc->syss_offs)
+				& SYSS_RESETDONE_MASK),
+			MAX_MODULE_SOFTRESET_WAIT, c);
+
+	if (c == MAX_MODULE_SOFTRESET_WAIT)
+		pr_warning("dss_core: waiting for reset to finish failed\n");
+	else
+		pr_debug("dss_core: softreset done\n");
+
+	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
+		if (oc->_clk)
+			clk_disable(oc->_clk);
+
+	r = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
+
+	return r;
+}
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index d78c132..c696420 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 
 #include "omap_hwmod_common_data.h"
+#include "common-board-devices.h"
 
 /* UART */
 
@@ -51,6 +52,7 @@ static struct omap_hwmod_class_sysconfig omap2_dss_sysc = {
 struct omap_hwmod_class omap2_dss_hwmod_class = {
 	.name	= "dss",
 	.sysc	= &omap2_dss_sysc,
+	.reset	= omap_dss_reset,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 8b74058..27969e6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -37,6 +37,7 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "wd_timer.h"
+#include "common-board-devices.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
 #define OMAP44XX_IRQ_GIC_START	32
@@ -1204,6 +1205,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_dss_sysc = {
 static struct omap_hwmod_class omap44xx_dss_hwmod_class = {
 	.name	= "dss",
 	.sysc	= &omap44xx_dss_sysc,
+	.reset	= omap_dss_reset,
 };
 
 /* dss */
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3b55ef2..105b05d 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -245,15 +245,8 @@ struct omap_dss_board_info {
 	void (*dsi_mux_pads)(bool enable);
 };
 
-#if defined(CONFIG_OMAP2_DSS_MODULE) || defined(CONFIG_OMAP2_DSS)
 /* Init with the board info */
 extern int omap_display_init(struct omap_dss_board_info *board_data);
-#else
-static inline int omap_display_init(struct omap_dss_board_info *board_data)
-{
-	return 0;
-}
-#endif
 
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
-- 
1.7.5.4

