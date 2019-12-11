From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v5 1/3] clk: ti: dra7: add vpe clkctrl data
Date: Wed, 11 Dec 2019 08:08:08 -0600
Message-ID: <20191211140810.10657-2-bparrot@ti.com>
References: <20191211140810.10657-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211140810.10657-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add clkctrl data for VPE.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/ti/clk-7xx.c         |  6 ++++++
 include/dt-bindings/clock/dra7.h | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 5f46782cebeb..34e49f909a07 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -146,6 +146,11 @@ static const struct omap_clkctrl_reg_data dra7_rtc_clkctrl_regs[] __initconst =
 	{ 0 },
 };
 
+static const struct omap_clkctrl_reg_data dra7_vpe_clkctrl_regs[] __initconst = {
+	{ DRA7_VPE_VPE_CLKCTRL, NULL, CLKF_HW_SUP, "dpll_core_h23x2_ck" },
+	{ 0 },
+};
+
 static const struct omap_clkctrl_reg_data dra7_coreaon_clkctrl_regs[] __initconst = {
 	{ DRA7_COREAON_SMARTREFLEX_MPU_CLKCTRL, NULL, CLKF_SW_SUP, "wkupaon_iclk_mux" },
 	{ DRA7_COREAON_SMARTREFLEX_CORE_CLKCTRL, NULL, CLKF_SW_SUP, "wkupaon_iclk_mux" },
@@ -769,6 +774,7 @@ const struct omap_clkctrl_data dra7_clkctrl_data[] __initconst = {
 	{ 0x4a005550, dra7_ipu_clkctrl_regs },
 	{ 0x4a005620, dra7_dsp2_clkctrl_regs },
 	{ 0x4a005720, dra7_rtc_clkctrl_regs },
+	{ 0x4a005760, dra7_vpe_clkctrl_regs },
 	{ 0x4a008620, dra7_coreaon_clkctrl_regs },
 	{ 0x4a008720, dra7_l3main1_clkctrl_regs },
 	{ 0x4a008920, dra7_ipu2_clkctrl_regs },
diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
index 72f2e8411523..2b765e579b2a 100644
--- a/include/dt-bindings/clock/dra7.h
+++ b/include/dt-bindings/clock/dra7.h
@@ -29,6 +29,11 @@
 #define DRA7_RTC_CLKCTRL_INDEX(offset)	((offset) - DRA7_RTC_CLKCTRL_OFFSET)
 #define DRA7_RTCSS_CLKCTRL	DRA7_RTC_CLKCTRL_INDEX(0x44)
 
+/* vpe clocks */
+#define DRA7_VPE_CLKCTRL_OFFSET	0x60
+#define DRA7_VPE_CLKCTRL_INDEX(offset)	((offset) - DRA7_VPE_CLKCTRL_OFFSET)
+#define DRA7_VPE_CLKCTRL	DRA7_VPE_CLKCTRL_INDEX(0x64)
+
 /* coreaon clocks */
 #define DRA7_SMARTREFLEX_MPU_CLKCTRL	DRA7_CLKCTRL_INDEX(0x28)
 #define DRA7_SMARTREFLEX_CORE_CLKCTRL	DRA7_CLKCTRL_INDEX(0x38)
@@ -192,6 +197,11 @@
 /* rtc clocks */
 #define DRA7_RTC_RTCSS_CLKCTRL	DRA7_CLKCTRL_INDEX(0x44)
 
+/* vpe clocks */
+#define DRA7_VPE_CLKCTRL_OFFSET	0x60
+#define DRA7_VPE_CLKCTRL_INDEX(offset)	((offset) - DRA7_VPE_CLKCTRL_OFFSET)
+#define DRA7_VPE_VPE_CLKCTRL	DRA7_VPE_CLKCTRL_INDEX(0x64)
+
 /* coreaon clocks */
 #define DRA7_COREAON_SMARTREFLEX_MPU_CLKCTRL	DRA7_CLKCTRL_INDEX(0x28)
 #define DRA7_COREAON_SMARTREFLEX_CORE_CLKCTRL	DRA7_CLKCTRL_INDEX(0x38)
-- 
2.17.1
