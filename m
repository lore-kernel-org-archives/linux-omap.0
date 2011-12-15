From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v4 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Wed, 14 Dec 2011 22:18:27 -0600
Message-ID: <1323922709-6986-3-git-send-email-omar.ramirez@ti.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33165 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754814Ab1LOESt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 23:18:49 -0500
In-Reply-To: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, MyungJoo Ham <myungjoo.ham@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Linux PM <linux-pm@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Add mmu hwmod data for ipu and dsp.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  154 +++++++++++++++++++++++++--
 1 files changed, 142 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index daaf165..3a29407 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -31,6 +31,7 @@
 #include <plat/i2c.h>
 #include <plat/dmtimer.h>
 #include <plat/common.h>
+#include <plat/iommu.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -1102,10 +1103,6 @@ static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
-	{ .name = "mmu_cache", .rst_shift = 1 },
-};
-
 static struct omap_hwmod_rst_info omap44xx_dsp_c0_resets[] = {
 	{ .name = "dsp", .rst_shift = 0 },
 };
@@ -1157,8 +1154,6 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.class		= &omap44xx_dsp_hwmod_class,
 	.clkdm_name	= "tesla_clkdm",
 	.mpu_irqs	= omap44xx_dsp_irqs,
-	.rst_lines	= omap44xx_dsp_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
 	.main_clk	= "dsp_fck",
 	.prcm = {
 		.omap4 = {
@@ -2507,10 +2502,6 @@ static struct omap_hwmod_rst_info omap44xx_ipu_c1_resets[] = {
 	{ .name = "cpu1", .rst_shift = 1 },
 };
 
-static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
-	{ .name = "mmu_cache", .rst_shift = 2 },
-};
-
 /* ipu master ports */
 static struct omap_hwmod_ocp_if *omap44xx_ipu_masters[] = {
 	&omap44xx_ipu__l3_main_2,
@@ -2564,8 +2555,6 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.class		= &omap44xx_ipu_hwmod_class,
 	.clkdm_name	= "ducati_clkdm",
 	.mpu_irqs	= omap44xx_ipu_irqs,
-	.rst_lines	= omap44xx_ipu_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
 	.main_clk	= "ipu_fck",
 	.prcm = {
 		.omap4 = {
@@ -3932,6 +3921,143 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
+ * 'mmu' class
+ * The memory management unit performs virtual to physical address translation
+ * for its requestors.
+ */
+
+static struct omap_hwmod_class_sysconfig mmu_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
+	.name = "mmu",
+	.sysc = &mmu_sysc,
+};
+
+/* ipu mmu */
+
+static struct omap_mmu_dev_attr ipu_mmu_dev_attr = {
+	.da_start = 0x0,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap44xx_ipu_mmu_hwmod;
+static struct omap_hwmod_irq_info omap44xx_ipu_mmu_irqs[] = {
+	{ .irq = 100 + OMAP44XX_IRQ_GIC_START, },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap44xx_ipu_mmu_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 2 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_ipu_mmu_addrs[] = {
+	{
+		.pa_start	= 0x55082000,
+		.pa_end		= 0x550820ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l3_main_1 -> ipu mmu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_1__ipu_mmu = {
+	.master		= &omap44xx_l3_main_1_hwmod,
+	.slave		= &omap44xx_ipu_mmu_hwmod,
+	.addr		= omap44xx_ipu_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ipu mmu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_ipu_mmu_slaves[] = {
+	&omap44xx_l3_main_1__ipu_mmu,
+};
+
+static struct omap_hwmod omap44xx_ipu_mmu_hwmod = {
+	.name		= "ipu_mmu",
+	.class		= &omap44xx_mmu_hwmod_class,
+	.clkdm_name	= "ducati_clkdm",
+	.mpu_irqs	= omap44xx_ipu_mmu_irqs,
+	.rst_lines	= omap44xx_ipu_mmu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_mmu_resets),
+	.main_clk	= "ipu_fck",
+	.prcm = {
+		.omap4 = {
+			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
+		},
+	},
+	.dev_attr	= &ipu_mmu_dev_attr,
+	.slaves		= omap44xx_ipu_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_ipu_mmu_slaves),
+};
+
+/* dsp mmu */
+
+static struct omap_mmu_dev_attr dsp_mmu_dev_attr = {
+	.da_start = 0x0,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap44xx_dsp_mmu_hwmod;
+static struct omap_hwmod_irq_info omap44xx_dsp_mmu_irqs[] = {
+	{ .irq = 28 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap44xx_dsp_mmu_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 1 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dsp_mmu_addrs[] = {
+	{
+		.pa_start	= 0x4a066000,
+		.pa_end		= 0x4a0660ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l3_main_1 -> dsp mmu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dsp_mmu = {
+	.master		= &omap44xx_l3_main_1_hwmod,
+	.slave		= &omap44xx_dsp_mmu_hwmod,
+	.addr		= omap44xx_dsp_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp mmu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dsp_mmu_slaves[] = {
+	&omap44xx_l3_main_1__dsp_mmu,
+};
+
+static struct omap_hwmod omap44xx_dsp_mmu_hwmod = {
+	.name		= "dsp_mmu",
+	.class		= &omap44xx_mmu_hwmod_class,
+	.clkdm_name	= "tesla_clkdm",
+	.mpu_irqs	= omap44xx_dsp_mmu_irqs,
+	.rst_lines	= omap44xx_dsp_mmu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_mmu_resets),
+	.main_clk	= "dsp_fck",
+	.prcm = {
+		.omap4 = {
+			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
+		},
+	},
+	.dev_attr	= &dsp_mmu_dev_attr,
+	.slaves		= omap44xx_dsp_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dsp_mmu_slaves),
+};
+
+/*
  * 'smartreflex' class
  * smartreflex module (monitor silicon performance and outputs a measure of
  * performance error)
@@ -5388,6 +5514,10 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
 
+	/* mmu class */
+	&omap44xx_ipu_mmu_hwmod,
+	&omap44xx_dsp_mmu_hwmod,
+
 	/* smartreflex class */
 	&omap44xx_smartreflex_core_hwmod,
 	&omap44xx_smartreflex_iva_hwmod,
-- 
1.7.4.1

