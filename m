From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 2/2] OMAP3: GPIO: disable GPIO debounce clocks on idle
Date: Wed, 28 Jan 2009 17:58:02 -0800
Message-ID: <1233194282-30057-3-git-send-email-khilman@deeprootsystems.com>
References: <1233194282-30057-1-git-send-email-khilman@deeprootsystems.com>
 <1233194282-30057-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:10300 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbZA2B6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 20:58:12 -0500
Received: by wf-out-1314.google.com with SMTP id 27so8408212wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2009 17:58:11 -0800 (PST)
In-Reply-To: <1233194282-30057-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ensure GPIO debounce clocks are disabled when idle.  Otherwise,
clocks will prevent PER powerdomain from entering retention.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++++
 arch/arm/plat-omap/gpio.c    |    8 ++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5ac0393..bf309f2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -466,6 +466,10 @@ static int omap3_fclks_active(void)
 	fck_core1 &= ~(OMAP3430_EN_UART1 | OMAP3430_EN_UART2);
 	fck_per &= ~OMAP3430_EN_UART3;
 
+	/* Ignore GPIO clocks.  Handled by GPIO prepare-idle hooks */
+	fck_per &= ~(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
+		     OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 | OMAP3430_EN_GPIO6);
+
 	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
 	    fck_cam | fck_per | fck_usbhost)
 		return 1;
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

