From: Ash Charles <ashcharles@gmail.com>
Subject: [PATCH 3/5] omap3: overo: Enable McBSP2 for all Overo COMs
Date: Fri, 12 Jun 2015 13:37:24 -0700
Message-ID: <1434141446-11568-4-git-send-email-ashcharles@gmail.com>
References: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36624 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbbFLUhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2015 16:37:31 -0400
In-Reply-To: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, Adam YH Lee <adam.yh.lee@gmail.com>

From: Adam YH Lee <adam.yh.lee@gmail.com>

Both Gumstix Overo and Overo Storm COMs use TWL4030 audio module
connected to the McBSP2.  As such, enable the McBSP2 module in the
common device tree file, omap3-overo-base.dtsi, rather than in the
processor-specific device tree files, omap3-overo.dtsi and
omap3-overo-storm.dtsi.  This corrects audio on the Storm COMs where
the setting was accidentally missing from the device tree.

Signed-off-by: Ash Charles <ashcharles@gmail.com>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 4 ++++
 arch/arm/boot/dts/omap3-overo.dtsi      | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 18e1649681c1..029e5feb65b4 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -218,3 +218,7 @@
 	pinctrl-0 = <&uart2_pins>;
 };
 
+&mcbsp2 {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 69ca7c45bca2..932a02ff552a 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -32,7 +32,3 @@
 		>;
 	};
 };
-
-&mcbsp2 {
-	status = "okay";
-};
-- 
2.1.4

