From: David Lambert <dlambert@ti.com>
Subject: [PATCH 4/5] OMAP4: hwmod: add entries for DMIC driver
Date: Mon, 27 Dec 2010 22:17:05 -0600
Message-ID: <1293509826-23253-5-git-send-email-dlambert@ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59044 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311Ab0L1ERn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Dec 2010 23:17:43 -0500
In-Reply-To: <1293509826-23253-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, David Lambert <dlambert@ti.com>

Adds HWMOD entries for the OMAP DMIC driver and creates
a platform device.  The HWMOD entires define the system 
resource requirements for the drvier such as DMA addresses, channels,
and IRQ's.  Placing this information in the HWMOD database allows
for more generic drivers to be written and having the specific
implementation details defined in HWMOD.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/devices.c               |   35 +++++++++++
 2 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7274db4..f9b2ad3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -383,6 +383,95 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 };
 
 /*
+ * 'dmic' class
+ * digital microphone controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_dmic_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_dmic_hwmod_class = {
+	.name = "omap-dmic",
+	.sysc = &omap44xx_dmic_sysc,
+};
+
+/* dmic */
+static struct omap_hwmod omap44xx_dmic_hwmod;
+static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] = {
+	{ .irq = 114 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] = {
+	{ .dma_req = 66 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
+	{
+		.pa_start	= 0x4012e000,
+		.pa_end		= 0x4012e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> dmic */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_dmic_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_dmic_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] = {
+	{
+		.pa_start	= 0x4902e000,
+		.pa_end		= 0x4902e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> dmic (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_dmic_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_dmic_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* dmic slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dmic_slaves[] = {
+	&omap44xx_l4_abe__dmic,
+	&omap44xx_l4_abe__dmic_dma,
+};
+
+static struct omap_hwmod omap44xx_dmic_hwmod = {
+	.name		= "omap-dmic",
+	.class		= &omap44xx_dmic_hwmod_class,
+	.mpu_irqs	= omap44xx_dmic_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmic_irqs),
+	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_reqs),
+	.main_clk	= "dmic_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_dmic_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmic_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'mpu_bus' class
  * instance(s): mpu_private
  */
@@ -826,6 +915,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_l4_cfg_hwmod,
 	&omap44xx_l4_per_hwmod,
 	&omap44xx_l4_wkup_hwmod,
+	/* dmic class */
+	&omap44xx_dmic_hwmod,
 	/* mpu_bus class */
 	&omap44xx_mpu_private_hwmod,
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index fc81912..b347f75 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -72,6 +72,40 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_SND_OMAP_SOC_DMIC) || \
+	defined(CONFIG_SND_OMAP_SOC_DMIC_MODULE)
+
+static struct omap_device_pm_latency omap_dmic_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static void omap_init_dmic(void)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+
+	oh = omap_hwmod_lookup("omap-dmic");
+	if (!oh) {
+		printk(KERN_ERR "Could not look up dmic hw_mod\n");
+		return;
+	}
+
+	od = omap_device_build("omap-dmic-dai", -1, oh, NULL, 0,
+				omap_dmic_latency,
+				ARRAY_SIZE(omap_dmic_latency), 0);
+	if (IS_ERR(od))
+		printk(KERN_ERR "Could not build omap_device for omap-dmic-dai\n");
+}
+#else
+static inline void omap_init_dmic(void) {}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
 		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
 
@@ -328,6 +362,7 @@ static int __init omap_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_init_dmic();
 	omap_init_rng();
 	omap_init_mcpdm();
 	omap_init_uwire();
-- 
1.7.0.4

