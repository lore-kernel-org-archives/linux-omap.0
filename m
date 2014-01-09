From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 12/18] ARM: dts: omap3-tobi: Rename to omap3-overo-tobi
Date: Thu,  9 Jan 2014 17:48:06 +0100
Message-ID: <1389286092-27087-13-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:41068 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863AbaAIQsv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 11:48:51 -0500
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

To enhance the clarity and coherence, rename omap3-tobi to omap3-overo-tobi.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile                                 | 2 +-
 arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi.dts} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi.dts} (93%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b7af502..7b028e4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -189,7 +189,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-n900.dtb \
 	omap3-n9.dtb \
 	omap3-n950.dtb \
-	omap3-tobi.dtb \
+	omap3-overo-tobi.dtb \
 	omap3-gta04.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
similarity index 93%
rename from arch/arm/boot/dts/omap3-tobi.dts
rename to arch/arm/boot/dts/omap3-overo-tobi.dts
index 928d12f..5072da2 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "TI OMAP3 Gumstix Overo on Tobi";
-	compatible = "gumstix,omap3-tobi", "gumstix,omap3-overo", "ti,omap3";
+	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3";
 
 	leds {
 		compatible = "gpio-leds";
-- 
1.8.1.2

