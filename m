From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/3] OMAP: 4430SDP: Use common configuration for V1V8, V2V1 supplies
Date: Wed,  9 May 2012 10:33:33 +0300
Message-ID: <1336548814-1005-3-git-send-email-peter.ujfalusi@ti.com>
References: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35289 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757025Ab2EIHdb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 03:33:31 -0400
Received: by lbok6 with SMTP id k6so6008600lbo.32
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 00:33:29 -0700 (PDT)
In-Reply-To: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

These supplies going to be needed for the twl6040 driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 130ab00..c8d38bd 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -615,7 +615,9 @@ static int __init omap4_i2c_init(void)
 			TWL_COMMON_REGULATOR_VANA |
 			TWL_COMMON_REGULATOR_VCXIO |
 			TWL_COMMON_REGULATOR_VUSB |
-			TWL_COMMON_REGULATOR_CLK32KG);
+			TWL_COMMON_REGULATOR_CLK32KG |
+			TWL_COMMON_REGULATOR_V1V8 |
+			TWL_COMMON_REGULATOR_V2V1);
 	omap4_pmic_init("twl6030", &sdp4430_twldata,
 			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
 	omap_register_i2c_bus(2, 400, NULL, 0);
-- 
1.7.8.6

