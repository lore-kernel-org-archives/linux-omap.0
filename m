From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] OMAP3: PM: Check in set_pwrdm_state that target state is supported by pwrdm
Date: Fri, 14 Nov 2008 10:38:43 +0200
Message-ID: <1226651923-5682-1-git-send-email-jouni.hogander@nokia.com>
References: <491A0082.4040807@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33019 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbYKNIjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 03:39:18 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAE8dCTj003419
	for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 10:39:16 +0200
In-Reply-To: <491A0082.4040807@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Check that wanted sleep state is supported by powerdomain. If it is
not supported, then use next lowest supported state.

Check also on suspend that state of pwrdm was lower or equal.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index da098d2..babead5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -239,8 +239,13 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (pwrdm == NULL || IS_ERR(pwrdm))
 		return -EINVAL;
 
-	cur_state = pwrdm_read_next_pwrst(pwrdm);
+	while (!(pwrdm->pwrsts & (1 << state))) {
+		if (state < PWRDM_POWER_OFF)
+			return ret;
+		state--;
+	}
 
+	cur_state = pwrdm_read_next_pwrst(pwrdm);
 	if (cur_state == state)
 		return ret;
 
@@ -314,7 +319,7 @@ restore:
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
-		if (state != pwrst->next_state) {
+		if (state > pwrst->next_state) {
 			printk(KERN_INFO "Powerdomain (%s) didn't enter "
 			       "target state %d\n",
 			       pwrst->pwrdm->name, pwrst->next_state);
-- 
1.6.0.1

