From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] ARM: dts: omap3-igep: add mux pins for MMC device node
Date: Sat, 15 Dec 2012 12:19:01 +0100
Message-ID: <1355570341-6458-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60201 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2LOLTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Dec 2012 06:19:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The omap_hsmmc driver now expects that Device Trees will
set up the SD/MMC pin mux and not doing that leads to the
mmc not been mounted:

[    1.870300] omap_hsmmc mmc.20: pins are not configured from the driver
[    2.025634] Waiting for root device /dev/mmcblk0p2...

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index fdd9154..dd01c46 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -47,6 +47,21 @@
 			0x170 0		/* uart3_tx.uart3_tx OUTPUT | MODE0 */
 		>;
 	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x114 0x0118    /* sdmmc1_clk.sdmmc1_clk INPUT PULLUP | MODE 0 */
+			0x116 0x0118    /* sdmmc1_cmd.sdmmc1_cmd INPUT PULLUP | MODE 0 */
+			0x118 0x0118 	/* sdmmc1_dat0.sdmmc1_dat0 INPUT PULLUP | MODE 0 */
+			0x11a 0x0118	/* sdmmc1_dat1.sdmmc1_dat1 INPUT PULLUP | MODE 0 */
+			0x11c 0x0118	/* sdmmc1_dat2.sdmmc1_dat2 INPUT PULLUP | MODE 0 */
+			0x11e 0x0118	/* sdmmc1_dat3.sdmmc1_dat3 INPUT PULLUP | MODE 0 */
+			0x120 0x0100	/* sdmmc1_dat4.sdmmc1_dat4 INPUT | MODE 0 */
+			0x122 0x0100	/* sdmmc1_dat5.sdmmc1_dat5 INPUT | MODE 0 */
+			0x124 0x0100	/* sdmmc1_dat6.sdmmc1_dat6 INPUT | MODE 0 */
+			0x126 0x0100	/* sdmmc1_dat7.sdmmc1_dat7 INPUT | MODE 0 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -72,9 +87,11 @@
 };
 
 &mmc1 {
-	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
-	bus-width = <8>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&mmc1_pins>;
+      vmmc-supply = <&vmmc1>;
+      vmmc_aux-supply = <&vsim>;
+      bus-width = <8>;
 };
 
 &mmc2 {
-- 
1.7.7.6

