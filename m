From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 06/10] arm/dts: dra7.dtsi: add DSS support
Date: Tue, 24 Mar 2015 16:55:06 +0200
Message-ID: <1427208910-17678-7-git-send-email-tomi.valkeinen@ti.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbCXO4J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 10:56:09 -0400
In-Reply-To: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
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
index 8e50ca3fc102..312ede660b23 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1445,6 +1445,44 @@
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
 };
 
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index e5a3d23a3df1..0866866c8e94 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -28,3 +28,14 @@
 		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
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
index 10173fab1a15..1a4f4970aaad 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -67,3 +67,18 @@
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
2.3.3

