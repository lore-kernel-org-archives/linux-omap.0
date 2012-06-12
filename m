From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 19/20] ARM: OMAP4: PM: enable off mode by default
Date: Tue, 12 Jun 2012 18:31:34 +0300
Message-ID: <1339515095-9908-20-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38422 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab2FLPc0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:32:26 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

System will now enter device off by default during suspend.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 341655e..8054afc 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -114,7 +114,11 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	pwrst->pwrdm = pwrdm;
 	pwrst->next_state = pwrdm_get_achievable_func_pwrst(
 						pwrdm,
-						PWRDM_FUNC_PWRST_OSWR);
+						PWRDM_FUNC_PWRST_OFF);
+
+	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE)
+		pwrst->next_state = PWRDM_FUNC_PWRST_OFF;
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-- 
1.7.4.1

