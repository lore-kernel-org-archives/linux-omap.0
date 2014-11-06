From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 03/11] ARM: dts: omap3-igep0030: Specify IGEP COM revision in device tree.
Date: Thu,  6 Nov 2014 13:01:43 +0100
Message-ID: <1415275311-6857-4-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:41824 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaKFMCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:24 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

We'll introduce new hardware revisions soon. This patch is only to
indicate which board revision supports this device tree file in order
to avoid confusions.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/omap3-igep0030.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 5862380..d7527b6 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for IGEP COM MODULE (TI OMAP AM/DM37x)
+ * Device Tree Source for IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
@@ -12,7 +12,7 @@
 #include "omap3-igep.dtsi"
 
 / {
-	model = "IGEP COM MODULE (TI OMAP AM/DM37x)";
+	model = "IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)";
 	compatible = "isee,omap3-igep0030", "ti,omap36xx", "ti,omap3";
 
 	leds {
-- 
1.9.1

