From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 05/17] ARM: dts: Add missing smartreflex node and binding for omap4
Date: Wed, 30 Aug 2017 08:19:41 -0700
Message-ID: <20170830151953.30856-6-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We are missing smartreflex device tree nodes for omap4 with
their related "ti,hwmods" properties that the SoC interconnect
code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

And since we're missing the device tree binding for smartreflex,
let's also add it and document the existing omap3 use too.

Note that the related driver also needs to be updated to probe
using device tree and get the platform data passed to it using
auxdata with arch/arm/mach-omap2/pdata-quirks.c.

Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/power/ti-smartreflex.txt   | 47 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       | 21 ++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/ti-smartreflex.txt

diff --git a/Documentation/devicetree/bindings/power/ti-smartreflex.txt b/Documentation/devicetree/bindings/power/ti-smartreflex.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/ti-smartreflex.txt
@@ -0,0 +1,47 @@
+Texas Instruments SmartReflex binding
+
+SmartReflex is used to set and adjust the SoC operating points.
+
+
+Required properties:
+
+compatible: Shall be one of the following:
+	    "ti,omap3-smartreflex-core"
+	    "ti,omap3-smartreflex-iva"
+	    "ti,omap4-smartreflex-core"
+	    "ti,omap4-smartreflex-mpu"
+	    "ti,omap4-smartreflex-iva"
+
+reg: Shall contain the device instance IO range
+
+interrupts: Shall contain the device instance interrupt
+
+
+Optional properties:
+
+ti,hwmods: Shall contain the TI interconnect module name if needed
+	   by the SoC
+
+
+Example:
+
+	smartreflex_iva: smartreflex@4a0db000 {
+		compatible = "ti,omap4-smartreflex-iva";
+		reg = <0x4a0db000 0x80>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "smartreflex_iva";
+	};
+
+	smartreflex_core: smartreflex4a0dd000 {
+		compatible = "ti,omap4-smartreflex-core";
+		reg = <0x4a0dd000 0x80>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "smartreflex_core";
+	};
+
+	smartreflex_mpu: smartreflex@4a0d9000 {
+		compatible = "ti,omap4-smartreflex-mpu";
+		reg = <0x4a0d9000 0x80>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "smartreflex_mpu";
+	};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -442,6 +442,27 @@
 			clock-frequency = <48000000>;
 		};
 
+		smartreflex_iva: smartreflex@4a0db000 {
+			compatible = "ti,omap4-smartreflex-iva";
+			reg = <0x4a0db000 0x80>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "smartreflex_iva";
+		};
+
+		smartreflex_core: smartreflex4a0dd000 {
+			compatible = "ti,omap4-smartreflex-core";
+			reg = <0x4a0dd000 0x80>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "smartreflex_core";
+		};
+
+		smartreflex_mpu: smartreflex@4a0d9000 {
+			compatible = "ti,omap4-smartreflex-mpu";
+			reg = <0x4a0d9000 0x80>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "smartreflex_mpu";
+		};
+
 		hwspinlock: spinlock@4a0f6000 {
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x4a0f6000 0x1000>;
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
