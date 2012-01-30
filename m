From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()
Date: Mon, 30 Jan 2012 02:43:18 -0700
Message-ID: <20120130094317.11027.82072.stgit@dusk>
References: <20120130093931.11027.31048.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48278 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2A3Jya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 04:54:30 -0500
In-Reply-To: <20120130093931.11027.31048.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Clean up a few different parts of omap_set_pwrdm_state():

- Remove a superfluous call to pwrdm_state_switch().  Not needed
  unless LOWPOWERSTATECHANGE is used, because the state switch code is
  called by either clkdm_sleep() or clkdm_allow_idle().

- Add code to wait for the power state transition in the OMAP4+ low
  power state change.  This is speculative, so I would particularly
  appreciate feedback on this part.

- Remove a superfluous call to pwrdm_read_pwrst().

- Update variable names to be more meaningful (hopefully) and precise.

- Fix an error path bug that would not place the clockdomain back into
  hardware-supervised idle or sleep mode if the power state could not
  be programmed.

The documentation for this function still needs major improvements;
that's left for a later patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..137d2d9 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -72,28 +72,27 @@ static void omap2_init_processor_devices(void)
  * This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported.
  */
-int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
+int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
 {
-	u32 cur_state;
-	int sleep_switch = -1;
-	int ret = 0;
-	int hwsup = 0;
+	u8 curr_pwrst, next_pwrst;
+	int sleep_switch = -1, ret = 0, hwsup = 0;
 
-	if (pwrdm == NULL || IS_ERR(pwrdm))
+	if (!pwrdm || IS_ERR(pwrdm))
 		return -EINVAL;
 
-	while (!(pwrdm->pwrsts & (1 << state))) {
-		if (state == PWRDM_POWER_OFF)
+	while (!(pwrdm->pwrsts & (1 << pwrst))) {
+		if (pwrst == PWRDM_POWER_OFF)
 			return ret;
-		state--;
+		pwrst--;
 	}
 
-	cur_state = pwrdm_read_next_pwrst(pwrdm);
-	if (cur_state == state)
+	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	if (next_pwrst == pwrst)
 		return ret;
 
-	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
-		if ((pwrdm_read_pwrst(pwrdm) > state) &&
+	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	if (curr_pwrst < PWRDM_POWER_ON) {
+		if ((curr_pwrst > pwrst) &&
 			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
 			sleep_switch = LOWPOWERSTATE_SWITCH;
 		} else {
@@ -103,12 +102,10 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		}
 	}
 
-	ret = pwrdm_set_next_pwrst(pwrdm, state);
-	if (ret) {
-		pr_err("%s: unable to set state of powerdomain: %s\n",
+	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+	if (ret)
+		pr_err("%s: unable to set power state of powerdomain: %s\n",
 		       __func__, pwrdm->name);
-		goto err;
-	}
 
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
@@ -119,13 +116,11 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		break;
 	case LOWPOWERSTATE_SWITCH:
 		pwrdm_set_lowpwrstchange(pwrdm);
+		pwrdm_wait_transition(pwrdm);
+		pwrdm_state_switch(pwrdm);
 		break;
-	default:
-		return ret;
 	}
 
-	pwrdm_state_switch(pwrdm);
-err:
 	return ret;
 }
 


