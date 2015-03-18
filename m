From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: dts: Remove PIN_INPUT for dm816x McSPI
Date: Tue, 17 Mar 2015 17:19:21 -0700
Message-ID: <1426637961-4197-5-git-send-email-tony@atomide.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aso-006-i431.relay.mailchannels.net ([23.91.64.112]:31763 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753546AbbCRAYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 20:24:44 -0400
In-Reply-To: <1426637961-4197-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>

On dm816x we have no PIN_INPUT vs PIN_OUTPUT configuration, there
are just pulls. Let's remove the bogus flags.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index b520a8b..169a855 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -29,10 +29,10 @@
 &dm816x_pinmux {
 	mcspi1_pins: pinmux_mcspi1_pins {
 		pinctrl-single,pins = <
-			DM816X_IOPAD(0x0a94, PIN_INPUT | MUX_MODE0)	/* SPI_SCLK */
-			DM816X_IOPAD(0x0a98, PIN_OUTPUT | MUX_MODE0)	/* SPI_SCS0 */
-			DM816X_IOPAD(0x0aa8, PIN_INPUT | MUX_MODE0)	/* SPI_D0 */
-			DM816X_IOPAD(0x0aac, PIN_INPUT | MUX_MODE0)	/* SPI_D1 */
+			DM816X_IOPAD(0x0a94, MUX_MODE0)			/* SPI_SCLK */
+			DM816X_IOPAD(0x0a98, MUX_MODE0)			/* SPI_SCS0 */
+			DM816X_IOPAD(0x0aa8, MUX_MODE0)			/* SPI_D0 */
+			DM816X_IOPAD(0x0aac, MUX_MODE0)			/* SPI_D1 */
 		>;
 	};
 
-- 
2.1.4

