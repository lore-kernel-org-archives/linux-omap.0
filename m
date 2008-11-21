From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 clock: disable DPLL autoidle while waiting for DPLL to lock
Date: Fri, 21 Nov 2008 14:40:41 -0800
Message-ID: <87zljs66ty.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0811141043400.27331@utopia.booyaka.com>
	<20081121222807.GI4927@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:2557 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYKUWkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:40:47 -0500
Received: by yx-out-2324.google.com with SMTP id 8so523299yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 14:40:46 -0800 (PST)
In-Reply-To: <20081121222807.GI4927@atomide.com> (Tony Lindgren's message of "Fri\, 21 Nov 2008 14\:28\:08 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Peter de Schrijver <peter.de-schrijver@nokia.com>

Tony Lindgren <tony@atomide.com> writes:

> * Paul Walmsley <paul@pwsan.com> [081114 09:46]:
>> 
>> During _omap3_noncore_dpll_lock(), if a DPLL has no active downstream
>> clocks and DPLL autoidle is enabled, the DPLL may never lock, since it
>> will enter autoidle immediately.  To resolve this, disable DPLL
>> autoidle while locking the DPLL, and unconditionally wait for the DPLL
>> to lock.  This fixes some bugs where the kernel would hang when returning
>> from retention or return the wrong rate for the DPLL.
>> 
>> This patch is a collaboration with Peter de Schrijver 
>> <peter.de-schrijver@nokia.com> and Kevin Hilman 
>> <khilman@deeprootsystems.com>.
>
> Pushing to l-o tree today.
>

Actually, I think Tero and Paul have a different fix for this now,
which is what I've included in the latest PM branch.

Tero can you send the updated version of you "Fix a bug with noncore
dpll rate calculation" patch?

Kevin

>
>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/mach-omap2/clock34xx.c |   15 +++++----------
>>  1 files changed, 5 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
>> index 3a4e160..b8b4494 100644
>> --- a/arch/arm/mach-omap2/clock34xx.c
>> +++ b/arch/arm/mach-omap2/clock34xx.c
>> @@ -163,19 +163,14 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
>>  
>>  	ai = omap3_dpll_autoidle_read(clk);
>>  
>> +	omap3_dpll_deny_idle(clk);
>> +
>>  	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
>>  
>> -	if (ai) {
>> -		/*
>> -		 * If no downstream clocks are enabled, CM_IDLEST bit
>> -		 * may never become active, so don't wait for DPLL to lock.
>> -		 */
>> -		r = 0;
>> +	r = _omap3_wait_dpll_status(clk, 1);
>> +
>> +	if (ai)
>>  		omap3_dpll_allow_idle(clk);
>> -	} else {
>> -		r = _omap3_wait_dpll_status(clk, 1);
>> -		omap3_dpll_deny_idle(clk);
>> -	};
>>  
>>  	return r;
>>  }
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
