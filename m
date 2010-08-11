From: Mathieu Poirier <mathieu.poirier@canonical.com>
Subject: [PATCH] Initializing gpmc before accessing flash
Date: Wed, 11 Aug 2010 08:41:30 -0600
Message-ID: <1281537690.1512.2.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:56563 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab0HKOlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 10:41:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Mathieu Poirier <mathieu.poirier@canonical.com>

>From b12de3010763a8c047eefd2eb9296eb68157b07e Mon Sep 17 00:00:00 2001
From: Mathieu J. Poirier <mathieu.poirier@canonical.com>
Date: Tue, 10 Aug 2010 17:14:25 -0400
Subject: [PATCH] Initializing gpmc before accessing flash

Adding initialization of the General Purpose Memory Controller
(gpmc) in 'omap3beagle_flash_init'.

The gpmc init was decoupled from nand flash init and
got its own init function.  This change was not reflected in
'omap3beagle_flash_init' resulting in a lookup failure when
probing for flash.

BugLink: https://bugs/launchpad.net/bugs/608266

Signed-off-by: Mathieu Poirier <mathieu.poirier@canonical.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7a1b351..e1203a4 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -466,6 +466,7 @@ static void __init omap3beagle_flash_init(void)
 		omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)
 			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
 		omap3beagle_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+               gpmc_nand_init(&omap3beagle_nand_data);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (platform_device_register(&omap3beagle_nand_device) < 0)
-- 
1.7.0.4



