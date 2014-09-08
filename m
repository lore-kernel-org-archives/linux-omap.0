From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 08/13] arm: dts: am4372: Add dcan nodes
Date: Mon, 8 Sep 2014 17:10:37 +0300
Message-ID: <1410185442-907-9-git-send-email-rogerq@ti.com>
References: <1410185442-907-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1410185442-907-1-git-send-email-rogerq@ti.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, tony@atomide.com
Cc: tglx@linutronix.de, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

Add dcan nodes.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: George Cherian <george.cherian@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 8689949..3514d0a 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -885,6 +885,28 @@
 				clock-names = "fck";
 			};
 		};
+
+		dcan0: can@481cc000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can0";
+			clocks = <&dcan0_fck>;
+			clock-names = "fck";
+			reg = <0x481cc000 0x2000
+				0x44e10644 0x4>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		dcan1: can@481d0000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can1";
+			clocks = <&dcan1_fck>;
+			clock-names = "fck";
+			reg = <0x481d0000 0x2000
+				0x44e10644 0x4>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.3.2
