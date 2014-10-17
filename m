From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [REPOST PATCH 0/2] ARM: OMAP3+: VCVP mapping fixes to get DVFS working
Date: Fri, 17 Oct 2014 14:48:15 +0200
Message-ID: <CAFqH_52u-q44sqUPiU-r+RO6QM2W2kKpM=VkBGcT=33U1_15FA@mail.gmail.com>
References: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
	<CAFqH_512uU6ztmN6wh2WSb==pBZiQE8e+tmeyXFiQWYqj50V_g@mail.gmail.com>
	<5440AF53.9090003@ti.com>
	<CAFqH_517JGCgZH06hxExWVEP2PK_kAUw-ZcTCyiHrYBu6XsisQ@mail.gmail.com>
	<54410D19.8090609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:41825 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaJQMsQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2014 08:48:16 -0400
Received: by mail-wi0-f177.google.com with SMTP id fb4so1161189wid.4
        for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2014 05:48:15 -0700 (PDT)
In-Reply-To: <54410D19.8090609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>, nm@ti.com, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

2014-10-17 14:35 GMT+02:00 Tero Kristo <t-kristo@ti.com>:
> On 10/17/2014 02:55 PM, Enric Balletbo Serra wrote:
>>
>> 2014-10-17 7:55 GMT+02:00 Tero Kristo <t-kristo@ti.com>:
>>>
>>> On 10/16/2014 05:21 PM, Enric Balletbo Serra wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> 2014-10-10 16:06 GMT+02:00 Tero Kristo <t-kristo@ti.com>:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Seems like MPU DVFS does not scale the voltages currently with DT boot,
>>>>> due to missing mapping between regulator -> VCVP. Fixed this by adding
>>>>> support for platform data in the TWL regulator DT case + adding
>>>>> platform
>>>>> data quirk for the same. This same already works in the legacy boot,
>>>>> the
>>>>> platform data is passed fine.
>>>>>
>>>>> Tested on omap3-beagle by measuring the MPU voltage rail.
>>>>>
>>>>> OMAP4+ platforms do not currently register DVFS regulator, so this set
>>>>> by
>>>>> itself does not fix OMAP4 (needs the TPS MPU regulator added to DT etc.
>>>>> for OMAP4460.)
>>>>>
>>>>> -Tero
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>> Tony proposed in the IRC apply this patch series in order to solve the
>>>> following error messages with kernel 3.17
>>>>
>>>> [    2.522949] omap2_set_init_voltage: unable to find boot up OPP for
>>>> vdd_mpu_iva
>>>> [    2.533721] omap2_set_init_voltage: unable to set vdd_mpu_iva
>>>> [    2.541564] omap2_set_init_voltage: unable to find boot up OPP for
>>>> vdd_core
>>>> [    2.551208] omap2_set_init_voltage: unable to set vdd_core
>>>>
>>>> I'm using omap3-igep0020, I didn't mesure the MPU voltage rail but
>>>> should these patches solve these errors ? Did you resolve these errors
>>>> on your Beagleboard ?
>>>
>>>
>>>
>>> These prints are caused by something else: namely the fact that
>>> beagleboard
>>> rev C4+ boots up at 720MHz. This OPP is not supported by the kernel and
>>> quelches out the warning prints.
>>>
>>> This should be fixed by modifying the OPP tables under the dtsi files,
>>> however the nasty thing is not all beagleboards support 720MHz OPP. You
>>> either need to specify a dts file for beagle-revC4 or do some kernel
>>> magic
>>> to manually disable the 720MHz OPP on non-supported boards.
>>>
>>
>> Adding and modifying some printk looks the problem is because it can't
>> find the device opp.
>>
>> [    2.532836] cpu cpu0: dev_pm_opp_find_freq_ceil: can't find device opp
>> [    2.542755] omap2_set_init_voltage: unable to find boot up OPP for
>> vdd_mpu_iva (clk = dpll1_ck - freq = 600000000)
>> [    2.554931] omap2_set_init_voltage: unable to set vdd_mpu_iva
>>
>> [    2.562957] platform 68000000.ocp: dev_pm_opp_find_freq_ceil: can't
>> find device opp
>> [    2.573333] omap2_set_init_voltage: unable to find boot up OPP for
>> vdd_core (clk = l3_ick - freq = 200000000)
>> [    2.584442] omap2_set_init_voltage: unable to set vdd_core
>>
>>
>> The of_init_opp_table who reads the 'operating-points" from dtb is
>> called after. Should be called before?
>>
>> [    2.592834] cpu cpu0: of_init_opp_table: init_opp_table
>>
>
> What is the board revision you got? Looks like it boots up at 600/200MHz.
>

Well, about board revision I'm using IGEPv2 not Beagleboard. And my
board should be able to run up to 1GHz. Is 1GHz supported ?

> You can also try tweaking around the tables under opp3xxx_data.c, not sure
> if these are initialized in the correct order either. However, the lack of
> these tables and the warnings mentioned do not prevent cpufreq from working,
> cpufreq is dependant on the DT tables. That being said, I am not sure if the
> legacy OPP tables are even needed anymore on DT boot...
>

Right, I've checked and cpufreq seems to work. Does this means that
following call is not needed anymore ?

arch/arm/mach-omap2/opp3xxx_data.c:171:omap_device_initcall(omap3_opp_init);

Thanks,
  Enric


> -Tero
>
