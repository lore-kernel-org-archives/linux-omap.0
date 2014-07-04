From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: sti: Add st-dwc3 devicetree bindings documentation
Date: Fri,  4 Jul 2014 12:13:51 +0100
Message-ID: <1404472432-24764-3-git-send-email-peter.griffin@linaro.org>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404472432-24764-1-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch documents the device tree documentation required for
the ST usb3 controller glue layer found in STiH407 devices.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/dwc3-st.txt | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt

diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Documentation/devicetree/bindings/usb/dwc3-st.txt
new file mode 100644
index 0000000..f14e5da
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc3-st.txt
@@ -0,0 +1,58 @@
+ST DWC3 glue logic
+
+This file documents the parameters for the dwc3-st driver.
+This driver provides the glue logic to use the dwc3 on STiH407 based platforms.
+
+Required properties:
+ - compatible	: must be "st,stih407-dwc3"
+ - reg		: glue logic base address and USB syscfg ctrl register offest
+ - reg-names	: Should be "reg-glue" and "syscfg-reg".
+ - st,syscon    : should be phandle to system configuration node which
+		  encompases the glue registers.
+ - resets       : phandle pointing to the system powerdown controller
+See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+See: Documentation/devicetree/bindings/reset/reset.txt
+
+ - #address-cells, #size-cells : should be '1' if the device has sub-nodes
+                                 with 'reg' property.
+
+ - pinctl-names : A pinctrl state named "default" must be defined.
+See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt.
+
+ - pinctrl-0	: Pin control group
+See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt.
+
+ - ranges: allows valid 1:1 translation between child's address space and
+   parent's address space.
+
+Optional properties:
+ - st,dwc3-drd-device: to program the HC as "device" (static setup)
+
+Sub-nodes:
+The dwc3 core should be added as subnode to ST DWC3 glue as shown in the
+example below. The DT binding details of dwc3 can be found in:
+Documentation/devicetree/bindings/usb/dwc3.txt
+
+Example:
+
+st_dwc3: dwc3@8f94000 {
+	status		= "disabled";
+	compatible	= "st,stih407-dwc3";
+	reg		= <0x08f94000 0x1000>, <0x110 0x4>;
+	reg-names	= "reg-glue", "syscfg-reg";
+	st,syscfg	= <&syscfg_core>;
+	resets          = <&powerdown STIH407_USB3_POWERDOWN>;
+	#address-cells	= <1>;
+	#size-cells	= <1>;
+	pinctrl-names	= "default";
+	pinctrl-0	= <&pinctrl_usb3>;
+	ranges;
+
+	dwc3: dwc3@9900000 {
+		compatible	= "synopsys,dwc3";
+		reg		= <0x09900000 0x100000>;
+		interrupts	=  <GIC_SPI 155 IRQ_TYPE_NONE>;
+
+		usb-phy = <&usb2_phy>, <&usb3_phy>;
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
