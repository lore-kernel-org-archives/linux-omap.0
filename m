From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for omap4
Date: Wed, 30 Aug 2017 08:19:50 -0700
Message-ID: <20170830151953.30856-15-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we're missing the PowerVR SGX GPU node with it's related
"ti,hwmods" property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/gpu/ti-powervr-sgx.txt     | 39 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 ++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/ti-powervr-sgx.txt

diff --git a/Documentation/devicetree/bindings/gpu/ti-powervr-sgx.txt b/Documentation/devicetree/bindings/gpu/ti-powervr-sgx.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/ti-powervr-sgx.txt
@@ -0,0 +1,39 @@
+Texas Instruments PowevVR SGX binding
+
+SGX can be used for graphics acceleration on Texas Instruments SoCs.
+
+Note that the SGX binding is currently only used by the SoC interconnect
+code to idle the module on init and no open source driver is available
+for SGX. The PowerVR model specific driver nodes should be child nodes
+of this instance, and a clock binding may need to be added.
+
+Required properties:
+
+compatible: Shall be one of the following:
+		"ti,omap3-sgx530"
+		"ti,am335-sgx530"
+		"ti,omap4-sgx540"
+		"ti,omap5-sgx544"
+		"ti,dra7-sgx544"
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
+	gpu: gpu@56000000 {
+		compatible = "ti,omap4-sgx540";
+		reg = <0x56000000 0x10000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		ti,hwmods = "gpu";
+	};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -1111,6 +1111,13 @@
 			status = "disabled";
 		};
 
+		gpu: gpu@56000000 {
+			compatible = "ti,omap4-sgx540";
+			reg = <0x56000000 0x10000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "gpu";
+		};
+
 		dss: dss@58000000 {
 			compatible = "ti,omap4-dss";
 			reg = <0x58000000 0x80>;
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
