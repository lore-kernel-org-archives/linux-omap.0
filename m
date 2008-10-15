From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/2] Hook into PM counters
Date: Wed, 15 Oct 2008 17:48:44 +0300
Message-ID: <1224082124-24439-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1224082124-24439-1-git-send-email-peter.de-schrijver@nokia.com>
 <1224082124-24439-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16899 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYJOOtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 10:49:15 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FEn54b031447
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 17:49:12 +0300
In-Reply-To: <1224082124-24439-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch modifies the clock, clockdomain and OMAP3 specific powerdomain
code to call the PM counter infrastructure whenever one or more powerdomains
might have changed state.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock.c       |    2 ++
 arch/arm/mach-omap2/clockdomain.c |    4 ++++
 arch/arm/mach-omap2/pm34xx.c      |    6 ++++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index c3af24e..dbbc7c8 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1013,5 +1013,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 
 	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
 	_omap2_clk_disable(clk);
+	if (clk->clkdm.ptr != NULL)
+		pwrdm_clkdm_state_switch(clk->clkdm.ptr);
 }
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index fa62f14..5249fe8 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+	pwrdm_clkdm_state_switch(clkdm);
+
 	return 0;
 }
 
@@ -618,6 +620,8 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
+	pwrdm_clkdm_state_switch(clkdm);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a828db6..1fbb690 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -170,6 +170,8 @@ static void omap_sram_idle(void)
 	disable_smartreflex(SR1);
 	disable_smartreflex(SR2);
 
+	pwrdm_pre_transition();
+
 	omap2_gpio_prepare_for_retention();
 
 	_omap_sram_idle(NULL, save_state);
@@ -179,6 +181,9 @@ static void omap_sram_idle(void)
 	/* Enable smartreflex after WFI */
 	enable_smartreflex(SR1);
 	enable_smartreflex(SR2);
+
+	pwrdm_post_transition();
+
 }
 
 /*
@@ -260,6 +265,7 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (sleep_switch) {
 		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		pwrdm_wait_transition(pwrdm);
+		pwrdm_state_switch(pwrdm);
 	}
 
 err:
-- 
1.5.6.3

