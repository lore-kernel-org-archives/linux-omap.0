From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv7 7/7] OMAP3: PM: Added support for suspending to INACTIVE state
Date: Fri, 12 Mar 2010 17:39:17 +0200
Message-ID: <1268408357-15621-7-git-send-email-tero.kristo@nokia.com>
References: <>
 <1268408357-15621-1-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-2-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-3-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-4-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-5-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-6-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53983 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757962Ab0CLNyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 08:54:45 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsgGo009081
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 07:54:44 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsV8o003701
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 15:54:38 +0200
In-Reply-To: <1268408357-15621-6-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

With the new support functions this is now possible. Suspending to INACTIVE
is useful for testing purposes.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 78b0926..054ec67 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -625,9 +625,11 @@ int omap3_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 	return data->next_state;
 }
 
-/* This sets pwrdm state (other than mpu & core. Currently only ON &
- * RET are supported. Function is assuming that clkdm doesn't have
- * hw_sup mode enabled. */
+/*
+ * This sets pwrdm state, used for suspend target state control and
+ * switching off-mode. Function is assuming that clkdm doesn't have
+ * hw_sup mode enabled.
+ */
 int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
@@ -637,11 +639,12 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (pwrdm == NULL || IS_ERR(pwrdm))
 		return -EINVAL;
 
-	while (!(pwrdm->pwrsts & (1 << state))) {
-		if (state == PWRDM_POWER_OFF)
-			return ret;
-		state--;
-	}
+	if (state != PWRDM_POWER_INACTIVE)
+		while (!(pwrdm->pwrsts & (1 << state))) {
+			if (state == PWRDM_POWER_OFF)
+				return ret;
+			state--;
+		}
 
 	cur_state = pwrdm_read_next_pwrst(pwrdm);
 	if (cur_state == state)
-- 
1.5.4.3

