From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv5 9/9] OMAP3: PM: Added support for suspending to INACTIVE state
Date: Tue,  2 Feb 2010 16:52:27 +0200
Message-ID: <1265122347-2233-10-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265122347-2233-1-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-2-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-3-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-4-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-5-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-6-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-7-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-8-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-9-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25437 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab0BBNEb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 08:04:31 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D4Pth006095
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 07:04:30 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D2wJk029178
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 15:03:09 +0200
In-Reply-To: <1265122347-2233-9-git-send-email-tero.kristo@nokia.com>
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
index 7946b70..b0911f2 100644
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

