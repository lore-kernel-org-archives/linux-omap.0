From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/7] usb: usb: dsps: update device tree bindings
Date: Tue, 17 Jan 2017 14:45:35 +0100
Message-ID: <20170117134540.9988-3-abailon@baylibre.com>
References: <20170117134540.9988-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117134540.9988-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In order to make CPPI 4.1 DMA driver more generic, accesses to USBSS
have been removed. So it is not required anymore to define "glue"
register's address and size in DT.
Update dsps device tree bindings.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/am33xx-usb.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 20c2ff2..ef89010 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -54,9 +54,9 @@ node.
 DMA
 ~~~
 - compatible: ti,am3359-cppi41
-- reg: offset and length of the following register spaces: USBSS, USB
+- reg: offset and length of the following register spaces: USB
   CPPI DMA Controller, USB CPPI DMA Scheduler, USB Queue Manager
-- reg-names: glue, controller, scheduler, queuemgr
+- reg-names: controller, scheduler, queuemgr
 - #dma-cells: should be set to 2. The first number represents the
   endpoint number (0 … 14 for endpoints 1 … 15 on instance 0 and 15 … 29
   for endpoints 1 … 15 on instance 1). The second number is 0 for RX and
@@ -183,11 +183,10 @@ usb: usb@47400000 {
 
 	cppi41dma: dma-controller@07402000 {
 		compatible = "ti,am3359-cppi41";
-		reg =  <0x47400000 0x1000
-			0x47402000 0x1000
+		reg =  <0x47402000 0x1000
 			0x47403000 0x1000
 			0x47404000 0x4000>;
-		reg-names = "glue", "controller", "scheduler", "queuemgr";
+		reg-names = "controller", "scheduler", "queuemgr";
 		interrupts = <17>;
 		interrupt-names = "glue";
 		#dma-cells = <2>;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
