From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-droid4: add bluetooth
Date: Sun, 16 Apr 2017 00:18:32 +0200
Message-ID: <20170415221832.16175-1-sre@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Droid 4 has wl1835 connected to the OMAP's UART4 port, which is
used for Bluetooth and most likely can also be used for controlling
the FM radio and GPS receivers.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
Hi,

Thanks to the work of Rob adding Bluetooth support for Droid 4 was
straight forward :) I did a short test scanning for available devices
using bluetoothctl. For that I had to rebind the bluetooth device,
since it has been initialized before rootfs/firmware was available
(builtin driver):

echo serial0-0 > /sys/bus/serial/drivers/hci-ti/unbind
echo serial0-0 > /sys/bus/serial/drivers/hci-ti/bind

According to my research the FM module should be functional on
Droid 4 and the wl1835's GPS is also used. Rob, do you have a
plans for supporting the extra resources?

-- Sebastian
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index e0fdfe6cc78c..2495faf79a43 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -395,6 +395,15 @@
 		>;
 	};
 
+	uart4_pins: pinmux_uart4_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x15c, PIN_INPUT | MUX_MODE0)		/* uart4_rx */
+		OMAP4_IOPAD(0x15e, PIN_OUTPUT | MUX_MODE0)		/* uart4_tx */
+		OMAP4_IOPAD(0x110, PIN_INPUT_PULLUP | MUX_MODE5)	/* uart4_cts */
+		OMAP4_IOPAD(0x112, PIN_OUTPUT_PULLUP | MUX_MODE5)	/* uart4_rts */
+		>;
+	};
+
 	mcbsp2_pins: pinmux_mcbsp2_pins {
 		pinctrl-single,pins = <
 			OMAP4_IOPAD(0x0f6, PIN_INPUT | MUX_MODE0)	/* abe_mcbsp2_clkx */
@@ -429,6 +438,17 @@
 			       &omap4_pmx_core 0x17c>;
 };
 
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+
+	bluetooth {
+		compatible = "ti,wl1835-st";
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
