From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 1/5] arm: dts: am4372: Add pwm-cells property for ecap device.
Date: Wed, 27 Nov 2013 13:00:43 +0530
Message-ID: <1385537447-6922-2-git-send-email-sourav.poddar@ti.com>
References: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57027 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab3K0HbD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 02:31:03 -0500
In-Reply-To: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add "pwm-cells" node for all ecap, ehrpwm in am43x dtsi files.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 6ccf5c2..ea55a4e 100644
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
1.7.1

