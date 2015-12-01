From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 08/14] ARM: dts: am437x: cm-t43: add eMMC support
Date: Tue,  1 Dec 2015 15:55:03 +0200
Message-ID: <1448978109-5614-9-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448978109-5614-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

One of the CompuLab cm-t43 configurations comes with on-board eMMC as
primary storage, residing on the mmc2 interface. Add it to the device tree.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
Changes in V2:
	- Removed unnecessary line break after fixedregulator-v3_3 section.

 arch/arm/boot/dts/am437x-cm-t43.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index a2893c6..1011acc 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -26,6 +26,15 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	vmmc_3v3: fixedregulator-v3_3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		enable-active-high;
+	};
 };
 
 &am43xx_pinmux {
@@ -45,6 +54,21 @@
 		>;
 	};
 
+	emmc_pins: emmc_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad8.mmc1_dat0 */
+			AM4372_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad9.mmc1_dat1 */
+			AM4372_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad10.mmc1_dat2 */
+			AM4372_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad11.mmc1_dat3 */
+			AM4372_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad12.mmc1_dat4 */
+			AM4372_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad13.mmc1_dat5 */
+			AM4372_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad14.mmc1_dat6 */
+			AM4372_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad15.mmc1_dat7 */
+			AM4372_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM4372_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+		>;
+	};
+
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
 			AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0) /* spi0_sclk.spi0_sclk */
@@ -271,6 +295,15 @@
 	status = "okay";
 };
 
+&mmc2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_pins>;
+	vmmc-supply = <&vmmc_3v3>;
+	bus-width = <8>;
+	ti,non-removable;
+};
+
 &spi0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
