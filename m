From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 5/7] OMAP2+: GPIO: make workaround_enabled bank specific
Date: Mon, 18 Apr 2011 20:36:55 +0530
Message-ID: <1303139217-10285-6-git-send-email-charu@ti.com>
References: <no>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47455 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab1DRPDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 11:03:44 -0400
In-Reply-To: <no>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, paul@pwsan.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Make workaround_enabled flag bank-specific instead of using a single
flag for all the banks together. This would be helpful while making
use of runtime framework in OMAP GPIO driver which would make the
driver handle each GPIO bank independently.

Also rename workaround_enabled flag to off_mode_wkup_wa_enabled

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 5d4ed6c..5933c98 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -176,6 +176,7 @@ struct gpio_bank {
 	int stride;
 	bool looses_context;
 	u32 ctx_lost_cnt_before;
+	bool off_mode_wkup_wa_enabled;
 };
 
 /*
@@ -1636,6 +1637,7 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 	static int gpio;
 
 	bank->mod_usage = 0;
+	bank->off_mode_wkup_wa_enabled = false;
 	/*
 	 * REVISIT eventually switch from OMAP-specific gpio structs
 	 * over to the generic ones
@@ -1858,11 +1860,9 @@ static struct sys_device omap_gpio_device = {
 static void omap_gpio_save_context(struct gpio_bank *bank);
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
-static int workaround_enabled;
-
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
-	int i, c = 0;
+	int i;
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
@@ -1922,7 +1922,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
 		}
 
-		c++;
+		bank->off_mode_wkup_wa_enabled = true;
 
 save_gpio_ctx:
 		pdev = to_platform_device(bank->dev);
@@ -1930,11 +1930,6 @@ save_gpio_ctx:
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
@@ -1964,7 +1959,7 @@ void omap2_gpio_resume_after_idle(void)
 		if (ctx_lost_cnt_after == bank->ctx_lost_cnt_before)
 			continue;
 
-		if (!workaround_enabled)
+		if (!bank->off_mode_wkup_wa_enabled)
 			goto restore_gpio_ctx;
 
 		if (!(bank->enabled_non_wakeup_gpios))
@@ -2042,6 +2037,7 @@ void omap2_gpio_resume_after_idle(void)
 		}
 
 restore_gpio_ctx:
+		bank->off_mode_wkup_wa_enabled = false;
 		omap_gpio_restore_context(bank);
 	}
 
-- 
1.7.1

