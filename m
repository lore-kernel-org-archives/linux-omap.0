From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP2+: Powerdomain: Fix unchecked dereference of arch_pwrdm
Date: Wed, 27 Nov 2013 17:27:17 +0530
Message-ID: <1385553437-22568-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60064 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab3K0L5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 06:57:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, nm@ti.com, dan.carpenter@oracle.com, Rajendra Nayak <rnayak@ti.com>

Commit 'cd8abed' "ARM: OMAP2+: Powerdomain: Remove the need to
always have a voltdm associated to a pwrdm" leads to the following
Smatch complaint:

arch/arm/mach-omap2/powerdomain.c:131 _pwrdm_register()
	 error: we previously assumed 'arch_pwrdm' could be null (see line 105)

So, fix the unchecked dereference of arch_pwrdm.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index e233dfc..93a2a6e 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -128,7 +128,8 @@ skip_voltdm:
 	for (i = 0; i < pwrdm->banks; i++)
 		pwrdm->ret_mem_off_counter[i] = 0;
 
-	arch_pwrdm->pwrdm_wait_transition(pwrdm);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_wait_transition)
+		arch_pwrdm->pwrdm_wait_transition(pwrdm);
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
 
-- 
1.7.9.5

