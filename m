From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 08/15] OMAP2+: GPIO: make workaround_enabled bank specific
Date: Tue, 24 May 2011 19:54:47 +0530
Message-ID: <1306247094-25372-9-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43520 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350Ab1EXOZN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:13 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Make workaround_enabled flag bank-specific instead of using a single
flag for all the banks together. This would be helpful while making
use of runtime framework in OMAP GPIO driver which would make the
driver handle each GPIO bank independently.

Also rename workaround_enabled flag to off_mode_wkup_wa_enabled

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/gpio/gpio_omap.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index bc02ec5..fcc60be 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -72,6 +72,7 @@ struct gpio_bank {
 	struct device *dev;
 	bool dbck_flag;
 	bool loses_context;
+	bool off_mode_wkup_wa_enabled;
 	int stride;
 	u32 width;
 	u32 ctx_lost_cnt_before;
@@ -1077,6 +1078,7 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 	static int gpio;
 
 	bank->mod_usage = 0;
+	bank->off_mode_wkup_wa_enabled = false;
 	/*
 	 * REVISIT eventually switch from OMAP-specific gpio structs
 	 * over to the generic ones
@@ -1316,11 +1318,8 @@ static struct sys_device omap_gpio_device = {
 static void omap_gpio_save_context(struct gpio_bank *bank);
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
-static int workaround_enabled;
-
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
-	int c = 0;
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
@@ -1378,7 +1377,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
 		}
 
-		c++;
+		bank->off_mode_wkup_wa_enabled = true;
 
 save_gpio_ctx:
 		pdev = to_platform_device(bank->dev);
@@ -1386,11 +1385,6 @@ save_gpio_ctx:
 				omap_device_get_context_loss_count(pdev);
 		omap_gpio_save_context(bank);
 	}
-	if (!c) {
-		workaround_enabled = 0;
-		return;
-	}
-	workaround_enabled = 1;
 }
 
 void omap2_gpio_resume_after_idle(void)
@@ -1415,7 +1409,7 @@ void omap2_gpio_resume_after_idle(void)
 		if (ctx_lost_cnt_after == bank->ctx_lost_cnt_before)
 			continue;
 
-		if (!workaround_enabled)
+		if (!bank->off_mode_wkup_wa_enabled)
 			goto restore_gpio_ctx;
 
 		if (!(bank->enabled_non_wakeup_gpios))
@@ -1495,6 +1489,7 @@ void omap2_gpio_resume_after_idle(void)
 		}
 
 restore_gpio_ctx:
+		bank->off_mode_wkup_wa_enabled = false;
 		omap_gpio_restore_context(bank);
 	}
 
-- 
1.6.0.4

