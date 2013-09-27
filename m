From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] ARM: dts: am335x-bone-common: correct mux mode for cmd line
Date: Fri, 27 Sep 2013 17:05:09 +0530
Message-ID: <1380281710-12728-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36639 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab3I0Lfp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Sep 2013 07:35:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, koen@dominion.thruhere.net, Balaji T K <balajitk@ti.com>

pinmux_emmc_pins: mux mode for cmd line should be MODE2
to detect eMMC on beagle bone black and beagle bone white + eMMC cape.

Signed-off-by: Balaji T K <balajitk@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
---
based on git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts

 arch/arm/boot/dts/am335x-bone-common.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index ff5c3ca..51f6a99 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -153,7 +153,7 @@
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
 			0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			0x84 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_csn2.mmc1_cmd */
+			0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
 			0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
 			0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
 			0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-- 
1.7.5.4

