From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 05/16] TEMP: OMAP4xxx: hwmod data: add PRM hwmod
Date: Fri, 16 Sep 2011 19:05:39 +0300
Message-ID: <1316189150-21448-6-git-send-email-t-kristo@ti.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37047 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab1IPQGc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 12:06:32 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm@lists.arm.linux.org.uk, Benoit Cousson <b-cousson@ti.com>

This patch is temporary until Benoit can provide final version.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   65 ++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..600c7b9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3990,6 +3990,68 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+ /*
+ * 'prm' class
+ * power and reset manager (part of the prcm infrastructure)
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_prm_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_flags	= 0,
+};
+
+static struct omap_hwmod_class omap44xx_prm_hwmod_class = {
+	.name	= "prm",
+	.sysc	= &omap44xx_prm_sysc,
+};
+
+/* prm */
+static struct omap_hwmod omap44xx_prm_hwmod;
+static struct omap_hwmod_irq_info omap44xx_prm_irqs[] = {
+	{ .irq = 11 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
+	{ .name = "rst_global_warm_sw", .rst_shift = 0 },
+	{ .name = "rst_global_cold_sw", .rst_shift = 1 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_prm_addrs[] = {
+	{
+		.pa_start       = 0x4a306000,
+		.pa_end         = 0x4a307fff,
+		.flags          = ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> prm */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__prm = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_prm_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_prm_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* prm slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_prm_slaves[] = {
+	&omap44xx_l4_wkup__prm,
+};
+
+static struct omap_hwmod omap44xx_prm_hwmod = {
+	.name		= "prm",
+	.class		= &omap44xx_prm_hwmod_class,
+	.mpu_irqs	= omap44xx_prm_irqs,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.rst_lines	= omap44xx_prm_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
+	.slaves		= omap44xx_prm_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_prm_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 /*
  * 'smartreflex' class
  * smartreflex module (monitor silicon performance and outputs a measure of
@@ -5448,6 +5510,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
 
+	/* prm class */
+	&omap44xx_prm_hwmod,
+
 	/* smartreflex class */
 	&omap44xx_smartreflex_core_hwmod,
 	&omap44xx_smartreflex_iva_hwmod,
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

