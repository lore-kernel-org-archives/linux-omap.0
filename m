From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 3/3] ARM: dts: dra76x: Add MCAN node
Date: Sun, 8 Apr 2018 15:29:02 +0530
Message-ID: <1523181542-3770-4-git-send-email-faiz_abbas@ti.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, faiz_abbas@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add support for the MCAN peripheral which supports both classic
CAN messages along with the new CAN-FD message.

Add MCAN node to evm and enable it with a maximum datarate of 5 mbps

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts |  7 +++++++
 arch/arm/boot/dts/dra76x.dtsi   | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 2deb964..2777652 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -404,3 +404,10 @@
 	phys = <&pcie1_phy>, <&pcie2_phy>;
 	phy-names = "pcie-phy0", "pcie-phy1";
 };
+
+&m_can0 {
+	status = "okay";
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index bfc8263..71bd2a2 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -11,6 +11,23 @@
 / {
 	compatible = "ti,dra762", "ti,dra7";
 
+	ocp {
+		m_can0: mcan@42C01A00 {
+			compatible = "bosch,m_can";
+			reg = <0x42C01A00 0x4000>, <0x42C00000 0x18FC>;
+			reg-names = "m_can", "message_ram";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			ti,hwmods = "mcan";
+			clocks = <&mcan_clk>, <&l3_iclk_div>;
+			clock-names = "cclk", "hclk";
+			bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+			status = "disabled";
+		};
+	};
+
 };
 
 /* MCAN interrupts are hard-wired to irqs 67, 68 */
-- 
2.7.4
