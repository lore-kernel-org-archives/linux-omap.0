From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/3] power off on state counter infrastructure
Date: Thu, 24 Jul 2008 16:00:33 +0300
Message-ID: <1216904434-7545-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
 <1216904434-7545-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24021 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYGXNA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2008 09:00:56 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6OD0o9d021150
	for <linux-omap@vger.kernel.org>; Thu, 24 Jul 2008 08:00:54 -0500
In-Reply-To: <1216904434-7545-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/powerdomain.c       |   48 +++++++++++++++++++++++++++++-
 include/asm-arm/arch-omap/powerdomain.h |    9 +++++-
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 7615f9d..721f73c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -102,6 +102,27 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 	return pd->pwrdm;
 }
 
+static int pwr_domain_save_state_cb(struct powerdomain *pwrdm, void *user)
+{
+	pwrdm_save_state(pwrdm);
+
+	return 0;
+}
+
+static int pwr_domain_count_off_mode_cb(struct powerdomain *pwrdm, void *user)
+{
+	int prev;
+
+	prev = pwrdm_read_prev_pwrst(pwrdm);
+
+	if (prev != PWRDM_POWER_OFF && pwrdm->state != prev)
+		 pwrdm->offstate_count++;
+
+	pwrdm->state = pwrdm_read_pwrst(pwrdm);
+
+	return 0;
+}
+
 
 /* Public functions */
 
@@ -217,7 +238,7 @@ struct powerdomain *pwrdm_lookup(const char *name)
  * anything else to indicate failure; or -EINVAL if the function
  * pointer is null.
  */
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user), void *user)
 {
 	struct powerdomain *temp_pwrdm;
 	unsigned long flags;
@@ -228,7 +249,7 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
 
 	read_lock_irqsave(&pwrdm_rwlock, flags);
 	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
-		ret = (*fn)(temp_pwrdm);
+		ret = (*fn)(temp_pwrdm, user);
 		if (ret)
 			break;
 	}
@@ -1110,4 +1131,27 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+void pwrdm_save_state(struct powerdomain *pwrdm)
+{
+	pwrdm->state = pwrdm_read_pwrst(pwrdm);
+}
+
+void pwrdm_check_off_mode(struct powerdomain *pwrdm)
+{
+	int state;
+
+	state = pwrdm_read_pwrst(pwrdm);
+	if (pwrdm->state == PWRDM_POWER_OFF && state == PWRDM_POWER_ON)
+		pwrdm->offstate_count++;
+}
+
+void pwrdm_save_state_all(void)
+{
+	pwrdm_for_each(pwr_domain_save_state_cb, NULL);
+}
+
+void pwrdm_count_off_mode(void)
+{
+	pwrdm_for_each(pwr_domain_count_off_mode_cb, NULL);
+}
 
diff --git a/include/asm-arm/arch-omap/powerdomain.h b/include/asm-arm/arch-omap/powerdomain.h
index 1cd8942..19ad6fd 100644
--- a/include/asm-arm/arch-omap/powerdomain.h
+++ b/include/asm-arm/arch-omap/powerdomain.h
@@ -117,6 +117,8 @@ struct powerdomain {
 
 	struct list_head node;
 
+	int state;
+	u32 offstate_count;
 };
 
 
@@ -126,7 +128,8 @@ int pwrdm_register(struct powerdomain *pwrdm);
 int pwrdm_unregister(struct powerdomain *pwrdm);
 struct powerdomain *pwrdm_lookup(const char *name);
 
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
 
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
@@ -165,4 +168,8 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
 
+void pwrdm_save_state(struct powerdomain *pwrdm);
+void pwrdm_check_off_mode(struct powerdomain *pwrdm);
+void pwrdm_save_state_all(void);
+void pwrdm_count_off_mode(void);
 #endif
-- 
1.5.6.3

