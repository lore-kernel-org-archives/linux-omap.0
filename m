From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] OMAP3: don't init PM on AM35{05,17}
Date: Wed, 11 Jan 2012 23:36:41 +0400
Message-ID: <4F0DE4C9.5060903@emcraft.com>
References: <4EEE80DE.8040001@emcraft.com>	<1324339251-10764-1-git-send-email-yanok@emcraft.com> <87lipo8ii4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:35086 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab2AKTgk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 14:36:40 -0500
In-Reply-To: <87lipo8ii4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On 04.01.2012 03:37, Kevin Hilman wrote:
>> Current OMAP3 PM code seems to be incompatible with AM35{05,17} and
>> leads to system hang during boot.
>> Disable PM init on AM35{05,17} until working implementation will be
>> merged.
> 
> Were you able to find out where exactly things got hung up?

Well, actually there were two manifestations of this problem:
 1. Output on the serial console is slow. I'm working with the board
remotely so it really looked like slow internet connection but I've
verified it and found that the problem is certainly on the board side. I
can't say if it's the whole system running so slow or only serial
console cause I haven't managed to boot it.
 2. At some point cpu_idle() is called, execution goes to SRAM and never
comes back...

Regards, Ilya.

> We're trying hard to avoid adding more cpu_is_* checks so would like to
> better understand the problem before merging such a fix.
> 
> Thanks,
> 
> Kevin
> 
>> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>> ---
>> This patch solves the problem for me but I'm curious why simple
>> CONFIG_PM disabling doesn't work? I'm getting
>> Unhandled fault: external abort on non-linefetch
>> while trying to access absolutely valid register from omapdss/venc
>> driver. I've tried to disable VENC but then I got the same error
>> from omap_wdt driver. Is it supposed to be so? Are !CONFIG_PM
>> configurations supported? How comes that disabling CONFIG_PM
>> makes some registers inaccessible?
>>
>> Regards, Ilya.
>>
>>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index fc69875..0f30742 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -790,7 +790,7 @@ static int __init omap3_pm_init(void)
>>  	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
>>  	int ret;
>>  
>> -	if (!cpu_is_omap34xx())
>> +	if (!cpu_is_omap34xx() || cpu_is_omap3505() || cpu_is_omap3517())
>>  		return -ENODEV;
>>  
>>  	if (!omap3_has_io_chain_ctrl())

