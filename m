From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under
 smp_prepare_cpus()
Date: Thu, 28 Mar 2013 13:05:01 +0530
Message-ID: <5153F2A5.7020609@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com> <878v587kco.fsf@linaro.org> <515342D2.2080409@ti.com> <87txnw62la.fsf@linaro.org> <51535B93.2040505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53355 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755945Ab3C1HdG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 03:33:06 -0400
In-Reply-To: <51535B93.2040505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 28 March 2013 02:20 AM, Santosh Shilimkar wrote:
> On Thursday 28 March 2013 01:24 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
>>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>>
>>>>> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
>>>>
>>>> Why?
>>>>
>>> Because that code belongs to smp_prepare_cpus(). As I said
>>> in earlier patches, it was remainder of the pen release code
>>> which was borrowed from ARM code initially.
>>
>> Sure, but that should be in the changelog.
>>
> Yep. Will add above info in changelog.
> 
For record, patch with updated changelog end of email.

Regards,
Santosh

>From b699ddd19bf3542d43ffe293c6148161e160b1bc Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 10 Feb 2013 13:54:00 +0530
Subject: [PATCH v2 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under
 smp_prepare_cpus()

Move the secondary CPU wakeup prepare code under smp_prepare_cpus() where it
belongs. It was remainder of the pen release code which was borrowed from
ARM code initially.

While at it drop the un-necessary sev() and barrier which was under
prepare code.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |   51 ++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 1e14899..0cbb677 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -164,36 +164,6 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 	return 0;
 }
 
-static void __init wakeup_secondary(void)
-{
-	void *startup_addr = omap_secondary_startup;
-	void __iomem *base = omap_get_wakeupgen_base();
-
-	if (cpu_is_omap446x()) {
-		startup_addr = omap_secondary_startup_4460;
-		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
-	}
-
-	/*
-	 * Write the address of secondary startup routine into the
-	 * AuxCoreBoot1 where ROM code will jump and start executing
-	 * on secondary core once out of WFE
-	 * A barrier is added to ensure that write buffer is drained
-	 */
-	if (omap_secure_apis_support())
-		omap_auxcoreboot_addr(virt_to_phys(startup_addr));
-	else
-		__raw_writel(virt_to_phys(omap5_secondary_startup),
-						base + OMAP_AUX_CORE_BOOT_1);
-
-	/*
-	 * Send a 'sev' to wake the secondary core from WFE.
-	 * Drain the outstanding writes to memory
-	 */
-	dsb_sev();
-	mb();
-}
-
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
@@ -229,6 +199,8 @@ static void __init omap4_smp_init_cpus(void)
 
 static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 {
+	void *startup_addr = omap_secondary_startup;
+	void __iomem *base = omap_get_wakeupgen_base();
 
 	/*
 	 * Initialise the SCU and wake up the secondary core using
@@ -236,7 +208,24 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	if (scu_base)
 		scu_enable(scu_base);
-	wakeup_secondary();
+
+	if (cpu_is_omap446x()) {
+		startup_addr = omap_secondary_startup_4460;
+		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
+	}
+
+	/*
+	 * Write the address of secondary startup routine into the
+	 * AuxCoreBoot1 where ROM code will jump and start executing
+	 * on secondary core once out of WFE
+	 * A barrier is added to ensure that write buffer is drained
+	 */
+	if (omap_secure_apis_support())
+		omap_auxcoreboot_addr(virt_to_phys(startup_addr));
+	else
+		__raw_writel(virt_to_phys(omap5_secondary_startup),
+						base + OMAP_AUX_CORE_BOOT_1);
+
 }
 
 struct smp_operations omap4_smp_ops __initdata = {
-- 
1.7.9.5


