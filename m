From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 09/14] ARM: OMAP2: Drop the concept of certain power domains not being able to lose context.
Date: Thu, 12 Apr 2018 09:23:54 +0530
Message-ID: <1523505239-16229-10-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <Russ.Dill@ti.com>

It isn't much of a win, and with hibernation, everything loses context.
So Drop the concept of certain power domains not being able to lose
context.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c | 41 ---------------------------------------
 arch/arm/mach-omap2/powerdomain.h |  1 -
 2 files changed, 42 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index ee693f6..f180d22 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1160,47 +1160,6 @@ int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 }
 
 /**
- * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
- * @pwrdm: struct powerdomain *
- *
- * Given a struct powerdomain * @pwrdm, returns 1 if the powerdomain
- * can lose either memory or logic context or if @pwrdm is invalid, or
- * returns 0 otherwise.  This function is not concerned with how the
- * powerdomain registers are programmed (i.e., to go off or not); it's
- * concerned with whether it's ever possible for this powerdomain to
- * go off while some other part of the chip is active.  This function
- * assumes that every powerdomain can go to either ON or INACTIVE.
- */
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
-{
-	int i;
-
-	if (!pwrdm) {
-		pr_debug("powerdomain: %s: invalid powerdomain pointer\n",
-			 __func__);
-		return 1;
-	}
-
-	if (pwrdm->pwrsts & PWRSTS_OFF)
-		return 1;
-
-	if (pwrdm->pwrsts & PWRSTS_RET) {
-		if (pwrdm->pwrsts_logic_ret & PWRSTS_OFF)
-			return 1;
-
-		for (i = 0; i < pwrdm->banks; i++)
-			if (pwrdm->pwrsts_mem_ret[i] & PWRSTS_OFF)
-				return 1;
-	}
-
-	for (i = 0; i < pwrdm->banks; i++)
-		if (pwrdm->pwrsts_mem_on[i] & PWRSTS_OFF)
-			return 1;
-
-	return 0;
-}
-
-/**
  * pwrdm_save_context - save powerdomain registers
  *
  * Register state is going to be lost due to a suspend or hibernate
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 9a907fb..a5bdc28 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -247,7 +247,6 @@ u8 pwrdm_get_valid_lp_state(struct powerdomain *pwrdm,
 int pwrdm_pre_transition(struct powerdomain *pwrdm);
 int pwrdm_post_transition(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
 
-- 
1.9.1
