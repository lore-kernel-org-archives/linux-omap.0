From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 3/3] Hook into powerdomain code
Date: Tue, 14 Oct 2008 17:39:58 +0300
Message-ID: <1223995198-19985-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223995198-19985-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223995198-19985-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58198 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYJNOkj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 10:40:39 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EEeIZ6011899
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 17:40:37 +0300
In-Reply-To: <1223995198-19985-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Make the powerdomain code call the new hook for updating the time. 
Also implement the updated pwrdm_for_each.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/powerdomain.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 349b7ab..0334609 100644
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
+			void *user)
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
@@ -1195,13 +1203,13 @@ int pwrdm_clk_state_switch(struct clk *clk)
 
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
 
-- 
1.5.6.3

