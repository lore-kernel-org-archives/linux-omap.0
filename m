From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] ARM: dts: Do not set pulls for I2C lines
Date: Mon, 15 Sep 2014 20:11:59 -0700
Message-ID: <1410837126-31553-5-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19922 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754322AbaIPDNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 23:13:05 -0400
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

There are external pulls on these lines and enabling the
internal pulls can cause issue. This is because the internal
pulls are parallel with the external pulls. So let's clear
the internal I2C pulls.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 1fe45d1..f0d8236 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -136,22 +136,22 @@
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0x18a (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
-			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+			0x18a (PIN_INPUT | MUX_MODE0)		/* i2c1_scl */
+			0x18c (PIN_INPUT | MUX_MODE0)		/* i2c1_sda */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			0x18e (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
-			0x190 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
+			0x18e (PIN_INPUT | MUX_MODE0)		/* i2c2_scl */
+			0x190 (PIN_INPUT | MUX_MODE0)		/* i2c2_sda */
 		>;
 	};
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0x192 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
-			0x194 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+			0x192 (PIN_INPUT | MUX_MODE0)		/* i2c3_scl */
+			0x194 (PIN_INPUT | MUX_MODE0)		/* i2c3_sda */
 		>;
 	};
 
-- 
2.1.0

