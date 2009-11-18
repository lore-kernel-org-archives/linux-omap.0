From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap3: zoom2/3: make MMC slot work again
Date: Wed, 18 Nov 2009 19:09:10 +0530
Message-ID: <1258551550-25301-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58446 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756721AbZKRNjJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Nov 2009 08:39:09 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAIDdCbu001350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 07:39:14 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

omap3: zoom2/3: make MMC slot work again

Commit 12f8dfb56 accidentally broke MMC on zoom2/3.
The .vmmc1 field of zoom_twldata was deleted. Restoring it
allows the MMC slot to work again

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-zoom-peripherals.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -236,6 +236,7 @@ static struct twl4030_platform_data zoom
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
 	.codec		= &zoom_codec_data,
+	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
 	.vsim           = &zoom_vsim,
 
