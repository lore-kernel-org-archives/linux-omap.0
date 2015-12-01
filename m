From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 14/19] ARM: dts: am57xx: sbc-am57x: add EEPROM support
Date: Tue,  1 Dec 2015 20:03:16 +0200
Message-ID: <1448993001-19495-15-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On-board EEPROM chip is used for storing a board production info.

Add carrier board EEPROM support (over I2C5 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---

  v2:

   * No fuctional changes
   * Reformat subject

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 17a1972..a3588ba 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -43,6 +43,13 @@
 			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
 		>;
 	};
+
+	i2c5_pins_default: i2c5_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x36b4, PIN_INPUT| MUX_MODE10)	/* mcasp1_axr0.i2c5_sda */
+			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT| MUX_MODE10)	/* mcasp1_axr1.i2c5_scl */
+		>;
+	};
 };
 
 &uart3 {
@@ -70,3 +77,16 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
+
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom_base: atmel@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
