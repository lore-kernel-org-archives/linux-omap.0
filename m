From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 02/10] ARM: dts: DRA7: Add DCAN nodes
Date: Thu, 13 Nov 2014 14:22:43 +0200
Message-ID: <1415881371-4982-3-git-send-email-rogerq@ti.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The SoC supports 2 DCAN nodes. Add them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5fd52cd..631b5fb 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -34,6 +34,8 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &uart6;
+		d_can0 = &dcan1;
+		d_can1 = &dcan2;
 	};
 
 	timer {
@@ -1270,6 +1272,26 @@
 			ti,irqs-skip = <10 133 139 140>;
 			ti,irqs-safe-map = <0>;
 		};
+
+		dcan1: can@481cc000 {
+			compatible = "ti,dra7-d_can";
+			ti,hwmods = "dcan1";
+			reg = <0x4ae3c000 0x2000>;
+			syscon-raminit = <&dra7_ctrl_core 0x558 0>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcan1_sys_clk_mux>;
+			status = "disabled";
+		};
+
+		dcan2: can@481d0000 {
+			compatible = "ti,dra7-d_can";
+			ti,hwmods = "dcan2";
+			reg = <0x48480000 0x2000>;
+			syscon-raminit = <&dra7_ctrl_core 0x558 1>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_clkin1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.3.2

