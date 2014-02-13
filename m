From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 2/4] ARM: dts: omap3-tobi: Use the correct vendor prefix
Date: Thu, 13 Feb 2014 11:25:14 +0100
Message-ID: <1392287116-4548-3-git-send-email-florian.vaussard@epfl.ch>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:46938 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaBMKZf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 05:25:35 -0500
In-Reply-To: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

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

