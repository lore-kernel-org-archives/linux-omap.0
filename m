From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] soc: ti: pm33xx: Add a print while entering RTC only mode with DDR in self-refresh
Date: Mon, 29 Apr 2019 10:14:35 +0530
Message-ID: <20190429044435.19315-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ssantosh@kernel.org, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com, d-gerlach@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Currently there is no way to distinguish if the SoC entered DS0
mode or the RTC only mode. Hence add a print before entering
the RTC only mode.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/soc/ti/pm33xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index fc5802ccb1c0..bb77c220b6f8 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -178,6 +178,7 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 					  suspend_wfi_flags);
 
 		suspend_wfi_flags &= ~WFI_FLAG_RTC_ONLY;
+		dev_info(pm33xx_dev, "Entering RTC Only mode with DDR in self-refresh\n");
 
 		if (!ret) {
 			clk_restore_context();
-- 
2.17.1
