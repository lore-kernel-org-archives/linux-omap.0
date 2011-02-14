From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP4: clockdomain: Remove pr_errs' stating unsupported wkdep
Date: Mon, 14 Feb 2011 17:36:05 +0530
Message-ID: <1297685165-25489-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39182 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab1BNMGQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 07:06:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Now that wkup and sleep dependencies are supported (in the
form of static deps) for OMAP4, remove all instances of
pr_errs' stating dependencies are still unsupported
on OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
Patch applies on the integration-2.6.39 of 
git://git.pwsan.com/linux-integration which
has the dependency support for omap4 queued
up.

 arch/arm/mach-omap2/clockdomain.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 70d2420..a0341de 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -400,12 +400,6 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	struct clkdm_dep *cd;
 	int ret = 0;
 
-	if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
-		pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
-		       clkdm1->name, clkdm2->name, __func__);
-		return -EINVAL;
-	}
-
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
@@ -447,12 +441,6 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	struct clkdm_dep *cd;
 	int ret = 0;
 
-	if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
-		pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
-		       clkdm1->name, clkdm2->name, __func__);
-		return -EINVAL;
-	}
-
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
@@ -501,12 +489,6 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
-	if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
-		pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
-		       clkdm1->name, clkdm2->name, __func__);
-		return -EINVAL;
-	}
-
 	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
 	if (IS_ERR(cd))
 		ret = PTR_ERR(cd);
@@ -536,12 +518,6 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
  */
 int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 {
-	if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
-		pr_err("clockdomain: %s: %s: not yet implemented\n",
-		       clkdm->name, __func__);
-		return -EINVAL;
-	}
-
 	if (!clkdm)
 		return -EINVAL;
 
-- 
1.7.0.4

