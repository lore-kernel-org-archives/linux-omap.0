From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [RFC] am33xx: create child nodes for the two musb controllers
Date: Wed, 26 Jun 2013 17:33:26 +0200
Message-ID: <20130626153325.GA24075@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I've been thinkig about creating two child nodes for the independent musb
controllers on the am33. I've been thinking about the following:

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 8e1248f..6aa9506 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -326,21 +326,78 @@
 			status = "disabled";
 		};
 
 		usb@47400000 {
 			compatible = "ti,musb-am33xx";
-			reg = <0x47400000 0x1000	/* usbss */
-			       0x47401000 0x800		/* musb instance 0 */
-			       0x47401800 0x800>;	/* musb instance 1 */
-			interrupts = <17		/* usbss */
-				      18		/* musb instance 0 */
-				      19>;		/* musb instance 1 */
-			multipoint = <1>;
-			num-eps = <16>;
-			ram-bits = <12>;
-			port0-mode = <3>;
-			port1-mode = <3>;
-			power = <250>;
+			reg = <0x47400000 0x1000>;	/* usbss */
+			interrupts = <17>;		/* usbss */
 			ti,hwmods = "usb_otg_hs";
+
+			usb0@0x47401000 {
+				reg = <0x47401000 0x800>;	/* musb instance 0 */
+				interrupts = <18>;		/* musb instance 0 */
+				multipoint = <1>;
+				num-eps = <16>;
+				ram-bits = <12>;
+				port-mode = <3>;
+				power = <250>;
+
+				phys = <&nopphy0>;
+				dmas = <&cppi41dma 0
+					&cppi41dma 1
+					&cppi41dma 2
+					&cppi41dma 3
+					&cppi41dma 4
+					&cppi41dma 32
+					&cppi41dma 34
+					&cppi41dma 36
+					&cppi41dma 38
+					&cppi41dma 40>;
+				dma-names = "rx1", "rx2", "rx3", "rx4", "rx5",
+					    "tx1", "tx2", "tx3", "tx4", "tx5";
+			};
+
+			usb0@0x47401800 {
+				reg = <0x47401800 0x800>;	/* musb instance 1 */
+				interrupts = <19>;		/* musb instance 1 */
+				multipoint = <1>;
+				num-eps = <16>;
+				ram-bits = <12>;
+				port-mode = <3>;
+				power = <250>;
+
+				phys = <&nopphy1>;
+				dmas = <&cppi41dma 0
+					&cppi41dma 1
+					&cppi41dma 2
+					&cppi41dma 3
+					&cppi41dma 4
+					&cppi41dma 62
+					&cppi41dma 64
+					&cppi41dma 66
+					&cppi41dma 68
+					&cppi41dma 70>;
+				dma-names = "rx1", "rx2", "rx3", "rx4", "rx5",
+					    "tx1", "tx2", "tx3", "tx4", "tx5";
+			};
+		};

Please keep in mind that his is not a proper patch it should point out
what I have in mind.
This would easy the for instance the dma channel assignment. Also, it will
move back to the port-mode property instead of portX-mode one which it has
now. This is kind of confusing since it is not a root hub or anything like
that it is a complete musb controller. Plus for the phys property could
easily take the one avaible and would not require which instance it
really it is.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
