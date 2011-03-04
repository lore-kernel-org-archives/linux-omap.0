From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Integration branch base switchover to Tony's omap-for-linus branch
Date: Fri, 4 Mar 2011 16:25:50 +0100
Message-ID: <4D71047E.1060703@ti.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com> <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com> <4D6F89FB.7080201@ti.com> <4D70F25C.4040206@ti.com> <4D70FE4A.8060600@ti.com> <4837f9c890c8a6c38d346cac73d9cec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53200 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758511Ab1CDPZy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 10:25:54 -0500
In-Reply-To: <4837f9c890c8a6c38d346cac73d9cec6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 3/4/2011 4:01 PM, Shilimkar, Santosh wrote:
>> From: Cousson, Benoit [mailto:b-cousson@ti.com]
>> Sent: Friday, March 04, 2011 8:29 PM
>>
>> Hi Rajendra,
>>
>> On 3/4/2011 3:08 PM, Nayak, Rajendra wrote:
>>> Hi Paul,
>>
>> [...]
>>
>>> This however is still not rootcaused and is not the same as the
>> issue
>>> seen with i2c as the WE for GPT1 is already programmed for
>> enabling
>>> wakeup.
>>>
>>> The one way to fix this for now is to put GPT1 block in software
>>> controlled idle as was done by your test patch for i2c.
>>>
>>> ---
>>>    From fde94c22bb2db233b0b0cc4c2024d6f4e9f95257 Mon Sep 17
>> 00:00:00 2001
>>> From: Rajendra Nayak<rnayak@ti.com>
>>> Date: Fri, 4 Mar 2011 19:33:45 +0530
>>> Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle
>> for GPT1
>>
>> Maybe we should emphasis the temporary need for this commit to avoid
>> forgetting it?
>>
>>> Some issues seen (which cause lockups in suspend) with GPT1
>>> after the MPU<->L4_WKUP static dependency was cleared can be
>>> Worked-around for now by forcing GPT1 in software
>>> controlled idle.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> ---
>>>     arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>>>     1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> index 2c58827..9317a05 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -3989,7 +3989,7 @@ static struct omap_hwmod_ocp_if
>>> *omap44xx_timer1_slaves[] = {
>>>     static struct omap_hwmod omap44xx_timer1_hwmod = {
>>>            .name           = "timer1",
>>>            .class          =&omap44xx_timer_1ms_hwmod_class,
>>> -       .flags          = HWMOD_INIT_NO_IDLE |
>> HWMOD_INIT_NO_RESET,
>>> +       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET
>> |
>>> HWMOD_SWSUP_SIDLE,
>>
>> I was wondering why the previous flags were still there, but it
>> looks
>> like the revert was not done.
>>
>> I'll push it with the revert for the flags.
>>
>> Where is the Santosh's branch that should be rebased on top of that
>> one?
>>
> I am trying to rebase it on Kevin's pm-core branch. Will cherry pick
> these patches

Cool, I updated Rajendra's patch and rebased it on top of the revert.
Both patches are below.

You can find them in the following place:
git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data_fixes

Could you check them before I can send a pull request to Tony?

Thanks,
Benoit

---
 From aa22c44486c12c388eb96e9fe9b1476267856006 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 4 Mar 2011 16:01:43 +0100
Subject: [PATCH 1/2] Revert "OMAP4: hwmod data: Prevent timer1 to be 
reset and idle during init"

The following commit: 38698be:
OMAP2+: clockevent: set up GPTIMER clockevent hwmod right before timer init

Fixed properly the issue with early init for the timer1

So reverts commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6 that is now
generated a warning at boot time.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7dbcdf7..7b72316 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,7 +4005,6 @@ static struct omap_hwmod_ocp_if 
*omap44xx_timer1_slaves[] = {
  static struct omap_hwmod omap44xx_timer1_hwmod = {
  	.name		= "timer1",
  	.class		= &omap44xx_timer_1ms_hwmod_class,
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
  	.mpu_irqs	= omap44xx_timer1_irqs,
  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
  	.main_clk	= "timer1_fck",
-- 
1.7.0.4

---
 From cdaaad0d1ce032129102b6ebc56e372d6f345861 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 4 Mar 2011 19:33:45 +0530
Subject: [PATCH 2/2] OMAP4: hwmod data: Temporary disable 
hardware-controlled idle for timer1

Some issues seen (which cause lockups in suspend) with timer1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing timer1 in software
controlled idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[b-cousson: Update the changelog and the subject]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7b72316..cfe957a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,6 +4005,7 @@ static struct omap_hwmod_ocp_if 
*omap44xx_timer1_slaves[] = {
  static struct omap_hwmod omap44xx_timer1_hwmod = {
  	.name		= "timer1",
  	.class		= &omap44xx_timer_1ms_hwmod_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
  	.mpu_irqs	= omap44xx_timer1_irqs,
  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
  	.main_clk	= "timer1_fck",
-- 
1.7.0.4




