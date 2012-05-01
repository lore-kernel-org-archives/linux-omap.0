From: jean.pihet@newoldbits.com
Subject: [PATCH 2/5] ARM: OMAP2+: PM: use the power domains registers cache for the power states
Date: Tue,  1 May 2012 15:07:40 +0200
Message-ID: <1335877663-32649-3-git-send-email-j-pihet@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45379 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab2EANIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 09:08:13 -0400
Received: by wibhj6 with SMTP id hj6so3712963wib.1
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 06:08:11 -0700 (PDT)
In-Reply-To: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Use the caching API for the previous, current and next power domains states.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 18e1ffc..2058e27 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -854,6 +854,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 					  smp_processor_id());
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
+		if (!ret)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_NEXT_PWRST, pwrst);
 	}
 
 	return ret;
@@ -869,13 +871,19 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
  */
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = -EINVAL;
+	int pwrst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_next_pwrst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_NEXT_PWRST, &pwrst))
+		return pwrst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_next_pwrst) {
 		ret = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_NEXT_PWRST, ret);
+	}
 
 	return ret;
 }
@@ -906,13 +914,19 @@ int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = -EINVAL;
+	int pwrst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_PWRST, &pwrst))
+		return pwrst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst) {
 		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_PWRST, ret);
+	}
 
 	return ret;
 }
@@ -943,13 +957,19 @@ int pwrdm_read_func_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = -EINVAL;
+	int pwrst, ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_pwrst)
+	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_PREV_PWRST, &pwrst))
+		return pwrst;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_pwrst) {
 		ret = arch_pwrdm->pwrdm_read_prev_pwrst(pwrdm);
+		if (ret >= 0)
+			pwrdm_cache_write(pwrdm, PWRDM_CACHE_PREV_PWRST, ret);
+	}
 
 	return ret;
 }
-- 
1.7.7.6

