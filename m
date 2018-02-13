From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] dt-bindings: memory: ti-emif: add edac support under emif
Date: Tue, 13 Feb 2018 19:15:29 +0200
Message-ID: <1518542129-25813-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Certain revisions of the TI EMIF IP contain ECC support in them. Reflect
this in the DT binding. Also, add interrupts property as a required
property for the emif controller, as all revisions of the emif IP contain
interrupt support; this might remain unused by the kernel driver though.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/memory-controllers/ti/emif.txt      | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
index 621b41c..87022a9 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -3,7 +3,9 @@
 EMIF - External Memory Interface - is an SDRAM controller used in
 TI SoCs. EMIF supports, based on the IP revision, one or more of
 DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
-of the EMIF IP and memory parts attached to it.
+of the EMIF IP and memory parts attached to it. Certain revisions
+of the EMIF controller also contain optional ECC support, which
+corrects one bit errors and detects two bit errors.
 
 Required properties:
 - compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
@@ -11,6 +13,8 @@ Required properties:
   compatible should be one of the following:
   	     "ti,emif-am3352"
 	     "ti,emif-am4372"
+	     "ti,emif-dra7xx"
+	     "ti,emif-keystone"
 
 - phy-type	: <u32> indicating the DDR phy type. Following are the
   allowed values
@@ -22,6 +26,7 @@ Required properties:
 - ti,hwmods	: For TI hwmods processing and omap device creation
   the value shall be "emif<n>" where <n> is the number of the EMIF
   instance with base 1.
+- interrupts	: interrupt used by the controller
 
 Required only for "ti,emif-am3352" and "ti,emif-am4372":
 - sram			: Phandles for generic sram driver nodes,
@@ -71,3 +76,9 @@ emif: emif@4c000000 {
         sram = <&pm_sram_code
                 &pm_sram_data>;
 };
+
+emif1: emif@4c000000 {
+	compatible = "ti,emif-dra7xx";
+	reg = <0x4c000000 0x200>;
+	interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
