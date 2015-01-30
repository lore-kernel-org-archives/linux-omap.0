From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP3: legacy clock data move under clk driver
Date: Fri, 30 Jan 2015 17:20:36 +0200
Message-ID: <54CBA144.8020409@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com> <20150107230006.GE13010@atomide.com> <54CA95D1.6080700@ti.com> <20150130004224.22722.56051@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41017 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbbA3PUv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2015 10:20:51 -0500
In-Reply-To: <20150130004224.22722.56051@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 01/30/2015 02:42 AM, Mike Turquette wrote:
> Quoting Tero Kristo (2015-01-29 12:19:29)
>> On 01/08/2015 01:00 AM, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [141216 08:22]:
>>>> Hi,
>>>>
>>>> These patches move the legacy clock data for omap3 under drivers/clk/ti.
>>>> After these patches are applied, it should be possible to get rid of
>>>> clk-private.h (long pending project for Mike.)
>>>>
>>>> Testing done (on top of 3.18-rc1):
>>>>
>>>> omap3-beagle: boot / suspend-resume (ret/off) / cpuidle (ret/off)
>>>> omap3-beagle-xm: boot upto fs mount (see note below)
>>>> sdp3430: boot
>>>> n900: boot
>>>>
>>>> Note: beagle-xm failed with FS mount on the board I have access to, but
>>>>         this happens with clean 3.18-rc1 and linux-next also at the moment.
>>>>         The board has probably corrupted filesystem image but I am unable
>>>>         to fix this atm (remote board.)
>>>>
>>>> Test branch:
>>>> tree: https://github.com/t-kristo/linux-pm.git
>>>> branch: 3.18-rc1-omap3-clk-rework
>>>
>>> Great, hopefully this will finally allow Mike to make the
>>> generic struct clk private to drivers/clk :)
>>>
>>> Seems to boot just fine based on a quick legacy booting test
>>> on n900.
>>>
>>> Mike, assuming no other issues, can you please apply these into a
>>> immutable branch against v3.19-rc1 that Paul and I can also merge
>>> in as needed?
>>>
>>> Please also feel free to add:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>
>> I just rebased these patches on top of 3.19-rc1, and noticed a problem
>> with dpll5 on beagle-xm (basically a divide-by-zero error + locking
>> issue during boot.) The extra diff at the end of this email fixes the
>> problems, I will also send the updated two patches as v2. Updated branch
>> available in my tree under name 3.19-rc1-omap3-clk-rework.
>
> I've applied these 11 patches on top of v3.19-rc1, including the two V2
> patches for #6 and #8 to the clk-omap-legacy branch here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-omap-legacy
>
> Let me know if I screwed anything up. I've merged this immutable branch
> into clk-next.
>
> In addition I've made some changes to remove clk-private.h permanently.
> I'll post those later today. Again, please let me know if I screwed
> anything up.

I can't see the clk-omap-legacy merged to clk-next so far, maybe you did 
not push it yet? The branch itself is identical copy of mine, so can't 
see any issues there so far.

-Tero

>
> Regards,
> Mike
>
>>
>> - Tero
>>
>> ---------------------
>>
>> diff --git a/drivers/clk/ti/clk-3xxx-legacy.c
>> b/drivers/clk/ti/clk-3xxx-legacy.c
>> index 81ad510..e0732a4 100644
>> --- a/drivers/clk/ti/clk-3xxx-legacy.c
>> +++ b/drivers/clk/ti/clk-3xxx-legacy.c
>> @@ -136,6 +136,7 @@ static struct ti_clk_dpll dpll3_ck_data = {
>>          .idlest_mask = 0x1,
>>          .auto_recal_bit = 0x3,
>>          .max_divider = 0x80,
>> +       .min_divider = 0x1,
>>          .recal_en_bit = 0x5,
>>          .max_multiplier = 0x7ff,
>>          .enable_mask = 0x7,
>> @@ -307,6 +308,7 @@ static struct ti_clk_dpll dpll4_ck_data = {
>>          .idlest_mask = 0x2,
>>          .auto_recal_bit = 0x13,
>>          .max_divider = 0x80,
>> +       .min_divider = 0x1,
>>          .recal_en_bit = 0x6,
>>          .max_multiplier = 0x7ff,
>>          .enable_mask = 0x70000,
>> @@ -507,6 +509,7 @@ static struct ti_clk_dpll dpll5_ck_data = {
>>          .idlest_mask = 0x1,
>>          .auto_recal_bit = 0x3,
>>          .max_divider = 0x80,
>> +       .min_divider = 0x1,
>>          .recal_en_bit = 0x19,
>>          .max_multiplier = 0x7ff,
>>          .enable_mask = 0x7,
>> @@ -1271,6 +1274,7 @@ static struct ti_clk_dpll dpll1_ck_data = {
>>          .idlest_mask = 0x1,
>>          .auto_recal_bit = 0x3,
>>          .max_divider = 0x80,
>> +       .min_divider = 0x1,
>>          .recal_en_bit = 0x7,
>>          .max_multiplier = 0x7ff,
>>          .enable_mask = 0x7,
>> @@ -2154,6 +2158,7 @@ static struct ti_clk_dpll dpll2_ck_data = {
>>          .idlest_mask = 0x1,
>>          .auto_recal_bit = 0x3,
>>          .max_divider = 0x80,
>> +       .min_divider = 0x1,
>>          .recal_en_bit = 0x8,
>>          .max_multiplier = 0x7ff,
>>          .enable_mask = 0x7,
>> @@ -2513,6 +2518,7 @@ static struct ti_clk_dpll dpll4_ck_omap36xx_data = {
>>          .idlest_mask = 0x2,
>>          .auto_recal_bit = 0x13,
>>          .max_divider = 0x80,
>> +       .min_divider = 0x1,
>>          .recal_en_bit = 0x6,
>>          .max_multiplier = 0xfff,
>>          .enable_mask = 0x70000,
>> diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
>> index 8d9c603..404158d 100644
>> --- a/drivers/clk/ti/clock.h
>> +++ b/drivers/clk/ti/clock.h
>> @@ -148,6 +148,7 @@ struct ti_clk_dpll {
>>          u32 sddiv_mask;
>>          u16 max_multiplier;
>>          u16 max_divider;
>> +       u8 min_divider;
>>          u8 auto_recal_bit;
>>          u8 recal_en_bit;
>>          u8 recal_st_bit;
>> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
>> index 7d67639..47ebff7 100644
>> --- a/drivers/clk/ti/dpll.c
>> +++ b/drivers/clk/ti/dpll.c
>> @@ -243,6 +243,7 @@ struct clk *ti_clk_register_dpll(struct ti_clk *setup)
>>          dd->sddiv_mask = dpll->sddiv_mask;
>>          dd->dco_mask = dpll->dco_mask;
>>          dd->max_divider = dpll->max_divider;
>> +       dd->min_divider = dpll->min_divider;
>>          dd->max_multiplier = dpll->max_multiplier;
>>          dd->auto_recal_bit = dpll->auto_recal_bit;
>>          dd->recal_en_bit = dpll->recal_en_bit;
>>

