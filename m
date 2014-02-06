From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/3] ARM: dts: omap3-tobi: Use the correct vendor prefix
Date: Thu,  6 Feb 2014 10:10:17 +0100
Message-ID: <1391677818-21154-3-git-send-email-florian.vaussard@epfl.ch>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:51857 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932303AbaBFJKm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Feb 2014 04:10:42 -0500
In-Reply-To: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Gumstix is the correct vendor for all Overo related products.

Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-tobi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 0e3b8bf..c742afa 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "TI OMAP3 Gumstix Overo on Tobi";
-	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
 
 	leds {
 		compatible = "gpio-leds";
-- 
1.8.1.2

