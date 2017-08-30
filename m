From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 06/17] ARM: dts: Add missing slimbus node and binding for omap4
Date: Wed, 30 Aug 2017 08:19:42 -0700
Message-ID: <20170830151953.30856-7-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we're missing the slimbus node and it's related
"ti,hwmods" property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Let's also add the missing slimbus device tree binding
documentation while at it.

Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/sound/ti-slimbus.txt       | 34 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       | 17 +++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti-slimbus.txt

diff --git a/Documentation/devicetree/bindings/sound/ti-slimbus.txt b/Documentation/devicetree/bindings/sound/ti-slimbus.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti-slimbus.txt
@@ -0,0 +1,34 @@
+Texas Instruments Serial Low-power Inter-chip Media Bus (SLIMbus) binding
+
+SLIMbus is used for communication between digital audio components and the SoC.
+
+
+Required properties:
+
+compatible: Shall be one of the following:
+	    "ti,omap4-slimbus"
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
+	slimbus1: slimbus@4012c000 {
+		compatible = "ti,omap4-slimbus";
+		reg = <0x4012c000 0x400>, /* MPU private access */
+		      <0x4902c000 0x400>; /* L3 Interconnect */
+		reg-names = "mpu", "dma";
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "slimbus1";
+	};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -382,6 +382,14 @@
 			#interrupt-cells = <2>;
 		};
 
+		slimbus2: slimbus@48076000 {
+			compatible = "ti,omap4-slimbus";
+			reg = <0x48076000 0x400>;
+			reg-names = "mpu";
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "slimbus2";
+		};
+
 		elm: elm@48078000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48078000 0x2000>;
@@ -711,6 +719,15 @@
 			status = "disabled";
 		};
 
+		slimbus1: slimbus@4012c000 {
+			compatible = "ti,omap4-slimbus";
+			reg = <0x4012c000 0x400>, /* MPU private access */
+			      <0x4902c000 0x400>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "slimbus1";
+		};
+
 		mcbsp4: mcbsp@48096000 {
 			compatible = "ti,omap4-mcbsp";
 			reg = <0x48096000 0xff>; /* L4 Interconnect */
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
