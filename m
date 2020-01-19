From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: motorola-cpcap-mapphone: Configure calibration interrupt
Date: Sun, 19 Jan 2020 11:45:01 -0800
Message-ID: <20200119194501.17125-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51754 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgASTpE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sun, 19 Jan 2020 14:45:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>

We added coulomb counter calibration support With commit 0cb90f071f73
("power: supply: cpcap-battery: Add basic coulomb counter calibrate
support"), but we also need to configure the related interrupt.

Without the interrupt calibration happens based on a timeout after two
seconds, with the interrupt the calibration just gets done a bit faster.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -27,11 +27,12 @@
 			compatible = "motorola,cpcap-battery";
 			interrupts-extended = <
 				&cpcap 6 0 &cpcap 5 0 &cpcap 3 0
-				&cpcap 20 0 &cpcap 54 0
+				&cpcap 20 0 &cpcap 54 0 &cpcap 57 0
 			>;
 			interrupt-names =
 				"eol", "lowbph", "lowbpl",
-				"chrgcurr1", "battdetb";
+				"chrgcurr1", "battdetb",
+				"cccal";
 			io-channels = <&cpcap_adc 0 &cpcap_adc 1
 				       &cpcap_adc 5 &cpcap_adc 6>;
 			io-channel-names = "battdetb", "battp",
-- 
2.24.1
