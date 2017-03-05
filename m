From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/6] ARM: dts: omap4-droid4: Add GPIO poweroff
Date: Sat,  4 Mar 2017 21:43:56 -0800
Message-ID: <20170305054359.8293-4-tony@atomide.com>
References: <20170305054359.8293-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Droid 4 has a GPIO line that we can use with CONFIG_POWER_RESET_GPIO.
It is probably connected to the CPCAP PMIC, and seems to power down
the whole device taking power consumption to zero based on what
I measured.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -27,6 +27,14 @@
 		reg = <0x80000000 0x3fd00000>;	/* 1021 MB */
 	};
 
+	/* Poweroff GPIO probably connected to CPCAP */
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&poweroff_gpio>;
+		pinctrl-names = "default";
+		gpios = <&gpio2 18 GPIO_ACTIVE_LOW>;	/* gpio50 */
+	};
+
 	/* This is probably coming straight from the battery.. */
 	wl12xx_vmmc: regulator-wl12xx {
 		compatible = "regulator-fixed";
@@ -226,6 +234,14 @@
 };
 
 &omap4_pmx_core {
+
+	/* gpmc_ncs0.gpio_50 */
+	poweroff_gpio: pinmux_poweroff_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x074, PIN_OUTPUT_PULLUP | MUX_MODE3)
+		>;
+	};
+
 	usb_gpio_mux_sel1: pinmux_usb_gpio_mux_sel1_pins {
 		/* gpio_60 */
 		pinctrl-single,pins = <
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
