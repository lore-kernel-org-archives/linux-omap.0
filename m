From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 1/9] arm: dts: am4372: Add pwm-cells property for ecap device.
Date: Thu, 19 Dec 2013 18:03:33 +0530
Message-ID: <1387456421-21379-2-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, afzal-l0cyMroinI0@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add "pwm-cells" node for all ecap, ehrpwm in am43x dtsi files.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 974d103..c314adb 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -495,6 +495,7 @@
 
 			ecap0: ecap@48300100 {
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
+				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
 				ti,hwmods = "ecap0";
 				status = "disabled";
@@ -502,6 +503,7 @@
 
 			ehrpwm0: ehrpwm@48300200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
 				ti,hwmods = "ehrpwm0";
 				status = "disabled";
@@ -519,6 +521,7 @@
 
 			ecap1: ecap@48302100 {
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
+				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
 				ti,hwmods = "ecap1";
 				status = "disabled";
@@ -526,6 +529,7 @@
 
 			ehrpwm1: ehrpwm@48302200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
 				ti,hwmods = "ehrpwm1";
 				status = "disabled";
@@ -543,6 +547,7 @@
 
 			ecap2: ecap@48304100 {
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
+				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
 				ti,hwmods = "ecap2";
 				status = "disabled";
@@ -550,6 +555,7 @@
 
 			ehrpwm2: ehrpwm@48304200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
 				ti,hwmods = "ehrpwm2";
 				status = "disabled";
@@ -567,6 +573,7 @@
 
 			ehrpwm3: ehrpwm@48306200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
 				reg = <0x48306200 0x80>;
 				ti,hwmods = "ehrpwm3";
 				status = "disabled";
@@ -584,6 +591,7 @@
 
 			ehrpwm4: ehrpwm@48308200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
 				reg = <0x48308200 0x80>;
 				ti,hwmods = "ehrpwm4";
 				status = "disabled";
@@ -601,6 +609,7 @@
 
 			ehrpwm5: ehrpwm@4830a200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
 				reg = <0x4830a200 0x80>;
 				ti,hwmods = "ehrpwm5";
 				status = "disabled";
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
