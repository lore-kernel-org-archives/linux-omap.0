From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 5/5] OMAP: HWMOD: Unify DSS resets for all OMAPs
Date: Mon,  8 Aug 2011 12:15:14 +0300
Message-ID: <1312794914-22894-6-git-send-email-tomi.valkeinen@ti.com>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55179 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752416Ab1HHJPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 05:15:36 -0400
Received: by mail-ey0-f172.google.com with SMTP id 4so3722851eye.17
        for <linux-omap@vger.kernel.org>; Mon, 08 Aug 2011 02:15:34 -0700 (PDT)
In-Reply-To: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds a custom DSS reset function used on all OMAP's.

The function doesn't actually do a reset, it only waits for the reset to
complete. The reason for this is that on OMAP4 there is no possibility
to do a SW reset, and on OMAP2/3 doing a SW reset for dss_core resets
all the other DSS modules also, thus breaking the HWMOD model where
every DSS module is independent.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/common-board-devices.h         |    4 ++
 arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +
 4 files changed, 43 insertions(+), 0 deletions(-)

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
-- 
1.7.4.1

