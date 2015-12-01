From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 03/19] ARM: dts: am57xx: cl-som-am57x: add I2C3 support
Date: Tue,  1 Dec 2015 20:03:05 +0200
Message-ID: <1448993001-19495-4-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Enable I2C3 bus and add appropriate pinmux.

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---

  v2:

   * No fuctional changes
   * Refactor patch with respect to the previous changes in I2C4 node structure
   * Reformat subject

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 58156a9..2074fd4 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -52,6 +52,13 @@
 		>;
 	};
 
+	i2c3_pins_default: i2c3_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x36a4, PIN_INPUT| MUX_MODE10)	/* mcasp1_aclkx.i2c3_sda */
+			DRA7XX_CORE_IOPAD(0x36a8, PIN_INPUT| MUX_MODE10)	/* mcasp1_fsx.i2c3_scl */
+		>;
+	};
+
 	i2c4_pins_default: i2c4_pins_default {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x36ac, PIN_INPUT| MUX_MODE10)	/* mcasp1_acl.i2c4_sda */
@@ -73,6 +80,13 @@
 	clock-frequency = <400000>;
 };
 
+&i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &i2c4 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
