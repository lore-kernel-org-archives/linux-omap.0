From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 03/11] ARM: dts: omap3-igep: Update to use the TI AM/DM37x processor.
Date: Wed, 20 Nov 2013 02:06:07 +0100
Message-ID: <1384909575-19108-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34711 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab3KTBHb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 20:07:31 -0500
In-Reply-To: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@gmail.com>

Most of the boards are using the TI AM/DM37x processor, there is only a small
quantity of IGEP Processor Boards based on TI OMAP3530. So it's better use the
omap36xx.dtsi include instead of omap34xx.dtsi include.

To avoid confusion we have added to the model the (TI AM/DM37x) comment.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi    | 4 ++--
 arch/arm/boot/dts/omap3-igep0020.dts | 4 ++--
 arch/arm/boot/dts/omap3-igep0030.dts | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index b3517b2..e4c8769 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for IGEP Technology devices
+ * Common device tree for IGEP boards based on AM/DM37x
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
@@ -10,7 +10,7 @@
  */
 /dts-v1/;
 
-#include "omap34xx.dtsi"
+#include "omap36xx.dtsi"
 
 / {
 	memory {
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index d5cc792..33ce123 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for IGEPv2 board
+ * Device Tree Source for IGEPv2 Rev. (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
@@ -13,7 +13,7 @@
 #include "omap-gpmc-smsc911x.dtsi"
 
 / {
-	model = "IGEPv2";
+	model = "IGEPv2 (TI OMAP AM/DM37x)";
 	compatible = "isee,omap3-igep0020", "ti,omap3";
 
 	leds {
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 525e6d9..02a23f8 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for IGEP COM Module
+ * Device Tree Source for IGEP COM MODULE (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
@@ -12,7 +12,7 @@
 #include "omap3-igep.dtsi"
 
 / {
-	model = "IGEP COM Module";
+	model = "IGEP COM MODULE (TI OMAP AM/DM37x)";
 	compatible = "isee,omap3-igep0030", "ti,omap3";
 
 	leds {
-- 
1.8.4.2

