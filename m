From: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
Subject: [PATCH 5/5] Add information about the new DT device name
Date: Fri, 23 Oct 2015 17:57:19 +0200
Message-ID: <562A58DF.5020706@imms.de>
References: <562A557B.4090501@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A557B.4090501-cSCHQGRfioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add some information about the new device name to the DT documentation.

Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt | 35
++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt
b/Documentation/devicetree/bindings/usb/omap-usb.txt
index 38d9bb8..cf98f61 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -78,3 +78,38 @@ omap_dwc3 {
 	ranges;
 };

+AM35x MUSB GLUE
+ - compatible : Should be "ti,am35x-musb"
+ - ti,hwmods : must be "am35x_otg_hs"
+ - multipoint : Should be "1" indicating the musb controller supports
+   multipoint. This is a MUSB configuration-specific setting.
+ - num-eps : Specifies the number of endpoints. This is also a
+   MUSB configuration-specific setting. Should be set to "16"
+ - ram-bits : Specifies the ram address size. Should be set to "12"
+ - interface-type : Should be set to "1". (The AM35xx SOCs feature an
+   integrated phy, connected via UTMI+)
+ - mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
+   represents PERIPHERAL.
+ - power : Should be "50". This signifies the controller can supply up to
+   100mA when operating in host mode.
+
+SOC specific device node entry
+am35x_otg_hs: am35x_otg_hs@5c040000 {
+	compatible = "ti,am35x-musb";
+	ti,hwmods = "am35x_otg_hs";
+	clocks = <&hsotgusb_ick_am35xx>, <&hsotgusb_fck_am35xx>;
+	clock-names = "ick", "fck";
+	reg = <0x5c040000 0x1000>;
+	interrupts = <71>;
+	interrupt-names = "mc";
+};
+
+Board specific device node entry
+&am35x_otg_hs {
+	mode = <1>;
+	interface-type = <1>;
+	multipoint = <1>;
+	num-eps = <16>;
+	ram-bits = <12>;
+	power = <50>;
+};
-- 
2.4.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
