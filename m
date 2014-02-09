From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/2] ARM: dts: N900: add missing compatible property
Date: Sun,  9 Feb 2014 14:12:36 +0200
Message-ID: <1391947956-24462-2-git-send-email-aaro.koskinen@iki.fi>
References: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:56537 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaBIMM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Feb 2014 07:12:58 -0500
In-Reply-To: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add missing compatible property to avoid problems in the future.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6fc85f963530..0bf40c90faba 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2013 Pavel Machek <pavel@ucw.cz>
- * Copyright 2013 Aaro Koskinen <aaro.koskinen@iki.fi>
+ * Copyright (C) 2013-2014 Aaro Koskinen <aaro.koskinen@iki.fi>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 (or later) as
@@ -13,7 +13,7 @@
 
 / {
 	model = "Nokia N900";
-	compatible = "nokia,omap3-n900", "ti,omap3";
+	compatible = "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
 
 	cpus {
 		cpu@0 {
-- 
1.8.5.3

