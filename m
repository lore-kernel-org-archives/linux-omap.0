From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-droid4: Add isl29030 ALS/proximity sensor
Date: Tue,  2 May 2017 10:03:01 +0200
Message-ID: <20170502080301.18111-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The Droid 4 has a isl29030 to measure ambient light (e.g. for
automatically adapting display brightness) and proximity.

Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
Hi,

The (trivial) driver changes have already been queued to iio-testing:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=e530cc8408770e6451e4d5c5e8a2a45132689cc1

-- Sebastian
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 89eb607f4a9e..1ad442ee6f30 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -348,6 +348,17 @@
 		interrupt-names = "irq", "wakeup";
 		wakeup-source;
 	};
+
+	isl29030@44 {
+		compatible = "isil,isl29030";
+		reg = <0x44>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&als_proximity_pins>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>; /* gpio177 */
+	};
 };
 
 &omap4_pmx_core {
@@ -395,6 +406,12 @@
 		>;
 	};
 
+	als_proximity_pins: pinmux_als_proximity_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x18c, PIN_INPUT_PULLUP | MUX_MODE3)
+		>;
+	};
+
 	usb_ulpi_pins: pinmux_usb_ulpi_pins {
 		pinctrl-single,pins = <
 		OMAP4_IOPAD(0x196, MUX_MODE7)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
