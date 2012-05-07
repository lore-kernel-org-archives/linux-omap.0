From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH] [OMAP] Mark Beagleboard-xM MMC bus as 4-bit
Date: Mon,  7 May 2012 12:56:17 -0700
Message-ID: <1336420577-2578-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49510 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757550Ab2EGT4V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 15:56:21 -0400
Received: by obbtb18 with SMTP id tb18so8709039obb.19
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 12:56:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@ti.com>

On Beagleboard-xM (all revisions) only MMC1_DAT0-MMC1_DAT3 are wired up.
Tested on Beagleboard-xM Rev C1 and Beagleboard Rev B4.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7be8d65..3b9647a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -523,6 +523,10 @@ static void __init omap3_beagle_init(void)
 
 	if (beagle_config.mmc1_gpio_wp != -EINVAL)
 		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
+
+	/* All xM versions have 4-bit MMC bus */
+	if (cpu_is_omap3630())
+		mmc[0].caps &= ~MMC_CAP_8_BIT_DATA;
 	omap_hsmmc_init(mmc);
 
 	omap3_beagle_i2c_init();
-- 
1.7.9.5

