From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 09/14] OMAP4: hwmod data: Align interconnect format with regular modules
Date: Fri, 24 Jun 2011 13:05:55 +0200
Message-ID: <1308913560-333-10-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51892 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754835Ab1FXLG2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 07:06:28 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

The interconnect modules were using a slightly different layout than
the regular modules.
Align the layout for better consitency.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   48 ++++++++++++++--------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1c0c96a..06df473 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -80,7 +80,11 @@ static struct omap_hwmod_class omap44xx_dmm_hwmod_class = {
 	.name	= "dmm",
 };
 
-/* dmm interface data */
+/* dmm */
+static struct omap_hwmod_irq_info omap44xx_dmm_irqs[] = {
+	{ .irq = 113 + OMAP44XX_IRQ_GIC_START },
+};
+
 /* l3_main_1 -> dmm */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dmm = {
 	.master		= &omap44xx_l3_main_1_hwmod,
@@ -113,14 +117,12 @@ static struct omap_hwmod_ocp_if *omap44xx_dmm_slaves[] = {
 	&omap44xx_mpu__dmm,
 };
 
-static struct omap_hwmod_irq_info omap44xx_dmm_irqs[] = {
-	{ .irq = 113 + OMAP44XX_IRQ_GIC_START },
-};
-
 static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.name		= "dmm",
 	.class		= &omap44xx_dmm_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
+	.mpu_irqs	= omap44xx_dmm_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmm_irqs),
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET,
@@ -128,8 +130,6 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
 	},
 	.slaves		= omap44xx_dmm_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmm_slaves),
-	.mpu_irqs	= omap44xx_dmm_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmm_irqs),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
@@ -141,7 +141,7 @@ static struct omap_hwmod_class omap44xx_emif_fw_hwmod_class = {
 	.name	= "emif_fw",
 };
 
-/* emif_fw interface data */
+/* emif_fw */
 /* dmm -> emif_fw */
 static struct omap_hwmod_ocp_if omap44xx_dmm__emif_fw = {
 	.master		= &omap44xx_dmm_hwmod,
@@ -196,7 +196,7 @@ static struct omap_hwmod_class omap44xx_l3_hwmod_class = {
 	.name	= "l3",
 };
 
-/* l3_instr interface data */
+/* l3_instr */
 /* iva -> l3_instr */
 static struct omap_hwmod_ocp_if omap44xx_iva__l3_instr = {
 	.master		= &omap44xx_iva_hwmod,
@@ -233,7 +233,12 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
-/* l3_main_1 interface data */
+/* l3_main_1 */
+static struct omap_hwmod_irq_info omap44xx_l3_main_1_irqs[] = {
+	{ .name = "dbg_err", .irq = 9 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "app_err", .irq = 10 + OMAP44XX_IRQ_GIC_START },
+};
+
 /* dsp -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_dsp__l3_main_1 = {
 	.master		= &omap44xx_dsp_hwmod,
@@ -311,15 +316,12 @@ static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
 	&omap44xx_mpu__l3_main_1,
 };
 
-static struct omap_hwmod_irq_info omap44xx_l3_main_1_irqs[] = {
-	{ .name = "dbg_err", .irq = 9 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "app_err", .irq = 10 + OMAP44XX_IRQ_GIC_START },
-};
-
 static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_1_clkdm",
+	.mpu_irqs	= omap44xx_l3_main_1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_irqs),
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET,
@@ -327,12 +329,10 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	},
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
-	.mpu_irqs	= omap44xx_l3_main_1_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_irqs),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
-/* l3_main_2 interface data */
+/* l3_main_2 */
 /* dma_system -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
 	.master		= &omap44xx_dma_system_hwmod,
@@ -433,7 +433,7 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
-/* l3_main_3 interface data */
+/* l3_main_3 */
 static struct omap_hwmod_addr_space omap44xx_l3_main_3_addrs[] = {
 	{
 		.pa_start	= 0x45000000,
@@ -497,7 +497,7 @@ static struct omap_hwmod_class omap44xx_l4_hwmod_class = {
 	.name	= "l4",
 };
 
-/* l4_abe interface data */
+/* l4_abe */
 /* aess -> l4_abe */
 static struct omap_hwmod_ocp_if omap44xx_aess__l4_abe = {
 	.master		= &omap44xx_aess_hwmod,
@@ -552,7 +552,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
-/* l4_cfg interface data */
+/* l4_cfg */
 /* l3_main_1 -> l4_cfg */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l4_cfg = {
 	.master		= &omap44xx_l3_main_1_hwmod,
@@ -580,7 +580,7 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
-/* l4_per interface data */
+/* l4_per */
 /* l3_main_2 -> l4_per */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l4_per = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -608,7 +608,7 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
-/* l4_wkup interface data */
+/* l4_wkup */
 /* l4_cfg -> l4_wkup */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l4_wkup = {
 	.master		= &omap44xx_l4_cfg_hwmod,
@@ -644,7 +644,7 @@ static struct omap_hwmod_class omap44xx_mpu_bus_hwmod_class = {
 	.name	= "mpu_bus",
 };
 
-/* mpu_private interface data */
+/* mpu_private */
 /* mpu -> mpu_private */
 static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_private = {
 	.master		= &omap44xx_mpu_hwmod,
-- 
1.7.0.4

