From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 7/8] ARM: OMAP4: PM: Add next_logic_state param to power_state
Date: Fri, 20 Apr 2012 12:19:50 +0300
Message-ID: <1334913591-26312-8-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52318 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab2DTJUV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:20:21 -0400
In-Reply-To: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This will make it easier to handle next logic states for power domains
during suspend. With this patch, the parameter is also programmed to
retention for every powerdomain, thus all powerdomains enter CSWR
state after this patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 31990d5..cc85576 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -26,6 +26,7 @@
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
+	u32 next_logic_state;
 #ifdef CONFIG_SUSPEND
 	u32 saved_state;
 	u32 saved_logic_state;
@@ -51,7 +52,7 @@ static int omap4_pm_suspend(void)
 	/* Set targeted power domain states by suspend */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-		pwrdm_set_logic_retst(pwrst->pwrdm, PWRDM_POWER_OFF);
+		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->next_logic_state);
 	}
 
 	/*
@@ -108,6 +109,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 
 	pwrst->pwrdm = pwrdm;
 	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_logic_state = PWRDM_POWER_RET;
 	list_add(&pwrst->node, &pwrst_list);
 
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-- 
1.7.4.1

