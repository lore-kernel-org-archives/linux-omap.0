From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/7] OMAP2+: PM: idle clkdms only if already in idle
Date: Fri, 24 Jun 2011 14:06:30 +0200
Message-ID: <1308917193-16912-5-git-send-email-b-cousson@ti.com>
References: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab1FXMIk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 08:08:40 -0400
In-Reply-To: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

From: Nayak, Rajendra <rnayak@ti.com>

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
index d48813f..840b0e1 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -108,6 +108,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	u32 cur_state;
 	int sleep_switch = -1;
 	int ret = 0;
+	int hwsup = 0;
 
 	if (pwrdm == NULL || IS_ERR(pwrdm))
 		return -EINVAL;
@@ -127,6 +128,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
 			sleep_switch = LOWPOWERSTATE_SWITCH;
 		} else {
+			hwsup = clkdm_is_idle(pwrdm->pwrdm_clkdms[0]);
 			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
 			pwrdm_wait_transition(pwrdm);
 			sleep_switch = FORCEWAKEUP_SWITCH;
@@ -142,7 +144,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
-		if (pwrdm->pwrdm_clkdms[0]->flags & CLKDM_CAN_ENABLE_AUTO)
+		if (hwsup)
 			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		else
 			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
-- 
1.7.0.4

