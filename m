From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv6 9/9] OMAP3: PM: Added support for suspending to INACTIVE state
Date: Fri, 12 Feb 2010 20:27:45 +0200
Message-ID: <1265999265-4363-10-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-3-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-4-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-5-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-6-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-7-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-8-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-9-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53946 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179Ab0BLQjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:39:48 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGddEA031375
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:46 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdVM2021112
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:42 +0200
In-Reply-To: <1265999265-4363-9-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

With the new support functions this is now possible. Suspending to INACTIVE
is useful for testing purposes.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index cdbedcf..41d6cc3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -633,11 +633,12 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
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

