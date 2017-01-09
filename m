From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 07/11] dt/bindings: da8xx-usb: Add binding for the cppi41 dma controller
Date: Mon,  9 Jan 2017 17:06:52 +0100
Message-ID: <20170109160656.3470-8-abailon@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

DT binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx cppi41 dma controller.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/usb/da8xx-usb.txt          | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
index ccb844a..2a4d737 100644
--- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
@@ -18,10 +18,26 @@ Required properties:
 
  - phy-names: Should be "usb-phy"
 
+ - dmas: specifies the dma channels
+
+ - dma-names: specifies the names of the channels. Use "rxN" for receive
+   and "txN" for transmit endpoints. N specifies the endpoint number.
+
 Optional properties:
 ~~~~~~~~~~~~~~~~~~~~
  - vbus-supply: Phandle to a regulator providing the USB bus power.
 
+DMA
+~~~
+- compatible: ti,da8xx-cppi41
+- reg: offset and length of the following register spaces: USBSS, USB
+  CPPI DMA Controller, USB CPPI DMA Scheduler, USB Queue Manager
+- reg-names: glue, controller, scheduler, queuemgr
+- #dma-cells: should be set to 2. The first number represents the
+  endpoint number (0 … 3 for endpoints 1 … 4).
+  The second number is 0 for RX and 1 for TX transfers.
+- #dma-channels: should be set to 4 representing the 4 endpoints.
+
 Example:
 	usb_phy: usb-phy {
 		compatible = "ti,da830-usb-phy";
@@ -39,5 +55,28 @@ Example:
 		phys = <&usb_phy 0>;
 		phy-names = "usb-phy";
 
+		dmas = <&cppi41dma 0 0 &cppi41dma 1 0
+			&cppi41dma 2 0 &cppi41dma 3 0
+			&cppi41dma 0 1 &cppi41dma 1 1
+			&cppi41dma 2 1 &cppi41dma 3 1>;
+		dma-names =
+			"rx1", "rx2", "rx3", "rx4",
+			"tx1", "tx2", "tx3", "tx4";
+
 		status = "okay";
 	};
+	cppi41dma: dma-controller@201000 {
+		compatible = "ti,da8xx-cppi41";
+		reg =  <0x200000 0x1000
+			0x201000 0x1000
+			0x202000 0x1000
+			0x204000 0x4000>;
+		reg-names = "glue", "controller", "scheduler", "queuemgr";
+		interrupts = <58>;
+		interrupt-names = "glue";
+		#dma-cells = <2>;
+		#dma-channels = <4>;
+		#dma-requests = <256>;
+		status = "disabled";
+
+	};
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
