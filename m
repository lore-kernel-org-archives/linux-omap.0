From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 4/5] Make counter types unsigned, add closure pointer to pwrdm_for_each, add prototypes
Date: Wed, 24 Sep 2008 17:11:57 +0300
Message-ID: <1222265518-7230-5-git-send-email-peter.de-schrijver@nokia.com>
References: <1222265518-7230-1-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-2-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-3-git-send-email-peter.de-schrijver@nokia.com>
 <1222265518-7230-4-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58174 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYIXONB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:13:01 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8OECiaO013899
	for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 17:12:59 +0300
In-Reply-To: <1222265518-7230-4-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/plat-omap/include/mach/powerdomain.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 7c3dbb3..c8f194b 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -116,9 +116,10 @@ struct powerdomain {
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
 
 	struct list_head node;
-#ifdef CONFIG_PM_DEBUG
+
 	int state;
-	int state_counter[4];
+	unsigned state_counter[4];
+#ifdef CONFIG_PM_DEBUG
 	s64 timer;
 	s64 state_timer[4];
 #endif
@@ -131,7 +132,8 @@ int pwrdm_register(struct powerdomain *pwrdm);
 int pwrdm_unregister(struct powerdomain *pwrdm);
 struct powerdomain *pwrdm_lookup(const char *name);
 
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
 
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
@@ -169,4 +171,9 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
 
+int pwrdm_state_switch(struct powerdomain *pwrdm);
+int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
+int pwrdm_pre_suspend(void);
+int pwrdm_post_suspend(void);
+
 #endif
-- 
1.5.6.3

