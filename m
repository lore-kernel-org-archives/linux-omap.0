From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 3/3] ARM: dts: omap3-igep*: Update to use the TI AM/DM37x processor.
Date: Sat, 19 Oct 2013 21:54:08 +0200
Message-ID: <1382212448-31094-4-git-send-email-eballetbo@gmail.com>
References: <1382212448-31094-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:51578 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab3JST4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 15:56:39 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so4985541wgg.4
        for <linux-omap@vger.kernel.org>; Sat, 19 Oct 2013 12:56:38 -0700 (PDT)
In-Reply-To: <1382212448-31094-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

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
index 882e318..04b83ce 100644
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
index 750ce84..495ef0c 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for IGEPv2 board
+ * Device Tree Source for IGEPv2 Rev. (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
@@ -12,7 +12,7 @@
 #include "omap3-igep.dtsi"
 
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
1.8.1.2

