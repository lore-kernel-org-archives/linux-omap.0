From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/4] OMAP2+: PM: idle clkdms only if already in idle
Date: Tue,  5 Apr 2011 18:14:57 +0530
Message-ID: <1302007497-10525-5-git-send-email-rnayak@ti.com>
References: <1302007497-10525-1-git-send-email-rnayak@ti.com>
 <1302007497-10525-2-git-send-email-rnayak@ti.com>
 <1302007497-10525-3-git-send-email-rnayak@ti.com>
 <1302007497-10525-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43377 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1DEMpT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 08:45:19 -0400
In-Reply-To: <1302007497-10525-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

The omap_set_pwrdm_state function forces clockdomains
to idle, without checking the existing idle state
programmed, instead based solely on the HW capability
of the clockdomain to support idle.
This is wrong and the clockdomains should be idled
post a state_switch *only* if idle transitions on the
clockdomain were already enabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 04b6da7..b1190c4 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -107,6 +107,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	u32 cur_state;
 	int sleep_switch = -1;
 	int ret = 0;
+	int hwsup = 0;
 
 	if (pwrdm == NULL || IS_ERR(pwrdm))
 		return -EINVAL;
@@ -126,6 +127,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
 			sleep_switch = LOWPOWERSTATE_SWITCH;
 		} else {
+			hwsup = clkdm_is_idle(pwrdm->pwrdm_clkdms[0]);
 			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
 			pwrdm_wait_transition(pwrdm);
 			sleep_switch = FORCEWAKEUP_SWITCH;
@@ -141,7 +143,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
-		if (pwrdm->pwrdm_clkdms[0]->flags & CLKDM_CAN_ENABLE_AUTO)
+		if (hwsup)
 			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		else
 			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
-- 
1.7.0.4

