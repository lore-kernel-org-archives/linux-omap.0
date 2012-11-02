From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 4/5] usb: musb: dsps: dt binding - add resources, example
Date: Fri, 2 Nov 2012 22:02:47 +0530
Message-ID: <392aceb635682614b8509b4090943f806b3236f2.1351870620.git.afzal@ti.com>
References: <cover.1351870620.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1351870620.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

OMAP2+ family of devices are now obtaining resources via DT, earlier
it was obtained from hwmod. Update binding document accrodingly, while
at it add example.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 .../devicetree/bindings/usb/am33xx-usb.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index a922505..6b7e3bd 100644
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
+usb_otg_hs@47400000  {
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

