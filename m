From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 1/4] OMAP4: hwmod data: Add GPMC
Date: Fri, 1 Jul 2011 23:54:24 +0200
Message-ID: <1309557267-27165-2-git-send-email-b-cousson@ti.com>
References: <1309557267-27165-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32775 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757791Ab1GAVyi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:54:38 -0400
In-Reply-To: <1309557267-27165-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Add the GPMC hwmod data.

The GPMC hwmod does need the flags HWMOD_INIT_NO_IDLE and
HWMOD_INIT_NO_RESET due to a bug described in the previous commit:

 OMAP4: clock: Keep GPMC clocks always enabled and hardware managed

 On OMAP4, CPU accesses on unmapped addresses are redirected to GPMC by
 L3 interconnect. Because of CPU speculative nature, such accesses are
 possible which can lead to indirect access to GPMC and if it's clock is
 not running, it can result in hang/abort on the platform.

 Above makes access to GPMC unpredictable during the execution, so it's
 module mode needs to be kept under hardware control instead of software
 control.
 Since the auto gating is supported for GPMC, there isn't any power impact
 because of this change.

 The issue was un-covered with security middleware running along with HLOS.
 In this case GPMC had a valid MMU descriptor on secure side where as HLOS
 didn't map the GMPC because it isn't being used.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   78 +++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 160c77a..e2971bc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -701,7 +701,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  emif1
  *  emif2
  *  fdif
- *  gpmc
  *  gpu
  *  hdq1w
  *  mcasp
@@ -2195,6 +2194,80 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 };
 
 /*
+ * 'gpmc' class
+ * general purpose memory controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpmc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_gpmc_hwmod_class = {
+	.name	= "gpmc",
+	.sysc	= &omap44xx_gpmc_sysc,
+};
+
+/* gpmc */
+static struct omap_hwmod omap44xx_gpmc_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpmc_irqs[] = {
+	{ .irq = 20 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_gpmc_sdma_reqs[] = {
+	{ .dma_req = 3 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x50000000,
+		.pa_end		= 0x500003ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l3_main_2 -> gpmc */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpmc = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_gpmc_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_gpmc_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpmc_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpmc slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpmc_slaves[] = {
+	&omap44xx_l3_main_2__gpmc,
+};
+
+static struct omap_hwmod omap44xx_gpmc_hwmod = {
+	.name		= "gpmc",
+	.class		= &omap44xx_gpmc_hwmod_class,
+	.clkdm_name	= "l3_2_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.mpu_irqs	= omap44xx_gpmc_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpmc_irqs),
+	.sdma_reqs	= omap44xx_gpmc_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_gpmc_sdma_reqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3_2_GPMC_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+	.slaves		= omap44xx_gpmc_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpmc_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
+};
+
+/*
  * 'hsi' class
  * mipi high-speed synchronous serial interface (multichannel and full-duplex
  * serial if)
@@ -5392,6 +5465,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_gpio5_hwmod,
 	&omap44xx_gpio6_hwmod,
 
+	/* gpmc class */
+	&omap44xx_gpmc_hwmod,
+
 	/* hsi class */
 /*	&omap44xx_hsi_hwmod, */
 
-- 
1.7.0.4

