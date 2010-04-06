From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH] OMAP3630 PM: Update for OPP 1GHz
Date: Tue, 06 Apr 2010 11:39:59 -0700
Message-ID: <871vespgqo.fsf@deeprootsystems.com>
References: <1270577169-8831-1-git-send-email-vishwanath.bs@ti.com>
	<4BBB5A18.4090406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:41562 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab0DFSkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 14:40:03 -0400
Received: by pzk31 with SMTP id 31so221509pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 11:40:02 -0700 (PDT)
In-Reply-To: <4BBB5A18.4090406@ti.com> (Nishanth Menon's message of "Tue\, 6 Apr 2010 10\:58\:16 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Sripathy, Vishwanath had written, on 04/06/2010 01:06 PM, the following:
>> It is found that system is not very stable with current 1GHz OPP
>> configuration (ARM@1G, IVA@880M, VDD1@1.31V) and it has been
>> recommended to use below configuration for stable 1GHz OPP. (ARM@1G,
>> IVA@800M, VDD1@1.35V).
>>
>> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>> ---
>> diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
>> index c453ec5..189c42e
>> --- a/arch/arm/mach-omap2/cpufreq34xx.c
>> +++ b/arch/arm/mach-omap2/cpufreq34xx.c
>> @@ -82,7 +82,7 @@ static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
>>  	/* OPP3 - OPP-Turbo */
>>  	OMAP_OPP_DEF(false, 800000000, 1260000),
>>  	/* OPP4 - OPP-SB */
>> -	OMAP_OPP_DEF(false, 1000000000, 1310000),
>> +	OMAP_OPP_DEF(false, 1000000000, 1350000),
>>  	/* Terminator */
>>  	OMAP_OPP_DEF(0, 0, 0)
>>  };
>> @@ -104,7 +104,7 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
>>  	/* OPP3 - OPP-Turbo */
>>  	OMAP_OPP_DEF(false, 660000000, 1260000),
>>  	/* OPP4 - OPP-SB */
>> -	OMAP_OPP_DEF(false, 875000000, 1310000),
>> +	OMAP_OPP_DEF(false, 800000000, 1350000),
>>  	/* Terminator */
>>  	OMAP_OPP_DEF(0, 0, 0)
>>  };
>
> Acked-by: Nishanth Menon <nm@ti.com>
>

Thanks, pushed to pm-wip-opp

Kevin
