From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 7/8] ARM: OMAP2+: powerdomain: add error logs
Date: Wed, 15 Aug 2012 12:02:47 +0200
Message-ID: <1345024968-28951-8-git-send-email-j-pihet@ti.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41567 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab2HOKDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 06:03:18 -0400
Received: by weyx8 with SMTP id x8so884341wey.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 03:03:17 -0700 (PDT)
In-Reply-To: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>

From: Nishanth Menon <nm@ti.com>

Silent failure makes debug hard. So, provide rate limited error
messages in functional and oft-used code to prevent spam
when something goes wrong..

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   72 +++++++++++++++++++++++++++++-------
 1 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 06a566b..691247e 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/ratelimit.h>
 #include <trace/events/power.h>
 
 #include "cm2xxx_3xxx.h"
@@ -146,8 +147,12 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 
 	int prev, next, state, trace_state;
 
-	if (pwrdm == NULL)
+	if (pwrdm == NULL) {
+		WARN_ONCE(1, "null pwrdm\n");
+		pr_err_ratelimited("%s: powerdomain: null pwrdm param\n",
+				   __func__);
 		return -EINVAL;
+	}
 
 	state = pwrdm_read_fpwrst(pwrdm);
 
@@ -174,6 +179,8 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		}
 		break;
 	default:
+		pr_err_ratelimited("%s: powerdomain %s: bad flag %d\n",
+				   __func__, pwrdm->name, flag);
 		return -EINVAL;
 	}
 
@@ -690,7 +697,8 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
 	unsigned long flags;
 
 	if (!pwrdm || IS_ERR(pwrdm)) {
-		pr_debug("%s: invalid params: pwrdm=%p\n", __func__, pwrdm);
+		pr_err_ratelimited("%s: invalid params: pwrdm=%p\n",
+				   __func__, pwrdm);
 		return -EINVAL;
 	}
 
@@ -775,8 +783,11 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (!(pwrdm->pwrsts & (1 << pwrst)))
+	if (!(pwrdm->pwrsts & (1 << pwrst))) {
+		pr_err_ratelimited("%s: powerdomain %s: bad pwrst %d\n",
+				   __func__, pwrdm->name, pwrst);
 		return -EINVAL;
+	}
 
 	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
@@ -924,8 +935,11 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (!(pwrdm->pwrsts_logic_ret & (1 << pwrst)))
+	if (!(pwrdm->pwrsts_logic_ret & (1 << pwrst))) {
+		pr_err_ratelimited("%s: powerdomain %s: bad pwrst %d\n",
+				   __func__, pwrdm->name, pwrst);
 		return -EINVAL;
+	}
 
 	pr_debug("powerdomain: setting next logic powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
@@ -958,11 +972,17 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (pwrdm->banks < (bank + 1))
+	if (pwrdm->banks < (bank + 1)) {
+		pr_err_ratelimited("%s: powerdomain %s: bad bank %d\n",
+				   __func__, pwrdm->name, bank);
 		return -EEXIST;
+	}
 
-	if (!(pwrdm->pwrsts_mem_on[bank] & (1 << pwrst)))
+	if (!(pwrdm->pwrsts_mem_on[bank] & (1 << pwrst))) {
+		pr_err_ratelimited("%s: powerdomain %s: bank %d bad pwrst %d\n",
+				   __func__, pwrdm->name, bank, pwrst);
 		return -EINVAL;
+	}
 
 	pr_debug("powerdomain: setting next memory powerstate for domain %s "
 		 "bank %0x while pwrdm-ON to %0x\n", pwrdm->name, bank, pwrst);
@@ -996,11 +1016,17 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (pwrdm->banks < (bank + 1))
+	if (pwrdm->banks < (bank + 1)) {
+		pr_err_ratelimited("%s: powerdomain %s: bad bank %d\n",
+				   __func__, pwrdm->name, bank);
 		return -EEXIST;
+	}
 
-	if (!(pwrdm->pwrsts_mem_ret[bank] & (1 << pwrst)))
+	if (!(pwrdm->pwrsts_mem_ret[bank] & (1 << pwrst))) {
+		pr_err_ratelimited("%s: powerdomain %s: bank %d bad pwrst %d\n",
+				   __func__, pwrdm->name, bank, pwrst);
 		return -EINVAL;
+	}
 
 	pr_debug("powerdomain: setting next memory powerstate for domain %s "
 		 "bank %0x while pwrdm-RET to %0x\n", pwrdm->name, bank, pwrst);
@@ -1092,8 +1118,11 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (!pwrdm)
 		return ret;
 
-	if (pwrdm->banks < (bank + 1))
+	if (pwrdm->banks < (bank + 1)) {
+		pr_err_ratelimited("%s: powerdomain %s: bad bank %d\n",
+				   __func__, pwrdm->name, bank);
 		return ret;
+	}
 
 	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
 		bank = 1;
@@ -1122,8 +1151,11 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (!pwrdm)
 		return ret;
 
-	if (pwrdm->banks < (bank + 1))
+	if (pwrdm->banks < (bank + 1)) {
+		pr_err_ratelimited("%s: powerdomain %s: bad bank %d\n",
+				   __func__, pwrdm->name, bank);
 		return ret;
+	}
 
 	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
 		bank = 1;
@@ -1151,8 +1183,11 @@ int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 	if (!pwrdm)
 		return ret;
 
-	if (pwrdm->banks < (bank + 1))
+	if (pwrdm->banks < (bank + 1)) {
+		pr_err_ratelimited("%s: powerdomain %s: bad bank %d\n",
+				   __func__, pwrdm->name, bank);
 		return ret;
+	}
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_retst)
 		ret = arch_pwrdm->pwrdm_read_mem_retst(pwrdm, bank);
@@ -1208,8 +1243,11 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return ret;
 
-	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
+	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR)) {
+		pr_err_ratelimited("%s: powerdomain %s: no HDSAR in flag %d\n",
+				   __func__, pwrdm->name, pwrdm->flags);
 		return ret;
+	}
 
 	pr_debug("powerdomain: %s: setting SAVEANDRESTORE bit\n",
 		 pwrdm->name);
@@ -1238,8 +1276,11 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return ret;
 
-	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
+	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR)) {
+		pr_err_ratelimited("%s: powerdomain %s: no HDSAR in flag %d\n",
+				   __func__, pwrdm->name, pwrdm->flags);
 		return ret;
+	}
 
 	pr_debug("powerdomain: %s: clearing SAVEANDRESTORE bit\n",
 		 pwrdm->name);
@@ -1279,8 +1320,11 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE))
+	if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
+		pr_err_ratelimited("%s: powerdomain %s:no lowpwrch in flag%d\n",
+				   __func__, pwrdm->name, pwrdm->flags);
 		return -EINVAL;
+	}
 
 	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
 		 pwrdm->name);
-- 
1.7.7.6

