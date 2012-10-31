From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RESEND PATCH 03/11] ARM: OMAP3: USB: Add USB2 Host Device Tree Node
Date: Wed, 31 Oct 2012 19:56:44 +0530
Message-ID: <1351693612-23314-4-git-send-email-keshava_mgowda@ti.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351693612-23314-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The device tree node details of usb2 host and tll components
are included for OMAP3

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 696e929..5c805d7 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -300,5 +300,27 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
 		};
+
+		usbhs: usbhs@0x4a064000 {
+			compatible = "ti,usbhs";
+			reg = <0x48064000 0x400>, /* uhh */
+				  <0x48064400 0x400>, /* ohci */
+				  <0x48064800 0x400>; /* ehci */
+			reg-names = "uhh", "ohci", "ehci";
+			interrupts = <76>, <77>;
+			interrupt-names = "ohci-irq", "ehci-irq";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "usb_host_hs";
+		};
+
+		usbtll: usbtll@0x4a062000 {
+			compatible = "ti,usbtll";
+			reg = <0x48062000 0x1000>;
+			reg-names = "tll";
+			interrupts = <78>;
+			interrupt-names = "tll-irq";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "usb_tll_hs";
+		};
 	};
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
