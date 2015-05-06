From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 06/10] arm/dts: dra7.dtsi: add DSS support
Date: Wed, 6 May 2015 13:08:54 +0300
Message-ID: <1430906938-26128-7-git-send-email-tomi.valkeinen@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50673 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbbEFKJn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 06:09:43 -0400
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

DRA7xxx contains a very similar DSS to OMAP5. The main differences are:

* no DSI or RFBI support.
* 1 or 2 dedicated video PLLs.
* need to do additional configuration to the DRA7 CONTROL module.

DRA72xx has only one video PLL, and DRA74xx has two.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/dra7.dtsi   | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi | 11 +++++++++++
 arch/arm/boot/dts/dra74x.dtsi | 15 +++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5332b57b4950..a319de723851 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1469,6 +1469,44 @@
 			clocks = <&sys_clkin1>;
 			status = "disabled";
 		};
+
+		dss: dss@58000000 {
+			compatible = "ti,dra7-dss";
+			/* 'reg' defined in dra72x.dtsi and dra74x.dtsi */
+			/* 'clocks' defined in dra72x.dtsi and dra74x.dtsi */
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			/* CTRL_CORE_DSS_PLL_CONTROL */
+			syscon-pll-ctrl = <&scm_conf 0x538>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@58001000 {
+				compatible = "ti,dra7-dispc";
+				reg = <0x58001000 0x1000>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+				clocks = <&dss_dss_clk>;
+				clock-names = "fck";
+				/* CTRL_CORE_SMA_SW_1 */
+				syscon-pol = <&scm_conf 0x534>;
+			};
+
+			hdmi: encoder@58060000 {
+				compatible = "ti,dra7-hdmi";
+				reg = <0x58040000 0x200>,
+				      <0x58040200 0x80>,
+				      <0x58040300 0x80>,
+				      <0x58060000 0x19000>;
+				reg-names = "wp", "pll", "phy", "core";
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_hdmi";
+				clocks = <&dss_48mhz_clk>, <&dss_hdmi_clk>;
+				clock-names = "fck", "sys_clk";
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index 03d742f8d572..eaca143faa77 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -34,3 +34,14 @@
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
+
+&dss {
+	reg = <0x58000000 0x80>,
+	      <0x58004054 0x4>,
+	      <0x58004300 0x20>;
+	reg-names = "dss", "pll1_clkctrl", "pll1";
+
+	clocks = <&dss_dss_clk>,
+		 <&dss_video1_clk>;
+	clock-names = "fck", "video1_clk";
+};
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index cc560a70926f..fa995d0ca1f2 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -73,3 +73,18 @@
 		};
 	};
 };
+
+&dss {
+	reg = <0x58000000 0x80>,
+	      <0x58004054 0x4>,
+	      <0x58004300 0x20>,
+	      <0x58005054 0x4>,
+	      <0x58005300 0x20>;
+	reg-names = "dss", "pll1_clkctrl", "pll1",
+		    "pll2_clkctrl", "pll2";
+
+	clocks = <&dss_dss_clk>,
+		 <&dss_video1_clk>,
+		 <&dss_video2_clk>;
+	clock-names = "fck", "video1_clk", "video2_clk";
+};
-- 
2.1.4

