From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCH] ARM: OMAP: Pointers to __devexit should be __devexit_p
Date: Tue, 16 Aug 2011 16:33:32 +0200
Message-ID: <CAFULf_wXK_2XkjUaDuZc+Ap8YiaesrdmHjErNvwyzV5CizLYYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47409 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1HPOdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 10:33:33 -0400
Received: by vxi9 with SMTP id 9so4695252vxi.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 07:33:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

Pointers to functions that are annotated as __devexit should be
protected by the __devexit_p() macro.

This fixes a build failure for OMAP when defined(CONFIG_SMP_ON_UP) &&
!defined(CONFIG_DEBUG_SPINLOCK)

Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 arch/arm/plat-omap/dma.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c
b/arch/arm/mach-omap2/smartreflex.c
index 34c01a7..67bc6ce 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1002,7 +1002,7 @@ static int __devexit omap_sr_remove(struct
platform_device *pdev)
 }

 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove         = __devexit_p(omap_sr_remove),
 	.driver		= {
 		.name	= "smartreflex",
 	},
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..f7150ba 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2105,7 +2105,7 @@ static int __devexit
omap_system_dma_remove(struct platform_device *pdev)

 static struct platform_driver omap_system_dma_driver = {
 	.probe		= omap_system_dma_probe,
-	.remove		= omap_system_dma_remove,
+	.remove		= __devexit_p(omap_system_dma_remove),
 	.driver		= {
 		.name	= "omap_dma_system"
 	},
-- 
1.7.1
