From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: enable TWL4030_USB in omap2plus_defconfig
Date: Thu, 26 Feb 2015 23:07:29 +0200
Message-ID: <1424984849-13083-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:36597 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbBZVHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 16:07:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Enable TWL4030_USB which is used at least on Nokia N900/N950/N9 (OMAP3).

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b738652..8c93aa9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -375,6 +375,7 @@ CONFIG_PWM_TWL=m
 CONFIG_PWM_TWL_LED=m
 CONFIG_OMAP_USB2=m
 CONFIG_TI_PIPE3=m
+CONFIG_TWL4030_USB=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
2.2.0

