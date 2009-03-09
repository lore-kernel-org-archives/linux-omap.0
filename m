From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Mon, 09 Mar 2009 10:50:51 -0700
Message-ID: <8763iizitg.fsf@deeprootsystems.com>
References: <1236532839-3696-1-git-send-email-juha.yrjola@solidboot.com>
	<20090309172140.GF7329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:29340 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbZCIRu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 13:50:56 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1759886rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 10:50:54 -0700 (PDT)
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

Looks ok to me.

Maybe just a brief description of this scratchpad location is reserved.
Is there a boot ROM doc that could be referenced?

Any interactions with bootrom are a bit of black magic, so I like there to be
as much description as possible.

Kevin

