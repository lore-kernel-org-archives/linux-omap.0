From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH PM 2/2] OMAP3: GPIO: disable GPIO debounce clocks on idle
Date: Tue, 27 Jan 2009 11:26:54 -0800
Message-ID: <1233084414-8088-3-git-send-email-khilman@deeprootsystems.com>
References: <1233084414-8088-1-git-send-email-khilman@deeprootsystems.com>
 <1233084414-8088-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:1754 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbZA0T1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 14:27:06 -0500
Received: by an-out-0708.google.com with SMTP id c2so1506221anc.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2009 11:27:04 -0800 (PST)
In-Reply-To: <1233084414-8088-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ensure GPIO debounce clocks are disabled when idle.  Otherwise,
clocks will prevent PER powerdomain from entering retention.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index cd7380e..eb7a703 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -154,6 +154,7 @@ struct gpio_bank {
 	spinlock_t lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
+	u32 dbck_enable_mask;
 };
 
 #define METHOD_MPUIO		0
@@ -489,6 +490,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
 		goto done;
 
 	if (cpu_is_omap34xx()) {
+		bank->dbck_enable_mask = val;
 		if (enable)
 			clk_enable(bank->dbck);
 		else
@@ -1639,6 +1641,9 @@ void omap2_gpio_prepare_for_idle(int power_state)
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1, l2;
 
+		if (cpu_is_omap34xx() && bank->dbck_enable_mask)
+			clk_disable(bank->dbck);
+
 		if (power_state > PWRDM_POWER_OFF)
 			continue;
 
@@ -1682,6 +1687,9 @@ void omap2_gpio_resume_after_idle(void)
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l;
 
+		if (cpu_is_omap34xx() && bank->dbck_enable_mask)
+			clk_enable(bank->dbck);
+
 		if (!workaround_enabled)
 			continue;
 
-- 
1.6.1

