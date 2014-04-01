From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] ARM: AM335X: EVM: fix pinmux documentation in devicetree
Date: Tue,  1 Apr 2014 18:38:13 +0200
Message-ID: <1396370358-778-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58348 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbaDAQju (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Apr 2014 12:39:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Wrong documentation in pinmux description can be especially confusing.
Keep it proper.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/boot/dts/am335x-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7e6c64ed966d..fb5dc92692cf 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -295,8 +295,8 @@
 
 	am335x_evm_audio_pins: am335x_evm_audio_pins {
 		pinctrl-single,pins = <
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rx_dv.mcasp1_aclkx */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_txd3.mcasp1_fsx */
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
 			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
 			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
 		>;
-- 
1.9.0

