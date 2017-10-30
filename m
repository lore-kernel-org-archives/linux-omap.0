From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 27/27] clk: ti: omap4: clkctrl data fixes for opt-clocks
Date: Mon, 30 Oct 2017 15:04:45 +0200
Message-ID: <1509368685-29112-28-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Re-route all opt-clocks to use the new clkctrl clocks also, instead of
depending on the old dt clocks. Also, add aliases for certain clkctrl
clocks that hwmod core depends upon. The alias list can be stripped
down once hwmod database no longer needs these.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-44xx.c | 155 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 115 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 9470e09..339d30d 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -35,7 +35,7 @@
 #define OMAP4_DPLL_USB_DEFFREQ				960000000
 
 static const struct omap_clkctrl_reg_data omap4_mpuss_clkctrl_regs[] __initconst = {
-	{ OMAP4_MPU_CLKCTRL, NULL, CLKF_HW_SUP, "dpll_mpu_m2_ck" },
+	{ OMAP4_MPU_CLKCTRL, NULL, 0, "dpll_mpu_m2_ck" },
 	{ 0 },
 };
 
@@ -59,7 +59,7 @@
 };
 
 static const char * const omap4_func_dmic_abe_gfclk_parents[] __initconst = {
-	"dmic_sync_mux_ck",
+	"abe_cm:clk:0018:26",
 	"pad_clks_ck",
 	"slimbus_clk",
 	NULL,
@@ -79,7 +79,7 @@
 };
 
 static const char * const omap4_func_mcasp_abe_gfclk_parents[] __initconst = {
-	"mcasp_sync_mux_ck",
+	"abe_cm:clk:0020:26",
 	"pad_clks_ck",
 	"slimbus_clk",
 	NULL,
@@ -92,7 +92,7 @@
 };
 
 static const char * const omap4_func_mcbsp1_gfclk_parents[] __initconst = {
-	"mcbsp1_sync_mux_ck",
+	"abe_cm:clk:0028:26",
 	"pad_clks_ck",
 	"slimbus_clk",
 	NULL,
@@ -105,7 +105,7 @@
 };
 
 static const char * const omap4_func_mcbsp2_gfclk_parents[] __initconst = {
-	"mcbsp2_sync_mux_ck",
+	"abe_cm:clk:0030:26",
 	"pad_clks_ck",
 	"slimbus_clk",
 	NULL,
@@ -118,7 +118,7 @@
 };
 
 static const char * const omap4_func_mcbsp3_gfclk_parents[] __initconst = {
-	"mcbsp3_sync_mux_ck",
+	"abe_cm:clk:0038:26",
 	"pad_clks_ck",
 	"slimbus_clk",
 	NULL,
@@ -186,18 +186,18 @@
 
 static const struct omap_clkctrl_reg_data omap4_abe_clkctrl_regs[] __initconst = {
 	{ OMAP4_L4_ABE_CLKCTRL, NULL, 0, "ocp_abe_iclk" },
-	{ OMAP4_AESS_CLKCTRL, omap4_aess_bit_data, CLKF_SW_SUP, "aess_fclk" },
+	{ OMAP4_AESS_CLKCTRL, omap4_aess_bit_data, CLKF_SW_SUP, "abe_cm:clk:0008:24" },
 	{ OMAP4_MCPDM_CLKCTRL, NULL, CLKF_SW_SUP, "pad_clks_ck" },
-	{ OMAP4_DMIC_CLKCTRL, omap4_dmic_bit_data, CLKF_SW_SUP, "func_dmic_abe_gfclk" },
-	{ OMAP4_MCASP_CLKCTRL, omap4_mcasp_bit_data, CLKF_SW_SUP, "func_mcasp_abe_gfclk" },
-	{ OMAP4_MCBSP1_CLKCTRL, omap4_mcbsp1_bit_data, CLKF_SW_SUP, "func_mcbsp1_gfclk" },
-	{ OMAP4_MCBSP2_CLKCTRL, omap4_mcbsp2_bit_data, CLKF_SW_SUP, "func_mcbsp2_gfclk" },
-	{ OMAP4_MCBSP3_CLKCTRL, omap4_mcbsp3_bit_data, CLKF_SW_SUP, "func_mcbsp3_gfclk" },
-	{ OMAP4_SLIMBUS1_CLKCTRL, omap4_slimbus1_bit_data, CLKF_SW_SUP, "slimbus1_fclk_0" },
-	{ OMAP4_TIMER5_CLKCTRL, omap4_timer5_bit_data, CLKF_SW_SUP, "timer5_sync_mux" },
-	{ OMAP4_TIMER6_CLKCTRL, omap4_timer6_bit_data, CLKF_SW_SUP, "timer6_sync_mux" },
-	{ OMAP4_TIMER7_CLKCTRL, omap4_timer7_bit_data, CLKF_SW_SUP, "timer7_sync_mux" },
-	{ OMAP4_TIMER8_CLKCTRL, omap4_timer8_bit_data, CLKF_SW_SUP, "timer8_sync_mux" },
+	{ OMAP4_DMIC_CLKCTRL, omap4_dmic_bit_data, CLKF_SW_SUP, "abe_cm:clk:0018:24" },
+	{ OMAP4_MCASP_CLKCTRL, omap4_mcasp_bit_data, CLKF_SW_SUP, "abe_cm:clk:0020:24" },
+	{ OMAP4_MCBSP1_CLKCTRL, omap4_mcbsp1_bit_data, CLKF_SW_SUP, "abe_cm:clk:0028:24" },
+	{ OMAP4_MCBSP2_CLKCTRL, omap4_mcbsp2_bit_data, CLKF_SW_SUP, "abe_cm:clk:0030:24" },
+	{ OMAP4_MCBSP3_CLKCTRL, omap4_mcbsp3_bit_data, CLKF_SW_SUP, "abe_cm:clk:0038:24" },
+	{ OMAP4_SLIMBUS1_CLKCTRL, omap4_slimbus1_bit_data, CLKF_SW_SUP, "abe_cm:clk:0040:8" },
+	{ OMAP4_TIMER5_CLKCTRL, omap4_timer5_bit_data, CLKF_SW_SUP, "abe_cm:clk:0048:24" },
+	{ OMAP4_TIMER6_CLKCTRL, omap4_timer6_bit_data, CLKF_SW_SUP, "abe_cm:clk:0050:24" },
+	{ OMAP4_TIMER7_CLKCTRL, omap4_timer7_bit_data, CLKF_SW_SUP, "abe_cm:clk:0058:24" },
+	{ OMAP4_TIMER8_CLKCTRL, omap4_timer8_bit_data, CLKF_SW_SUP, "abe_cm:clk:0060:24" },
 	{ OMAP4_WD_TIMER3_CLKCTRL, NULL, CLKF_SW_SUP, "sys_32k_ck" },
 	{ 0 },
 };
@@ -280,6 +280,7 @@
 
 static const struct omap_clkctrl_div_data omap4_fdif_fck_data __initconst = {
 	.max_div = 4,
+	.flags = CLK_DIVIDER_POWER_OF_TWO,
 };
 
 static const struct omap_clkctrl_bit_data omap4_fdif_bit_data[] __initconst = {
@@ -289,7 +290,7 @@
 
 static const struct omap_clkctrl_reg_data omap4_iss_clkctrl_regs[] __initconst = {
 	{ OMAP4_ISS_CLKCTRL, omap4_iss_bit_data, CLKF_SW_SUP, "ducati_clk_mux_ck" },
-	{ OMAP4_FDIF_CLKCTRL, omap4_fdif_bit_data, CLKF_SW_SUP, "fdif_fck" },
+	{ OMAP4_FDIF_CLKCTRL, omap4_fdif_bit_data, CLKF_SW_SUP, "iss_cm:clk:0008:24" },
 	{ 0 },
 };
 
@@ -322,7 +323,7 @@
 };
 
 static const struct omap_clkctrl_reg_data omap4_l3_dss_clkctrl_regs[] __initconst = {
-	{ OMAP4_DSS_CORE_CLKCTRL, omap4_dss_core_bit_data, CLKF_SW_SUP, "dss_dss_clk" },
+	{ OMAP4_DSS_CORE_CLKCTRL, omap4_dss_core_bit_data, CLKF_SW_SUP, "l3_dss_cm:clk:0000:8" },
 	{ 0 },
 };
 
@@ -338,7 +339,7 @@
 };
 
 static const struct omap_clkctrl_reg_data omap4_l3_gfx_clkctrl_regs[] __initconst = {
-	{ OMAP4_GPU_CLKCTRL, omap4_gpu_bit_data, CLKF_SW_SUP, "sgx_clk_mux" },
+	{ OMAP4_GPU_CLKCTRL, omap4_gpu_bit_data, CLKF_SW_SUP, "l3_gfx_cm:clk:0000:24" },
 	{ 0 },
 };
 
@@ -365,6 +366,7 @@
 
 static const struct omap_clkctrl_div_data omap4_hsi_fck_data __initconst = {
 	.max_div = 4,
+	.flags = CLK_DIVIDER_POWER_OF_TWO,
 };
 
 static const struct omap_clkctrl_bit_data omap4_hsi_bit_data[] __initconst = {
@@ -373,12 +375,12 @@
 };
 
 static const char * const omap4_usb_host_hs_utmi_p1_clk_parents[] __initconst = {
-	"utmi_p1_gfclk",
+	"l3_init_cm:clk:0038:24",
 	NULL,
 };
 
 static const char * const omap4_usb_host_hs_utmi_p2_clk_parents[] __initconst = {
-	"utmi_p2_gfclk",
+	"l3_init_cm:clk:0038:25",
 	NULL,
 };
 
@@ -419,7 +421,7 @@
 };
 
 static const char * const omap4_usb_otg_hs_xclk_parents[] __initconst = {
-	"otg_60m_gfclk",
+	"l3_init_cm:clk:0040:24",
 	NULL,
 };
 
@@ -453,14 +455,14 @@
 };
 
 static const struct omap_clkctrl_reg_data omap4_l3_init_clkctrl_regs[] __initconst = {
-	{ OMAP4_MMC1_CLKCTRL, omap4_mmc1_bit_data, CLKF_SW_SUP, "hsmmc1_fclk" },
-	{ OMAP4_MMC2_CLKCTRL, omap4_mmc2_bit_data, CLKF_SW_SUP, "hsmmc2_fclk" },
-	{ OMAP4_HSI_CLKCTRL, omap4_hsi_bit_data, CLKF_HW_SUP, "hsi_fck" },
+	{ OMAP4_MMC1_CLKCTRL, omap4_mmc1_bit_data, CLKF_SW_SUP, "l3_init_cm:clk:0008:24" },
+	{ OMAP4_MMC2_CLKCTRL, omap4_mmc2_bit_data, CLKF_SW_SUP, "l3_init_cm:clk:0010:24" },
+	{ OMAP4_HSI_CLKCTRL, omap4_hsi_bit_data, CLKF_HW_SUP, "l3_init_cm:clk:0018:24" },
 	{ OMAP4_USB_HOST_HS_CLKCTRL, omap4_usb_host_hs_bit_data, CLKF_SW_SUP, "init_60m_fclk" },
 	{ OMAP4_USB_OTG_HS_CLKCTRL, omap4_usb_otg_hs_bit_data, CLKF_HW_SUP, "l3_div_ck" },
 	{ OMAP4_USB_TLL_HS_CLKCTRL, omap4_usb_tll_hs_bit_data, CLKF_HW_SUP, "l4_div_ck" },
 	{ OMAP4_USB_HOST_FS_CLKCTRL, NULL, CLKF_SW_SUP, "func_48mc_fclk" },
-	{ OMAP4_OCP2SCP_USB_PHY_CLKCTRL, omap4_ocp2scp_usb_phy_bit_data, CLKF_HW_SUP, "ocp2scp_usb_phy_phy_48m" },
+	{ OMAP4_OCP2SCP_USB_PHY_CLKCTRL, omap4_ocp2scp_usb_phy_bit_data, CLKF_HW_SUP, "l3_init_cm:clk:00c0:8" },
 	{ 0 },
 };
 
@@ -531,7 +533,7 @@
 };
 
 static const char * const omap4_per_mcbsp4_gfclk_parents[] __initconst = {
-	"mcbsp4_sync_mux_ck",
+	"l4_per_cm:clk:00c0:26",
 	"pad_clks_ck",
 	NULL,
 };
@@ -544,7 +546,7 @@
 
 static const struct omap_clkctrl_bit_data omap4_mcbsp4_bit_data[] __initconst = {
 	{ 24, TI_CLK_MUX, omap4_per_mcbsp4_gfclk_parents, NULL },
-	{ 25, TI_CLK_MUX, omap4_mcbsp4_sync_mux_ck_parents, NULL },
+	{ 26, TI_CLK_MUX, omap4_mcbsp4_sync_mux_ck_parents, NULL },
 	{ 0 },
 };
 
@@ -571,12 +573,12 @@
 };
 
 static const struct omap_clkctrl_reg_data omap4_l4_per_clkctrl_regs[] __initconst = {
-	{ OMAP4_TIMER10_CLKCTRL, omap4_timer10_bit_data, CLKF_SW_SUP, "cm2_dm10_mux" },
-	{ OMAP4_TIMER11_CLKCTRL, omap4_timer11_bit_data, CLKF_SW_SUP, "cm2_dm11_mux" },
-	{ OMAP4_TIMER2_CLKCTRL, omap4_timer2_bit_data, CLKF_SW_SUP, "cm2_dm2_mux" },
-	{ OMAP4_TIMER3_CLKCTRL, omap4_timer3_bit_data, CLKF_SW_SUP, "cm2_dm3_mux" },
-	{ OMAP4_TIMER4_CLKCTRL, omap4_timer4_bit_data, CLKF_SW_SUP, "cm2_dm4_mux" },
-	{ OMAP4_TIMER9_CLKCTRL, omap4_timer9_bit_data, CLKF_SW_SUP, "cm2_dm9_mux" },
+	{ OMAP4_TIMER10_CLKCTRL, omap4_timer10_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:0008:24" },
+	{ OMAP4_TIMER11_CLKCTRL, omap4_timer11_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:0010:24" },
+	{ OMAP4_TIMER2_CLKCTRL, omap4_timer2_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:0018:24" },
+	{ OMAP4_TIMER3_CLKCTRL, omap4_timer3_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:0020:24" },
+	{ OMAP4_TIMER4_CLKCTRL, omap4_timer4_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:0028:24" },
+	{ OMAP4_TIMER9_CLKCTRL, omap4_timer9_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:0030:24" },
 	{ OMAP4_ELM_CLKCTRL, NULL, 0, "l4_div_ck" },
 	{ OMAP4_GPIO2_CLKCTRL, omap4_gpio2_bit_data, CLKF_HW_SUP, "l4_div_ck" },
 	{ OMAP4_GPIO3_CLKCTRL, omap4_gpio3_bit_data, CLKF_HW_SUP, "l4_div_ck" },
@@ -589,14 +591,14 @@
 	{ OMAP4_I2C3_CLKCTRL, NULL, CLKF_SW_SUP, "func_96m_fclk" },
 	{ OMAP4_I2C4_CLKCTRL, NULL, CLKF_SW_SUP, "func_96m_fclk" },
 	{ OMAP4_L4_PER_CLKCTRL, NULL, 0, "l4_div_ck" },
-	{ OMAP4_MCBSP4_CLKCTRL, omap4_mcbsp4_bit_data, CLKF_SW_SUP, "per_mcbsp4_gfclk" },
+	{ OMAP4_MCBSP4_CLKCTRL, omap4_mcbsp4_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:00c0:24" },
 	{ OMAP4_MCSPI1_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
 	{ OMAP4_MCSPI2_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
 	{ OMAP4_MCSPI3_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
 	{ OMAP4_MCSPI4_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
 	{ OMAP4_MMC3_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
 	{ OMAP4_MMC4_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
-	{ OMAP4_SLIMBUS2_CLKCTRL, omap4_slimbus2_bit_data, CLKF_SW_SUP, "slimbus2_fclk_0" },
+	{ OMAP4_SLIMBUS2_CLKCTRL, omap4_slimbus2_bit_data, CLKF_SW_SUP, "l4_per_cm:clk:0118:8" },
 	{ OMAP4_UART1_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
 	{ OMAP4_UART2_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
 	{ OMAP4_UART3_CLKCTRL, NULL, CLKF_SW_SUP, "func_48m_fclk" },
@@ -619,7 +621,7 @@
 	{ OMAP4_L4_WKUP_CLKCTRL, NULL, 0, "l4_wkup_clk_mux_ck" },
 	{ OMAP4_WD_TIMER2_CLKCTRL, NULL, CLKF_SW_SUP, "sys_32k_ck" },
 	{ OMAP4_GPIO1_CLKCTRL, omap4_gpio1_bit_data, CLKF_HW_SUP, "l4_wkup_clk_mux_ck" },
-	{ OMAP4_TIMER1_CLKCTRL, omap4_timer1_bit_data, CLKF_SW_SUP, "dmt1_clk_mux" },
+	{ OMAP4_TIMER1_CLKCTRL, omap4_timer1_bit_data, CLKF_SW_SUP, "l4_wkup_cm:clk:0020:24" },
 	{ OMAP4_COUNTER_32K_CLKCTRL, NULL, 0, "sys_32k_ck" },
 	{ OMAP4_KBD_CLKCTRL, NULL, CLKF_SW_SUP, "sys_32k_ck" },
 	{ 0 },
@@ -633,7 +635,7 @@
 };
 
 static const char * const omap4_trace_clk_div_div_ck_parents[] __initconst = {
-	"pmd_trace_clk_mux_ck",
+	"emu_sys_cm:clk:0000:22",
 	NULL,
 };
 
@@ -651,12 +653,13 @@
 };
 
 static const char * const omap4_stm_clk_div_ck_parents[] __initconst = {
-	"pmd_stm_clock_mux_ck",
+	"emu_sys_cm:clk:0000:20",
 	NULL,
 };
 
 static const struct omap_clkctrl_div_data omap4_stm_clk_div_ck_data __initconst = {
 	.max_div = 64,
+	.flags = CLK_DIVIDER_POWER_OF_TWO,
 };
 
 static const struct omap_clkctrl_bit_data omap4_debugss_bit_data[] __initconst = {
@@ -698,6 +701,78 @@
 
 static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
+	/*
+	 * XXX: All the clock aliases below are only needed for legacy
+	 * hwmod support. Once hwmod is removed, these can be removed
+	 * also.
+	 */
+	DT_CLK(NULL, "aess_fclk", "abe_cm:0008:24"),
+	DT_CLK(NULL, "cm2_dm10_mux", "l4_per_cm:0008:24"),
+	DT_CLK(NULL, "cm2_dm11_mux", "l4_per_cm:0010:24"),
+	DT_CLK(NULL, "cm2_dm2_mux", "l4_per_cm:0018:24"),
+	DT_CLK(NULL, "cm2_dm3_mux", "l4_per_cm:0020:24"),
+	DT_CLK(NULL, "cm2_dm4_mux", "l4_per_cm:0028:24"),
+	DT_CLK(NULL, "cm2_dm9_mux", "l4_per_cm:0030:24"),
+	DT_CLK(NULL, "dmic_sync_mux_ck", "abe_cm:0018:26"),
+	DT_CLK(NULL, "dmt1_clk_mux", "l4_wkup_cm:0020:24"),
+	DT_CLK(NULL, "dss_48mhz_clk", "l3_dss_cm:0000:9"),
+	DT_CLK(NULL, "dss_dss_clk", "l3_dss_cm:0000:8"),
+	DT_CLK(NULL, "dss_sys_clk", "l3_dss_cm:0000:10"),
+	DT_CLK(NULL, "dss_tv_clk", "l3_dss_cm:0000:11"),
+	DT_CLK(NULL, "fdif_fck", "iss_cm:0008:24"),
+	DT_CLK(NULL, "func_dmic_abe_gfclk", "abe_cm:0018:24"),
+	DT_CLK(NULL, "func_mcasp_abe_gfclk", "abe_cm:0020:24"),
+	DT_CLK(NULL, "func_mcbsp1_gfclk", "abe_cm:0028:24"),
+	DT_CLK(NULL, "func_mcbsp2_gfclk", "abe_cm:0030:24"),
+	DT_CLK(NULL, "func_mcbsp3_gfclk", "abe_cm:0038:24"),
+	DT_CLK(NULL, "gpio1_dbclk", "l4_wkup_cm:0018:8"),
+	DT_CLK(NULL, "gpio2_dbclk", "l4_per_cm:0040:8"),
+	DT_CLK(NULL, "gpio3_dbclk", "l4_per_cm:0048:8"),
+	DT_CLK(NULL, "gpio4_dbclk", "l4_per_cm:0050:8"),
+	DT_CLK(NULL, "gpio5_dbclk", "l4_per_cm:0058:8"),
+	DT_CLK(NULL, "gpio6_dbclk", "l4_per_cm:0060:8"),
+	DT_CLK(NULL, "hsi_fck", "l3_init_cm:0018:24"),
+	DT_CLK(NULL, "hsmmc1_fclk", "l3_init_cm:0008:24"),
+	DT_CLK(NULL, "hsmmc2_fclk", "l3_init_cm:0010:24"),
+	DT_CLK(NULL, "iss_ctrlclk", "iss_cm:0000:8"),
+	DT_CLK(NULL, "mcasp_sync_mux_ck", "abe_cm:0020:26"),
+	DT_CLK(NULL, "mcbsp1_sync_mux_ck", "abe_cm:0028:26"),
+	DT_CLK(NULL, "mcbsp2_sync_mux_ck", "abe_cm:0030:26"),
+	DT_CLK(NULL, "mcbsp3_sync_mux_ck", "abe_cm:0038:26"),
+	DT_CLK(NULL, "mcbsp4_sync_mux_ck", "l4_per_cm:00c0:26"),
+	DT_CLK(NULL, "ocp2scp_usb_phy_phy_48m", "l3_init_cm:00c0:8"),
+	DT_CLK(NULL, "otg_60m_gfclk", "l3_init_cm:0040:24"),
+	DT_CLK(NULL, "per_mcbsp4_gfclk", "l4_per_cm:00c0:24"),
+	DT_CLK(NULL, "pmd_stm_clock_mux_ck", "emu_sys_cm:0000:20"),
+	DT_CLK(NULL, "pmd_trace_clk_mux_ck", "emu_sys_cm:0000:22"),
+	DT_CLK(NULL, "sgx_clk_mux", "l3_gfx_cm:0000:24"),
+	DT_CLK(NULL, "slimbus1_fclk_0", "abe_cm:0040:8"),
+	DT_CLK(NULL, "slimbus1_fclk_1", "abe_cm:0040:9"),
+	DT_CLK(NULL, "slimbus1_fclk_2", "abe_cm:0040:10"),
+	DT_CLK(NULL, "slimbus1_slimbus_clk", "abe_cm:0040:11"),
+	DT_CLK(NULL, "slimbus2_fclk_0", "l4_per_cm:0118:8"),
+	DT_CLK(NULL, "slimbus2_fclk_1", "l4_per_cm:0118:9"),
+	DT_CLK(NULL, "slimbus2_slimbus_clk", "l4_per_cm:0118:10"),
+	DT_CLK(NULL, "stm_clk_div_ck", "emu_sys_cm:0000:27"),
+	DT_CLK(NULL, "timer5_sync_mux", "abe_cm:0048:24"),
+	DT_CLK(NULL, "timer6_sync_mux", "abe_cm:0050:24"),
+	DT_CLK(NULL, "timer7_sync_mux", "abe_cm:0058:24"),
+	DT_CLK(NULL, "timer8_sync_mux", "abe_cm:0060:24"),
+	DT_CLK(NULL, "trace_clk_div_div_ck", "emu_sys_cm:0000:24"),
+	DT_CLK(NULL, "usb_host_hs_func48mclk", "l3_init_cm:0038:15"),
+	DT_CLK(NULL, "usb_host_hs_hsic480m_p1_clk", "l3_init_cm:0038:13"),
+	DT_CLK(NULL, "usb_host_hs_hsic480m_p2_clk", "l3_init_cm:0038:14"),
+	DT_CLK(NULL, "usb_host_hs_hsic60m_p1_clk", "l3_init_cm:0038:11"),
+	DT_CLK(NULL, "usb_host_hs_hsic60m_p2_clk", "l3_init_cm:0038:12"),
+	DT_CLK(NULL, "usb_host_hs_utmi_p1_clk", "l3_init_cm:0038:8"),
+	DT_CLK(NULL, "usb_host_hs_utmi_p2_clk", "l3_init_cm:0038:9"),
+	DT_CLK(NULL, "usb_host_hs_utmi_p3_clk", "l3_init_cm:0038:10"),
+	DT_CLK(NULL, "usb_otg_hs_xclk", "l3_init_cm:0040:8"),
+	DT_CLK(NULL, "usb_tll_hs_usb_ch0_clk", "l3_init_cm:0048:8"),
+	DT_CLK(NULL, "usb_tll_hs_usb_ch1_clk", "l3_init_cm:0048:9"),
+	DT_CLK(NULL, "usb_tll_hs_usb_ch2_clk", "l3_init_cm:0048:10"),
+	DT_CLK(NULL, "utmi_p1_gfclk", "l3_init_cm:0038:24"),
+	DT_CLK(NULL, "utmi_p2_gfclk", "l3_init_cm:0038:25"),
 	{ .node_name = NULL },
 };
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
