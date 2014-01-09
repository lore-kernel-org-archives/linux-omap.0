From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 10/18] ARM: dts: omap3-tobi: Add AT24C01 EEPROM
Date: Thu,  9 Jan 2014 17:48:04 +0100
Message-ID: <1389286092-27087-11-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:41054 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343AbaAIQst (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 11:48:49 -0500
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

Add the AT24C01 EEPROM node populated on most Gumstix expansion board.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-tobi.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index e9a841a..67c056d 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -63,6 +63,13 @@
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
1.8.1.2

