From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 3/3] OMAP3 PM: Adding counters for power domain logic off and mem off during retention.
Date: Thu,  4 Feb 2010 22:17:51 +0530
Message-ID: <1265302071-7624-4-git-send-email-thara@ti.com>
References: <1265302071-7624-1-git-send-email-thara@ti.com>
 <1265302071-7624-2-git-send-email-thara@ti.com>
 <1265302071-7624-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36611 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758471Ab0BDQr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 11:47:57 -0500
In-Reply-To: <1265302071-7624-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch adds counters to keep track of whether the powerdomain
logic or software controllable memory banks are turned off when
the power domain enters retention. During power domain retention
if logic gets turned off, the scenario is known as Open Switch Retention.
Also during retention s/w controllable memory banks of a power
domain can be chosen to be kept in retention or off.

This patch adds one counter per powerdomain to track the power domain
logic state during retention. Number of memory bank state counters
added depends on the number of software controllable memory banks
of the powerdomain. To view these counters do
	cat ../debug/pm_debug/count

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm-debug.c                |    5 +++++
 arch/arm/mach-omap2/powerdomain.c             |   20 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 ++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0ce356f..c18f7f2 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -385,6 +385,11 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
 			pwrdm->state_counter[i]);
 
+	seq_printf(s, ",RET-LOGIC-OFF:%d", pwrdm->ret_logic_off_counter);
+	for (i = 0; i < pwrdm->banks; i++)
+		seq_printf(s, ",RET-MEMBANK%d-OFF:%d", i + 1,
+				pwrdm->ret_mem_off_counter[i]);
+
 	seq_printf(s, "\n");
 
 	return 0;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index e9eeaa4..34f1f6c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -125,6 +125,10 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		pwrdm->state_counter[i] = 0;
 
+	pwrdm->ret_logic_off_counter = 0;
+	for (i = 0; i < pwrdm->banks; i++)
+		pwrdm->ret_mem_off_counter[i] = 0;
+
 	pwrdm_wait_transition(pwrdm);
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
@@ -153,6 +157,22 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		prev = pwrdm_read_prev_pwrst(pwrdm);
 		if (pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
+		if (prev == PWRDM_POWER_RET) {
+			int i;
+
+			if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
+					(pwrdm_read_prev_logic_pwrst(pwrdm) ==
+					PWRDM_POWER_OFF))
+				pwrdm->ret_logic_off_counter++;
+
+			for (i = 0; i < pwrdm->banks; i++) {
+				if ((pwrdm->pwrsts_mem_ret[i] ==
+						PWRSTS_OFF_RET) &&
+						(pwrdm_read_prev_mem_pwrst(
+						pwrdm, i) == PWRDM_POWER_OFF))
+					pwrdm->ret_mem_off_counter[i]++;
+			}
+		}
 		break;
 	default:
 		return -EINVAL;
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 9b97c90..de33455 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -100,6 +100,8 @@ struct powerdomain {
 	struct list_head node;
 	int state;
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
+	unsigned ret_logic_off_counter;
+	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
-- 
1.7.0.rc1.33.g07cf0f

