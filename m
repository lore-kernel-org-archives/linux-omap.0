From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 02/10] ARM: OMAP: Fix timer posted mode support
Date: Thu, 6 Sep 2012 09:20:07 -0500
Message-ID: <5048B117.7050601@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com> <1346871872-24413-3-git-send-email-jon-hunter@ti.com> <50489DBD.5030200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59313 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab2IFOUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 10:20:11 -0400
In-Reply-To: <50489DBD.5030200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 09/06/2012 07:57 AM, Vaibhav Hiremath wrote:
> 
> 
> On 9/6/2012 12:34 AM, Jon Hunter wrote:
>> Currently the dmtimer posted mode is being enabled when the function
>> __omap_dm_timer_reset() is called. This function is only being called for
>> OMAP1 timers and OMAP2+ timers that are being used as system timers. Hence,
>> for OMAP2+ timers that are NOT being used as a system timer, posted mode is
>> not enabled but the "timer->posted" variable is still set (incorrectly) in
>> the omap_dm_timer_prepare() function.
>>
>> This is a regression introduced by commit 3392cdd3 (ARM: OMAP: dmtimer:
>> switch-over to platform device driver) which changed the code to only call
>> omap_dm_timer_reset() for OMAP1 devices. Although this is a regression from
>> the original code it only impacts performance and so is not needed for stable.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  arch/arm/mach-omap2/timer.c               |    3 +--
>>  arch/arm/plat-omap/dmtimer.c              |   14 +++++---------
>>  arch/arm/plat-omap/include/plat/dmtimer.h |    9 ++++++++-
>>  3 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 5471706..e24ee0f 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -194,10 +194,9 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>>  	}
>>  	__omap_dm_timer_init_regs(timer);
>>  	__omap_dm_timer_reset(timer, 1, 1);
>> -	timer->posted = 1;
>> +	__omap_dm_timer_enable_posted(timer);
>>  
>>  	timer->rate = clk_get_rate(timer->fclk);
>> -
>>  	timer->reserved = 1;
>>  
>>  	return res;
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
>> index c34f55b..22790ea 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -122,21 +122,15 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
>>  
>>  static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>>  {
>> -	omap_dm_timer_enable(timer);
>>  	if (timer->pdev->id != 1) {
>>  		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
>>  		omap_dm_timer_wait_for_reset(timer);
>>  	}
>> -
>>  	__omap_dm_timer_reset(timer, 0, 0);
>> -	omap_dm_timer_disable(timer);
>> -	timer->posted = 1;
>>  }
>>  
>>  int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>>  {
>> -	int ret;
>> -
>>  	/*
>>  	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
>>  	 * do not call clk_get() for these devices.
>> @@ -150,13 +144,15 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>>  		}
>>  	}
>>  
>> +	omap_dm_timer_enable(timer);
>> +
>>  	if (timer->capability & OMAP_TIMER_NEEDS_RESET)
>>  		omap_dm_timer_reset(timer);
>>  
>> -	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>> +	__omap_dm_timer_enable_posted(timer);
>> +	omap_dm_timer_disable(timer);
>>  
>> -	timer->posted = 1;
>> -	return ret;
>> +	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> 
> May be I am speculating here and I know this is tested and supposed to
> work, but Isn't it safe to set parent keeping module enables.

So you would rather change the functional clock while the timer is
enabled/active? So although that we are doing this today, that does not
sound like a good idea to me :-)

> I would still recommend you to move is before omap_dm_timer_disable().
> There could be devices or hw bugs/issues, may be related to standby/idle
> protocol happening underneath module enable/disable.

The register for setting the timer parent clock is located in the
Configuration Module (OMAP1) and PRCM (OMAP2+) and so there is no
requirement to keep the timer active while doing this.

Furthermore, if you look at the omap_dm_timer_set_source() function that
can be called from any driver using the timer, we never enable the timer
when setting the timer clock source. So this way is more consistent with
how the set_source function is implemented.

Cheers
Jon
