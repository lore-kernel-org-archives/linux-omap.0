From: Ash Charles <ashcharles@gmail.com>
Subject: [PATCH 1/5] omap3: overo: Update LCD panel names
Date: Fri, 12 Jun 2015 13:37:22 -0700
Message-ID: <1434141446-11568-2-git-send-email-ashcharles@gmail.com>
References: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35501 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbFLUh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2015 16:37:29 -0400
In-Reply-To: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, Adam YH Lee <adam.yh.lee@gmail.com>

From: Adam YH Lee <adam.yh.lee@gmail.com>

For Gumstix Overo COMs, the u-boot bootloader typically passes an
argument specifying the default display via the omapdss.def_disp
parameter.  When a default display is specified, DSS2 tries to match
this name with either the device tree label (e.g. label=dvi) or,
failing this, the device tree alias (e.g. label=display0). Update the
panel names for the 'lcd43' and 'lcd35' displays in the device tree
such that they match the names passed by u-boot.

Signed-off-by: Ash Charles <ashcharles@gmail.com>
---
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi | 2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index 233c69e50ae3..df8908adb0cb 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -120,7 +120,7 @@
 
 	lcd0: display@0 {
 		compatible = "lgphilips,lb035q02";
-		label = "lcd";
+		label = "lcd35";
 
 		reg = <1>;					/* CS1 */
 		spi-max-frequency = <10000000>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
index f5395b7da912..048fd216970a 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -98,7 +98,7 @@
 
 	lcd0: display@0 {
 		compatible = "samsung,lte430wq-f0c", "panel-dpi";
-		label = "lcd";
+		label = "lcd43";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&lte430_pins>;
-- 
2.1.4

