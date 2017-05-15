From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4] =?UTF-8?q?DTS:=20ARM:=20OMAP5:=20uevm:=20add=20=C2=B5S?= =?UTF-8?q?D=20card=20detect?=
Date: Mon, 15 May 2017 10:31:16 +0200
Message-ID: <90e9c1d71ce9ee47b55f4c0794e582167c6b961d.1494837075.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

If we have Linux installed in eMMC we can boot without
µSD card, but inserting one is not recognised.

The reason is that the card detect gpio (gpio5_152)
is not configured and attached to the mmc1 interface
driver and the mmc driver does not poll by default.

Hence we add pinmux and gpio setup for the SDCARD_NCD
signal.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index d58b034513da..1a6e28c3d847 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -142,6 +142,13 @@
 	};
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+
+	cd-gpios = <&gpio5 24 GPIO_ACTIVE_LOW>;	/* gpio5_152 */
+};
+
 &omap5_pmx_core {
 	evm_keys_pins: pinmux_evm_keys_gpio_pins {
 		pinctrl-single,pins = <
@@ -161,6 +168,12 @@
 			OMAP5_IOPAD(0x0a8, PIN_INPUT_PULLUP | MUX_MODE6)	/* gpio3_76 */
 		>;
 	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x1d4, PIN_INPUT_PULLUP | MUX_MODE6)	/* gpio5_152 */
+		>;
+	};
 };
 
 &tpd12s015 {
-- 
2.12.2
