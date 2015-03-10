From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v4 4/6] ARM: dts: omap3-gta04: Add battery support
Date: Tue, 10 Mar 2015 22:27:25 +0100
Message-ID: <1426022847-30912-5-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42973 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbbCJV2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2015 17:28:04 -0400
In-Reply-To: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

Added battery support for gta04 devices.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fb3a696..cbf515a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -49,6 +49,32 @@
 		ti,codec = <&twl_audio>;
 	};
 
+	battery {
+		compatible = "ti,twl4030-madc-battery";
+		capacity-uah = <1200000>;
+		ti,volt-to-capacity-charging-map = <4200 100>,
+					     <4100 75>,
+					     <4000 55>,
+					     <3900 25>,
+					     <3800 5>,
+					     <3700 2>,
+					     <3600 1>,
+					     <3300 0>;
+		ti,volt-to-capacity-discharging-map = <4200 100>,
+						<4100 95>,
+						<4000 70>,
+						<3800 50>,
+						<3700 10>,
+						<3600 5>,
+						<3300 0>;
+		io-channels = <&twl_madc 1>,
+	                      <&twl_madc 10>,
+			      <&twl_madc 12>;
+		io-channel-names = "temp",
+		                   "ichg",
+		                   "vbat";
+	};
+
 	spi_lcd {
 		compatible = "spi-gpio";
 		#address-cells = <0x1>;
@@ -518,3 +544,7 @@
 &mcbsp2 {
 	status = "okay";
 };
+
+&twl_madc {
+	ti,system-uses-second-madc-irq;
+};
-- 
1.9.1

