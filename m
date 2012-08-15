From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 3/8] ARM: OMAP2+: PM: add a lock to protect the powerdomains next state
Date: Wed, 15 Aug 2012 12:02:43 +0200
Message-ID: <1345024968-28951-4-git-send-email-j-pihet@ti.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37506 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2HOKDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 06:03:14 -0400
Received: by weyx8 with SMTP id x8so884296wey.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 03:03:13 -0700 (PDT)
In-Reply-To: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

pwrdm_set_next_fpwrst and pwrdm_read_next_fpwrst are intented
to be the only API to program and request the next state of a power
domain.
This patch protects the power domain next state settings and structs
from concurrent accesses by the use of a lock.

A spinlock is used since pwrdm_set_next_fpwrst and
pwrdm_read_next_fpwrst can be called from atomic context
(.i.e) either from cpuidle path or suspend path.

[ambresh@ti.com: reported the atomic context issue and suggested
to replace the mutex with a spinlock]

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reported-by: Ambresh K <ambresh@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   36 +++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/powerdomain.h |    3 +++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 3a1f56c..a8f7a81 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -102,6 +102,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	INIT_LIST_HEAD(&pwrdm->voltdm_node);
 	voltdm_add_pwrdm(voltdm, pwrdm);
 
+	spin_lock_init(&pwrdm->lock);
 	list_add(&pwrdm->node, &pwrdm_list);
 
 	/* Initialize the powerdomain's state counter */
@@ -601,6 +602,22 @@ int pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
 }
 
 /**
+ * _pwrdm_read_next_fpwrst - get next powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain @pwrdm's next functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns
+ * the next power state upon success.
+ */
+int _pwrdm_read_next_fpwrst(struct powerdomain *pwrdm)
+{
+	int next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	int next_logic = pwrdm_read_logic_retst(pwrdm);
+
+	return pwrdm_pwrst_to_fpwrst(pwrdm, next_pwrst, next_logic);
+}
+
+/**
  * pwrdm_get_achievable_fpwrst() - Provide achievable functional state
  * @pwrdm: struct powerdomain * to set
  * @fpwrst: minimum functional state we would like to hit
@@ -670,6 +687,7 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
 	int sleep_switch = -1, ret = 0, hwsup = 0;
 	int new_fpwrst, next_fpwrst, pwrst, logic;
 	u8 curr_pwrst;
+	unsigned long flags;
 
 	if (!pwrdm || IS_ERR(pwrdm)) {
 		pr_debug("%s: invalid params: pwrdm=%p\n", __func__, pwrdm);
@@ -678,13 +696,15 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
 
 	pr_debug("%s(%s, fpwrst=%0x)\n", __func__, pwrdm->name, fpwrst);
 
+	spin_lock_irqsave(&pwrdm->lock, flags);
+
 	new_fpwrst = pwrdm_get_achievable_fpwrst(pwrdm, fpwrst);
 	pwrst = pwrdm_fpwrst_to_pwrst(pwrdm, new_fpwrst);
 	logic = pwrdm_fpwrst_to_logic_pwrst(pwrdm, new_fpwrst);
 
-	next_fpwrst = pwrdm_read_next_fpwrst(pwrdm);
+	next_fpwrst = _pwrdm_read_next_fpwrst(pwrdm);
 	if (new_fpwrst == next_fpwrst)
-		return ret;
+		goto out;
 
 	curr_pwrst = pwrdm_read_pwrst(pwrdm);
 	if (curr_pwrst < PWRDM_POWER_ON) {
@@ -732,6 +752,8 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
 		break;
 	}
 
+out:
+	spin_unlock_irqrestore(&pwrdm->lock, flags);
 	return ret;
 }
 
@@ -801,10 +823,14 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm)
 {
-	int next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	int next_logic = pwrdm_read_logic_retst(pwrdm);
+	int ret;
+	unsigned long flags;
 
-	return pwrdm_pwrst_to_fpwrst(pwrdm, next_pwrst, next_logic);
+	spin_lock_irqsave(&pwrdm->lock, flags);
+	ret = _pwrdm_read_next_fpwrst(pwrdm);
+	spin_unlock_irqrestore(&pwrdm->lock, flags);
+
+	return ret;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 45c449d..23b9da9 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
+#include <linux/spinlock.h>
 #include <linux/atomic.h>
 
 #include <plat/cpu.h>
@@ -109,6 +110,7 @@ struct powerdomain;
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
+ * @lock: powerdomain next state registers protection lock
  * @pwrstctrl_offs: (AM33XX only) XXX_PWRSTCTRL reg offset from prcm_offs
  * @pwrstst_offs: (AM33XX only) XXX_PWRSTST reg offset from prcm_offs
  * @logicretstate_mask: (AM33XX only) mask for logic retention bitfield
@@ -142,6 +144,7 @@ struct powerdomain {
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
 	struct list_head node;
 	struct list_head voltdm_node;
+	spinlock_t lock;
 	int state;
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
 	unsigned ret_logic_off_counter;
-- 
1.7.7.6

