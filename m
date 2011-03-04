From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Integration branch base switchover to Tony's omap-for-linus branch
Date: Fri, 04 Mar 2011 19:38:28 +0530
Message-ID: <4D70F25C.4040206@ti.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com> <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com> <4D6F89FB.7080201@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080701030307080809040302"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:35942 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070Ab1CDOMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 09:12:31 -0500
Received: by mail-gx0-f171.google.com with SMTP id 7so1014327gxk.16
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 06:12:29 -0800 (PST)
In-Reply-To: <4D6F89FB.7080201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701030307080809040302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,

On Thursday 03 March 2011 06:00 PM, Rajendra Nayak wrote:
> Hi Paul,
>
> On Wednesday 02 March 2011 03:03 AM, Paul Walmsley wrote:
>> Hi Santosh
>>
>> On Tue, 1 Mar 2011, Santosh Shilimkar wrote:
>>
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Paul Walmsley
>>>> Sent: Saturday, February 26, 2011 5:56 AM
>>>> To: linux-omap@vger.kernel.org
>>>> Subject: Integration branch base switchover to Tony's omap-for-linus
>>>> branch
>>>>
>>>>
>>>> Hi,
>>>>
>>>> this is a quick note for anyone using the integration-2.6.39 branch
>>>> on
>>>> git://git.pwsan.com/linux-2.6: I've switched the base over from
>>>> mainline to Tony's omap-for-linus branch.
>>>>
>>>
>>> I observed an issue when integrated omap-for-linus + your branch
>>> + OMAP4 PM patches. After debugging this with Rajendra, it seems
>>> that issue is seen only when static dependency between MPU
>>> and L4PER clock-domain is cleared _and_ L4_PER clock-domain
>>> is programmed to HW_SUP.
>>>
>>> Since the issue is observed with only I2C IP block from L4_PER
>>> and none of the other modules are affected, the suspect is I2C
>>> IP block. The hardware team is investigating this issue.
>>>
>>> So for now, to avoid this abort, there are two options
>>> - Remove HW_SUP from L4_PER CD
>>> - Keep MPU<->L4_PER static dependency.
>>>
>>> We tried both the options and they seems to work.
>>> Which one you prefer till we have hardware root-cause
>>> of this issue?
>>
>> Between the two alternatives you suggested, I'd prefer #1; but could you
>> try forcing the I2C blocks to use software idle control instead and
>> see if
>> that fixes it without the need to change the clockdomains file? Sample
>> patch follows. If that fixes it, it might be useful to know whether it is
>> the HWMOD_SWSUP_SIDLE flag or HWMOD_NO_OCP_AUTOIDLE flag or both that is
>> required.
>
> Yes, it does seem to fix the issue also, and its the HWMOD_SWSUP_SIDLE
> that apparently makes a difference. HWMOD_NO_OCP_AUTOIDLE alone does
> not fix it.

Some more debugging by the Hardware team and analyzing
the register dumps showed that the I2C_WE register of the i2c
modules needs to be programmed correctly for i2c wakeups to
function as expected.
This turned out to be the root cause for the i2c issues observed
by clearing the staticdeps and a patch has been posted
to address this...
http://marc.info/?l=linux-omap&m=129924557219813&w=2

>
> Also some more testing showed up a lockup in suspend on OMAP4 which I
> could narrow down to a similar case with GPT1. Either keeping the
> staticdep between MPU and L4_WKUP _or_ forcing GPT1 to use software
> idle control seems to help.

This however is still not rootcaused and is not the same as the issue
seen with i2c as the WE for GPT1 is already programmed for enabling
wakeup.

The one way to fix this for now is to put GPT1 block in software
controlled idle as was done by your test patch for i2c.

---
 From fde94c22bb2db233b0b0cc4c2024d6f4e9f95257 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 4 Mar 2011 19:33:45 +0530
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1

Some issues seen (which cause lockups in suspend) with GPT1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing GPT1 in software
controlled idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 2c58827..9317a05 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3989,7 +3989,7 @@ static struct omap_hwmod_ocp_if 
*omap44xx_timer1_slaves[] = {
  static struct omap_hwmod omap44xx_timer1_hwmod = {
         .name           = "timer1",
         .class          = &omap44xx_timer_1ms_hwmod_class,
-       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET | 
HWMOD_SWSUP_SIDLE,
         .mpu_irqs       = omap44xx_timer1_irqs,
         .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer1_irqs),
         .main_clk       = "timer1_fck",
-- 
1.7.0.4

>
> regards,
> Rajendra
>
>>
>>
>> - Paul
>>
>> From: Paul Walmsley<paul@pwsan.com>
>> Date: Tue, 1 Mar 2011 14:11:31 -0700
>> Subject: [PATCH] OMAP4: I2C hwmods: Test patch to attempt to narrow
>> down crashes
>>
>> Put the I2C IP blocks into software-controlled idle to attempt to
>> narrow down
>> some crashes.
>> ---
>> arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 8 ++++----
>> 1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 79a8601..8415b97 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -2124,7 +2124,7 @@ static struct omap_hwmod_ocp_if
>> *omap44xx_i2c1_slaves[] = {
>> static struct omap_hwmod omap44xx_i2c1_hwmod = {
>> .name = "i2c1",
>> .class =&omap44xx_i2c_hwmod_class,
>> - .flags = HWMOD_INIT_NO_RESET,
>> + .flags = HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE |
>> HWMOD_NO_OCP_AUTOIDLE,
>> .mpu_irqs = omap44xx_i2c1_irqs,
>> .mpu_irqs_cnt = ARRAY_SIZE(omap44xx_i2c1_irqs),
>> .sdma_reqs = omap44xx_i2c1_sdma_reqs,
>> @@ -2177,7 +2177,7 @@ static struct omap_hwmod_ocp_if
>> *omap44xx_i2c2_slaves[] = {
>> static struct omap_hwmod omap44xx_i2c2_hwmod = {
>> .name = "i2c2",
>> .class =&omap44xx_i2c_hwmod_class,
>> - .flags = HWMOD_INIT_NO_RESET,
>> + .flags = HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE |
>> HWMOD_NO_OCP_AUTOIDLE,
>> .mpu_irqs = omap44xx_i2c2_irqs,
>> .mpu_irqs_cnt = ARRAY_SIZE(omap44xx_i2c2_irqs),
>> .sdma_reqs = omap44xx_i2c2_sdma_reqs,
>> @@ -2230,7 +2230,7 @@ static struct omap_hwmod_ocp_if
>> *omap44xx_i2c3_slaves[] = {
>> static struct omap_hwmod omap44xx_i2c3_hwmod = {
>> .name = "i2c3",
>> .class =&omap44xx_i2c_hwmod_class,
>> - .flags = HWMOD_INIT_NO_RESET,
>> + .flags = HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE |
>> HWMOD_NO_OCP_AUTOIDLE,
>> .mpu_irqs = omap44xx_i2c3_irqs,
>> .mpu_irqs_cnt = ARRAY_SIZE(omap44xx_i2c3_irqs),
>> .sdma_reqs = omap44xx_i2c3_sdma_reqs,
>> @@ -2283,7 +2283,7 @@ static struct omap_hwmod_ocp_if
>> *omap44xx_i2c4_slaves[] = {
>> static struct omap_hwmod omap44xx_i2c4_hwmod = {
>> .name = "i2c4",
>> .class =&omap44xx_i2c_hwmod_class,
>> - .flags = HWMOD_INIT_NO_RESET,
>> + .flags = HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE |
>> HWMOD_NO_OCP_AUTOIDLE,
>> .mpu_irqs = omap44xx_i2c4_irqs,
>> .mpu_irqs_cnt = ARRAY_SIZE(omap44xx_i2c4_irqs),
>> .sdma_reqs = omap44xx_i2c4_sdma_reqs,
>


--------------080701030307080809040302
Content-Type: text/x-patch;
 name="0001-OMAP4-hwmod-Disable-hardware-controlled-idle-for-GPT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-OMAP4-hwmod-Disable-hardware-controlled-idle-for-GPT.pa";
 filename*1="tch"

>From fde94c22bb2db233b0b0cc4c2024d6f4e9f95257 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 4 Mar 2011 19:33:45 +0530
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1

Some issues seen (which cause lockups in suspend) with GPT1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing GPT1 in software
controlled idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 2c58827..9317a05 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3989,7 +3989,7 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
 static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
 	.main_clk	= "timer1_fck",
-- 
1.7.0.4


--------------080701030307080809040302--
