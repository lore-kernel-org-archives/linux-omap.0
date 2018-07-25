From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 31/32] ARM: dts: omap3-gta04a5: define pinmux for bluetooth enable of ti,wl1837 module
Date: Wed, 25 Jul 2018 08:59:03 +0200
Message-ID: <ba29653d4b919c3594df2c43ccf868ecc19290f3.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Properly pinmux the bluetooth enable so that it is not floating.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index 973d07d0b4c8..bd232b1b24cb 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -48,6 +48,12 @@
 };
 
 &omap3_pmx_core {
+	bt_pins: pinmux_bt_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE4)	/* mmc2_dat5 = mmc3_dat1 = gpio137 */
+		>;
+	};
+
 	wlan_pins: pinmux_wlan_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE4)	/* mmc2_dat6 = mmc3_dat2 = gpio138 */
-- 
2.12.2
