From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 06/12] ARM: OMAP4: suspend: Program all domains to retention
Date: Thu, 19 Jul 2012 16:26:26 +0300
Message-ID: <1342704392-23657-7-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33557 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab2GSN1T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:27:19 -0400
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Remove the FIXME's in the suspend sequence since
we now intend to support system level RET support.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
[Jean Pihet <j-pihet@ti.com>: ported on top of the functional power
states]
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 3a484b1..1e845e8 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -97,19 +97,15 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!strncmp(pwrdm->name, "cpu", 3))
 		return 0;
 
-	/*
-	 * FIXME: Remove this check when core retention is supported
-	 * Only MPUSS power domain is added in the list.
-	 */
-	if (strcmp(pwrdm->name, "mpu_pwrdm"))
-		return 0;
 
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
 		return -ENOMEM;
 
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_FUNC_PWRST_CSWR;
+	pwrst->next_state = pwrdm_get_achievable_func_pwrst(
+						pwrdm,
+						PWRDM_FUNC_PWRST_CSWR);
 	list_add(&pwrst->node, &pwrst_list);
 
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-- 
1.7.4.1

