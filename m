From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 2/3] ARM: dts: dra7: add vpe clkctrl node
Date: Wed, 9 Oct 2019 12:56:27 -0500
Message-ID: <20191009175628.20570-3-bparrot@ti.com>
References: <20191009175628.20570-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009175628.20570-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for VPE module.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 ++++++++++++++++--
 drivers/clk/ti/clk-7xx.c             |  6 ++++++
 include/dt-bindings/clock/dra7.h     | 10 ++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 93e1eb83bed9..d1c2406ec71c 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1591,10 +1591,10 @@
 
 	rtc_cm: rtc-cm@700 {
 		compatible = "ti,omap4-cm";
-		reg = <0x700 0x100>;
+		reg = <0x700 0x60>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0 0x700 0x100>;
+		ranges = <0 0x700 0x60>;
 
 		rtc_clkctrl: rtc-clkctrl@20 {
 			compatible = "ti,clkctrl";
@@ -1603,6 +1603,20 @@
 		};
 	};
 
+	vpe_cm: vpe-cm@760 {
+		compatible = "ti,omap4-cm";
+		reg = <0x760 0xc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x760 0xc>;
+
+		vpe_clkctrl: vpe-clkctrl@0 {
+			compatible = "ti,clkctrl";
+			reg = <0x0 0xc>;
+			#clock-cells = <2>;
+		};
+	};
+
 };
 
 &cm_core {
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index b57fe09b428b..5dd9cad07542 100644
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
