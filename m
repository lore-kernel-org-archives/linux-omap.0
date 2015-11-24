From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 4/6] ARM: OMAP2+: dts: cm-t335: add support for MMC
Date: Tue, 24 Nov 2015 16:02:11 +0200
Message-ID: <1448373733-5839-5-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448373733-5839-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

Add pinmux configuration for MMC0 pins.
Add fixed regulator 'vmmc_fixed'.
Enable MMC0 in 4-bit mode.

Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions

 arch/arm/boot/dts/am335x-cm-t335.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 431b6dd..0a20256 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -31,6 +31,14 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	/* regulator for mmc */
+	vmmc_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &am33xx_pinmux {
@@ -105,6 +113,23 @@
 			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
 		>;
 	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
 };
 
 &uart0 {
@@ -204,3 +229,11 @@
 	status = "okay";
 };
 
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&vmmc_fixed>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
