From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH] ARM: dts: omap3-gta04: Add hdqw1 support
Date: Tue, 28 Apr 2015 22:54:27 +0200
Message-ID: <1430254467-29177-1-git-send-email-marek@goldelico.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36732 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030930AbbD1Uyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2015 16:54:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

Enable omap-hdq for battery fuel gauge access.

Signed-off-by: Marek Belisko <marek@goldelico.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b9f6881..6ea1257 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -200,6 +200,12 @@
 			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
 		>;
        };
+
+	hdq_pins: hdq_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -517,3 +523,8 @@
 &mcbsp2 {
 	status = "okay";
 };
+
+&hdqw1w {
+        pinctrl-names = "default";
+        pinctrl-0 = <&hdq_pins>;
+};
-- 
1.9.1

