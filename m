From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/17] ARM: dts: Add missing hsi node for omap4
Date: Wed, 30 Aug 2017 08:19:44 -0700
Message-ID: <20170830151953.30856-9-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we're missing the hsi node with it's related "ti,hwmods"
property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Let's also update the binding accrodingly while at it.

Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/hsi/omap-ssi.txt |  7 ++++-
 arch/arm/boot/dts/omap4.dtsi                       | 34 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hsi/omap-ssi.txt b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
--- a/Documentation/devicetree/bindings/hsi/omap-ssi.txt
+++ b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
@@ -4,7 +4,7 @@ OMAP Synchronous Serial Interface (SSI) controller implements a legacy
 variant of MIPI's High Speed Synchronous Serial Interface (HSI).
 
 Required properties:
-- compatible:		Should include "ti,omap3-ssi".
+- compatible:		Should include "ti,omap3-ssi" or "ti,omap4-hsi"
 - reg-names:		Contains the values "sys" and "gdd" (in this order).
 - reg:			Contains a matching register specifier for each entry
 			in reg-names.
@@ -27,6 +27,7 @@ Each port is represented as a sub-node of the ti,omap3-ssi device.
 Required Port sub-node properties:
 - compatible:		Should be set to the following value
 			ti,omap3-ssi-port (applicable to OMAP34xx devices)
+			ti,omap4-ssi-port (applicable to OMAP44xx devices)
 - reg-names:		Contains the values "tx" and "rx" (in this order).
 - reg:			Contains a matching register specifier for each entry
 			in reg-names.
@@ -38,6 +39,10 @@ Required Port sub-node properties:
 			property. If it's missing the port will not be
 			enabled.
 
+Optional properties:
+- ti,hwmods:		Shall contain TI interconnect module name if needed
+			by the SoC
+
 Example for Nokia N900:
 
 ssi-controller@48058000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -632,6 +632,40 @@
 			dma-names = "tx", "rx";
 		};
 
+		hsi: hsi@4a058000 {
+			compatible = "ti,omap4-hsi";
+			reg = <0x4a058000 0x4000>,
+			      <0x4a05c000 0x1000>;
+			reg-names = "sys", "gdd";
+			ti,hwmods = "hsi";
+
+			clocks = <&hsi_fck>;
+			clock-names = "hsi_fck";
+
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gdd_mpu";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a058000 0x4000>;
+
+			hsi_port1: hsi-port@2000 {
+				compatible = "ti,omap4-hsi-port";
+				reg = <0x2000 0x800>,
+				      <0x2800 0x800>;
+				reg-names = "tx", "rx";
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			hsi_port2: hsi-port@3000 {
+				compatible = "ti,omap4-hsi-port";
+				reg = <0x3000 0x800>,
+				      <0x3800 0x800>;
+				reg-names = "tx", "rx";
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		mmu_dsp: mmu@4a066000 {
 			compatible = "ti,omap4-iommu";
 			reg = <0x4a066000 0x100>;
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
