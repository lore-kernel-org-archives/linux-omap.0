From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2] usb: musb: dsps: dt binding - add resources, example
Date: Tue, 6 Nov 2012 19:26:06 +0530
Message-ID: <1352210166-7253-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39602 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287Ab2KFN4T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 08:56:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, Daniel Mack <zonque@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

OMAP2+ family of devices are now obtaining resources via DT, earlier
it was obtained from hwmod. Update binding document accrodingly, while
at it add example.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v2: node name changed to "usb"

 .../devicetree/bindings/usb/am33xx-usb.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index a922505..ea840f7 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -1,5 +1,7 @@
 AM33XX MUSB GLUE
  - compatible : Should be "ti,musb-am33xx"
+ - reg : offset and length of register sets, first usbss, then for musb instances
+ - interrupts : usbss, musb instance interrupts in order
  - ti,hwmods : must be "usb_otg_hs"
  - multipoint : Should be "1" indicating the musb controller supports
    multipoint. This is a MUSB configuration-specific setting.
@@ -12,3 +14,22 @@ AM33XX MUSB GLUE
    represents PERIPHERAL.
  - power : Should be "250". This signifies the controller can supply upto
    500mA when operating in host mode.
+
+Example:
+
+usb@47400000  {
+	compatible = "ti,musb-am33xx";
+	reg = <0x47400000 0x1000	/* usbss */
+	       0x47401000 0x800		/* musb instance 0 */
+	       0x47401800 0x800>;	/* musb instance 1 */
+	interrupts = <17		/* usbss */
+		      18		/* musb instance 0 */
+		      19>;		/* musb instance 1 */
+	multipoint = <1>;
+	num-eps = <16>;
+	ram-bits = <12>;
+	port0-mode = <3>;
+	port1-mode = <3>;
+	power = <250>;
+	ti,hwmods = "usb_otg_hs";
+};
-- 
1.7.12

