From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 3/3] Hook into powerdomain code
Date: Tue,  7 Oct 2008 16:33:16 +0300
Message-ID: <1223386396-29560-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1223386396-29560-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223386396-29560-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223386396-29560-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43266 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbYJGNdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:33:33 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97DXHJa020850
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 16:33:31 +0300
In-Reply-To: <1223386396-29560-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/powerdomain.c |   95 ++++++------------------------------
 1 files changed, 16 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 63ea29a..4ae7b01 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -35,6 +35,8 @@
 #include <mach/powerdomain.h>
 #include <mach/clockdomain.h>
 
+#include "pm.h"
+
 enum {
 	PWRDM_STATE_NOW = 0,
 	PWRDM_STATE_PREV,
@@ -134,19 +136,21 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 	if (state != prev)
 		pwrdm->state_counter[state]++;
 
+	pm_dbg_update_time(pwrdm, prev);
+
 	pwrdm->state = state;
 
 	return 0;
 }
 
-static int _pwrdm_pre_transition_cb(struct powerdomain *pwrdm)
+static int _pwrdm_pre_transition_cb(struct powerdomain *pwrdm, void *unused)
 {
 	pwrdm_clear_all_prev_pwrst(pwrdm);
 	_pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
 	return 0;
 }
 
-static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm)
+static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 {
 	_pwrdm_state_switch(pwrdm, PWRDM_STATE_PREV);
 	return 0;
@@ -179,9 +183,12 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
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
@@ -279,7 +286,8 @@ struct powerdomain *pwrdm_lookup(const char *name)
  * anything else to indicate failure; or -EINVAL if the function
  * pointer is null.
  */
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+				void *user)
 {
 	struct powerdomain *temp_pwrdm;
 	unsigned long flags;
@@ -290,7 +298,7 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
 
 	read_lock_irqsave(&pwrdm_rwlock, flags);
 	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
-		ret = (*fn)(temp_pwrdm);
+		ret = (*fn)(temp_pwrdm, user);
 		if (ret)
 			break;
 	}
@@ -456,13 +464,13 @@ int pwrdm_clk_state_switch(struct clk *clk)
 
 int pwrdm_pre_transition(void)
 {
-	pwrdm_for_each(_pwrdm_pre_transition_cb);
+	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
 	return 0;
 }
 
 int pwrdm_post_transition(void)
 {
-	pwrdm_for_each(_pwrdm_post_transition_cb);
+	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
 	return 0;
 }
 
@@ -1203,74 +1211,3 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 
 	return 0;
 }
-
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include "pm.h"
-
-static const char pwrdm_state_names[][4] = {
-	"OFF",
-	"RET",
-	"INA",
-	"ON"
-};
-
-int pwrdm_dbg_show_counters(struct seq_file *s, void *unused)
-{
-	int i;
-	struct powerdomain *pwrdm;
-	unsigned long flags;
-
-	read_lock_irqsave(&pwrdm_rwlock, flags);
-	list_for_each_entry(pwrdm, &pwrdm_list, node) {
-		if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
-			strcmp(pwrdm->name, "wkup_pwrdm") == 0)
-			continue;
-		if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
-			printk(KERN_ERR "pwrdm state mismatch(%s) %d != %d\n",
-			       pwrdm->name, pwrdm->state,
-			       pwrdm_read_pwrst(pwrdm));
-		seq_printf(s, "%s (%s)", pwrdm->name,
-			   pwrdm_state_names[pwrdm->state]);
-		for (i = 0; i < 4; i++) {
-			seq_printf(s, ",%s:%d", pwrdm_state_names[i],
-				pwrdm->state_counter[i]);
-		}
-		seq_printf(s, "\n");
-	}
-	read_unlock_irqrestore(&pwrdm_rwlock, flags);
-
-	return 0;
-}
-
-int pwrdm_dbg_show_timers(struct seq_file *s, void *unused)
-{
-	int i;
-	struct powerdomain *pwrdm;
-	unsigned long flags;
-
-	read_lock_irqsave(&pwrdm_rwlock, flags);
-	list_for_each_entry(pwrdm, &pwrdm_list, node) {
-		if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
-			strcmp(pwrdm->name, "wkup_pwrdm") == 0)
-			continue;
-
-		/* Update timer for current state */
-		pm_dbg_pwrdm_state_switch(pwrdm);
-
-		seq_printf(s, "%s (%s)", pwrdm->name,
-			pwrdm_state_names[pwrdm->state]);
-		for (i = 0; i < 4; i++) {
-			seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
-				pwrdm->state_timer[i]);
-		}
-		seq_printf(s, "\n");
-	}
-	read_unlock_irqrestore(&pwrdm_rwlock, flags);
-
-	return 0;
-}
-
-#endif
-- 
1.5.6.3

