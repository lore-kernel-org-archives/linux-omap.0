From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/17] ARM: dts: Add missing properties for omap4 control modules
Date: Mon, 28 Aug 2017 14:19:04 -0700
Message-ID: <20170828211918.11573-4-tony@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170828211918.11573-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On omap4, we are missing several ti,hwmods properties and IO
ranges for system control modules. These are needed by the SoC
interconnect code.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

In order to add these, we need to move omap4_pmx_wkup to be a
child of omap4_padconf_wkup.

On omap4 there are separate modules for control module and
control module pads. For control module core, we have this
already configured except for the missing ti,hwmods and reg
entries.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |  2 ++
 arch/arm/boot/dts/omap4.dtsi                       | 39 ++++++++++++++++------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -21,6 +21,8 @@ Required properties:
 		"ti,omap3-scm"
 		"ti,omap4-scm-core"
 		"ti,omap4-scm-padconf-core"
+		"ti,omap4-scm-wkup"
+		"ti,omap4-scm-padconf-wkup"
 		"ti,omap5-scm-core"
 		"ti,omap5-scm-padconf-core"
 		"ti,dra7-scm-core"
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -174,6 +174,7 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 0x2000 0x1000>;
+				ti,hwmods = "ctrl_module_core";
 
 				scm_conf: scm_conf@0 {
 					compatible = "syscon";
@@ -186,9 +187,11 @@
 			omap4_padconf_core: scm@100000 {
 				compatible = "ti,omap4-scm-padconf-core",
 					     "simple-bus";
+				reg = <0x100000 0x1000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 0x100000 0x1000>;
+				ti,hwmods = "ctrl_module_pad_core";
 
 				omap4_pmx_core: pinmux@40 {
 					compatible = "ti,omap4-padconf",
@@ -263,17 +266,33 @@
 					};
 				};
 
-				omap4_pmx_wkup: pinmux@1e040 {
-					compatible = "ti,omap4-padconf",
-						     "pinctrl-single";
-					reg = <0x1e040 0x0038>;
+				omap4_scm_wkup: scm@c000 {
+					compatible = "ti,omap4-scm-wkup";
+					reg = <0xc000 0x1000>;
+					ti,hwmods = "ctrl_module_wkup";
+				};
+
+				omap4_padconf_wkup: padconf@1e000 {
+					compatible = "ti,omap4-scm-padconf-wkup",
+						     "simple-bus";
+					reg = <0x1e000 0x1000>;
 					#address-cells = <1>;
-					#size-cells = <0>;
-					#pinctrl-cells = <1>;
-					#interrupt-cells = <1>;
-					interrupt-controller;
-					pinctrl-single,register-width = <16>;
-					pinctrl-single,function-mask = <0x7fff>;
+					#size-cells = <1>;
+					ranges = <0 0x1e000 0x1000>;
+					ti,hwmods = "ctrl_module_pad_wkup";
+
+					omap4_pmx_wkup: pinmux@40 {
+						compatible = "ti,omap4-padconf",
+							     "pinctrl-single";
+						reg = <0x40 0x0038>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#pinctrl-cells = <1>;
+						#interrupt-cells = <1>;
+						interrupt-controller;
+						pinctrl-single,register-width = <16>;
+						pinctrl-single,function-mask = <0x7fff>;
+					};
 				};
 			};
 		};
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
