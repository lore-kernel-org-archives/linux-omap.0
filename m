From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 8/8] ARM: dts: omap3-tobi: Add AT24C01 EEPROM
Date: Thu, 27 Feb 2014 21:30:32 +0100
Message-ID: <1393533032-1619-9-git-send-email-florian.vaussard@epfl.ch>
References: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:39942 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbaB0Uaz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 15:30:55 -0500
In-Reply-To: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Add the AT24C01 EEPROM node populated on most Gumstix expansion board.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index caddb8c..b5e1b15 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -60,6 +60,13 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
 	clock-frequency = <100000>;
+
+	/* optional 1K EEPROM with revision information */
+	eeprom@51 {
+		compatible = "atmel,24c01";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
 };
 
 &mmc3 {
-- 
1.8.5.3

