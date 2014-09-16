From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] ARM: dts: omap: Remove WAKEUPENABLE mux options for UARTs
Date: Mon, 15 Sep 2014 20:11:58 -0700
Message-ID: <1410837126-31553-4-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19831 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754256AbaIPDNA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 23:13:00 -0400
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This is no longer needed as the device specific wake-up event
can now be specified with interrupts-extended property where
the second interrupt is the pinctrl-single register, such as
the UART3 RX pin.

Note that twl4030_omap3.dtsi needs to set WAKEUPENABLE for
off-idle to properly trigger the PMIC scripts. And GPIO pins
still need to set WAKEUPENABLE for wake-up events.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 1becefc..06a8aec 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -174,8 +174,8 @@
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x16e (PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
-			0x170 (PIN_OUTPUT | MUX_MODE0) /* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
+			0x16e (PIN_INPUT | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			0x170 (PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
 		>;
 	};
 
-- 
2.1.0

