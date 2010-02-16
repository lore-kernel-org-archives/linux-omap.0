From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/19] OMAP3 PM: Adding counters for power domain logic off
	and mem off during retention.
Date: Mon, 15 Feb 2010 18:24:48 -0700
Message-ID: <20100216012447.1101.72353.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57413 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489Ab0BPB06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:58 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

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
[paul@pwsan.com: conditional expressions simplified; counter increment
 code moved to its own function]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm-debug.c                |    5 +++++
 arch/arm/mach-omap2/powerdomain.c             |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 ++
 3 files changed, 32 insertions(+), 0 deletions(-)

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
index e9eeaa4..9a0fb38 100644
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
@@ -134,6 +138,25 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	return 0;
 }
 
+static void _update_logic_membank_counters(struct powerdomain *pwrdm)
+{
+	int i;
+	u8 prev_logic_pwrst, prev_mem_pwrst;
+
+	prev_logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
+	if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
+	    (prev_logic_pwrst == PWRDM_POWER_OFF))
+		pwrdm->ret_logic_off_counter++;
+
+	for (i = 0; i < pwrdm->banks; i++) {
+		prev_mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
+
+		if ((pwrdm->pwrsts_mem_ret[i] == PWRSTS_OFF_RET) &&
+		    (prev_mem_pwrst == PWRDM_POWER_OFF))
+			pwrdm->ret_mem_off_counter[i]++;
+	}
+}
+
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
@@ -153,6 +176,8 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		prev = pwrdm_read_prev_pwrst(pwrdm);
 		if (pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
+		if (prev == PWRDM_POWER_RET)
+			_update_logic_membank_counters(pwrdm);
 		break;
 	default:
 		return -EINVAL;
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 6657ff2..d82b2c0 100644
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


