From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 6/8] OMAP4: hwmod data: Add DMIC
Date: Thu, 17 Feb 2011 11:24:47 +0100
Message-ID: <1297938289-8678-7-git-send-email-b-cousson@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47647 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421Ab1BQKZa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 05:25:30 -0500
In-Reply-To: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, David Lambert <dlambert@ti.com>

Add HWMOD entries for the OMAP DMIC. The HWMOD entires define the system
resource requirements for the driver such as DMA addresses, channels,
and IRQ's. Placing this information in the HWMOD database allows for
more generic drivers to be written and having the specific implementation
details defined in HWMOD.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: David Lambert <dlambert@ti.com>
[b-cousson@ti.com: Change the wrong hwmod name,
add missing flag and re-order structures]
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   94 +++++++++++++++++++++++++++-
 1 files changed, 93 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index efdf266..1488438 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -516,7 +516,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  ctrl_module_pad_wkup
  *  ctrl_module_wkup
  *  debugss
- *  dmic
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
@@ -648,6 +647,96 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
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
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_dmic_hwmod_class = {
+	.name	= "dmic",
+	.sysc	= &omap44xx_dmic_sysc,
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
+	.name		= "dmic",
+	.class		= &omap44xx_dmic_hwmod_class,
+	.mpu_irqs	= omap44xx_dmic_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmic_irqs),
+	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_reqs),
+	.main_clk	= "dmic_fck",
+	.prcm		= {
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
  * 'dsp' class
  * dsp sub-system
  */
@@ -3570,6 +3659,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dma class */
 	&omap44xx_dma_system_hwmod,
 
+	/* dmic class */
+	&omap44xx_dmic_hwmod,
+
 	/* dsp class */
 	&omap44xx_dsp_hwmod,
 	&omap44xx_dsp_c0_hwmod,
-- 
1.7.0.4

