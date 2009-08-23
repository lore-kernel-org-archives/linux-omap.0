From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 2/7] OMAP: PM: Hook into PM counters
Date: Mon, 24 Aug 2009 00:32:21 +0300
Message-ID: <1251063146-9255-3-git-send-email-khilman@deeprootsystems.com>
References: <1251063146-9255-1-git-send-email-khilman@deeprootsystems.com>
 <1251063146-9255-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:39938 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934005AbZHWVce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 17:32:34 -0400
Received: by ey-out-2122.google.com with SMTP id 22so501954eye.37
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 14:32:35 -0700 (PDT)
In-Reply-To: <1251063146-9255-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

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
index 456e2ad..f2a92d6 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1043,5 +1043,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 		omap2_clk_disable(clk);
 	} else
 		_omap2_clk_disable(clk);
+	if (clk->clkdm != NULL)
+		pwrdm_clkdm_state_switch(clk->clkdm);
 }
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 26912a9..5b0b90b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -574,6 +574,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 		omap2_clkdm_wakeup(clkdm);
 
 	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
 }
@@ -626,6 +627,8 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
+	pwrdm_clkdm_state_switch(clkdm);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 488d595..f197624 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -170,6 +170,8 @@ static void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
+	pwrdm_pre_transition();
+
 	omap2_gpio_prepare_for_retention();
 	omap_uart_prepare_idle(0);
 	omap_uart_prepare_idle(1);
@@ -182,6 +184,9 @@ static void omap_sram_idle(void)
 	omap_uart_resume_idle(1);
 	omap_uart_resume_idle(0);
 	omap2_gpio_resume_after_retention();
+
+	pwrdm_post_transition();
+
 }
 
 /*
@@ -271,6 +276,7 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (sleep_switch) {
 		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		pwrdm_wait_transition(pwrdm);
+		pwrdm_state_switch(pwrdm);
 	}
 
 err:
-- 
1.6.4

