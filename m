From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/3] OMAP: omap4panda: Use common configuration for V1V8, V2V1 supplies
Date: Wed,  9 May 2012 10:33:34 +0300
Message-ID: <1336548814-1005-4-git-send-email-peter.ujfalusi@ti.com>
References: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42686 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752437Ab2EIHkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 03:40:14 -0400
Received: by lagu2 with SMTP id u2so57492lag.12
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 00:40:11 -0700 (PDT)
In-Reply-To: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

These supplies going to be needed for the twl6040 driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1b782ba..c47feed 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -323,7 +323,9 @@ static int __init omap4_panda_i2c_init(void)
 			TWL_COMMON_REGULATOR_VANA |
 			TWL_COMMON_REGULATOR_VCXIO |
 			TWL_COMMON_REGULATOR_VUSB |
-			TWL_COMMON_REGULATOR_CLK32KG);
+			TWL_COMMON_REGULATOR_CLK32KG |
+			TWL_COMMON_REGULATOR_V1V8 |
+			TWL_COMMON_REGULATOR_V2V1);
 	omap4_pmic_init("twl6030", &omap4_panda_twldata,
 			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
 	omap_register_i2c_bus(2, 400, NULL, 0);
-- 
1.7.8.6

