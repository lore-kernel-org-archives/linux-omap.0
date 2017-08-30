From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 16/17] ARM: dts: Add missing hwmod related nodes for am33xx
Date: Wed, 30 Aug 2017 08:19:52 -0700
Message-ID: <20170830151953.30856-17-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On am33xx we're missing the pmu and emif nodes with their related
"ti,hwmods" properties that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Let's also update the related binding documentation while at it.

Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/memory-controllers/ti/emif.txt         |  6 ++++--
 arch/arm/boot/dts/am33xx.dtsi                                  | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
--- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -7,8 +7,10 @@ of the EMIF IP and memory parts attached to it.
 
 Required properties:
 - compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
-  is the IP revision of the specific EMIF instance.
-		  For am437x should be ti,emif-am4372.
+  is the IP revision of the specific EMIF instance. For newer controllers,
+  compatible should be one of the following:
+  	     "ti,emif-am3352"
+	     "ti,emif-am4372"
 
 - phy-type	: <u32> indicating the DDR phy type. Following are the
   allowed values
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -128,9 +128,11 @@
 		};
 	};
 
-	pmu {
+	pmu@4b000000 {
 		compatible = "arm,cortex-a8-pmu";
 		interrupts = <3>;
+		reg = <0x4b000000 0x1000000>;
+		ti,hwmods = "debugss";
 	};
 
 	/*
@@ -927,6 +929,12 @@
 			};
 		};
 
+		emif: emif@4c000000 {
+			compatible = "ti,emif-am3352";
+			reg = <0x4c000000 0x1000000>;
+			ti,hwmods = "emif";
+		};
+
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
