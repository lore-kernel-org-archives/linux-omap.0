From: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
Subject: [PATCH 4/5] Use new MUSB device name in AM3517 device tree.
Date: Fri, 23 Oct 2015 17:53:36 +0200
Message-ID: <562A5800.3040609@imms.de>
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

Use new MUSB device name in AM3517 device tree and add name declarations
for interface and function clock, so the am35x drivers clk_get() calls
can find them.

Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
---
 arch/arm/boot/dts/am3517.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 0b1c07f5..10838b5 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -17,9 +17,11 @@

 	ocp {
 		am35x_otg_hs: am35x_otg_hs@5c040000 {
-			compatible = "ti,omap3-musb";
+			compatible = "ti,am35x-musb";
 			ti,hwmods = "am35x_otg_hs";
 			status = "disabled";
+			clocks = <&hsotgusb_ick_am35xx>, <&hsotgusb_fck_am35xx>;
+			clock-names = "ick", "fck";
 			reg = <0x5c040000 0x1000>;
 			interrupts = <71>;
 			interrupt-names = "mc";
-- 
2.4.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
