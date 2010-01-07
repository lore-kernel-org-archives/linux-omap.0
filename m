From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Wed, 06 Jan 2010 16:23:15 -0800
Message-ID: <87d41m930s.fsf@deeprootsystems.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
	<1258004721-7315-2-git-send-email-nm@ti.com>
	<1258004721-7315-3-git-send-email-nm@ti.com>
	<1258004721-7315-4-git-send-email-nm@ti.com>
	<1258004721-7315-5-git-send-email-nm@ti.com>
	<1258004721-7315-6-git-send-email-nm@ti.com>
	<87eimrx4em.fsf@deeprootsystems.com> <4B2CBA8A.5030905@ti.com>
	<87k4wfrm89.fsf@deeprootsystems.com> <4B4520CF.3000306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53325 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135Ab0AGAXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:23:18 -0500
Received: by pzk1 with SMTP id 1so2531057pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 16:23:18 -0800 (PST)
In-Reply-To: <4B4520CF.3000306@ti.com> (Nishanth Menon's message of "Wed\, 6 Jan 2010 17\:46\:23 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "K, Ambresh" <ambresh@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 12/22/2009 10:45 AM, the following:
>> "Menon, Nishanth" <nm@ti.com> writes:
>>
>>> Kevin Hilman said the following on 12/19/2009 04:42 AM:
>>>> Nishanth Menon <nm@ti.com> writes:
>>>>
>>>>   
>>>>> SmartReflex implements a get_opp to search through the opp table,
>>>>> replace it with the accessor function as it is a duplicate of
>>>>> freq_to_opp
>>>>>     
>>>> SmartReflex is not quite working with this version which is in
>>>> pm-wip-opp.  My (untested) theory below...
>>>>
>>>> [...]
>>>>   
>>> Ambresh and I  just tested the very latest of the pm-wip-opp branch
>>> and checked. Voltage transitions and SR adjustments are happily
>>> happening on SDP3430 ES3.1 at the very least (verified with a scope on
>>> vdd1).
>>>
>>> and if you look closely in the code, sr2.vdd_opp_clk->rate and
>>> sr1.vdd_opp_clk->rate are based on
>>> sr1.vdd_opp_clk = clk_get(NULL, "dpll1_ck")
>>> sr2.vdd_opp_clk = clk_get(NULL, "l3_ick");
>>>
>>> now, if the dpll1_ck ->rate and l3_ick->rate are not exact frequencies
>>> as the opp tables, I think we have a clockframework bug and the code
>>> here is correct. we should fix the clockframework/find the rootcause
>>> elsewhere.
>>>
>>> Now is the clockframework wrong? we added a patch to print the
>>> frequencies and checked if IS_ERR(opp) is true -> not a single call
>>> while using cpu_freq transitions resulted in an error value and all
>>> the frequencies we printed were from the OPP table
>>>
>>> Might be good to hear your rationale for saying this result..
>>
>> Part of my rationale was that the PM branch version get_vdd1_opp()
>> does an approximate match (actually the equivalent of
>> opp_find_freq_ceil() via get_opp.)  So you replaced an approximate
>> match with an exact match.  That may be the right solution and point
>> to a bug elsewhere, but it was not an equivalent replacement, and
>> probably should've been done in a separate patch with
>> justification/rationale.  I didn't catch it during initial review.
>>
>> But the primary reason I noticed it in the first place was that I was
>> seeing DVFS errors on n900, which is the only platform I have that
>> actually can do SmartReflex.  Specifically, sr_reset_voltage() is
>> failing for VDD1.  Dumping out the clock rates used in get_vdd1_opp()
>> show that the clocks rates are close, but not the exact value used in
>> the OPP table.
>>
>> Here is the patch I used to add some debugging, and I see that for the
>> 250MHz OPP, the clock framework rate is 249600000 and for the 125MHz
>> OPP, the clock rate is 124800000.  As I said, close, but clearly an
>> find with exact match is going to fail.
>>
>> Below the patch, is the console dump and backtrace of how get_vdd1_opp()
>> was called so you can see the call chain.
>>
>> Kevin
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>> index d341857..01a3dbd 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -155,6 +155,8 @@ static u8 get_vdd1_opp(void)
>>  							mpu_opps == NULL)
>>  		return 0;
>>  +	printk("%s: sr1.vdd_opp_clk->rate = %d\n", __func__,
>> +	       sr1.vdd_opp_clk->rate);
>>  	opp = opp_find_freq_exact(mpu_opps, sr1.vdd_opp_clk->rate, true);
>>  	if (IS_ERR(opp))
>>  		return 0;
>> @@ -451,6 +453,7 @@ static int sr_reset_voltage(int srid)
>>  		target_opp_no = get_vdd1_opp();
>>  		if (!target_opp_no) {
>>  			pr_info("Current OPP unknown: Cannot reset voltage\n");
>> +			__backtrace();
>>  			return 1;
>>  		}
>>  
>>
>>
>> /sys/devices/system/cpu/cpu0/cpufreq # echo 250000 >
>> scaling_setspeed get_vdd1_opp: sr1.vdd_opp_clk->rate = 249600000
>> Current OPP unknown: Cannot reset voltage
>> [<c0042c98>] (sr_reset_voltage+0x0/0x190) from [<c0043094>] (sr_stop_vddautocomap+0x12c/0x148)
>>  r7:00000001 r6:00000001 r5:c03ac878 r4:00000000
>> [<c0042f68>] (sr_stop_vddautocomap+0x0/0x148) from [<c0043388>] (sr_voltagescale_vcbypass+0x2c/0x170)
> [...]
>
> Throws up my hands! 3430 on N900/SDP3430 should be essentially the same!
>
> Configuration:
> ==============
> kernel:
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> branch:
> pm-wip-opp 6e1276f omap3:pm: remove map3_[mpu|dsp|l3]_rate_tables
> Applied my bugfix: http://patchwork.kernel.org/patch/71457/
>
> I have a 3430 ES3.1 SDP3430 where I did run the test:
>
> Log Patch: http://pastebin.mozilla.org/695225
> Test script: http://pastebin.mozilla.org/695226 (I call this test-me.sh)
> Result log: http://pastebin.mozilla.org/695224
>
> huh? no crash, all the frequencies and transitions are good, the rates
> of dpll1,2,3 look good! there is something definitely fishy about N900
> configuration??

OK, so for now we need to at least replace the original approximate
match with an equivalent approximate match.  Then, use an additional
patch to change it to an exact match when we find out what's happening
on N900.

Kevin
