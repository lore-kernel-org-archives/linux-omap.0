From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/6] OMAP3: GPIO: disable GPIO debounce clocks on idle
Date: Tue, 11 May 2010 16:30:50 -0700
Message-ID: <1273620652-15927-5-git-send-email-khilman@deeprootsystems.com>
References: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52016 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0EKXbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:31:05 -0400
Received: by pxi5 with SMTP id 5so2550721pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:31:04 -0700 (PDT)
In-Reply-To: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Ensure GPIO debounce clocks are disabled when idle.  Otherwise,
clocks will prevent PER powerdomain from entering retention.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 1c81340..c6e1de5 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -196,6 +196,7 @@ struct gpio_bank {
 	struct gpio_chip chip;
 	struct clk *dbck;
 	u32 mod_usage;
+	u32 dbck_enable_mask;
 };
 
 #define METHOD_MPUIO		0
@@ -647,6 +648,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
 		goto done;
 
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		bank->dbck_enable_mask = val;
 		if (enable)
 			clk_enable(bank->dbck);
 		else
@@ -2054,6 +2056,9 @@ void omap2_gpio_prepare_for_idle(int power_state)
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1, l2;
 
+		if (bank->dbck_enable_mask)
+			clk_disable(bank->dbck);
+
 		if (power_state > PWRDM_POWER_OFF)
 			continue;
 
@@ -2118,6 +2123,9 @@ void omap2_gpio_resume_after_idle(void)
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l, gen, gen0, gen1;
 
+		if (bank->dbck_enable_mask)
+			clk_enable(bank->dbck);
+
 		if (!workaround_enabled)
 			continue;
 
-- 
1.7.0.2

