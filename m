From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2] ARM: dts: Update ti-sysc data for existing users
Date: Thu, 11 Jan 2018 16:06:39 -0800
Message-ID: <20180112000639.10519-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Let's update the existing users with features and clock data as
specified in the binding. This is currently the smartreflex for most
part, and also few omap4 modules with no child device driver like
mcasp, abe iss and gfx.

Note that we had few mistakes that did not get noticed as we're still
probing the SmartReflex driver with legacy platform data and using
"ti,hwmods" legacy property for ti-sysc driver.

So let's fix the omap4 and dra7 smartreflex registers as there is no
no revision register.

And on omap4, the mcasp module has a revision register according to
the TRM.

And for omap34xx we need a different configuration compared to 36xx.
And the smartreflex on 3517 we've always kept disabled so let's
remove any references to it.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

Here's this one again, turns out more smartreflex fixes were needed

---
 arch/arm/boot/dts/am3517.dtsi   |   4 --
 arch/arm/boot/dts/dra7.dtsi     |  26 +++++++---
 arch/arm/boot/dts/omap3.dtsi    |  14 ------
 arch/arm/boot/dts/omap34xx.dtsi |  39 +++++++++++++++
 arch/arm/boot/dts/omap36xx.dtsi |  46 ++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    | 104 +++++++++++++++++++++++++++++++++++-----
 6 files changed, 198 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -99,9 +99,5 @@
 	status = "disabled";
 };
 
-&smartreflex_mpu_iva {
-	status = "disabled";
-};
-
 /include/ "am35xx-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -7,6 +7,8 @@
  * Based on "omap4.dtsi"
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
+#include <dt-bindings/clock/dra7.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/dra.h>
 #include <dt-bindings/clock/dra7.h>
@@ -1523,9 +1525,15 @@
 		target-module@4a0dd000 {
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_core";
-			reg = <0x4a0dd000 0x4>,
-			      <0x4a0dd008 0x4>;
-			reg-names = "rev", "sysc";
+			reg = <0x4a0dd038 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&coreaon_clkctrl DRA7_SMARTREFLEX_CORE_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0dd000 0x001000>;
@@ -1536,9 +1544,15 @@
 		target-module@4a0d9000 {
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_mpu";
-			reg = <0x4a0d9000 0x4>,
-			      <0x4a0d9008 0x4>;
-			reg-names = "rev", "sysc";
+			reg = <0x4a0d9038 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&coreaon_clkctrl DRA7_SMARTREFLEX_MPU_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0d9000 0x001000>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -587,20 +587,6 @@
 			dma-names = "rx";
 		};
 
-		smartreflex_core: smartreflex@480cb000 {
-			compatible = "ti,omap3-smartreflex-core";
-			ti,hwmods = "smartreflex_core";
-			reg = <0x480cb000 0x400>;
-			interrupts = <19>;
-		};
-
-		smartreflex_mpu_iva: smartreflex@480c9000 {
-			compatible = "ti,omap3-smartreflex-mpu-iva";
-			ti,hwmods = "smartreflex_mpu_iva";
-			reg = <0x480c9000 0x400>;
-			interrupts = <18>;
-		};
-
 		timer1: timer@48318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x48318000 0x400>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/media/omap3-isp.h>
 
 #include "omap3.dtsi"
@@ -61,6 +62,44 @@
 			compatible = "ti,omap34xx-bandgap";
 			#thermal-sensor-cells = <0>;
 		};
+
+		target-module@480cb000 {
+			compatible = "ti,sysc-omap3430-sr", "ti,sysc";
+			ti,hwmods = "smartreflex_core";
+			reg = <0x480cb024 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP2_CLOCKACTIVITY>;
+			clocks = <&sr2_fck>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x480cb000 0x001000>;
+
+			smartreflex_core: smartreflex@0 {
+				compatible = "ti,omap3-smartreflex-core";
+				reg = <0 0x400>;
+				interrupts = <19>;
+			};
+		};
+
+		target-module@480c9000 {
+			compatible = "ti,sysc-omap3430-sr", "ti,sysc";
+			ti,hwmods = "smartreflex_mpu_iva";
+			reg = <0x480c9024 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP2_CLOCKACTIVITY>;
+			clocks = <&sr1_fck>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x480c9000 0x001000>;
+
+			smartreflex_mpu_iva: smartreflex@480c9000 {
+				compatible = "ti,omap3-smartreflex-mpu-iva";
+				reg = <0 0x400>;
+				interrupts = <18>;
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/media/omap3-isp.h>
 
 #include "omap3.dtsi"
@@ -93,6 +94,51 @@
 			compatible = "ti,omap36xx-bandgap";
 			#thermal-sensor-cells = <0>;
 		};
+
+		target-module@480cb000 {
+			compatible = "ti,sysc-omap3630-sr", "ti,sysc";
+			ti,hwmods = "smartreflex_core";
+			reg = <0x480cb038 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			clocks = <&sr2_fck>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x480cb000 0x001000>;
+
+			smartreflex_core: smartreflex@0 {
+				compatible = "ti,omap3-smartreflex-core";
+				reg = <0 0x400>;
+				interrupts = <19>;
+			};
+		};
+
+		target-module@480c9000 {
+			compatible = "ti,sysc-omap3630-sr", "ti,sysc";
+			ti,hwmods = "smartreflex_mpu_iva";
+			reg = <0x480c9038 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			clocks = <&sr1_fck>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x480c9000 0x001000>;
+
+
+			smartreflex_mpu_iva: smartreflex@480c9000 {
+				compatible = "ti,omap3-smartreflex-mpu-iva";
+				reg = <0 0x400>;
+				interrupts = <18>;
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
+#include <dt-bindings/clock/omap4.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/omap.h>
@@ -398,6 +400,13 @@
 			reg = <0x48076000 0x4>,
 			      <0x48076010 0x4>;
 			reg-names = "rev", "sysc";
+			ti,sysc-mask = <SYSC_OMAP4_SOFTRESET>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&l4_per_clkctrl OMAP4_SLIMBUS2_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x48076000 0x001000>;
@@ -468,9 +477,15 @@
 		target-module@4a0db000 {
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_iva";
-			reg = <0x4a0db000 0x4>,
-			      <0x4a0db008 0x4>;
-			reg-names = "rev", "sysc";
+			reg = <0x4a0db038 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_IVA_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0db000 0x001000>;
@@ -485,9 +500,15 @@
 		target-module@4a0dd000 {
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_core";
-			reg = <0x4a0dd000 0x4>,
-			      <0x4a0dd008 0x4>;
-			reg-names = "rev", "sysc";
+			reg = <0x4a0dd038 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_CORE_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0dd000 0x001000>;
@@ -502,9 +523,15 @@
 		target-module@4a0d9000 {
 			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_mpu";
-			reg = <0x4a0d9000 0x4>,
-			      <0x4a0d9008 0x4>;
-			reg-names = "rev", "sysc";
+			reg = <0x4a0d9038 0x4>;
+			reg-names = "sysc";
+			ti,sysc-mask = <SYSC_OMAP3_SR_ENAWAKEUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_MPU_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0d9000 0x001000>;
@@ -725,6 +752,18 @@
 			reg = <0x52000000 0x4>,
 			      <0x52000010 0x4>;
 			reg-names = "rev", "sysc";
+			ti,sysc-mask = <SYSC_OMAP4_SOFTRESET>;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-delay-us = <2>;
+			clocks = <&iss_clkctrl OMAP4_ISS_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x52000000 0x1000000>;
@@ -829,8 +868,15 @@
 		target-module@40128000 {
 			compatible = "ti,sysc-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp";
-			reg = <0x40128004 0x4>;
-			reg-names = "sysc";
+			reg = <0x40128000 0x4>,
+			      <0x40128004 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&abe_clkctrl OMAP4_MCASP_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x00000000 0x40128000 0x1000>, /* MPU */
@@ -850,6 +896,13 @@
 			reg = <0x4012c000 0x4>,
 			      <0x4012c010 0x4>;
 			reg-names = "rev", "sysc";
+			ti,sysc-mask = <SYSC_OMAP4_SOFTRESET>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&abe_clkctrl OMAP4_SLIMBUS1_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x00000000 0x4012c000 0x1000>, /* MPU */
@@ -864,6 +917,15 @@
 			reg = <0x401f1000 0x4>,
 			      <0x401f1010 0x4>;
 			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			clocks = <&abe_clkctrl OMAP4_AESS_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x00000000 0x401f1000 0x1000>, /* MPU */
@@ -970,6 +1032,16 @@
 			reg = <0x4a10a000 0x4>,
 			      <0x4a10a010 0x4>;
 			reg-names = "rev", "sysc";
+			ti,sysc-mask = <SYSC_OMAP4_SOFTRESET>;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-delay-us = <2>;
+			clocks = <&iss_clkctrl OMAP4_FDIF_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a10a000 0x1000>;
@@ -1199,6 +1271,16 @@
 			reg = <0x5601fc00 0x4>,
 			      <0x5601fc10 0x4>;
 			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&l3_gfx_clkctrl OMAP4_GPU_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x56000000 0x2000000>;
-- 
2.15.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
