From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 01/17] OMAP3: PM: Adding hwmod data for Smartreflex
Date: Thu, 18 Mar 2010 14:45:39 +0530
Message-ID: <1268903755-4151-2-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38281 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0CRJQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 05:16:11 -0400
In-Reply-To: <1268903755-4151-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds the hwmod strucutres and other hwmod data for
OMAP3 Smartreflex IP's.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   94 ++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed60840..9c0c9e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -35,6 +35,8 @@ static struct omap_hwmod omap3xxx_mpu_hwmod;
 static struct omap_hwmod omap3xxx_l3_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap34xx_sr1_hwmod;
+static struct omap_hwmod omap34xx_sr2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3__l4_core = {
@@ -88,9 +90,47 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* L4 CORE -> SR1 interface */
+static struct omap_hwmod_addr_space omap34xx_sr1_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_SR1_BASE,
+		.pa_end		= OMAP34XX_SR1_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__sr1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_sr1_hwmod,
+	.clk		= NULL,
+	.addr		= omap34xx_sr1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_sr1_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 CORE -> SR1 interface */
+static struct omap_hwmod_addr_space omap34xx_sr2_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_SR2_BASE,
+		.pa_end		= OMAP34XX_SR2_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_sr2_hwmod,
+	.clk		= NULL,
+	.addr		= omap34xx_sr2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_sr2_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3__l4_core,
+	&omap3_l4_core__sr1,
+	&omap3_l4_core__sr2,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
@@ -164,12 +204,66 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* SR common */
+static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
+	.clkact_shift	= 20,
+};
+
+static struct omap_hwmod_class_sysconfig omap34xx_sr_sysc = {
+	.sysc_offs	= 0x24,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_NO_CACHE),
+	.clockact	= CLOCKACT_TEST_ICLK,
+	.sysc_fields	= &omap34xx_sr_sysc_fields,
+};
+
+static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
+	.name = "smartreflex",
+	.sysc = &omap34xx_sr_sysc,
+	.rev  = 1,
+};
+
+/* SR1 */
+static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
+	&omap3_l4_core__sr1,
+};
+
+static struct omap_hwmod omap34xx_sr1_hwmod = {
+	.name		= "sr1_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.mpu_irqs	= NULL,
+	.sdma_chs	= NULL,
+	.main_clk	= "sr1_fck",
+	.slaves		= omap34xx_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
+/* SR2 */
+static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
+	&omap3_l4_core__sr2,
+};
+
+static struct omap_hwmod omap34xx_sr2_hwmod = {
+	.name		= "sr2_hwmod",
+	.class		= &omap34xx_smartreflex_hwmod_class,
+	.mpu_irqs	= NULL,
+	.sdma_chs	= NULL,
+	.main_clk	= "sr2_fck",
+	.slaves		= omap34xx_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_hwmod,
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
+	&omap34xx_sr1_hwmod,
+	&omap34xx_sr2_hwmod,
 	NULL,
 };
 
-- 
1.7.0.rc1.33.g07cf0f

