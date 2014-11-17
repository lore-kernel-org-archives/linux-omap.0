From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Mon, 17 Nov 2014 15:08:45 +0200
Message-ID: <5469F35D.80504@ti.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com> <1415881371-4982-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415881371-4982-7-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The SoC contains 2 DCAN modules. Add them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 899c57c..f0ff256 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -901,6 +901,28 @@
 			compatible = "mmio-sram";
 			reg = <0x40300000 0x40000>; /* 256k */
 		};
+
+		dcan0: can@481cc000 {
+			compatible = "ti,am4372-d_can", "ti,am3352-d_can";
+			ti,hwmods = "d_can0";
+			clocks = <&dcan0_fck>;
+			clock-names = "fck";
+			reg = <0x481cc000 0x2000>;
+			syscon-raminit = <&am43xx_control_module 0x644 0>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		dcan1: can@481d0000 {
+			compatible = "ti,am4372-d_can", "ti,am3352-d_can";
+			ti,hwmods = "d_can1";
+			clocks = <&dcan1_fck>;
+			clock-names = "fck";
+			reg = <0x481d0000 0x2000>;
+			syscon-raminit = <&am43xx_control_module 0x644 1>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.3.2


