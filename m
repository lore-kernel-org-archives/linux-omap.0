From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/10] ARM: dts: Add nodes for missing omap4 interconnect target modules
Date: Wed, 20 Sep 2017 15:46:19 -0700
Message-ID: <20170920224621.16236-9-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920224621.16236-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we are missing dts nodes for several interconnect target
modules that we are idling on init. This currently works with the
legacy platform data still around.

To fix this, let's add the interconnect target modules so we can
idle the unused interconnect target module on init.

Also note that adding the interconnect target module node does not
necessarily mean that there is a driver available for the child IP
block, or that the child IP block is even functional.

In the SGX case, the PowerVR driver is closed source. And McASP on
omap4 has at least the TX path disabled and is not supported by the
davinci-mcasp driver. For AESS there is old Android 3.4 kernel
driver available but it's unlikely that anybody is going to update
it for the mainline kernel.

For smarflex, we are still probing with platform data and the
driver needs more work before we can add the device ip child nodes.

And finally, we're not yet using the interconnet ranges. I will
be posting separate patches for those later on.

Cc: Benoît Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 179 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 167 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -392,6 +392,21 @@
 			#interrupt-cells = <2>;
 		};
 
+		target-module@48076000 {
+			compatible = "ti,sysc-type2";
+			ti,hwmods = "slimbus2";
+			reg = <0x48076000 0x4>,
+			      <0x48076010 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&l4_per_clkctrl OMAP4_SLIMBUS2_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48076000 0x001000>;
+
+			/* No child device binding or driver in mainline */
+		};
+
 		elm: elm@48078000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48078000 0x2000>;
@@ -452,25 +467,61 @@
 			clock-frequency = <48000000>;
 		};
 
-		smartreflex_iva: smartreflex@4a0db000 {
-			compatible = "ti,omap4-smartreflex-iva";
-			reg = <0x4a0db000 0x80>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		target-module@4a0db000 {
+			compatible = "ti,sysc-sr";
 			ti,hwmods = "smartreflex_iva";
+			reg = <0x4a0db000 0x4>,
+			      <0x4a0db008 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_IVA_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a0db000 0x001000>;
+
+			smartreflex_iva: smartreflex@0 {
+				compatible = "ti,omap4-smartreflex-iva";
+				reg = <0 0x80>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
-		smartreflex_core: smartreflex@4a0dd000 {
-			compatible = "ti,omap4-smartreflex-core";
-			reg = <0x4a0dd000 0x80>;
-			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		target-module@4a0dd000 {
+			compatible = "ti,sysc-sr";
 			ti,hwmods = "smartreflex_core";
+			reg = <0x4a0dd000 0x4>,
+			      <0x4a0dd008 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_CORE_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a0dd000 0x001000>;
+
+			smartreflex_core: smartreflex@0 {
+				compatible = "ti,omap4-smartreflex-core";
+				reg = <0 0x80>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
-		smartreflex_mpu: smartreflex@4a0d9000 {
-			compatible = "ti,omap4-smartreflex-mpu";
-			reg = <0x4a0d9000 0x80>;
-			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		target-module@4a0d9000 {
+			compatible = "ti,sysc-sr";
 			ti,hwmods = "smartreflex_mpu";
+			reg = <0x4a0d9000 0x4>,
+			      <0x4a0d9008 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_MPU_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a0d9000 0x001000>;
+
+			smartreflex_mpu: smartreflex@0 {
+				compatible = "ti,omap4-smartreflex-mpu";
+				reg = <0 0x80>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		hwspinlock: spinlock@4a0f6000 {
@@ -676,6 +727,21 @@
 			#iommu-cells = <0>;
 		};
 
+		target-module@52000000 {
+			compatible = "ti,sysc-type2";
+			ti,hwmods = "iss";
+			reg = <0x52000000 0x4>,
+			      <0x52000010 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&iss_clkctrl OMAP4_ISS_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x52000000 0x1000000>;
+
+			/* No child device binding, driver in staging */
+		};
+
 		mmu_ipu: mmu@55082000 {
 			compatible = "ti,omap4-iommu";
 			reg = <0x55082000 0x100>;
@@ -770,6 +836,62 @@
 			status = "disabled";
 		};
 
+		target-module@40128000 {
+			compatible = "ti,sysc-mcasp";
+			ti,hwmods = "mcasp";
+			reg = <0x40128004 0x4>;
+			reg-names = "sysc";
+			clocks = <&abe_clkctrl OMAP4_MCASP_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x40128000 0x1000>, /* MPU */
+				 <0x49028000 0x49028000 0x1000>; /* L3 */
+
+			/*
+			 * Child device unsupported by davinci-mcasp. At least
+			 * TX path is disabled for omap4, and only DIT mode
+			 * works with no I2S. See also old Android kernel
+			 * omap-mcasp driver for more information.
+			 */
+		};
+
+		target-module@4012c000 {
+			compatible = "ti,sysc-type2";
+			ti,hwmods = "slimbus1";
+			reg = <0x4012c000 0x4>,
+			      <0x4012c010 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&abe_clkctrl OMAP4_SLIMBUS1_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x4012c000 0x1000>, /* MPU */
+				 <0x4902c000 0x4902c000 0x1000>; /* L3 */
+
+			/* No child device binding or driver in mainline */
+		};
+
+		target-module@401f1000 {
+			compatible = "ti,sysc-type2";
+			ti,hwmods = "aess";
+			reg = <0x401f1000 0x4>,
+			      <0x401f1010 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&abe_clkctrl OMAP4_AESS_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x401f1000 0x1000>, /* MPU */
+				 <0x490f1000 0x490f1000 0x1000>; /* L3 */
+
+			/*
+			 * No child device binding or driver in mainline.
+			 * See Android tree and related upstreaming efforts
+			 * for the old driver.
+			 */
+		};
+
 		mcbsp4: mcbsp@48096000 {
 			compatible = "ti,omap4-mcbsp";
 			reg = <0x48096000 0xff>; /* L4 Interconnect */
@@ -858,6 +980,21 @@
 			};
 		};
 
+		target-module@4a10a000 {
+			compatible = "ti,sysc-type2";
+			ti,hwmods = "fdif";
+			reg = <0x4a10a000 0x4>,
+			      <0x4a10a010 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&iss_clkctrl OMAP4_FDIF_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a10a000 0x1000>;
+
+			/* No child device binding or driver in mainline */
+		};
+
 		timer1: timer@4a318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x4a318000 0x80>;
@@ -1075,6 +1212,24 @@
 			status = "disabled";
 		};
 
+		target-module@56000000 {
+			compatible = "ti,sysc-type2";
+			ti,hwmods = "gpu";
+			reg = <0x5601fc00 0x4>,
+			      <0x5601fc10 0x4>;
+			reg-names = "rev", "sysc";
+			clocks = <&l3_gfx_clkctrl OMAP4_GPU_CLKCTRL 0>;
+			clock-names = "clkctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x56000000 0x2000000>;
+
+			/*
+			 * Closed source PowerVR driver, no child device
+			 * binding or driver in mainline
+			 */
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
