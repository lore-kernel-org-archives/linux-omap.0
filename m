From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] ARM: dts: omap3-igep: remove VSIM regulator
Date: Sat, 15 Dec 2012 01:52:20 +0100
Message-ID: <1355532740-5956-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:59565 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab2LOAxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 19:53:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

commit 5a8095e9 ARM: dts: Add omap3-beagle.dts

moved the VSIM regulator definition to the twl4030.dtsi to avoid
duplication. A definition for the VSIM regulator was also present
on omap3-igep.dtsi which leads to the following build error:

DTC     arch/arm/boot/dts/omap3-igep0020.dtb
DTC     arch/arm/boot/dts/omap3-igep0030.dtb
ERROR (duplicate_label): Duplicate label 'vsim' on /ocp/i2c@48070000/twl@48/regulator-vsim and /ocp/i2c@48070000/twl@48/regulator@10
ERROR: Input tree has errors, aborting (use -f to force output)
ERROR (duplicate_label): Duplicate label 'vsim' on /ocp/i2c@48070000/twl@48/regulator-vsim and /ocp/i2c@48070000/twl@48/regulator@10
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [arch/arm/boot/dts/omap3-igep0020.dtb] Error 2
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [arch/arm/boot/dts/omap3-igep0030.dtb] Error 2
make: *** [dtbs] Error 2

Since IGEP devices uses the same PMIC as Beagle boards, the VSIM
definition from twl4030.dtsi can be used.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 125fe00..de708ca 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -43,12 +43,6 @@
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
 
-		vsim: regulator@10 {
-			compatible = "ti,twl4030-vsim";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
 		twl_audio: audio {
 			compatible = "ti,twl4030-audio";
 			codec {
-- 
1.7.7.6

