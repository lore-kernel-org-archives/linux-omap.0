From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/6] OMAP3: hwmod data: Add mmu for iva2 and isp
Date: Fri,  5 Nov 2010 19:19:52 -0600
Message-ID: <1289006396-27230-3-git-send-email-omar.ramirez@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50818 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab0KFBaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 21:30:30 -0400
In-Reply-To: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add mmu hwmod data for iva2 and isp.

Plus a define for the iva2 base register.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  103 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/iommu.h    |    8 ++
 arch/arm/plat-omap/include/plat/omap34xx.h |    2 +
 3 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 60d977e..ff80efc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,6 +21,7 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/omap34xx.h>
+#include <plat/iommu.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -801,6 +802,106 @@ static struct omap_hwmod omap3xxx_mailbox_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* mmu */
+
+static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
+	.name = "mmu",
+};
+
+/* isp mmu */
+
+static struct omap_hwmod omap3xxx_isp_mmu_hwmod;
+
+static struct omap_hwmod_addr_space omap3xxx_isp_mmu_addrs[] = {
+	{
+		.pa_start	= OMAP3430_ISP_MMU_BASE,
+		.pa_end		= OMAP3430_ISP_MMU_BASE + SZ_256 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_core -> isp mmu */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__isp_mmu = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_isp_mmu_hwmod,
+	.addr		= omap3xxx_isp_mmu_addrs,
+	.clk		= "cam_ick",
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_isp_mmu_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* isp mmu slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] = {
+	&omap3xxx_l4_core__isp_mmu,
+};
+
+static struct omap_hwmod_irq_info omap3xxx_isp_mmu_irqs[] = {
+	{ .name = "isp", .irq = INT_24XX_CAM_IRQ, },
+};
+
+static struct omap_mmu_dev_attr isp_mmu_dev_attr = {
+	.nr_tlb_entries = 8,
+};
+
+static struct omap_hwmod omap3xxx_isp_mmu_hwmod = {
+	.name		= "isp",
+	.class		= &omap3xxx_mmu_hwmod_class,
+	.mpu_irqs	= omap3xxx_isp_mmu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_isp_mmu_irqs),
+	.slaves		= omap3xxx_isp_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_isp_mmu_slaves),
+	.dev_attr	= &isp_mmu_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* iva2 mmu */
+
+static struct omap_hwmod omap3xxx_iva2_mmu_hwmod;
+
+static struct omap_hwmod_addr_space omap3xxx_iva2_mmu_addrs[] = {
+	{
+		.pa_start	= OMAP34XX_IVA2_MMU_BASE,
+		.pa_end		= OMAP34XX_IVA2_MMU_BASE + SZ_256 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l3_main -> iva2 mmu */
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__iva2_mmu = {
+	.master		= &omap3xxx_l3_main_hwmod,
+	.slave		= &omap3xxx_iva2_mmu_hwmod,
+	.addr		= omap3xxx_iva2_mmu_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_iva2_mmu_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* iva2 mmu slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_iva2_mmu_slaves[] = {
+	&omap3xxx_l3_main__iva2_mmu,
+};
+
+static struct omap_hwmod_irq_info omap3xxx_iva2_mmu_irqs[] = {
+	{ .name = "iva2", .irq = INT_24XX_DSP_MMU, },
+};
+
+static struct omap_mmu_dev_attr iva2_mmu_dev_attr = {
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap3xxx_iva2_mmu_hwmod = {
+	.name		= "iva2",
+	.class		= &omap3xxx_mmu_hwmod_class,
+	.mpu_irqs	= omap3xxx_iva2_mmu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_iva2_mmu_irqs),
+	.main_clk	= "iva2_ck",
+	.slaves		= omap3xxx_iva2_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_iva2_mmu_slaves),
+	.dev_attr	= &iva2_mmu_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -817,6 +918,8 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
 	&omap3xxx_mailbox_hwmod,
+	&omap3xxx_isp_mmu_hwmod,
+	&omap3xxx_iva2_mmu_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 33c7d41..91a75a5 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -99,6 +99,14 @@ struct iommu_functions {
 	ssize_t (*dump_ctx)(struct iommu *obj, char *buf, ssize_t len);
 };
 
+/* omap_mmu_dev_attr - OMAP mmu device attributes for omap_hwmod
+ * @nr_tlb_entries: number of entries supported by the translation look-aside
+ *                   buffer (TLB).
+ */
+struct omap_mmu_dev_attr {
+	int nr_tlb_entries;
+};
+
 struct iommu_platform_data {
 	const char *name;
 	const char *clk_name;
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index 98fc8b4..697f8f9 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -82,6 +82,8 @@
 
 #define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
+#define OMAP34XX_IVA2_MMU_BASE	0x5D000000
+
 /* Security */
 #define OMAP34XX_SEC_BASE	(L4_34XX_BASE + 0xA0000)
 #define OMAP34XX_SEC_SHA1MD5_BASE	(OMAP34XX_SEC_BASE + 0x23000)
-- 
1.7.1

