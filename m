From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/3] ARM: dts: omap3-tobi: Fix boot with OMAP36xx-based Overo
Date: Thu,  6 Feb 2014 10:10:16 +0100
Message-ID: <1391677818-21154-2-git-send-email-florian.vaussard@epfl.ch>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:51845 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299AbaBFJKl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Feb 2014 04:10:41 -0500
In-Reply-To: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Tobi expansion board can be used with both OMAP35xx-based Overo,
and OMAP36xx-based Overo. Currently the boot is broken with newer
OMAP36xx-based Overo (Storm and alike). Fix include file and
compatible string to be able to boot newer models.

This will break older models. This will be addressed later.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi | 3 ---
 arch/arm/boot/dts/omap3-tobi.dts   | 5 ++++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index a461d2f..5970999 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -9,9 +9,6 @@
 /*
  * The Gumstix Overo must be combined with an expansion board.
  */
-/dts-v1/;
-
-#include "omap34xx.dtsi"
 
 / {
 	pwmleds {
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 7e4ad2a..0e3b8bf 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -10,11 +10,14 @@
  * Tobi expansion board is manufactured by Gumstix Inc.
  */
 
+/dts-v1/;
+
+#include "omap36xx.dtsi"
 #include "omap3-overo.dtsi"
 
 / {
 	model = "TI OMAP3 Gumstix Overo on Tobi";
-	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3";
+	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap36xx", "ti,omap3";
 
 	leds {
 		compatible = "gpio-leds";
-- 
1.8.1.2

