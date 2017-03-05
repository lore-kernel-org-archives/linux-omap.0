From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/6] ARM: dts: omap4-droid4: Add touchscreen
Date: Sat,  4 Mar 2017 21:43:54 -0800
Message-ID: <20170305054359.8293-2-tony@atomide.com>
References: <20170305054359.8293-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Droid4's touchscreen can be used with mainline's maxtouch driver. The
touchscreen's lower area is used for four soft buttons (KEY_MENU,
KEY_HOME, KEY_BACK, KEY_SEARCH), but that does not seem to be currently
supported by the mainline kernel.

The mxt224 configuration can be saved with "mxt-app" for the kernel
to load. It can be saved after the first boot with:

# mxt-app -d i2c-dev:1-004a --save /lib/firmware/maxtouch.cfg

Where the mxt-app can be found at:

https://github.com/atmel-maxtouch/mxt-app

The firmware for the droid 4 mxt224 comes with GPLv2 license in the
Motorola Linux kernel sources. This firmware can be dumped out with
"droid4-touchscreen-firmware" program at:

https://github.com/tmlind/droid4-touchscreen-firmware

The related LCD patches are still pending, but when merged,
the touchscreen can be rotated in X with something like:

# xrandr --output DSI-1 --rotate right
# xinput set-prop 6 'Coordinate Transformation Matrix' \
	0 1 0 -1 0 1 0 0 1

For now, we rely on a gpio-hog but later on we can add the reset
gpio handling to the driver and have it load the maxtouch.cfg and
maxtouch.fw on boot.

This patch is based on combined similar patches done by me and
Sebastian.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-ff-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -59,6 +59,15 @@
 	};
 };
 
+&gpio6 {
+	touchscreen_reset {
+		gpio-hog;
+		gpios = <13 0>;
+		output-high;
+		line-name = "touchscreen-reset";
+	};
+};
+
 /* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
 &gpmc {
 	status = "disabled";
@@ -171,6 +180,27 @@
 	};
 };
 
+/*
+ * REVISIT: Add gpio173 reset pin handling to the driver, see gpio-hog above.
+ * If the GPIO reset is used, we probably need to have /lib/firmware/maxtouch.fw
+ * available. See "mxt-app" and "droid4-touchscreen-firmware" tools for more
+ * information.
+ */
+&i2c2 {
+	tsp@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+
+		/* gpio_183 with sys_nirq2 pad as wakeup */
+		interrupts-extended = <&gpio6 23 IRQ_TYPE_EDGE_FALLING
+				       &omap4_pmx_core 0x160>;
+		interrupt-names = "irq", "wakeup";
+		wakeup-source;
+	};
+};
+
 /* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
 &ocmcram {
 	status = "disabled";
@@ -184,6 +214,12 @@
 		>;
 	};
 
+	touchscreen_pins: pinmux_touchscreen_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x1a0, PIN_INPUT_PULLUP | MUX_MODE3)
+		>;
+	};
+
 	usb_ulpi_pins: pinmux_usb_ulpi_pins {
 		pinctrl-single,pins = <
 		OMAP4_IOPAD(0x196, MUX_MODE7)
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
