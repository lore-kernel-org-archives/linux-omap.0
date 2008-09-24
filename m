From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/5] Adapt prototypes for counter functions
Date: Wed, 24 Sep 2008 17:11:55 +0300
Message-ID: <1222265518-7230-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1222265518-7230-1-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62517 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYIXONB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:13:01 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8OE9ShG009978
	for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 09:12:59 -0500
In-Reply-To: <1222265518-7230-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm.h |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index aad4aeb..16212c1 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -45,11 +45,8 @@ struct seq_file;
 struct clk;
 struct clockdomain;
 struct powerdomain;
-extern int pm_dbg_pwrdm_state_switch(struct powerdomain *pwrdm);
-extern int pm_dbg_clkdm_state_switch(struct clockdomain *clkdm);
-extern int pm_dbg_clk_state_switch(struct clk *clk);
-extern int pm_dbg_pre_suspend(void);
-extern int pm_dbg_post_suspend(void);
+extern int pwrdms_debug_setup(struct powerdomain *pwrdm);
+extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 extern int pm_dbg_regset_save(int reg_set);
 extern int pm_dbg_regset_init(int reg_set);
 extern int pwrdm_dbg_show_counters(struct seq_file *s, void *unused);
@@ -57,11 +54,8 @@ extern int pwrdm_dbg_show_timers(struct seq_file *s, void *unused);
 extern int clkdm_dbg_show_counters(struct seq_file *s, void *unused);
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 #else
-#define pm_dbg_pwrdm_state_switch(domain) do; while (0)
-#define pm_dbg_clkdm_state_switch(domain) do; while (0)
-#define pm_dbg_clk_state_switch(domain) do; while (0)
-#define pm_dbg_pre_suspend() do; while (0)
-#define pm_dbg_post_suspend() do; while (0)
+#define pwrdms_debug_setup(pwrdm) do ; while (0)
+#define pm_dbg_update_time(pwrdm, prev) do ; while (0)
 #define pm_dbg_regset_save(reg_set) do; while (0)
 #define pm_dbg_regset_init(reg_set) do; while (0)
 #define pwrdm_dbg_show_counters(s,unused) do; while (0)
-- 
1.5.6.3

