From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 7/7] ARM: dts: omap3-tobi: Add AT24C01 EEPROM
Date: Mon,  3 Mar 2014 10:34:07 +0100
Message-ID: <1393839247-6516-8-git-send-email-florian.vaussard@epfl.ch>
References: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:41522 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114AbaCCJec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 04:34:32 -0500
In-Reply-To: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

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
1.8.3.2

