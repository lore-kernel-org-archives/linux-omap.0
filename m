From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/11] ARM: dts: omap5.dtsi: add DSS nodes
Date: Fri, 9 May 2014 14:56:17 +0300
Message-ID: <1399636579-8062-10-git-send-email-tomi.valkeinen@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50687 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbaEIL5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 07:57:17 -0400
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add OMAP5 DSS nodes to omap5.dtsi.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index f8c9855ce587..32c02cefa9a6 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -869,6 +869,76 @@
 
 			#thermal-sensor-cells = <1>;
 		};
+
+		dss: dss@58000000 {
+			compatible = "ti,omap5-dss";
+			reg = <0x58000000 0x80>;
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			clocks = <&dss_dss_clk>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@58001000 {
+				compatible = "ti,omap5-dispc";
+				reg = <0x58001000 0x1000>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+				clocks = <&dss_dss_clk>;
+				clock-names = "fck";
+			};
+
+			rfbi: encoder@58002000  {
+				compatible = "ti,omap5-rfbi";
+				reg = <0x58002000 0x100>;
+				status = "disabled";
+				ti,hwmods = "dss_rfbi";
+				clocks = <&dss_dss_clk>, <&dss_l3_iclk>;
+				clock-names = "fck", "ick";
+			};
+
+			dsi1: encoder@58004000 {
+				compatible = "ti,omap5-dsi";
+				reg = <0x58004000 0x200>,
+				      <0x58004200 0x40>,
+				      <0x58004300 0x40>;
+				reg-names = "proto", "phy", "pll";
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_dsi1";
+				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clock-names = "fck", "sys_clk";
+			};
+
+			dsi2: encoder@58005000 {
+				compatible = "ti,omap5-dsi";
+				reg = <0x58009000 0x200>,
+				      <0x58009200 0x40>,
+				      <0x58009300 0x40>;
+				reg-names = "proto", "phy", "pll";
+				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_dsi2";
+				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clock-names = "fck", "sys_clk";
+			};
+
+			hdmi: encoder@58060000 {
+				compatible = "ti,omap5-hdmi";
+				reg = <0x58040000 0x400>,
+				      <0x58040200 0x80>,
+				      <0x58040300 0x80>,
+				      <0x58060000 0x19000>;
+				reg-names = "wp", "pll", "phy", "core";
+				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_hdmi";
+				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
+				clock-names = "fck", "sys_clk";
+			};
+		};
 	};
 };
 
-- 
1.9.1

