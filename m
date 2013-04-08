From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 0/4] ARM: OMAP4+: PM: Consolidate code for re-use on
 OMAP5
Date: Mon, 8 Apr 2013 16:33:53 +0530
Message-ID: <5162A419.6040504@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com> <87mwtck0i6.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------090705000303080506040807"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50998 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935282Ab3DHLBz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Apr 2013 07:01:55 -0400
In-Reply-To: <87mwtck0i6.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

--------------090705000303080506040807
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Saturday 06 April 2013 05:12 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> As discussed on list, I split the v2 [1] series into cleanup and OMAP5 support.
> 
> Thanks.
> 
>> This series contains the clean-up patches. I have rebased on top of Tony's
>> pull request and your 3.10/* branches. Series is tested on OMAP4430 SDP
>> with CPUIDLE and suspend. OMAP5 PM support I will post later since it has
>> a dependency with OMAP5 data files which are not pulled in yet.
> 
> I've added 4/4 to my cpuidle branch and added 1,3/4 to my
> for_3.10/cleanup/pm branch (now based on Tony's cleanup-v2 branch for
> dependencies.)   Patch 2/4 needs a respin without the rename as per
> Tony's comments.
> 
OK. Here is an updated patch against your "for_3.10/cleanup/pm"
branch. Attachment as well just in case mailer eat tabs.

Regards,
Santosh


>From 428289ddf30a6a34f7e459720e5f6bf59ce4fe63 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 12 Apr 2012 16:51:47 +0530
Subject: [PATCH] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for
 OMAP5

OMAP5 has backward compatible PRCM block and it's programming
model is mostly similar to OMAP4. Same is going to be maintained
for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
management code so that it can be re-used on OMAP5 and later devices.

While at it, update the kernel-doc for omap4_pm_init().

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   58 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 5ba6d88..228deca 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -1,7 +1,7 @@
 /*
- * OMAP4 Power Management Routines
+ * OMAP4+ Power Management Routines
  *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
+ * Copyright (C) 2010-2013 Texas Instruments, Inc.
  * Rajendra Nayak <rnayak@ti.com>
  * Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
@@ -135,16 +135,16 @@ static void omap_default_idle(void)
 }
 
 /**
- * omap4_pm_init - Init routine for OMAP4 PM
+ * omap4_init_static_deps - Add OMAP4 static dependencies
  *
- * Initializes all powerdomain and clockdomain target states
- * and all PRCM settings.
+ * Add needed static clockdomain dependencies on OMAP4 devices.
+ * Return: 0 on success or 'err' on failures
  */
-int __init omap4_pm_init(void)
+static inline int omap4_init_static_deps(void)
 {
-	int ret;
 	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm;
+	int ret = 0;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
@@ -163,7 +163,7 @@ int __init omap4_pm_init(void)
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		pr_err("Failed to setup powerdomains\n");
-		goto err2;
+		return ret;
 	}
 
 	/*
@@ -171,6 +171,10 @@ int __init omap4_pm_init(void)
 	 * MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't work as
 	 * expected. The hardware recommendation is to enable static
 	 * dependencies for these to avoid system lock ups or random crashes.
+	 * The L4 wakeup depedency is added to workaround the OCP sync hardware
+	 * BUG with 32K synctimer which lead to incorrect timer value read
+	 * from the 32K counter. The BUG applies for GPTIMER1 and WDT2 which
+	 * are part of L4 wakeup clockdomain.
 	 */
 	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
 	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
@@ -179,7 +183,7 @@ int __init omap4_pm_init(void)
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
 	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
 		(!l3_2_clkdm) || (!ducati_clkdm))
-		goto err2;
+		return -EINVAL;
 
 	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
@@ -188,9 +192,42 @@ int __init omap4_pm_init(void)
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
 		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 wakeup dependency\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * omap4_pm_init - Init routine for OMAP4+ devices
+ *
+ * Initializes all powerdomain and clockdomain target states
+ * and all PRCM settings.
+ * Return: Returns the error code returned by called functions.
+ */
+int __init omap4_pm_init(void)
+{
+	int ret = 0;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
+		return -ENODEV;
+	}
+
+	pr_info("Power Management for TI OMAP4+ devices.\n");
+
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
+	if (ret) {
+		pr_err("Failed to setup powerdomains.\n");
 		goto err2;
 	}
 
+	if (cpu_is_omap44xx()) {
+		ret = omap4_init_static_deps();
+		if (ret)
+			goto err2;
+	}
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
@@ -206,7 +243,8 @@ int __init omap4_pm_init(void)
 	/* Overwrite the default cpu_do_idle() */
 	arm_pm_idle = omap_default_idle;
 
-	omap4_idle_init();
+	if (cpu_is_omap44xx())
+		omap4_idle_init();
 
 err2:
 	return ret;
-- 
1.7.9.5



--------------090705000303080506040807
Content-Type: text/x-patch;
	name="0001-ARM-OMAP4-PM-Consolidate-OMAP4-PM-code-to-re-use-it-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-ARM-OMAP4-PM-Consolidate-OMAP4-PM-code-to-re-use-it-.pa";
	filename*1="tch"

>From 428289ddf30a6a34f7e459720e5f6bf59ce4fe63 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 12 Apr 2012 16:51:47 +0530
Subject: [PATCH] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for
 OMAP5

OMAP5 has backward compatible PRCM block and it's programming
model is mostly similar to OMAP4. Same is going to be maintained
for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
management code so that it can be re-used on OMAP5 and later devices.

While at it, update the kernel-doc for omap4_pm_init().

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   58 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 5ba6d88..228deca 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -1,7 +1,7 @@
 /*
- * OMAP4 Power Management Routines
+ * OMAP4+ Power Management Routines
  *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
+ * Copyright (C) 2010-2013 Texas Instruments, Inc.
  * Rajendra Nayak <rnayak@ti.com>
  * Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
@@ -135,16 +135,16 @@ static void omap_default_idle(void)
 }
 
 /**
- * omap4_pm_init - Init routine for OMAP4 PM
+ * omap4_init_static_deps - Add OMAP4 static dependencies
  *
- * Initializes all powerdomain and clockdomain target states
- * and all PRCM settings.
+ * Add needed static clockdomain dependencies on OMAP4 devices.
+ * Return: 0 on success or 'err' on failures
  */
-int __init omap4_pm_init(void)
+static inline int omap4_init_static_deps(void)
 {
-	int ret;
 	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm;
+	int ret = 0;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
@@ -163,7 +163,7 @@ int __init omap4_pm_init(void)
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		pr_err("Failed to setup powerdomains\n");
-		goto err2;
+		return ret;
 	}
 
 	/*
@@ -171,6 +171,10 @@ int __init omap4_pm_init(void)
 	 * MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't work as
 	 * expected. The hardware recommendation is to enable static
 	 * dependencies for these to avoid system lock ups or random crashes.
+	 * The L4 wakeup depedency is added to workaround the OCP sync hardware
+	 * BUG with 32K synctimer which lead to incorrect timer value read
+	 * from the 32K counter. The BUG applies for GPTIMER1 and WDT2 which
+	 * are part of L4 wakeup clockdomain.
 	 */
 	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
 	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
@@ -179,7 +183,7 @@ int __init omap4_pm_init(void)
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
 	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
 		(!l3_2_clkdm) || (!ducati_clkdm))
-		goto err2;
+		return -EINVAL;
 
 	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
@@ -188,9 +192,42 @@ int __init omap4_pm_init(void)
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
 		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 wakeup dependency\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * omap4_pm_init - Init routine for OMAP4+ devices
+ *
+ * Initializes all powerdomain and clockdomain target states
+ * and all PRCM settings.
+ * Return: Returns the error code returned by called functions.
+ */
+int __init omap4_pm_init(void)
+{
+	int ret = 0;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
+		return -ENODEV;
+	}
+
+	pr_info("Power Management for TI OMAP4+ devices.\n");
+
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
+	if (ret) {
+		pr_err("Failed to setup powerdomains.\n");
 		goto err2;
 	}
 
+	if (cpu_is_omap44xx()) {
+		ret = omap4_init_static_deps();
+		if (ret)
+			goto err2;
+	}
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
@@ -206,7 +243,8 @@ int __init omap4_pm_init(void)
 	/* Overwrite the default cpu_do_idle() */
 	arm_pm_idle = omap_default_idle;
 
-	omap4_idle_init();
+	if (cpu_is_omap44xx())
+		omap4_idle_init();
 
 err2:
 	return ret;
-- 
1.7.9.5


--------------090705000303080506040807--
