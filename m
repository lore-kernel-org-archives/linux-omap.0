From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv2 4/4] ARM: dts: omap4-droid4: Add bluetooth
Date: Wed,  3 May 2017 16:22:26 +0200
Message-ID: <20170503142226.32380-5-sebastian.reichel@collabora.co.uk>
References: <20170503142226.32380-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170503142226.32380-1-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Droid 4 has WL 1285C connected to the OMAP's UART4 port, which is
used for Bluetooth and most likely can also be used for controlling
the FM radio and GPS receivers.

Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index c09b51d6ccf7..bd7f1cc55371 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -453,6 +453,15 @@
 		OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
 		>;
 	};
+
+	uart4_pins: pinmux_uart4_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x15c, PIN_INPUT | MUX_MODE0)		/* uart4_rx */
+		OMAP4_IOPAD(0x15e, PIN_OUTPUT | MUX_MODE0)		/* uart4_tx */
+		OMAP4_IOPAD(0x110, PIN_INPUT_PULLUP | MUX_MODE5)	/* uart4_cts */
+		OMAP4_IOPAD(0x112, PIN_OUTPUT_PULLUP | MUX_MODE5)	/* uart4_rts */
+		>;
+	};
 };
 
 &omap4_pmx_wkup {
@@ -469,6 +478,17 @@
 			       &omap4_pmx_core 0x17c>;
 };
 
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+
+	bluetooth {
+		compatible = "ti,wl1285-st";
+		enable-gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>; /* gpio 174 */
+		max-speed = <3686400>;
+	};
+};
+
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
-- 
2.11.0
