From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2.6.38] omap: McBSP: Fix potential memory leak in omap_mcbsp_remove
Date: Wed,  3 Nov 2010 11:24:23 +0200
Message-ID: <1288776263-6600-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33861 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab0KCJY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 05:24:27 -0400
Received: by eye27 with SMTP id 27so127138eye.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Nov 2010 02:24:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

Function omap_mcbsp_probe allocates struct omap_mcbsp *mcbsp but it is not
freed in omap_mcbsp_remove. Fix this, remove unneeded structure cleanups
and clk_disable calls since they are not needed here.

This is not problem currently but becomes if the mcbsp driver is ever
modularized.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/mcbsp.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index eac4b97..f79090c 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1836,17 +1836,11 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 
 		omap34xx_device_exit(mcbsp);
 
-		clk_disable(mcbsp->fclk);
-		clk_disable(mcbsp->iclk);
 		clk_put(mcbsp->fclk);
 		clk_put(mcbsp->iclk);
 
 		iounmap(mcbsp->io_base);
-
-		mcbsp->fclk = NULL;
-		mcbsp->iclk = NULL;
-		mcbsp->free = 0;
-		mcbsp->dev = NULL;
+		kfree(mcbsp);
 	}
 
 	return 0;
-- 
1.7.2.3

