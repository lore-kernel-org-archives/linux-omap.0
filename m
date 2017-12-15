From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 9/9] ARM: dts: Update ti-sysc data for existing users
Date: Fri, 15 Dec 2017 10:09:00 -0800
Message-ID: <20171215180900.3243-10-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171215180900.3243-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Let's update the existing users with features and clock data.

Note that we had few mistakes that did not get noticed as we're still
probing the SmartReflex driver with legacy platform data and using
"ti,hwmods" legacy property for ti-sysc driver.

So let's fix the dra7 smartreflex registers as they are different
from omap4 with no revision register.

And on omap4, the mcasp module has a revision register according to
the TRM.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi  | 26 ++++++++++++----
 arch/arm/boot/dts/omap4.dtsi | 74 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 8 deletions(-)

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
 
@@ -1500,9 +1502,15 @@
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
@@ -1513,9 +1521,15 @@
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
@@ -388,6 +390,13 @@
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
@@ -461,6 +470,8 @@
 			reg = <0x4a0db000 0x4>,
 			      <0x4a0db008 0x4>;
 			reg-names = "rev", "sysc";
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_IVA_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0db000 0x001000>;
@@ -478,6 +489,8 @@
 			reg = <0x4a0dd000 0x4>,
 			      <0x4a0dd008 0x4>;
 			reg-names = "rev", "sysc";
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_CORE_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0dd000 0x001000>;
@@ -495,6 +508,8 @@
 			reg = <0x4a0d9000 0x4>,
 			      <0x4a0d9008 0x4>;
 			reg-names = "rev", "sysc";
+			clocks = <&l4_ao_clkctrl OMAP4_SMARTREFLEX_MPU_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x4a0d9000 0x001000>;
@@ -715,6 +730,18 @@
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
@@ -819,8 +846,15 @@
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
@@ -840,6 +874,13 @@
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
@@ -854,6 +895,15 @@
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
@@ -960,6 +1010,16 @@
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
@@ -1188,6 +1248,16 @@
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
