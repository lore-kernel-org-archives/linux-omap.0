From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 2/2] arm: dts: omap5-evm: Add mcspi data
Date: Wed, 30 Jan 2013 19:19:43 +0530
Message-ID: <1359553783-12129-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com
Cc: Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add mcspi node and pinmux data for omap5 mcspi controller.

Tested on omap5430 evm with 3.8-rc4 custom kernel.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
Develops this on the patch[1] submitted in mainline
[1]: http://www.spinics.net/lists/kernel/msg1473163.html
 arch/arm/boot/dts/omap5-evm.dts |   46 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index a96acc0..252edda 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -115,6 +115,33 @@
 			0x186 0x100     /* i2c4_sda INPUTENABLE | MODE0 */
 		>;
 	};
+
+	mcspi2_pins: pinmux_mcspi2_pins {
+		pinctrl-single,pins = <
+			0xbc 0x100
+			0xbe 0x100
+			0xc0 0x118
+			0xc2 0x0
+		>;
+	};
+
+	mcspi3_pins: pinmux_mcspi3_pins {
+		pinctrl-single,pins = <
+			0x78 0x101
+			0x7a 0x101
+			0x7c 0x101
+			0x7e 0x101
+		>;
+	};
+
+	mcspi4_pins: pinmux_mcspi4_pins {
+		pinctrl-single,pins = <
+			0x164 0x101
+			0x168 0x101
+			0x16a 0x101
+			0x16c 0x101
+		>;
+	};
 };
 
 &mmc1 {
@@ -213,3 +240,22 @@
 	cs1-used;
 	device-handle = <&samsung_K3PE0E000B>;
 };
+
+&mcspi1 {
+
+};
+
+&mcspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+};
+
+&mcspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+};
+
+&mcspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+};
-- 
1.7.1
