From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/12] ARM: OMAP2xxx: hwmod data: start to fix the IVA1,
 IVA2 and DSP
Date: Wed, 07 Mar 2012 19:38:41 -0700
Message-ID: <20120308023840.8205.51532.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45812 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab2CHCmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:11 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

N800 logs this message on boot:

[    0.182281] omap_hwmod: iva: cannot be enabled for reset (3)

Fix by creating basic IVA1 and DSP hwmods for OMAP2420, and a basic IVA2
hwmod for OMAP2430.  There is still more information to be added, but
this should resolve the immediate issue.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   46 ++++++++++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   11 ++++++-
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b01b66a..2c087ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -43,10 +43,41 @@
  * IP blocks
  */
 
-/* IVA2 (IVA2) */
+/* IVA1 (IVA1) */
+static struct omap_hwmod_class iva1_hwmod_class = {
+	.name		= "iva1",
+};
+
+static struct omap_hwmod_rst_info omap2420_iva_resets[] = {
+	{ .name = "iva", .rst_shift = 8 },
+};
+
 static struct omap_hwmod omap2420_iva_hwmod = {
 	.name		= "iva",
-	.class		= &iva_hwmod_class,
+	.class		= &iva1_hwmod_class,
+	.clkdm_name	= "iva1_clkdm",
+	.rst_lines	= omap2420_iva_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap2420_iva_resets),
+	.main_clk	= "iva1_ifck",
+};
+
+/* DSP */
+static struct omap_hwmod_class dsp_hwmod_class = {
+	.name		= "dsp",
+};
+
+static struct omap_hwmod_rst_info omap2420_dsp_resets[] = {
+	{ .name = "logic", .rst_shift = 0 },
+	{ .name = "mmu", .rst_shift = 1 },
+};
+
+static struct omap_hwmod omap2420_dsp_hwmod = {
+	.name		= "dsp",
+	.class		= &dsp_hwmod_class,
+	.clkdm_name	= "dsp_clkdm",
+	.rst_lines	= omap2420_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap2420_dsp_resets),
+	.main_clk	= "dsp_fck",
 };
 
 /* I2C common */
@@ -234,7 +265,15 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 = {
 static struct omap_hwmod_ocp_if omap2420_l3__iva = {
 	.master		= &omap2xxx_l3_main_hwmod,
 	.slave		= &omap2420_iva_hwmod,
-	.clk		= "iva1_ifck",
+	.clk		= "core_l3_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* DSP <- L3 interface */
+static struct omap_hwmod_ocp_if omap2420_l3__dsp = {
+	.master		= &omap2xxx_l3_main_hwmod,
+	.slave		= &omap2420_dsp_hwmod,
+	.clk		= "dsp_ick",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -402,6 +441,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__i2c1,
 	&omap2420_l4_core__i2c2,
 	&omap2420_l3__iva,
+	&omap2420_l3__dsp,
 	&omap2420_l4_wkup__timer1,
 	&omap2xxx_l4_core__timer2,
 	&omap2xxx_l4_core__timer3,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 23ca551..b359bfb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -45,9 +45,18 @@
  */
 
 /* IVA2 (IVA2) */
+static struct omap_hwmod_rst_info omap2430_iva_resets[] = {
+	{ .name = "logic", .rst_shift = 0 },
+	{ .name = "mmu", .rst_shift = 1 },
+};
+
 static struct omap_hwmod omap2430_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
+	.clkdm_name	= "dsp_clkdm",
+	.rst_lines	= omap2430_iva_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap2430_iva_resets),
+	.main_clk	= "dsp_fck",
 };
 
 /* I2C common */
@@ -599,7 +608,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 = {
 static struct omap_hwmod_ocp_if omap2430_l3__iva = {
 	.master		= &omap2xxx_l3_main_hwmod,
 	.slave		= &omap2430_iva_hwmod,
-	.clk		= "dsp_fck",
+	.clk		= "core_l3_ick",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 


