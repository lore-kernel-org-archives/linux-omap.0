From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 13/19] ARM: dts: am57xx: sbc-am57x: add usb vbus pinmux
Date: Tue,  1 Dec 2015 20:03:15 +0200
Message-ID: <1448993001-19495-14-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

usb1_drvvbus pin is used to Drive-VBUS enable to external charge
pump/power switch.

Add a pinmux for that pin.

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---

  v2:

   * No fuctional changes
   * Reformat subject

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 93852e2..17a1972 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -37,6 +37,12 @@
 			DRA7XX_CORE_IOPAD(0x377c, PIN_INPUT | MUX_MODE14)	/* mmc1_sdwp.gpio6_28 */
 		>;
 	};
+
+	usb1_pins: pinmux_usb1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
+		>;
+	};
 };
 
 &uart3 {
@@ -59,3 +65,8 @@
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio6 28 GPIO_ACTIVE_HIGH>;
 };
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
