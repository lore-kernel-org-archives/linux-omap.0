From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 04/12] ARM: dts: sb-t35: fix Ethernet power supply
Date: Sun, 12 Jan 2014 15:22:47 +0200
Message-ID: <1389532975-28281-5-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:37311 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbaALNXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:04 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

SB-T35 baseboard features SMSC9220 Ethernet chip which requires
its own power supply regulators.

Add baseboard specific regulators for the SB-T35 Ethernet chip.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-sb-t35.dtsi |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index b3b6e43..7909c51 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -2,6 +2,20 @@
  * Common support for CompuLab SB-T35 used on SBC-T3530, SBC-T3517 and SBC-T3730
  */
 
+/ {
+	vddvario_sb_t35: regulator-vddvario-sb-t35 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
+	};
+
+	vdd33a_sb_t35: regulator-vdd33a-sb-t35 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33a";
+		regulator-always-on;
+	};
+};
+
 &omap3_pmx_core {
 	smsc2_pins: pinmux_smsc2_pins {
 		pinctrl-single,pins = <
@@ -43,8 +57,8 @@
 		gpmc,wr-access-ns = <186>;
 		gpmc,cycle2cycle-samecsen;
 		gpmc,cycle2cycle-diffcsen;
-		vddvario-supply = <&vddvario>;
-		vdd33a-supply = <&vdd33a>;
+		vddvario-supply = <&vddvario_sb_t35>;
+		vdd33a-supply = <&vdd33a_sb_t35>;
 		reg-io-width = <4>;
 		smsc,save-mac-address;
 	};
-- 
1.7.5.4

