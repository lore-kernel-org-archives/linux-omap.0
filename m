From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] ARM: dts: omap3-beagle-xm: fix string error in compatible property
Date: Wed,  7 Aug 2013 09:14:15 -0500
Message-ID: <1375884855-19414-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:39160 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3HGOO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 10:14:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index afdb164..0c514dc 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard xM";
-	compatible = "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
+	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";
 
 	cpus {
 		cpu@0 {
-- 
1.7.10.4

