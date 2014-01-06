From: Satish Patel <satish.patel@ti.com>
Subject: [RFC PATCH v1 5/5] ARM: dts: AM43xx-epos-evm: DT entries  for ti-usim
Date: Mon, 6 Jan 2014 17:37:42 +0530
Message-ID: <1389010062-17185-6-git-send-email-satish.patel@ti.com>
References: <1389010062-17185-1-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389010062-17185-1-git-send-email-satish.patel@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: rob@landley.net, gregkh@linuxfoundation.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

Board specific DT entries for TI's USIM - smart card controller of AM43xx
platfrom.These entries are used by USIM driver for various configurations.

Shutdown line of NXP phy is maped to GPIO5. So enabling same to have support
for NXP phy.

Signed-off-by: Satish Patel <satish.patel@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index f20559b..4ca3460 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -202,6 +202,17 @@
 		>;
 	};
 
+	usim0_default: usim0_default {
+		pinctrl-single,pins = <
+			/* USIM 0 */
+			0x1B4 (SLEWCTRL_FAST | PULL_DISABLE | MUX_MODE8)		/* CLK0  */
+			0x1B0 (SLEWCTRL_FAST | PULL_DISABLE | MUX_MODE8)		/* CLK1  */
+			0x1B8 (SLEWCTRL_FAST | INPUT_EN | PULL_DISABLE | MUX_MODE8)	/* DATA0 */
+			0x1BC (SLEWCTRL_FAST | INPUT_EN | PULL_DISABLE | MUX_MODE8)	/* DATA1 */
+			0x1C8 (SLEWCTRL_FAST | INPUT_EN | PULL_UP | MUX_MODE8)		/* IRQn  */
+			>;
+		};
+
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
 			0x150 (PIN_INPUT | MUX_MODE0)           /* spi0_clk.spi0_clk */
@@ -328,6 +339,11 @@
 	status = "okay";
 };
 
+&gpio5 {
+	status = "okay";
+};
+
+
 &dpi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_pinctrl>;
@@ -478,6 +494,14 @@
 	};
 };
 
+&usim0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usim0_default>;
+	phy = <&tda8026>;
+	phy-slots = <1>;
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
@@ -490,6 +514,12 @@
 		video-source = <&dpi>;
 		data-lines = <24>;
 	};
+	tda8026: tda8026@48 {
+		compatible = "nxp,tda8026";
+		reg = <0x48>;
+		shutdown-gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;   /* Bank5, pin19 */
+		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 &spi0 {
-- 
1.7.1
