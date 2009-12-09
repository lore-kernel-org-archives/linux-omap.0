From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] Smartreflex: Avoid unnecessary spam
Date: Wed, 9 Dec 2009 17:21:29 -0600
Message-ID: <4B2030F9.9020705@ti.com>
References: <1260281775-30361-1-git-send-email-tero.kristo@nokia.com> <87y6lbsprl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40591 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758289AbZLIXVZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 18:21:25 -0500
In-Reply-To: <87y6lbsprl.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman had written, on 12/09/2009 05:15 PM, the following:
> Tero Kristo <tero.kristo@nokia.com> writes:
> 
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Current warning messages will be constantly printed out during normal operation
>> if smartreflex autocompensation is disabled.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> 
> Agreed that these warnings are spam, but I think they should be
> replaced by some one-time warning so at least there's a hint someplace
> that SR is not actually being done on a platfrom.

is'nt that already taken care?
echo -n 1 >/sys/power/vdd1_autocomp; echo $?
should return a non 0 value if it was not set, else should set 0 if it 
went ok.

if someone wants to verify the state, it should be a cat 
/sys/power/vdd1_autocomp to know if autocomp was set or not.

For some userspace to know if autocomp was set or not (if I understand 
your intention) should look at return value like normal linux commands.

> 
> Kevin
> 
>> ---
>>  arch/arm/mach-omap2/smartreflex.c |   10 +---------
>>  1 files changed, 1 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>> index be3a1da..db228b2 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -675,13 +675,8 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
>>  		sr_configure(sr);
>>  	}
>>  
>> -	if (sr->is_autocomp_active == 1)
>> -		pr_warning("SR%d: VDD autocomp is already active\n",
>> -									srid);
>> -
>>  	sr->is_autocomp_active = 1;
>>  	if (!sr_enable(sr, target_opp_no)) {
>> -		pr_warning("SR%d: VDD autocomp not activated\n", srid);
>>  		sr->is_autocomp_active = 0;
>>  		if (sr->is_sr_reset == 1)
>>  			sr_clk_disable(sr);
>> @@ -707,11 +702,8 @@ int sr_stop_vddautocomap(int srid)
>>  		/* Reset the volatage for current OPP */
>>  		sr_reset_voltage(srid);
>>  		return true;
>> -	} else {
>> -		pr_warning("SR%d: VDD autocomp is not active\n",
>> -								srid);
>> +	} else
>>  		return false;
>> -	}
>>  
>>  }
>>  EXPORT_SYMBOL(sr_stop_vddautocomap);
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Regards,
Nishanth Menon
