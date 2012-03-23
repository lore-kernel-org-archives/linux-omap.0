From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 01/12] Remove odd gpmc_cfg/board_data redirection.
Date: Fri, 23 Mar 2012 02:21:33 -0700
Message-ID: <1332494504-10251-2-git-send-email-Russ.Dill@ti.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33277 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2CWJVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:21:53 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so2248046obb.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:21:53 -0700 (PDT)
In-Reply-To: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

This seems to be a leftover from when gpmc-smsc911x.c was copied
from gpmc-smc91x.c.

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index 5e5880d..aa0c296 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -26,8 +26,6 @@
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
 
-static struct omap_smsc911x_platform_data *gpmc_cfg;
-
 static struct resource gpmc_smsc911x_resources[] = {
 	[0] = {
 		.flags		= IORESOURCE_MEM,
@@ -93,14 +91,12 @@ static struct platform_device gpmc_smsc911x_regulator = {
  * assume that pin multiplexing is done in the board-*.c file,
  * or in the bootloader.
  */
-void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
+void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 {
 	struct platform_device *pdev;
 	unsigned long cs_mem_base;
 	int ret;
 
-	gpmc_cfg = board_data;
-
 	if (!gpmc_cfg->id) {
 		ret = platform_device_register(&gpmc_smsc911x_regulator);
 		if (ret < 0) {
-- 
1.7.9.1

