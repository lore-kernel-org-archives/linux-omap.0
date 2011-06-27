From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 4/8] OMAP2+: PM: idle clkdms only if already in idle
Date: Mon, 27 Jun 2011 18:11:39 +0200
Message-ID: <1309191103-8817-5-git-send-email-b-cousson@ti.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39702 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab1F0QM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 12:12:56 -0400
In-Reply-To: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, toddpoynor@google.com

From: Rajendra Nayak <rnayak@ti.com>

The omap_set_pwrdm_state function forces clockdomains
to idle, without checking the existing idle state
programmed, instead based solely on the HW capability
of the clockdomain to support idle.
This is wrong and the clockdomains should be idled
post a state_switch *only* if idle transitions on the
clockdomain were already enabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d48813f..ce1a9f3 100644
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
+			hwsup = clkdm_allows_idle(pwrdm->pwrdm_clkdms[0]);
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

