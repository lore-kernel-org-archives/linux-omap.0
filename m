From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] ARM: dts: omap3-igep0020: use SMSC9221 timings
Date: Thu, 24 Apr 2014 18:53:50 +0200
Message-ID: <1398358430-13570-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:50431 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbaDXQyG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 12:54:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEPv2 board has a SMSC LAN9221i ethernet chip and not a
SMSC LAN911x connected to the GPMC. Each chip needs different
timings in order to operate correctly so is wrong to include
omap-gpmc-smsc911x.dtsi instead of omap-gpmc-smsc9221.dtsi.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Hi Tony,

I see no performance difference when measuring network throughput using
iperf(1) but this change is the correct one nonetheless since if we later
better adjust the timings it will already include the right dtsi.

Best regards,
Javier

 arch/arm/boot/dts/omap3-igep.dtsi    | 2 +-
 arch/arm/boot/dts/omap3-igep0020.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index b97736d..e2d163b 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -107,7 +107,7 @@
 		>;
 	};
 
-	smsc911x_pins: pinmux_smsc911x_pins {
+	smsc9221_pins: pinmux_smsc9221_pins {
 		pinctrl-single,pins = <
 			0x1a2 (PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
 		>;
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 7abd64f..b22caaa 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -10,7 +10,7 @@
  */
 
 #include "omap3-igep.dtsi"
-#include "omap-gpmc-smsc911x.dtsi"
+#include "omap-gpmc-smsc9221.dtsi"
 
 / {
 	model = "IGEPv2 (TI OMAP AM/DM37x)";
@@ -248,7 +248,7 @@
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
-		pinctrl-0 = <&smsc911x_pins>;
+		pinctrl-0 = <&smsc9221_pins>;
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
-- 
1.9.1

