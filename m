From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/6] ARM: dts: omap4-droid4: Add tmp105 sensor for droid 4
Date: Sat,  4 Mar 2017 21:43:57 -0800
Message-ID: <20170305054359.8293-5-tony@atomide.com>
References: <20170305054359.8293-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add tmp105 sensor for droid 4. This can be used with modprobe
lm75.ko and running sensors from lm-sensors package. Note that
the lm75.c driver does not yet support alert interrupt but
droid 4 seems to be wired for it.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -81,6 +81,20 @@
 	status = "disabled";
 };
 
+&i2c1 {
+	tmp105@48 {
+		compatible = "ti,tmp105";
+		reg = <0x48>;
+		pinctrl-0 = <&tmp105_irq>;
+		pinctrl-names = "default";
+		/* kpd_row0.gpio_178 */
+		interrupts-extended = <&gpio6 18 IRQ_TYPE_EDGE_FALLING
+				       &omap4_pmx_core 0x14e>;
+		interrupt-names = "irq", "wakeup";
+		wakeup-source;
+	};
+};
+
 &keypad {
 	keypad,num-rows = <8>;
 	keypad,num-columns = <8>;
@@ -242,6 +256,13 @@
 		>;
 	};
 
+	/* kpd_row0.gpio_178 */
+	tmp105_irq: pinmux_tmp105_irq {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x18e, PIN_INPUT_PULLUP | MUX_MODE3)
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
