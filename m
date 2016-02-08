From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFT PATCH 2/3] ARM: OMAP2+: hwmod: use HWMOD_CUSTOM_HARDRESET for custom reset handling
Date: Mon, 8 Feb 2016 16:42:20 +0530
Message-ID: <1454929941-23949-3-git-send-email-kishon@ti.com>
References: <1454929941-23949-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454929941-23949-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, bhelgaas@google.com, richardcochran@gmail.com, s-anna@ti.com
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Many of the IP blocks with PRM hardreset lines are processor IP blocks
and need special reset handling to ensure that WFI/HLT-like
instructions are executed after reset. (This special handling ensures that
the IP blocks' bus initiator interfaces indicate that they are in standby
to the PRCM - thus allowing power management for the rest of the chip to
work correctly.)
Use HWMOD_CUSTOM_HARDRESET flags in the hwmod data for IP blocks that
require special reset handling.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |    2 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    2 ++
 8 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 65b1647..2a7e5da 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -59,6 +59,7 @@ static struct omap_hwmod omap2420_iva_hwmod = {
 	.clkdm_name	= "iva1_clkdm",
 	.rst_lines	= omap2420_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap2420_iva_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "iva1_ifck",
 };
 
@@ -78,6 +79,7 @@ static struct omap_hwmod omap2420_dsp_hwmod = {
 	.clkdm_name	= "dsp_clkdm",
 	.rst_lines	= omap2420_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap2420_dsp_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "dsp_fck",
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 79127b3..7ec77ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -55,6 +55,7 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.clkdm_name	= "dsp_clkdm",
 	.rst_lines	= omap2430_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap2430_iva_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "dsp_fck",
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 907a452b..d8b701a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -161,6 +161,7 @@ struct omap_hwmod am33xx_pruss_hwmod = {
 	},
 	.rst_lines	= am33xx_pruss_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(am33xx_pruss_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /* gfx */
@@ -185,6 +186,7 @@ struct omap_hwmod am33xx_gfx_hwmod = {
 	},
 	.rst_lines	= am33xx_gfx_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(am33xx_gfx_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index cc0791d..f843af6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -86,6 +86,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	},
 	.rst_lines	= am33xx_wkup_m3_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0a98532..544c53d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -120,6 +120,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.clkdm_name	= "iva2_clkdm",
 	.rst_lines	= omap3xxx_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_iva_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "iva2_ck",
 	.prcm = {
 		.omap2 = {
@@ -2071,6 +2072,7 @@ static struct omap_hwmod omap3xxx_sad2d_hwmod = {
 	.name		= "sad2d",
 	.rst_lines	= omap3xxx_sad2d_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_sad2d_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "sad2d_ick",
 	.prcm		= {
 		.omap2 = {
@@ -2993,6 +2995,7 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.clkdm_name	= "iva2_clkdm",
 	.rst_lines	= omap3xxx_mmu_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_mmu_iva_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "iva2_ck",
 	.prcm = {
 		.omap2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index e97a894..72346f0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -73,6 +73,7 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod = {
 	},
 	.rst_lines	= am33xx_wkup_m3_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 static struct omap_hwmod am43xx_control_hwmod = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dad871a..b38aad9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -544,6 +544,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.clkdm_name	= "tesla_clkdm",
 	.rst_lines	= omap44xx_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "dpll_iva_m4x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -1424,6 +1425,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.clkdm_name	= "ducati_clkdm",
 	.rst_lines	= omap44xx_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "ducati_clk_mux_ck",
 	.prcm = {
 		.omap4 = {
@@ -1508,6 +1510,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.clkdm_name	= "ivahd_clkdm",
 	.rst_lines	= omap44xx_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "dpll_iva_m5x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -2106,6 +2109,7 @@ static struct omap_hwmod omap44xx_mmu_ipu_hwmod = {
 	.clkdm_name	= "ducati_clkdm",
 	.rst_lines	= omap44xx_mmu_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_mmu_ipu_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "ducati_clk_mux_ck",
 	.prcm = {
 		.omap4 = {
@@ -2138,6 +2142,7 @@ static struct omap_hwmod omap44xx_mmu_dsp_hwmod = {
 	.clkdm_name	= "tesla_clkdm",
 	.rst_lines	= omap44xx_mmu_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_mmu_dsp_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "dpll_iva_m4x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -2299,6 +2304,7 @@ static struct omap_hwmod omap44xx_prm_hwmod = {
 	.class		= &omap44xx_prcm_hwmod_class,
 	.rst_lines	= omap44xx_prm_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 8cdfd9b..b1d5433 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1388,6 +1388,7 @@ static struct omap_hwmod omap54xx_mmu_dsp_hwmod = {
 	.clkdm_name	= "dsp_clkdm",
 	.rst_lines	= omap54xx_mmu_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_dsp_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "dpll_iva_h11x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -1410,6 +1411,7 @@ static struct omap_hwmod omap54xx_mmu_ipu_hwmod = {
 	.clkdm_name	= "ipu_clkdm",
 	.rst_lines	= omap54xx_mmu_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_ipu_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 	.main_clk	= "dpll_core_h22x2_ck",
 	.prcm = {
 		.omap4 = {
-- 
1.7.9.5
