From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 28/33] ARM: dts: omap3: add syscon support to scrm node
Date: Fri, 13 Feb 2015 18:12:47 +0200
Message-ID: <1423843973-6050-26-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44924 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbbBMQOe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:34 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Control module will be converted to use syscon, thus add compatible
string for this. Also, remove the existing duplicate syscon entry
at the same time, and change the existing users of this to use the real
control module syscon.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 01b7111..969b4a1 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -122,8 +122,8 @@
 		};
 
 		scrm: scrm@48002000 {
-			compatible = "ti,omap3-scrm";
-			reg = <0x48002000 0x2000>;
+			compatible = "ti,omap3-scrm", "syscon";
+			reg = <0x48002000 0x1000>;
 
 			scrm_clocks: clocks {
 				#address-cells = <1>;
@@ -181,15 +181,10 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 
-		omap3_scm_general: tisyscon@48002270 {
-			compatible = "syscon";
-			reg = <0x48002270 0x2f0>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
-			reg = <0x2b0 0x4>;
-			syscon = <&omap3_scm_general>;
+			reg = <0x520 0x4>;
+			syscon = <&scrm>;
 			pbias_mmc_reg: pbias_mmc_omap2430 {
 				regulator-name = "pbias_mmc_omap2430";
 				regulator-min-microvolt = <1800000>;
-- 
1.7.9.5

