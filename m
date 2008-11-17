From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] OMAP3: PM: Check in set_pwrdm_state that target state is supported by pwrdm v2
Date: Mon, 17 Nov 2008 10:18:01 +0200
Message-ID: <1226909881-12415-1-git-send-email-jouni.hogander@nokia.com>
References: <alpine.DEB.2.00.0811142026040.16502@utopia.booyaka.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30215 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYKQISQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2008 03:18:16 -0500
In-Reply-To: <alpine.DEB.2.00.0811142026040.16502@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Check that wanted sleep state is supported by powerdomain. If it is
not supported, then use next lowest supported state.

Check also on suspend that state of pwrdm was lower or equal.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index da098d2..9f5a544 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -239,8 +239,13 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (pwrdm == NULL || IS_ERR(pwrdm))
 		return -EINVAL;
 
-	cur_state = pwrdm_read_next_pwrst(pwrdm);
+	while (!(pwrdm->pwrsts & (1 << state))) {
+		if (state == PWRDM_POWER_OFF)
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

