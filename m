From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 13/17] ARM: dts: Add missing fdif node and binding for omap4
Date: Mon, 28 Aug 2017 14:19:14 -0700
Message-ID: <20170828211918.11573-14-tony@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170828211918.11573-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we're missing the fdif node with it's related "ti,hwmods"
property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/media/ti-fdif.txt          | 37 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 ++++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/ti-fdif.txt

diff --git a/Documentation/devicetree/bindings/media/ti-fdif.txt b/Documentation/devicetree/bindings/media/ti-fdif.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti-fdif.txt
@@ -0,0 +1,37 @@
+Texas Instruments Face Detect (FDIF) binding
+
+FDD can be used for face detection on Texas Instruments SoCs.
+
+Note that the fdif binding is currently only used by the SoC interconnect
+code to idle the module on init and no open source driver is available
+for fdif. Please update this documentation if that changes.
+
+
+Required properties:
+
+compatible: Shall be one of the following:
+	    "ti,omap4-fdif"
+
+reg: Shall contain the device instance IO range
+
+interrupts: Shall contain the device instance interrupt
+
+
+Optional properties:
+
+reg-names: Shall contain the IO range names if multiple IO
+	   ranges are used by the SoC
+
+ti,hwmods: Shall contain the TI interconnect module name if needed
+	   by the SoC
+
+
+Example:
+
+	fdif: fdif@4a10a000 {
+		compatible = "ti,omap4-fdif";
+		reg = <0x4a10a000 0x200>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "fdif";
+	};
+
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -864,6 +864,13 @@
 			};
 		};
 
+		fdif: fdif@4a10a000 {
+			compatible = "ti,omap4-fdif";
+			reg = <0x4a10a000 0x200>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "fdif";
+		};
+
 		timer1: timer@4a318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x4a318000 0x80>;
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
