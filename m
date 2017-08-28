From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/17] ARM: dts: Add missing hsi node for omap4
Date: Mon, 28 Aug 2017 14:19:09 -0700
Message-ID: <20170828211918.11573-9-tony@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170828211918.11573-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we're missing the hsi node with it's related "ti,hwmods"
property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Let's also update the binding accrodingly while at it.

Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/hsi/omap-ssi.txt | 6 +++++-
 arch/arm/boot/dts/omap4.dtsi                       | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

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
@@ -38,6 +38,10 @@ Required Port sub-node properties:
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
@@ -632,6 +632,15 @@
 			dma-names = "tx", "rx";
 		};
 
+		hsi: hsi@4a058000 {
+			compatible = "ti,omap4-hsi";
+			reg = <0x4a058000 0x4000>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "hsi";
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
