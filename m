From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
Date: Wed, 14 Dec 2011 22:18:26 -0600
Message-ID: <1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:42643 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755957Ab1LOESq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 23:18:46 -0500
In-Reply-To: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, MyungJoo Ham <myungjoo.ham@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Linux PM <linux-pm@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Add mmu hwmod data for iva and isp.

Due to compatibility an ifdef CONFIG_OMAP_IOMMU_IVA2 needs to be
propagated (previously on iommu resource info) to hwmod data in OMAP3,
so users of iommu and tidspbridge can avoid issues of two modules
managing mmu data/irqs/resets; this until tidspbridge can be migrated
to iommu framework.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  135 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/iommu.h    |   13 +++
 2 files changed, 148 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7f8915a..6afd925 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -26,6 +26,7 @@
 #include <plat/mcbsp.h>
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
+#include <plat/iommu.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2947,6 +2948,132 @@ static struct omap_hwmod omap34xx_mcspi4 = {
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
+static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
+	.name = "mmu",
+	.sysc = &mmu_sysc,
+};
+
+/* isp mmu */
+
+static struct omap_mmu_dev_attr isp_mmu_dev_attr = {
+	.da_start = 0x0,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 8,
+};
+
+static struct omap_hwmod omap3xxx_isp_mmu_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_isp_mmu_irqs[] = {
+	{ .irq = 24 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_addr_space omap3xxx_isp_mmu_addrs[] = {
+	{
+		.pa_start	= 0x480bd400,
+		.pa_end		= 0x480bd47f,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l4_core -> isp mmu */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__isp_mmu = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_isp_mmu_hwmod,
+	.addr		= omap3xxx_isp_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* isp mmu slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] = {
+	&omap3xxx_l4_core__isp_mmu,
+};
+
+static struct omap_hwmod omap3xxx_isp_mmu_hwmod = {
+	.name		= "isp_mmu",
+	.class		= &omap3xxx_mmu_hwmod_class,
+	.mpu_irqs	= omap3xxx_isp_mmu_irqs,
+	.main_clk	= "cam_ick",
+	.dev_attr	= &isp_mmu_dev_attr,
+	.slaves		= omap3xxx_isp_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_isp_mmu_slaves),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* iva mmu */
+
+static struct omap_mmu_dev_attr iva_mmu_dev_attr = {
+	.da_start = 0x11000000,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap3xxx_iva_mmu_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_iva_mmu_irqs[] = {
+	{ .irq = 28 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap3xxx_iva_mmu_resets[] = {
+	{ .name = "mmu", .rst_shift = 1, .st_shift = 9 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_iva_mmu_addrs[] = {
+	{
+		.pa_start	= 0x5d000000,
+		.pa_end		= 0x5d00007f,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l3_main -> iva mmu */
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__iva_mmu = {
+	.master		= &omap3xxx_l3_main_hwmod,
+	.slave		= &omap3xxx_iva_mmu_hwmod,
+	.addr		= omap3xxx_iva_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* iva mmu slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_iva_mmu_slaves[] = {
+	&omap3xxx_l3_main__iva_mmu,
+};
+
+static struct omap_hwmod omap3xxx_iva_mmu_hwmod = {
+	.name		= "iva_mmu",
+	.class		= &omap3xxx_mmu_hwmod_class,
+	.mpu_irqs	= omap3xxx_iva_mmu_irqs,
+	.rst_lines	= omap3xxx_iva_mmu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_iva_mmu_resets),
+	.main_clk	= "iva2_ck",
+	.prcm = {
+		.omap2 = {
+			.module_offs = OMAP3430_IVA2_MOD,
+		},
+	},
+	.dev_attr	= &iva_mmu_dev_attr,
+	.slaves		= omap3xxx_iva_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_iva_mmu_slaves),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/*
  * usbhsotg
  */
 static struct omap_hwmod_class_sysconfig omap3xxx_usbhsotg_sysc = {
@@ -3264,7 +3391,11 @@ static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
 
 /* 34xx-only hwmods (all ES revisions) */
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
+	&omap3xxx_isp_mmu_hwmod,
 	&omap3xxx_iva_hwmod,
+#ifdef CONFIG_OMAP_IOMMU_IVA2
+	&omap3xxx_iva_mmu_hwmod,
+#endif
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
 	&omap3xxx_mailbox_hwmod,
@@ -3273,7 +3404,11 @@ static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 
 /* 36xx-only hwmods (all ES revisions) */
 static __initdata struct omap_hwmod *omap36xx_hwmods[] = {
+	&omap3xxx_isp_mmu_hwmod,
 	&omap3xxx_iva_hwmod,
+#ifdef CONFIG_OMAP_IOMMU_IVA2
+	&omap3xxx_iva_mmu_hwmod,
+#endif
 	&omap3xxx_uart4_hwmod,
 	&omap3xxx_dss_core_hwmod,
 	&omap36xx_sr1_hwmod,
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index a1d79ee..cfab835 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -103,6 +103,19 @@ struct iommu_functions {
 	ssize_t (*dump_ctx)(struct omap_iommu *obj, char *buf, ssize_t len);
 };
 
+/**
+ * omap_mmu_dev_attr - OMAP mmu device attributes for omap_hwmod
+ * @da_start:		device address where the va space starts.
+ * @da_end:		device address where the va space ends.
+ * @nr_tlb_entries:	number of entries supported by the translation
+ *			look-aside buffer (TLB).
+ */
+struct omap_mmu_dev_attr {
+	u32 da_start;
+	u32 da_end;
+	int nr_tlb_entries;
+};
+
 struct iommu_platform_data {
 	const char *name;
 	const char *clk_name;
-- 
1.7.4.1

