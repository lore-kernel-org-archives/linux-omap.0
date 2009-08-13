From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Thu, 13 Aug 2009 05:51:46 -0700
Message-ID: <87r5vfop0d.fsf@deeprootsystems.com>
References: <1236532839-3696-1-git-send-email-juha.yrjola@solidboot.com>
	<20090309172140.GF7329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:45781 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbZHMMvt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 08:51:49 -0400
Received: by pxi34 with SMTP id 34so23259pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 05:51:50 -0700 (PDT)
In-Reply-To: <20090309172140.GF7329@atomide.com> (Tony Lindgren's message of "Mon\, 9 Mar 2009 10\:21\:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Tony Lindgren <tony@atomide.com> writes:

> * Juha Yrjola <juha.yrjola@solidboot.com> [090308 10:20]:
>> The reboot mode can be communicated to a bootloader (or the
>> kernel itself) with a scratchpad register. This functionality
>> is especially useful, if userspace is allowed to change
>> the reboot mode.
>> 
>> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
>> ---
>>  arch/arm/mach-omap2/prcm.c |   10 ++++++++--
>>  1 files changed, 8 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
>> index f945156..2bd239e 100644
>> --- a/arch/arm/mach-omap2/prcm.c
>> +++ b/arch/arm/mach-omap2/prcm.c
>> @@ -43,9 +43,15 @@ void omap_prcm_arch_reset(char mode)
>>  
>>  	if (cpu_is_omap24xx())
>>  		prcm_offs = WKUP_MOD;
>> -	else if (cpu_is_omap34xx())
>> +	else if (cpu_is_omap34xx()) {
>> +		u32 l;
>> +
>>  		prcm_offs = OMAP3430_GR_MOD;
>> -	else
>> +		l = ('B' << 24) | ('M' << 16) | mode;
>> +		/* Reserve the first word in scratchpad for communicating
>> +		 * with the boot ROM. */
>> +		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
>> +	} else
>>  		WARN_ON(1);
>>  
>>  	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
>
> Looks OK to me, any comments from Kevin or Paul?
>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

I've had this one in the PM branch for awhile now I think can go upstream.

Kevin

