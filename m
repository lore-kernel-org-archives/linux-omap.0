From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] ARM: dts: igep0020: Add SD card write-protect pin.
Date: Fri,  6 May 2016 23:02:34 +0200
Message-ID: <1462568554-7868-2-git-send-email-enric.balletbo@collabora.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

A host device that supports write protection should refuse to write to
an SD card that is designated read-only when write-protect is set. This
is an optional feature of the SD specification.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index d6f839c..b697106 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -194,6 +194,12 @@
 			OMAP3630_CORE2_IOPAD(0x25f8, PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
 		>;
 	};
+
+	mmc1_wp_pins: pinmux_mmc1_cd_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT | MUX_MODE4)   /* etk_d15.gpio_29 */
+		>;
+	};
 };
 
 &i2c3 {
@@ -250,3 +256,8 @@
 		};
 	};
 };
+
+&mmc1 {
+	pinctrl-0 = <&mmc1_pins &mmc1_wp_pins>;
+	wp-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;	/* gpio_29 */
+};
-- 
2.1.0
