From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFT v3] OMAP4: fix temporary hacks that break multi-omap PM
Date: Tue, 09 Mar 2010 08:38:57 -0800
Message-ID: <87ocixsb4u.fsf@deeprootsystems.com>
References: <1268074368-27026-1-git-send-email-khilman@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C461A9CA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:48855 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0CIQjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 11:39:03 -0500
Received: by qyk9 with SMTP id 9so5940843qyk.5
        for <linux-omap@vger.kernel.org>; Tue, 09 Mar 2010 08:39:00 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C461A9CA@dbde02.ent.ti.com> (Santosh Shilimkar's message of "Tue\, 9 Mar 2010 14\:24\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> Kevin,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>> Hilman
>> Sent: Tuesday, March 09, 2010 12:23 AM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH/RFT v3] OMAP4: fix temporary hacks that break multi-omap PM
>> 
>> When building for multi-omap, and OMAP4 is enabled, CONFIG_ARCH_OMAP4
>> will be true and prevent included code from building/running for
>> OMAP2/3 as well.
>> 
>> This problem exists in io.c where some hwmod/PM/SDRC init code is
>> prevented from running even on OMAP2/3 when OMAP4 is included in a
>> multi-OMAP build.
>> 
>> A quick glance suggests that this #ifndef is no longer needed.  The
>> called functions should work fine or fail gracefully in the OMAP4
>> case.
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> 
>> Needs testing on OMAP4 since still no OMAP4 hardware here.
>> 
> Did you build test this ?

I did, but only with omap3_defconfig.

> This patch breaks builds on latest linux-omap master and mainline.
>
> omap_4430sdp_defconfig
> arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_hw':
> /work/linux-omap-2.6/arch/arm/mach-omap2/io.c:334: undefined reference to `omap_hwmod_late_init'
> /work/linux-omap-2.6/arch/arm/mach-omap2/io.c:336: undefined reference to `omap2_sdrc_init'
> make: *** [.tmp_vmlinux1] Error 1

I didn't test this OMAP4-only config.  I can see if I can wrap these
calls in if (!cpu_is_*) checks as a temporary workaround.

But the bigger issue is still there.  These OMAP4 #ifdefs break
multi-omap functionality (specifically PM) for OMAP2/3.

>
> omap3_defconfig
> arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_hw':
> /work/linux-omap-2.6/arch/arm/mach-omap2/io.c:315: undefined reference to `omap2430_hwmod_init'
> make: *** [.tmp_vmlinux1] Error 1

This one is fixed by an earlier patch to the cpu_is macros.  I will post the next
version as a series since they are related

   http://patchwork.kernel.org/patch/83859/

Kevin


>
>
>> Updates from v2:
>> - actually applies to l-o master
>> 
>> Updates from v1:
>> - removed additional #ifdef block in init_common_hw()
>> 
>>  arch/arm/mach-omap2/io.c |    5 +----
>>  1 files changed, 1 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>> index 402e8f0..595446f 100644
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -309,7 +309,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>>  {
>>  	pwrdm_init(powerdomains_omap);
>>  	clkdm_init(clockdomains_omap, clkdm_autodeps);
>> -#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
>>  	if (cpu_is_omap242x())
>>  		omap2420_hwmod_init();
>>  	else if (cpu_is_omap243x())
>> @@ -319,7 +318,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>>  	omap2_mux_init();
>>  	/* The OPP tables have to be registered before a clk init */
>>  	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
>> -#endif
>> 
>>  	if (cpu_is_omap2420())
>>  		omap2420_clk_init();
>> @@ -333,11 +331,10 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>>  		pr_err("Could not init clock framework - unknown CPU\n");
>> 
>>  	omap_serial_early_init();
>> -#ifndef CONFIG_ARCH_OMAP4
>>  	omap_hwmod_late_init();
>>  	omap_pm_if_init();
>>  	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>>  	_omap2_init_reprogram_sdrc();
>> -#endif
>> +
>>  	gpmc_init();
>>  }
>> --
>> 1.7.0.2
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
