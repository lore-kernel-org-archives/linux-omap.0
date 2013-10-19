From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/3] ARM: dts: omap3-igep: Fix bus-width for mmc1.
Date: Sat, 19 Oct 2013 21:54:06 +0200
Message-ID: <1382212448-31094-2-git-send-email-eballetbo@gmail.com>
References: <1382212448-31094-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59748 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab3JST4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 15:56:38 -0400
Received: by mail-wi0-f174.google.com with SMTP id cb5so2369953wib.7
        for <linux-omap@vger.kernel.org>; Sat, 19 Oct 2013 12:56:36 -0700 (PDT)
In-Reply-To: <1382212448-31094-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Both, IGEPv2 and IGEP COM MODULE have a bus-width of 4 not 8, so fix this and
do not mux data pins from mmc1_data5 to mmc1_data7.

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
1.8.1.2

