From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Move counter function into generic OMAP PM
Date: Wed, 24 Sep 2008 17:06:52 +0300
Message-ID: <1222265214-7106-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1222265214-7106-1-git-send-email-peter.de-schrijver@nokia.com>
 <1222265214-7106-2-git-send-email-peter.de-schrijver@nokia.com>
 <1222265214-7106-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57792 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbYIXOIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:08:34 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8OE8FE2009577
	for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 17:08:32 +0300
In-Reply-To: <1222265214-7106-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/powerdomain.c |  113 +++++++++++++++++++++++++++++++++++--
 1 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 097d5c4..3249903 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -23,6 +23,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/atomic.h>
 
@@ -30,10 +31,17 @@
 #include "cm-regbits-34xx.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
+#include "pm.h"
 
 #include <mach/cpu.h>
 #include <mach/powerdomain.h>
 #include <mach/clockdomain.h>
+#include <mach/tiocp_device.h>
+
+enum {
+	PWRDM_STATE_NOW = 0,
+	PWRDM_STATE_PREV,
+};
 
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
@@ -102,6 +110,64 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 	return pd->pwrdm;
 }
 
+static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
+{
+	int prev;
+	int state;
+
+	if (pwrdm == NULL)
+		return -EINVAL;
+
+	state = pwrdm_read_pwrst(pwrdm);
+
+	switch (flag) {
+	case PWRDM_STATE_NOW:
+		prev = pwrdm->state;
+		break;
+	case PWRDM_STATE_PREV:
+		prev = pwrdm_read_prev_pwrst(pwrdm);
+		if (pwrdm->state != prev)
+			pwrdm->state_counter[prev]++;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (state != prev)
+		pwrdm->state_counter[state]++;
+
+	pm_dbg_update_time(pwrdm,prev);
+
+	pwrdm->state = state;
+
+	return 0;
+}
+
+static int _pwrdm_pre_suspend_cb(struct powerdomain *pwrdm, void *user)
+{
+	pwrdm_clear_all_prev_pwrst(pwrdm);
+	_pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
+	return 0;
+}
+
+static int _pwrdm_post_suspend_cb(struct powerdomain *pwrdm, void *user)
+{
+	_pwrdm_state_switch(pwrdm, PWRDM_STATE_PREV);
+	return 0;
+}
+
+static __init void _pwrdm_setup(struct powerdomain *pwrdm)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) 
+		pwrdm->state_counter[i] = 0;
+
+	pwrdm_wait_transition(pwrdm);
+	pwrdm->state = pwrdm_read_pwrst(pwrdm);
+	pwrdm->state_counter[pwrdm->state] = 1;
+
+}
 
 /* Public functions */
 
@@ -117,9 +183,12 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
 {
 	struct powerdomain **p = NULL;
 
-	if (pwrdm_list)
-		for (p = pwrdm_list; *p; p++)
+	if (pwrdm_list) {
+		for (p = pwrdm_list; *p; p++) {
 			pwrdm_register(*p);
+			_pwrdm_setup(*p);
+		}
+	}
 }
 
 /**
@@ -217,7 +286,7 @@ struct powerdomain *pwrdm_lookup(const char *name)
  * anything else to indicate failure; or -EINVAL if the function
  * pointer is null.
  */
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user), void *user)
 {
 	struct powerdomain *temp_pwrdm;
 	unsigned long flags;
@@ -228,7 +297,7 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
 
 	read_lock_irqsave(&pwrdm_rwlock, flags);
 	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
-		ret = (*fn)(temp_pwrdm);
+		ret = (*fn)(temp_pwrdm, user);
 		if (ret)
 			break;
 	}
@@ -1110,11 +1179,43 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+int pwrdm_state_switch(struct powerdomain *pwrdm)
+{
+	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
+}
+
+int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
+{
+	if (clkdm != NULL && clkdm->pwrdm.ptr != NULL) {
+		pwrdm_wait_transition(clkdm->pwrdm.ptr);
+		return pwrdm_state_switch(clkdm->pwrdm.ptr);
+	}
+
+	return -EINVAL;
+}
+int pwrdm_clk_state_switch(struct clk *clk)
+{
+	if (clk != NULL && clk->clkdm.ptr != NULL)
+		return pwrdm_clkdm_state_switch(clk->clkdm.ptr);
+	return -EINVAL;
+}
+
+int pwrdm_pre_suspend(void)
+{
+	pwrdm_for_each(_pwrdm_pre_suspend_cb, NULL);
+	return 0;
+}
+
+int pwrdm_post_suspend(void)
+{
+	pwrdm_for_each(_pwrdm_post_suspend_cb, NULL);
+	return 0;
+}
+
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include "pm.h"
 
 static const char pwrdm_state_names[][4] = {
 	"OFF",
@@ -1164,7 +1265,7 @@ int pwrdm_dbg_show_timers(struct seq_file *s, void *unused)
 			continue;
 
 		/* Update timer for current state */
-		pm_dbg_pwrdm_state_switch(pwrdm);
+		pwrdm_state_switch(pwrdm);
 
 		seq_printf(s, "%s (%s)", pwrdm->name,
 			pwrdm_state_names[pwrdm->state]);
-- 
1.5.6.3

