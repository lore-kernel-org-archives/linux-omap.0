From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 01/11] ARM: dts: omap3-igep: Fix bus-width for mmc1.
Date: Sat, 16 Nov 2013 14:23:34 +0100
Message-ID: <1384608224-9452-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60329 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab3KPNYx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:24:53 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@gmail.com>

Both, IGEPv2 and IGEP COM MODULE have a bus-width of 4 not 8, so fix this and
do not mux data pins from mmc1_data4 to mmc1_data7.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index ba1e58b..d4fecce 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -65,10 +65,6 @@
 			0x11a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
 			0x11c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
 			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
-			0x120 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat4.sdmmc1_dat4 */
-			0x122 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat5.sdmmc1_dat5 */
-			0x124 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat6.sdmmc1_dat6 */
-			0x126 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat7.sdmmc1_dat7 */
 		>;
 	};
 
@@ -114,7 +110,7 @@
       pinctrl-0 = <&mmc1_pins>;
       vmmc-supply = <&vmmc1>;
       vmmc_aux-supply = <&vsim>;
-      bus-width = <8>;
+      bus-width = <4>;
 };
 
 &mmc2 {
-- 
1.8.4.2

