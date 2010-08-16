From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/4] omap4: control: Add ctrl_pad_base to omap_globals
Date: Mon, 16 Aug 2010 19:34:39 +0530
Message-ID: <1281967479-9515-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58009 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab0HPOEr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 10:04:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On omap4 control module is divided in four IP blocks.
- CTRL_MODULE_CORE			0x4a002000
- CTRL_MODULE_PAD_CORE		0x4a100000
- CTRL_MODULE_WKUP			0x4a30c000
- CTRL_MODULE_PAD_WKUP		0x4a31e000

Addressing all the modules with single base address is not possible
considering 16 bit offsets. The mux code manages the pad core and pad
wakeup related base address inside the mux framework. For other usage
only control core and control pad bases are necessary. So this patch
maps only needed pad control base address which is used by device drivers
and infrastructure code

The main control core base is still kept same in this patch to
keep git-bisect working. This will be fixed in the relevant patch
in this series.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/control.c            |    7 +++++++
 arch/arm/plat-omap/common.c              |    3 ++-
 arch/arm/plat-omap/include/plat/common.h |    1 +
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a8d20ee..99c0eb6 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -25,6 +25,7 @@
 #include "sdrc.h"
 
 static void __iomem *omap2_ctrl_base;
+static void __iomem *omap4_ctrl_pad_base;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
@@ -145,6 +146,12 @@ void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
 		omap2_ctrl_base = ioremap(omap2_globals->ctrl, SZ_4K);
 		WARN_ON(!omap2_ctrl_base);
 	}
+
+	/* Static mapping, never released */
+	if (omap2_globals->ctrl_pad) {
+		omap4_ctrl_pad_base = ioremap(omap2_globals->ctrl_pad, SZ_4K);
+		WARN_ON(!omap4_ctrl_pad_base);
+	}
 }
 
 void __iomem *omap_ctrl_base_get(void)
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3008e71..480718b 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -336,7 +336,8 @@ void __init omap3_map_io(void)
 static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-	.ctrl	= OMAP443X_CTRL_BASE,
+	.ctrl	= OMAP443X_CTRL_BASE,	/* FIXME: Move this to control core */
+	.ctrl_pad	= OMAP443X_CTRL_BASE,
 	.prm	= OMAP4430_PRM_BASE,
 	.cm	= OMAP4430_CM_BASE,
 	.cm2	= OMAP4430_CM2_BASE,
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 9776b41..7cd0180 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -47,6 +47,7 @@ struct omap_globals {
 	unsigned long   sdrc;           /* SDRAM Controller */
 	unsigned long   sms;            /* SDRAM Memory Scheduler */
 	unsigned long   ctrl;           /* System Control Module */
+	unsigned long   ctrl_pad;	/* PAD Control Module */
 	unsigned long   prm;            /* Power and Reset Management */
 	unsigned long   cm;             /* Clock Management */
 	unsigned long   cm2;
-- 
1.6.0.4

