From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 17/17] ARM: dts: Add missing hwmod related properties for dra7
Date: Mon, 28 Aug 2017 14:19:18 -0700
Message-ID: <20170828211918.11573-18-tony@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170828211918.11573-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On dra7 we're missing the smartreflex and hdq nodes with their
related "ti,hwmods" property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Note that the related driver also needs to be updated to probe
using device tree and get the platform data passed to it using
auxdata with arch/arm/mach-omap2/pdata-quirks.c.

Let's also update the related binding documentation while at it.

Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/power/ti-smartreflex.txt     |  2 ++
 arch/arm/boot/dts/dra7.dtsi                          | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/ti-smartreflex.txt b/Documentation/devicetree/bindings/power/ti-smartreflex.txt
--- a/Documentation/devicetree/bindings/power/ti-smartreflex.txt
+++ b/Documentation/devicetree/bindings/power/ti-smartreflex.txt
@@ -11,6 +11,8 @@ compatible: Shall be one of the following:
 	    "ti,omap4-smartreflex-core"
 	    "ti,omap4-smartreflex-mpu"
 	    "ti,omap4-smartreflex-iva"
+	    "ti,dra7-smartreflex-core"
+	    "ti,dra7-smartreflex-mpu"
 
 reg: Shall contain the device instance IO range
 
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -457,6 +457,7 @@
 			#dma-cells = <1>;
 			dma-channels = <32>;
 			dma-requests = <127>;
+			ti,hwmods = "dma_system";
 		};
 
 		edma: edma@43300000 {
@@ -1069,6 +1070,13 @@
 			max-frequency = <192000000>;
 		};
 
+		hdqw1w: 1w@480b2000 {
+			compatible = "ti,omap3-1w";
+			reg = <0x480b2000 0x1000>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "hdq1w";
+		};
+
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480b4000 0x400>;
@@ -1489,6 +1497,18 @@
 			};
 		};
 
+		smartreflex_core: smartreflex4a0dd000 {
+			compatible = "ti,dra7-smartreflex-core";
+			ti,hwmods = "smartreflex_core";
+			reg = <0x4a0dd000 0x80>;
+		};
+
+		smartreflex_mpu: smartreflex@4a0d9000 {
+			compatible = "ti,dra7-smartreflex-mpu";
+			ti,hwmods = "smartreflex_mpu";
+			reg = <0x4a0d9000 0x80>;
+		};
+
 		omap_dwc3_1: omap_dwc3_1@48880000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss1";
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
