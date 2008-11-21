From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] PM: Fix compile error
Date: Fri, 21 Nov 2008 13:08:38 +0530
Message-ID: <1227253118-32169-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60087 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbYKUHir (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 02:38:47 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAL7cddT022976
	for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 01:38:45 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Function pm_dbg_update_time() is defined in within
an #ifdef CONFIG_DEBUG_FS; leading to this error:

arch/arm/mach-omap2/built-in.o: In function `_pwrdm_state_switch':
/db/psp_git/users/a0756819/omap-kern-latest/arch/arm/mach-omap2/powerdomain.c:139: undefined reference to `pm_dbg_update_time'

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 0334609..081b3b6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -136,7 +136,9 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 	if (state != prev)
 		pwrdm->state_counter[state]++;
 
+#ifdef CONFIG_DEBUG_FS
 	pm_dbg_update_time(pwrdm, prev);
+#endif
 
 	pwrdm->state = state;
 
-- 
1.5.6

