From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v2 01/10] clk: ti: dra7: add cam clkctrl data
Date: Mon, 4 Nov 2019 14:48:44 -0600
Message-ID: <20191104204853.4355-2-bparrot@ti.com>
References: <20191104204853.4355-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191104204853.4355-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add clkctrl data for CAM domain.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/clk/ti/clk-7xx.c         | 19 +++++++++++++++++++
 include/dt-bindings/clock/dra7.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 5dd9cad07542..8f2204a36b51 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -151,6 +151,24 @@ static const struct omap_clkctrl_reg_data dra7_vpe_clkctrl_regs[] __initconst =
 	{ 0 },
 };
 
+static const char * const dra7_cam_gfclk_mux_parents[] __initconst = {
+	"l3_iclk_div",
+	"core_iss_main_clk",
+	NULL,
+};
+
+static const struct omap_clkctrl_bit_data dra7_cam_bit_data[] __initconst = {
+	{ 24, TI_CLK_MUX, dra7_cam_gfclk_mux_parents, NULL },
+	{ 0 },
+};
+
+static const struct omap_clkctrl_reg_data dra7_cam_clkctrl_regs[] __initconst = {
+	{ DRA7_CAM_VIP1_CLKCTRL, dra7_cam_bit_data, CLKF_HW_SUP, "l3_iclk_div" },
+	{ DRA7_CAM_VIP2_CLKCTRL, dra7_cam_bit_data, CLKF_HW_SUP, "l3_iclk_div" },
+	{ DRA7_CAM_VIP3_CLKCTRL, dra7_cam_bit_data, CLKF_HW_SUP, "l3_iclk_div" },
+	{ 0 },
+};
+
 static const struct omap_clkctrl_reg_data dra7_coreaon_clkctrl_regs[] __initconst = {
 	{ DRA7_COREAON_SMARTREFLEX_MPU_CLKCTRL, NULL, CLKF_SW_SUP, "wkupaon_iclk_mux" },
 	{ DRA7_COREAON_SMARTREFLEX_CORE_CLKCTRL, NULL, CLKF_SW_SUP, "wkupaon_iclk_mux" },
@@ -783,6 +801,7 @@ const struct omap_clkctrl_data dra7_clkctrl_data[] __initconst = {
 	{ 0x4a008c00, dra7_atl_clkctrl_regs },
 	{ 0x4a008d20, dra7_l4cfg_clkctrl_regs },
 	{ 0x4a008e20, dra7_l3instr_clkctrl_regs },
+	{ 0x4a009020, dra7_cam_clkctrl_regs },
 	{ 0x4a009120, dra7_dss_clkctrl_regs },
 	{ 0x4a009320, dra7_l3init_clkctrl_regs },
 	{ 0x4a0093b0, dra7_pcie_clkctrl_regs },
diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
index 2b765e579b2a..2c058a534bab 100644
--- a/include/dt-bindings/clock/dra7.h
+++ b/include/dt-bindings/clock/dra7.h
@@ -34,6 +34,11 @@
 #define DRA7_VPE_CLKCTRL_INDEX(offset)	((offset) - DRA7_VPE_CLKCTRL_OFFSET)
 #define DRA7_VPE_CLKCTRL	DRA7_VPE_CLKCTRL_INDEX(0x64)
 
+/* vip clocks */
+#define DRA7_VIP1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x20)
+#define DRA7_VIP2_CLKCTRL	DRA7_CLKCTRL_INDEX(0x28)
+#define DRA7_VIP3_CLKCTRL	DRA7_CLKCTRL_INDEX(0x30)
+
 /* coreaon clocks */
 #define DRA7_SMARTREFLEX_MPU_CLKCTRL	DRA7_CLKCTRL_INDEX(0x28)
 #define DRA7_SMARTREFLEX_CORE_CLKCTRL	DRA7_CLKCTRL_INDEX(0x38)
@@ -202,6 +207,11 @@
 #define DRA7_VPE_CLKCTRL_INDEX(offset)	((offset) - DRA7_VPE_CLKCTRL_OFFSET)
 #define DRA7_VPE_VPE_CLKCTRL	DRA7_VPE_CLKCTRL_INDEX(0x64)
 
+/* vip clocks */
+#define DRA7_CAM_VIP1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x20)
+#define DRA7_CAM_VIP2_CLKCTRL	DRA7_CLKCTRL_INDEX(0x28)
+#define DRA7_CAM_VIP3_CLKCTRL	DRA7_CLKCTRL_INDEX(0x30)
+
 /* coreaon clocks */
 #define DRA7_COREAON_SMARTREFLEX_MPU_CLKCTRL	DRA7_CLKCTRL_INDEX(0x28)
 #define DRA7_COREAON_SMARTREFLEX_CORE_CLKCTRL	DRA7_CLKCTRL_INDEX(0x38)
-- 
2.17.1
