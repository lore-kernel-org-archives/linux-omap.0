From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ARM: dts: am335x-boneblack: Add names for remaining regulators
Date: Fri,  5 Sep 2014 22:12:05 +0100
Message-ID: <1409951525-30035-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52190 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbaIEVMV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2014 17:12:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@kernel.org>

Add regulator-name properties for the regulators that don't have them,
allowing the kernel to display the name from the schematic rather than
the name of the regulator on the PMIC in order to improve diagnostics.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bde1777b62be..fe983d204b2b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -227,6 +227,7 @@
 &tps {
 	regulators {
 		dcdc1_reg: regulator@0 {
+			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
@@ -249,18 +250,22 @@
 		};
 
 		ldo1_reg: regulator@3 {
+			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator@4 {
+			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
 		ldo3_reg: regulator@5 {
+			regulator-name = "vdd_1v8";
 			regulator-always-on;
 		};
 
 		ldo4_reg: regulator@6 {
+			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
 	};
-- 
2.1.0

