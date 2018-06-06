From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v3 6/6] ARM: dts: dra76x: Add MCAN node
Date: Wed, 6 Jun 2018 11:38:26 +0530
Message-ID: <20180606060826.14671-7-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606060826.14671-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, faiz_abbas@ti.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add support for the MCAN peripheral which supports both classic
CAN messages along with the new CAN-FD message.

Add MCAN node to evm and enable it with a maximum datarate of 5 mbps

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts |  6 ++++++
 arch/arm/boot/dts/dra76x.dtsi   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 2deb96405d06..b6ac2b6ffc6e 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -404,3 +404,9 @@
 	phys = <&pcie1_phy>, <&pcie2_phy>;
 	phy-names = "pcie-phy0", "pcie-phy1";
 };
+
+&m_can0 {
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 5157cc431574..613e4dc0ed3e 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -26,6 +26,19 @@
 			ti,syss-mask = <1>;
 			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
 			clock-names = "fck";
+
+			m_can0: mcan@1a00 {
+				compatible = "bosch,m_can";
+				reg = <0x1a00 0x4000>, <0x0 0x18FC>;
+				reg-names = "m_can", "message_ram";
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "int0", "int1";
+				clocks = <&mcan_clk>, <&l3_iclk_div>;
+				clock-names = "cclk", "hclk";
+				bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+			};
 		};
 	};
 
-- 
2.17.0
