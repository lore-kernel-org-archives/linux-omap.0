From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
Date: Thu, 25 Feb 2016 16:36:34 -0600
Message-ID: <1456439796-28546-4-git-send-email-fcooper@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, tony@atomide.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
clock to control ehrpwm tbclk.
The TRM says, tbclk is derived from SYSCLKOUT. SYSCLKOUT is nothing but
ehrpwm functional clock derived from the gateable interface and
functional clock of PWMSS(l4_root_clk_div).
Refer AM57x TRM SPRUHZ6[1], October 2014, Table 29-4 and Section 29.2.2.1,
Table 29-19 and the NOTE at the end of the table.

[1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
Version 3 changes:
None

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 357bede..d0bae06 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2146,4 +2146,28 @@
 		ti,bit-shift = <0>;
 		reg = <0x558>;
 	};
+
+       ehrpwm0_tbclk: ehrpwm0_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <20>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm1_tbclk: ehrpwm1_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <21>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm2_tbclk: ehrpwm2_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <22>;
+		reg = <0x0558>;
+	};
 };
-- 
2.7.0

