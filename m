From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 04/11] ARM: dts: omap3-igep0020: Specify IGEPv2 revision in device tree.
Date: Thu,  6 Nov 2014 13:01:44 +0100
Message-ID: <1415275311-6857-5-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:62756 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbaKFMCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:25 -0500
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
 arch/arm/boot/dts/omap3-igep0020.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 731ab8f..75a3ac3 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for IGEPv2 Rev. (TI OMAP AM/DM37x)
+ * Device Tree Source for IGEPv2 Rev. C (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
@@ -13,7 +13,7 @@
 #include "omap-gpmc-smsc9221.dtsi"
 
 / {
-	model = "IGEPv2 (TI OMAP AM/DM37x)";
+	model = "IGEPv2 Rev. C (TI OMAP AM/DM37x)";
 	compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
 
 	leds {
-- 
1.9.1

