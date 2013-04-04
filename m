From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 09/18] ARM: OMAP4+: PM: Restore CPU power state to
 ON with clockdomain force wakeup method
Date: Thu, 4 Apr 2013 19:07:25 +0530
Message-ID: <515D8215.10705@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-10-git-send-email-santosh.shilimkar@ti.com> <87mwtftjvy.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35517 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760834Ab3DDNfd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 09:35:33 -0400
In-Reply-To: <87mwtftjvy.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 02:24 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> While waking up CPU from off state using clock domain force wakeup, restore
>> the CPU power state to ON state before putting CPU clock domain under
>> hardware control. Otherwise CPU wakeup might fail. The change is recommended
>> for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
>> devices first.
> 
> Sounds reasonable, but can you describe the "weakness" a little more?
> 
> IOW, what exactly happens if this is not done?  It sounds like the CPU
> might immediately go back to retention, but how does that happen unless
> it does a WFI?
> 
Its more of lock-up inside the hardware state machine and results
are UN-predictable. We have seen hard-locks most of the time where system
is just frozen. The hardware gets into wrong state machine if the power
domain state isn't restored. I will add this information to changelog.

> Also, this sounds like a fix to me, and should probably be broken out
> accordingly.
> 
Yeah. You mean a separate patch from the series, right ? This patch
actually can be independently added.

In case you decide to apply it for the fixes branch, updated patch
at end of the email.

Regards,
Santosh

>From a0cef44760d859b63a34603010f8c0621da4b8ab Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 8 Feb 2013 22:50:58 +0530
Subject: [PATCH] ARM: OMAP4+: PM: Restore CPU power state to ON with
 clockdomain force wakeup method

While waking up CPU from off state using clock domain force wakeup, restore
the CPU power state to ON state before putting CPU clock domain under
hardware control. Otherwise CPU wakeup might fail. The change is recommended
for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
devices first.

As a result of weakness, lock-up is observed inside the hardware state
machine of local CPU PRCM and results are UN-predictable as per designers.
In software testing, we have seen hard-locks most of the time where system
gets frozen. With power domain state restored, system behaves correctly.

So update the code accordingly.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    1 +
 arch/arm/mach-omap2/omap-smp.c    |   12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 944e64a..9de47a7 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -131,6 +131,7 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 	/* Wakeup CPU1 only if it is not offlined */
 	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
 		clkdm_wakeup(cpu_clkdm[1]);
+		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
 		clkdm_allow_idle(cpu_clkdm[1]);
 	}
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 5b20165..8106e8d 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -83,6 +83,7 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 {
 	static struct clockdomain *cpu1_clkdm;
 	static bool booted;
+	static struct powerdomain *cpu1_pwrdm;
 	void __iomem *base = omap_get_wakeupgen_base();
 
 	/*
@@ -102,8 +103,10 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 	else
 		__raw_writel(0x20, base + OMAP_AUX_CORE_BOOT_0);
 
-	if (!cpu1_clkdm)
+	if (!cpu1_clkdm && !cpu1_pwrdm) {
 		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
+		cpu1_pwrdm = pwrdm_lookup("cpu1_pwrdm");
+	}
 
 	/*
 	 * The SGI(Software Generated Interrupts) are not wakeup capable
@@ -116,7 +119,7 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 	 * Section :
 	 *	4.3.4.2 Power States of CPU0 and CPU1
 	 */
-	if (booted) {
+	if (booted && cpu1_pwrdm && cpu1_clkdm) {
 		/*
 		 * GIC distributor control register has changed between
 		 * CortexA9 r1pX and r2pX. The Control Register secure
@@ -137,7 +140,12 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 			gic_dist_disable();
 		}
 
+		/*
+		 * Ensure that CPU power state is set to ON to avoid CPU
+		 * powerdomain transition on wfi
+		 */
 		clkdm_wakeup(cpu1_clkdm);
+		omap_set_pwrdm_state(cpu1_pwrdm, PWRDM_POWER_ON);
 		clkdm_allow_idle(cpu1_clkdm);
 
 		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD)) {
-- 
1.7.9.5


