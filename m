From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 1/2] ARM: OMAP2+: hwmod: AM43x: add hwmod support for ADC on AM43xx
Date: Fri, 21 Nov 2014 15:44:21 +0530
Message-ID: <1416564862-23056-2-git-send-email-vigneshr@ti.com>
References: <1416564862-23056-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416564862-23056-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch adds hwmod support for ADC on AM43xx. Since clockdomain
and offsets of adc_tsc are different from AM33xx, ADC data has been
directly added to AM43xx hwmod file.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index fea01aa3ef42..b47f6ad0928c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -417,6 +417,37 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
 	},
 };
 
+/*
+ * 'adc/tsc' class
+ * TouchScreen Controller (Anolog-To-Digital Converter)
+ */
+static struct omap_hwmod_class_sysconfig am43xx_adc_tsc_sysc = {
+	.rev_offs       = 0x00,
+	.sysc_offs      = 0x10,
+	.sysc_flags     = SYSC_HAS_SIDLEMODE,
+	.idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			  SIDLE_SMART_WKUP),
+	.sysc_fields    = &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class am43xx_adc_tsc_hwmod_class = {
+	.name           = "adc_tsc",
+	.sysc           = &am43xx_adc_tsc_sysc,
+};
+
+static struct omap_hwmod am43xx_adc_tsc_hwmod = {
+	.name           = "adc_tsc",
+	.class          = &am43xx_adc_tsc_hwmod_class,
+	.clkdm_name     = "l3s_tsc_clkdm",
+	.main_clk       = "adc_tsc_fck",
+	.prcm           = {
+		.omap4  = {
+			.clkctrl_offs   = AM43XX_CM_WKUP_ADC_TSC_CLKCTRL_OFFSET,
+			.modulemode     = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* dss */
 
 static struct omap_hwmod am43xx_dss_core_hwmod = {
@@ -547,6 +578,13 @@ static struct omap_hwmod_ocp_if am43xx_l4_wkup__gpio0 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__adc_tsc = {
+	.master         = &am33xx_l4_wkup_hwmod,
+	.slave          = &am43xx_adc_tsc_hwmod,
+	.clk            = "dpll_core_m4_div2_ck",
+	.user           = OCP_USER_MPU,
+};
+
 static struct omap_hwmod_ocp_if am43xx_l4_hs__cpgmac0 = {
 	.master		= &am43xx_l4_hs_hwmod,
 	.slave		= &am33xx_cpgmac0_hwmod,
@@ -789,6 +827,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_wkup__i2c1,
 	&am43xx_l4_wkup__gpio0,
 	&am43xx_l4_wkup__wd_timer1,
+	&am43xx_l4_wkup__adc_tsc,
 	&am43xx_l3_s__qspi,
 	&am33xx_l4_per__dcan0,
 	&am33xx_l4_per__dcan1,
-- 
1.9.1
