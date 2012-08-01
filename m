From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Tue, 31 Jul 2012 19:20:20 -0500
Message-ID: <50187644.40308@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com> <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36758 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2HAAUm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 20:20:42 -0400
In-Reply-To: <5018210A.1040902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 07/31/2012 01:16 PM, Jon Hunter wrote:

[snip]

> So scratch item #1 above. As Rajendra pointed out in another thread this
> is not right. The only other comment I have with your patch is maybe we
> need to add the following to prevent the EMU PD being idled during
> boot-up if enabled early in the boot process. 
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 011186f..84d3fbc 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -825,7 +825,8 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
>         if (!clkdm)
>                 return;
>  
> -       if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO)) {
> +       if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO) ||
> +                       (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING)) {
>                 pr_debug("clock: automatic idle transitions cannot be enabled "
>                          "on clockdomain %s\n", clkdm->name);
>                 return;

Sorry for all the emails. However, I wanted to get this out to you as
I am due to be out for a couple weeks. 

So I have updated your patch [1] with the following changes ...

1. Re-based on top of your omap3 clock domain fix [2]
2. Modified the above change I mentioned to check for
   CLKDM_MISSING_IDLE_REPORTING in omap_pm_clkdms_setup() instead of
   the omap2_clkdm_clk_enable(). This is to prevent the clock domain
   being placed in HW_AUTO on boot if enabled early.
3. Made the other change I mentioned earlier [3].

This is now working well for me on OMAP3/4.

Let me know your thoughts.

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=134212809112530&w=2
[2] http://marc.info/?l=linux-omap&m=134333691309305&w=2
[3] http://marc.info/?l=linux-arm-kernel&m=134376848803220&w=2

>From c0b0077192239f7c03e39e8292bd74575d74f7d8 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 12 Jul 2012 14:58:43 -0600
Subject: [PATCH] ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU
 clockdomain idle problems

The idle status of the IP blocks and clocks inside the EMU clockdomain
isn't taken into account by the PRCM hardware when deciding whether
the clockdomain is idle.  Add a workaround flag, CLKDM_MISSING_IDLE_REPORTING,
to deal with this problem, and add the code necessary to support it.

XXX Add more description of what this flag actually does

XXX Jon, Ming, Will
---
 arch/arm/mach-omap2/clockdomain.c           |   17 +++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h           |   20 +++++++++++++++++---
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c  |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c       |   11 +++++++++++
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    7 ++-----
 arch/arm/mach-omap2/clockdomains44xx_data.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod.c            |    3 ++-
 arch/arm/mach-omap2/pm.c                    |    3 ++-
 8 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8664f5a..011186f 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -905,6 +905,23 @@ bool clkdm_in_hwsup(struct clockdomain *clkdm)
 	return ret;
 }
 
+/**
+ * clkdm_missing_idle_reporting - can @clkdm enter autoidle even if in use?
+ * @clkdm: struct clockdomain *
+ *
+ * Returns true if clockdomain @clkdm has the
+ * CLKDM_MISSING_IDLE_REPORTING flag set, or false if not or @clkdm is
+ * null.  More information is available in the documentation for the
+ * CLKDM_MISSING_IDLE_REPORTING macro.
+ */
+bool clkdm_missing_idle_reporting(struct clockdomain *clkdm)
+{
+	if (!clkdm)
+		return false;
+
+	return (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) ? true : false;
+}
+
 /* Clockdomain-to-clock/hwmod framework interface code */
 
 static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 5601dc1..629576b 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -1,9 +1,7 @@
 /*
- * arch/arm/plat-omap/include/mach/clockdomain.h
- *
  * OMAP2/3 clockdomain framework functions
  *
- * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008, 2012 Texas Instruments, Inc.
  * Copyright (C) 2008-2011 Nokia Corporation
  *
  * Paul Walmsley
@@ -34,6 +32,20 @@
  * CLKDM_ACTIVE_WITH_MPU: The PRCM guarantees that this clockdomain is
  *     active whenever the MPU is active.  True for interconnects and
  *     the WKUP clockdomains.
+ * CLKDM_MISSING_IDLE_REPORTING: The idle status of the IP blocks and
+ *     clocks inside this clockdomain are not taken into account by
+ *     the PRCM when determining whether the clockdomain is idle.
+ *     Without this flag, if the clockdomain is set to
+ *     hardware-supervised idle mode, the PRCM may transition the
+ *     enclosing powerdomain to a low power state, even when devices
+ *     inside the clockdomain and powerdomain are in use.  (An example
+ *     of such a clockdomain is the EMU clockdomain on OMAP3/4.)  If
+ *     this flag is set, and the clockdomain does not support the
+ *     force-sleep mode, then the HW_AUTO mode will be used to put the
+ *     clockdomain to sleep.  Similarly, if the clockdomain supports
+ *     the force-wakeup mode, then it will be used whenever a clock or
+ *     IP block inside the clockdomain is active, rather than the
+ *     HW_AUTO mode.
  */
 #define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
 #define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
@@ -41,6 +53,7 @@
 #define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
 #define CLKDM_NO_AUTODEPS			(1 << 4)
 #define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
+#define CLKDM_MISSING_IDLE_REPORTING		(1 << 6)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
@@ -187,6 +200,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 void clkdm_allow_idle(struct clockdomain *clkdm);
 void clkdm_deny_idle(struct clockdomain *clkdm);
 bool clkdm_in_hwsup(struct clockdomain *clkdm);
+bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
 
 int clkdm_wakeup(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index f99e65c..d2b081d 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -248,6 +248,17 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
+	/*
+	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+	 * more details on the unpleasant problem this is working
+	 * around
+	 */
+	if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
+				(clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
+		omap3_clkdm_wakeup(clkdm);
+		return 0;
+	}
+
 	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 
@@ -271,6 +282,17 @@ static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
+	/*
+	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+	 * more details on the unpleasant problem this is working
+	 * around
+	 */
+	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
+	    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
+		_enable_hwsup(clkdm);
+		return 0;
+	}
+
 	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index 762f2cc..6fc6155 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -113,6 +113,17 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 	if (!clkdm->prcm_partition)
 		return 0;
 
+	/*
+	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+	 * more details on the unpleasant problem this is working
+	 * around
+	 */
+	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
+	    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
+		omap4_clkdm_allow_idle(clkdm);
+		return 0;
+	}
+
 	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
 					clkdm->cm_inst, clkdm->clkdm_offs);
 
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index 56089c4..933a35c 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -387,14 +387,11 @@ static struct clockdomain per_am35x_clkdm = {
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
 };
 
-/*
- * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
- * switched of even if sdti is in use
- */
 static struct clockdomain emu_clkdm = {
 	.name		= "emu_clkdm",
 	.pwrdm		= { .name = "emu_pwrdm" },
-	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
+	.flags		= (CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_SWSUP |
+			   CLKDM_MISSING_IDLE_REPORTING),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
 };
 
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 63d60a7..b56d06b 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,8 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-	.flags		  = CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP,
+	.flags		  = (CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP |
+			     CLKDM_MISSING_IDLE_REPORTING),
 };
 
 static struct clockdomain l3_dma_44xx_clkdm = {
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6ca8e51..36f0603 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1857,7 +1857,8 @@ static int _enable(struct omap_hwmod *oh)
 		 * completely the module. The clockdomain can be set
 		 * in HW_AUTO only when the module become ready.
 		 */
-		hwsup = clkdm_in_hwsup(oh->clkdm);
+		hwsup = clkdm_in_hwsup(oh->clkdm) &&
+			!clkdm_missing_idle_reporting(oh->clkdm);
 		r = clkdm_hwmod_enable(oh->clkdm, oh);
 		if (r) {
 			WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..0747300 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -80,7 +80,8 @@ static void __init omap2_init_processor_devices(void)
 
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
-	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+	if ((clkdm->flags & CLKDM_CAN_ENABLE_AUTO) &&
+			!(clkdm->flags & CLKDM_MISSING_IDLE_REPORTING))
 		clkdm_allow_idle(clkdm);
 	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
 		 atomic_read(&clkdm->usecount) == 0)
-- 
1.7.9.5

