From: jean.pihet@newoldbits.com
Subject: [PATCH 1/6] ARM: OMAP2+: PM: protect the power domain state change by a mutex
Date: Wed, 11 Apr 2012 22:46:07 +0200
Message-ID: <1334177172-28583-2-git-send-email-j-pihet@ti.com>
References: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33352 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761174Ab2DKUqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 16:46:42 -0400
Received: by wejx9 with SMTP id x9so818515wej.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 13:46:41 -0700 (PDT)
In-Reply-To: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ldc_pm_all@list.ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.c          |    8 ++++++--
 arch/arm/mach-omap2/powerdomain.c |    1 +
 arch/arm/mach-omap2/powerdomain.h |    3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d0c1c96..6918a13 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -100,15 +100,17 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
 	if (!pwrdm || IS_ERR(pwrdm))
 		return -EINVAL;
 
+	mutex_lock(&pwrdm->lock);
+
 	while (!(pwrdm->pwrsts & (1 << pwrst))) {
 		if (pwrst == PWRDM_POWER_OFF)
-			return ret;
+			goto out;
 		pwrst--;
 	}
 
 	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
 	if (next_pwrst == pwrst)
-		return ret;
+		goto out;
 
 	curr_pwrst = pwrdm_read_pwrst(pwrdm);
 	if (curr_pwrst < PWRDM_POWER_ON) {
@@ -141,6 +143,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
 		break;
 	}
 
+out:
+	mutex_unlock(&pwrdm->lock);
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 96ad3dbe..319b277 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -102,6 +102,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	INIT_LIST_HEAD(&pwrdm->voltdm_node);
 	voltdm_add_pwrdm(voltdm, pwrdm);
 
+	mutex_init(&pwrdm->lock);
 	list_add(&pwrdm->node, &pwrdm_list);
 
 	/* Initialize the powerdomain's state counter */
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..6c6567d 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -19,7 +19,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-
+#include <linux/mutex.h>
 #include <linux/atomic.h>
 
 #include <plat/cpu.h>
@@ -116,6 +116,7 @@ struct powerdomain {
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
 	struct list_head node;
 	struct list_head voltdm_node;
+	struct mutex lock;
 	int state;
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
 	unsigned ret_logic_off_counter;
-- 
1.7.7.6

