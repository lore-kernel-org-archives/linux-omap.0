From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 13/21] OMAP: PM: Hook into PM counters
Date: Wed,  4 Feb 2009 18:05:59 -0800
Message-ID: <1233799567-22250-14-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-11-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-12-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:57993 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282AbZBECHP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:15 -0500
Received: by yw-out-2324.google.com with SMTP id 9so61ywe.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:14 -0800 (PST)
In-Reply-To: <1233799567-22250-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch modifies the clock, clockdomain and OMAP3 specific
powerdomain code to call the PM counter infrastructure whenever one or
more powerdomains might have changed state.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock.c       |    2 ++
 arch/arm/mach-omap2/clockdomain.c |    3 +++
 arch/arm/mach-omap2/pm34xx.c      |    6 ++++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 72e3db8..1de04d1 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1080,6 +1080,8 @@ void omap2_clk_disable_unused(struct clk *clk)
 		omap2_clk_disable(clk);
 	} else
 		_omap2_clk_disable(clk);
+	if (clk->clkdm.ptr != NULL)
+		pwrdm_clkdm_state_switch(clk->clkdm.ptr);
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index a7c2d87..6650d44 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -570,6 +570,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 		omap2_clkdm_wakeup(clkdm);
 
 	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
 }
@@ -622,6 +623,8 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
+	pwrdm_clkdm_state_switch(clkdm);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 87ac320..253ab97 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -176,6 +176,8 @@ static void omap_sram_idle(void)
 	disable_smartreflex(SR1);
 	disable_smartreflex(SR2);
 
+	pwrdm_pre_transition();
+
 	omap2_gpio_prepare_for_retention();
 	omap_uart_prepare_idle(0);
 	omap_uart_prepare_idle(1);
@@ -191,6 +193,9 @@ static void omap_sram_idle(void)
 	/* Enable smartreflex after WFI */
 	enable_smartreflex(SR1);
 	enable_smartreflex(SR2);
+
+	pwrdm_post_transition();
+
 }
 
 /*
@@ -284,6 +289,7 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (sleep_switch) {
 		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		pwrdm_wait_transition(pwrdm);
+		pwrdm_state_switch(pwrdm);
 	}
 
 err:
-- 
1.6.1

