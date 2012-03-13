From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Workaround the OCP synchronisation issue
 with 32K synctimer.
Date: Tue, 13 Mar 2012 14:17:10 +0530
Message-ID: <4F5F098E.4040006@ti.com>
References: <1331566388-2397-1-git-send-email-santosh.shilimkar@ti.com> <87399d225f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020509020904040208040106"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34328 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758953Ab2CMIrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 04:47:18 -0400
Received: by ghbf11 with SMTP id f11so272196ghb.36
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 01:47:16 -0700 (PDT)
In-Reply-To: <87399d225f.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dave.long@linaro.org

This is a multi-part message in MIME format.
--------------020509020904040208040106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Monday 12 March 2012 10:21 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On OMAP4, recently a synchronisation bug is discovered by hardware
>> team, which leads to incorrect timer value read from 32K sync timer
>> IP when the IP is comming out of idle.
>>
>> The issue is due to the synchronization methodology used in the SYNCTIMER IP.
>> The value of the counter register in 32kHz domain is synchronized to the OCP
>> domain register only at count up event, and if the OCP clock is switched off,
>> the OCP register gets out of synch until the first count up event after the
>> clock is switched back -at the next falling edge of the 32kHz clock.
>>
>> Further investigation revealed that it applies to gptimer1 and watchdog timer2
>> as well which may run on 32KHz. This patch fixes the issue for all the
>> applicable modules.
> 
> The changelog describes the problem ver well, but doesn't actually
> describe the fix (enable static dep.)  Can you update the changelog do
> describe the fix, and why it fixes the problem.
> 
Sure. Updated patch below. The idea is to ensure that synctimer is
syncronised before software does any reads on the counter. The BUG
will get fixed in future OMAP designs

Attaching the patch in case thunderbird email client eats the tabs.

Regards
Santosh

>From 2edeebbd434627d1d0a9d96f6c5bda044a68fa70 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 12 Mar 2012 20:34:45 +0530
Subject: [PATCH] ARM: OMAP4: Workaround the OCP synchronisation issue
with 32K synctimer.

On OMAP4, recently a synchronisation bug is discovered by hardware
team, which leads to incorrect timer value read from 32K sync timer
IP when the IP is comming out of idle.

The issue is due to the synchronization methodology used in the
SYNCTIMER IP.
The value of the counter register in 32kHz domain is synchronized to the OCP
domain register only at count up event, and if the OCP clock is switched
off,
the OCP register gets out of synch until the first count up event after the
clock is switched back -at the next falling edge of the 32kHz clock.

Further investigation revealed that it applies to gptimer1 and watchdog
timer2
as well which may run on 32KHz. This patch fixes the issue for all the
applicable modules.

The BUG has not made it yet to the OMAP errata list and it is applicable to
OMAP1/2/3/4/5. OMAP1/2/3 it is taken care indirectly by autodeps.

By enabling static depedency of wakeup clockdomain with MPU, as soon as MPU
is woken up from lowpower state(idle) or whenever MPU is active, PRCM forces
the OCP clock to be running and allow the counter value to be updated
properly
in the OCP clock domain.

The bug is going to fixed in future OMAP versions.

Reported-Tested-by: dave.long@linaro.org
[dave.long@linaro.org: Reported the oprofile time stamp issue with synctimer
and helped to test this patch]
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index c264ef7..974f7ea 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -196,7 +196,7 @@ static void omap_default_idle(void)
 static int __init omap4_pm_init(void)
 {
 	int ret;
-	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;

 	if (!cpu_is_omap44xx())
@@ -220,14 +220,19 @@ static int __init omap4_pm_init(void)
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
 	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
 	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
 	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
+	l4wkup = clkdm_lookup("l4_wkup_clkdm");
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
-	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) || (!l4wkup) ||
 		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
 		goto err2;

@@ -235,6 +240,7 @@ static int __init omap4_pm_init(void)
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
-- 
1.7.4.1






--------------020509020904040208040106
Content-Type: text/x-patch;
 name="0001-ARM-OMAP4-Workaround-the-OCP-synchronisation-issue-w.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ARM-OMAP4-Workaround-the-OCP-synchronisation-issue-w.pa";
 filename*1="tch"

>From 2edeebbd434627d1d0a9d96f6c5bda044a68fa70 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 12 Mar 2012 20:34:45 +0530
Subject: [PATCH] ARM: OMAP4: Workaround the OCP synchronisation issue with 32K synctimer.

On OMAP4, recently a synchronisation bug is discovered by hardware
team, which leads to incorrect timer value read from 32K sync timer
IP when the IP is comming out of idle.

The issue is due to the synchronization methodology used in the SYNCTIMER IP.
The value of the counter register in 32kHz domain is synchronized to the OCP
domain register only at count up event, and if the OCP clock is switched off,
the OCP register gets out of synch until the first count up event after the
clock is switched back -at the next falling edge of the 32kHz clock.

Further investigation revealed that it applies to gptimer1 and watchdog timer2
as well which may run on 32KHz. This patch fixes the issue for all the
applicable modules.

The BUG has not made it yet to the OMAP errata list and it is applicable to
OMAP1/2/3/4/5. OMAP1/2/3 it is taken care indirectly by autodeps.

By enabling static depedency of wakeup clockdomain with MPU, as soon as MPU
is woken up from lowpower state(idle) or whenever MPU is active, PRCM forces
the OCP clock to be running and allow the counter value to be updated properly
in the OCP clock domain.

The bug is going to fixed in future OMAP versions.

Reported-Tested-by: dave.long@linaro.org
[dave.long@linaro.org: Reported the oprofile time stamp issue with synctimer
and helped to test this patch]
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index c264ef7..974f7ea 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -196,7 +196,7 @@ static void omap_default_idle(void)
 static int __init omap4_pm_init(void)
 {
 	int ret;
-	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
 
 	if (!cpu_is_omap44xx())
@@ -220,14 +220,19 @@ static int __init omap4_pm_init(void)
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
 	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
 	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
 	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
+	l4wkup = clkdm_lookup("l4_wkup_clkdm");
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
-	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) || (!l4wkup) ||
 		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
 		goto err2;
 
@@ -235,6 +240,7 @@ static int __init omap4_pm_init(void)
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
-- 
1.7.4.1


--------------020509020904040208040106--
