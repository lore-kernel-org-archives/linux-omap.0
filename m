From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/6] OMAP4: hwmod data: add mmu hwmod for ducati and tesla
Date: Fri,  5 Nov 2010 19:19:53 -0600
Message-ID: <1289006396-27230-4-git-send-email-omar.ramirez@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50813 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab0KFBa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 21:30:26 -0400
In-Reply-To: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add mmu hwmod data for ducati and tesla.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  105 ++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f7525e3..1d5eace 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/iommu.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -1103,6 +1104,106 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/* mmu */
+
+static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
+	.name = "mmu",
+};
+
+/* ducati mmu */
+
+static struct omap_hwmod omap44xx_ducati_mmu_hwmod;
+
+static struct omap_hwmod_addr_space omap44xx_ducati_mmu_addrs[] = {
+	{
+		.pa_start	= OMAP4_MMU1_BASE,
+		.pa_end		= OMAP4_MMU1_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l3_main_1 -> ducati mmu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_1__ducati_mmu = {
+	.master		= &omap44xx_l3_main_1_hwmod,
+	.slave		= &omap44xx_ducati_mmu_hwmod,
+	.addr		= omap44xx_ducati_mmu_addrs,
+	.clk		= "dpll_mpu_m2_ck",
+	.addr_cnt	= ARRAY_SIZE(omap44xx_ducati_mmu_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ducati mmu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_ducati_mmu_slaves[] = {
+	&omap44xx_l3_main_1__ducati_mmu,
+};
+
+static struct omap_hwmod_irq_info omap44xx_ducati_mmu_irqs[] = {
+	{ .name = "ducati", .irq = 100 + OMAP44XX_IRQ_GIC_START, },
+};
+
+static struct omap_mmu_dev_attr ducati_mmu_dev_attr = {
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap44xx_ducati_mmu_hwmod = {
+	.name		= "ducati",
+	.class		= &omap44xx_mmu_hwmod_class,
+	.mpu_irqs	= omap44xx_ducati_mmu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_ducati_mmu_irqs),
+	.slaves		= omap44xx_ducati_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_ducati_mmu_slaves),
+	.dev_attr	= &ducati_mmu_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* tesla mmu */
+
+static struct omap_hwmod omap44xx_tesla_mmu_hwmod;
+
+static struct omap_hwmod_addr_space omap44xx_tesla_mmu_addrs[] = {
+	{
+		.pa_start	= OMAP4_MMU2_BASE,
+		.pa_end		= OMAP4_MMU2_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l3_main_1 -> tesla mmu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_1__tesla_mmu = {
+	.master		= &omap44xx_l3_main_1_hwmod,
+	.slave		= &omap44xx_tesla_mmu_hwmod,
+	.addr		= omap44xx_tesla_mmu_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_tesla_mmu_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* tesla mmu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_tesla_mmu_slaves[] = {
+	&omap44xx_l3_main_1__tesla_mmu,
+};
+
+static struct omap_hwmod_irq_info omap44xx_tesla_mmu_irqs[] = {
+	{ .name = "tesla", .irq = 28 + OMAP44XX_IRQ_GIC_START, },
+};
+
+static struct omap_mmu_dev_attr tesla_mmu_dev_attr = {
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap44xx_tesla_mmu_hwmod = {
+	.name		= "tesla",
+	.class		= &omap44xx_mmu_hwmod_class,
+	.mpu_irqs	= omap44xx_tesla_mmu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_tesla_mmu_irqs),
+	.main_clk	= "dsp_fck",
+	.slaves		= omap44xx_tesla_mmu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_tesla_mmu_slaves),
+	.dev_attr	= &tesla_mmu_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -1140,6 +1241,10 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* mailbox */
 	&omap44xx_mailbox_hwmod,
+
+	/* mmu */
+	&omap44xx_ducati_mmu_hwmod,
+	&omap44xx_tesla_mmu_hwmod,
 	NULL,
 };
 
-- 
1.7.1

