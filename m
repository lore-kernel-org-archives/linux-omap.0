From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 09/17] ARM: dts: Add missing iss node and binding for omap4
Date: Wed, 30 Aug 2017 08:19:45 -0700
Message-ID: <20170830151953.30856-10-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we're missing the iss node with it's related "ti,hwmods"
property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/media/ti-iss.txt | 33 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 +++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/ti-iss.txt

diff --git a/Documentation/devicetree/bindings/media/ti-iss.txt b/Documentation/devicetree/bindings/media/ti-iss.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti-iss.txt
@@ -0,0 +1,33 @@
+Texas Instruments Imaging Subsystem (ISS) binding
+
+ISS is used for cameras on Texas Instruments SoCs. Note that this
+binding is still missing the connections to the external devices
+modeled for the driver.
+
+Required properties:
+
+compatible: Shall be one of the following:
+	    "ti,omap4-iss"
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
+	iss: iss@52000000 {
+		compatible = "ti,omap4-iss";
+		reg = <0x52000000 0x1000000>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "iss";
+	};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -674,6 +674,13 @@
 			#iommu-cells = <0>;
 		};
 
+		iss: iss@52000000 {
+			compatible = "ti,omap4-iss";
+			reg = <0x52000000 0x1000000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "iss";
+		};
+
 		mmu_ipu: mmu@55082000 {
 			compatible = "ti,omap4-iommu";
 			reg = <0x55082000 0x100>;
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
