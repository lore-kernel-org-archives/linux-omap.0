From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 2/6] ARM: dts: AM33XX: Add default pinctrl binding for I2C device
Date: Thu, 28 Mar 2013 12:12:39 +0530
Message-ID: <1364452963-22083-3-git-send-email-hvaibhav@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51566 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab3C1GoN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 02:44:13 -0400
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, mporter@ti.com, b-cousson@ti.com, jacmet@sunsite.dk, Vaibhav Hiremath <hvaibhav@ti.com>

Add pin control binding for I2C device nodes in all
board specific DT files (as per current usage),

EVM: Both i2c0 and i2c1
EVM-SK and Bone: Only i2c0

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Matt Porter <mporter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |   10 ++++++++++
 arch/arm/boot/dts/am335x-evm.dts   |   20 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   10 ++++++++++
 3 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index cdc8307..c917efa 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -36,6 +36,13 @@
 				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
 			>;
 		};
+
+		i2c0_pins: pinmux_i2c0_pins {
+			pinctrl-single,pins = <
+				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
+				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+			>;
+		};
 	};

 	ocp {
@@ -44,6 +51,9 @@
 		};

 		i2c0: i2c@44e0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+
 			status = "okay";
 			clock-frequency = <400000>;

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index a6539ad..db52d3c 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -44,6 +44,20 @@
 				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
 			>;
 		};
+
+		i2c0_pins: pinmux_i2c0_pins {
+			pinctrl-single,pins = <
+				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
+				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+			>;
+		};
+
+		i2c1_pins: pinmux_i2c1_pins {
+			pinctrl-single,pins = <
+				0x158 0x32	/* spi0_d1.i2c1_sda PULLUP | INPUTENABLE | MODE2 */
+				0x15c 0x32	/* spi0_cs0.i2c1_scl PULLUP | INPUTENABLE | MODE2 */
+			>;
+		};
 	};

 	ocp {
@@ -52,6 +66,9 @@
 		};

 		i2c0: i2c@44e0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+
 			status = "okay";
 			clock-frequency = <400000>;

@@ -61,6 +78,9 @@
 		};

 		i2c1: i2c@4802a000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
+
 			status = "okay";
 			clock-frequency = <100000>;

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 45cb39a..24e915c 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -51,6 +51,13 @@
 				0x9c 0x27	/* gpmc_ben0_cle.gpio2_5, INPUT | MODE7 */
 			>;
 		};
+
+		i2c0_pins: pinmux_i2c0_pins {
+			pinctrl-single,pins = <
+				0x188 0x30	/* i2c0_sda.i2c0_sda PULLUP | INPUTENABLE | MODE0 */
+				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP | INPUTENABLE | MODE0 */
+			>;
+		};
 	};

 	ocp {
@@ -59,6 +66,9 @@
 		};

 		i2c0: i2c@44e0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+
 			status = "okay";
 			clock-frequency = <400000>;

--
1.7.0.4

