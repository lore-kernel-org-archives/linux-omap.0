From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 03/13] Remove unused rate calculation.
Date: Wed, 21 Mar 2012 22:19:44 -0700
Message-ID: <1332393594-23993-4-git-send-email-Russ.Dill@ti.com>
References: <20120321194133.GP9859@atomide.com>
 <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566Ab2CVFUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 01:20:21 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so2617327iag.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 22:20:20 -0700 (PDT)
In-Reply-To: <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Looking back into git history, this code was never used and was
probably left over from a copy/paste.

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c     |    9 ---------
 arch/arm/mach-omap2/board-omap3stalker.c |    9 ---------
 2 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a659e19..548e1ef 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -114,15 +114,6 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
 
 static inline void __init omap3evm_init_smsc911x(void)
 {
-	struct clk *l3ck;
-	unsigned int rate;
-
-	l3ck = clk_get(NULL, "l3_ck");
-	if (IS_ERR(l3ck))
-		rate = 100000000;
-	else
-		rate = clk_get_rate(l3ck);
-
 	/* Configure ethernet controller reset gpio */
 	if (cpu_is_omap3430()) {
 		if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 6410043..de95352 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -72,15 +72,6 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
 
 static inline void __init omap3stalker_init_eth(void)
 {
-	struct clk *l3ck;
-	unsigned int rate;
-
-	l3ck = clk_get(NULL, "l3_ck");
-	if (IS_ERR(l3ck))
-		rate = 100000000;
-	else
-		rate = clk_get_rate(l3ck);
-
 	omap_mux_init_gpio(19, OMAP_PIN_INPUT_PULLUP);
 	gpmc_smsc911x_init(&smsc911x_cfg);
 }
-- 
1.7.9.1

