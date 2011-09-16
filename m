From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 04/16] TEMP: OMAP3xxx: hwmod data: add PRM hwmod
Date: Fri, 16 Sep 2011 19:05:38 +0300
Message-ID: <1316189150-21448-5-git-send-email-t-kristo@ti.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53681 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab1IPQGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 12:06:33 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm@lists.arm.linux.org.uk, Paul Walmsley <paul@pwsan.com>

This patch is temporary until Paul can provide a final version.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   56 ++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 59fdb9f..77f44de 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -161,6 +161,7 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
+static struct omap_hwmod omap3xxx_prm_hwmod;
 static struct omap_hwmod omap3xxx_uart1_hwmod;
 static struct omap_hwmod omap3xxx_uart2_hwmod;
 static struct omap_hwmod omap3xxx_uart3_hwmod;
@@ -478,6 +479,24 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+static struct omap_hwmod_addr_space omap3xxx_prm_addrs[] = {
+	{
+		.pa_start	= 0x48306000,
+		.pa_end		= 0x48306000 + SZ_8K + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{}
+};
+
+/* L4_WKUP -> PRM interface */
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__prm = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_prm_hwmod,
+	.clk		= "wkup_l4_ick",
+	.addr		= omap3xxx_prm_addrs,
+	.user		= OCP_USER_MPU,
+};
+
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
 	&omap3xxx_l4_core__l4_wkup,
@@ -493,6 +512,40 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/* Slave interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_prm_slaves[] = {
+	&omap3xxx_l4_wkup__prm,
+};
+
+static struct omap_hwmod_class_sysconfig omap3xxx_prm_sysc = {
+	.rev_offs	= 0x0804,
+	.sysc_offs	= 0x0814,
+	.sysc_flags	= SYSC_HAS_AUTOIDLE,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_prm_hwmod_class = {
+	.name		= "prm",
+	.sysc		= &omap3xxx_prm_sysc,
+};
+
+static struct omap_hwmod_irq_info omap3xxx_prm_irqs[] = {
+	{ .irq = 11 },
+	{ .irq = -1 }
+};
+
+/* PRM */
+static struct omap_hwmod omap3xxx_prm_hwmod = {
+	.name		= "prm",
+	.mpu_irqs	= omap3xxx_prm_irqs,
+	.class		= &omap3xxx_prm_hwmod_class,
+	.main_clk	= "wkup_32k_fck",
+	.slaves		= omap3xxx_prm_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_prm_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
 	&omap3xxx_mpu__l3_main,
@@ -3201,6 +3254,9 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
+
+	&omap3xxx_prm_hwmod,
+
 	&omap3xxx_mmc1_hwmod,
 	&omap3xxx_mmc2_hwmod,
 	&omap3xxx_mmc3_hwmod,
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

