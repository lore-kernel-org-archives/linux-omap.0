From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/2] PM counter infrastructure.
Date: Wed, 15 Oct 2008 17:48:43 +0300
Message-ID: <1224082124-24439-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1224082124-24439-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16869 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbYJOOsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 10:48:50 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FEmVrS030729
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 17:48:47 +0300
In-Reply-To: <1224082124-24439-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch provides the infrastructure to count how many times a powerdomain
entered a given power state (on, inactive, retention, off). A number of
functions are provided which will be called by the chip specific powerdomain
and clockdomain code whenever a transition might have happened.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/powerdomain.c             |  101 ++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/powerdomain.h |    7 ++
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 73e2971..3a9e151 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -35,6 +35,11 @@
 #include <mach/powerdomain.h>
 #include <mach/clockdomain.h>
 
+enum {
+	PWRDM_STATE_NOW = 0,
+	PWRDM_STATE_PREV,
+};
+
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
 
@@ -102,6 +107,63 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 	return pd->pwrdm;
 }
 
+static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
+{
+
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
+	pwrdm->state = state;
+
+	return 0;
+}
+
+static int _pwrdm_pre_transition_cb(struct powerdomain *pwrdm)
+{
+	pwrdm_clear_all_prev_pwrst(pwrdm);
+	_pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
+	return 0;
+}
+
+static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm)
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
 
@@ -117,9 +179,12 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
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
@@ -1110,4 +1175,36 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
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
+int pwrdm_pre_transition(void)
+{
+	pwrdm_for_each(_pwrdm_pre_transition_cb);
+	return 0;
+}
+
+int pwrdm_post_transition(void)
+{
+	pwrdm_for_each(_pwrdm_post_transition_cb);
+	return 0;
+}
 
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 69c9e67..52663fc 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -117,6 +117,8 @@ struct powerdomain {
 
 	struct list_head node;
 
+	int state;
+	unsigned state_counter[4];
 };
 
 
@@ -164,4 +166,9 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
 
+int pwrdm_state_switch(struct powerdomain *pwrdm);
+int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
+int pwrdm_pre_transition(void);
+int pwrdm_post_transition(void);
+
 #endif
-- 
1.5.6.3

