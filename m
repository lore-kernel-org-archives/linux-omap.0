From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: omap5-uevm: Allow bootloader to configure USB Ethernet MAC
Date: Thu,  5 Jan 2017 08:37:02 -0800
Message-ID: <20170105163703.1982-3-tony@atomide.com>
References: <20170105163703.1982-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170105163703.1982-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Note that with 9730 the wiring is different compared to 9514 found on
beagleboard xm for example.

On beagleboard xm we have:

/sys/bus/usb/devices/1-2	hub
/sys/bus/usb/devices/1-2.1	9514

While on omap5-uevm we have:

/sys/bus/usb/devices/1-2	hub
/sys/bus/usb/devices/1-3	9730

Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -18,6 +18,10 @@
 		reg = <0 0x80000000 0 0x7f000000>; /* 2032 MB */
 	};
 
+	aliases {
+		ethernet = &ethernet;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led1 {
@@ -164,6 +168,23 @@
 	>;
 };
 
+&usbhsehci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	hub@2 {
+		compatible = "usb424,3503";
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	ethernet: usbether@3 {
+		compatible = "usb424,9730";
+		reg = <3>;
+	};
+};
+
 &wlcore {
 	compatible = "ti,wl1837";
 };
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
