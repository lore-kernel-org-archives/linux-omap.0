From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] OMAP: omap_device: optionally auto-adjust device activate/deactivate latencies
Date: Mon, 11 Jan 2010 16:50:26 -0800
Message-ID: <871vhwjgdp.fsf@deeprootsystems.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-2-git-send-email-khilman@deeprootsystems.com>
	<4B489B1A.8040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:48615 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab0ALAu2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:50:28 -0500
Received: by ywh6 with SMTP id 6so22012364ywh.4
        for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 16:50:28 -0800 (PST)
In-Reply-To: <4B489B1A.8040609@gmail.com> (Nishanth Menon's message of "Sat\, 09 Jan 2010 09\:04\:58 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Nishanth Menon <menon.nishanth@gmail.com> writes:

> Kevin Hilman said the following on 01/08/2010 05:26 PM:
>> First, this patch adds new worst-case latency values to the
>> omap_device_pm_latency struct.  Here the worst-case measured latencies
>> for the activate and deactivate hooks are stored.
>>
>> In addition, add an option to auto-adjust the latency values used for
>> device activate/deactivate.
>>
>> By setting a new 'OMAP_DEVICE_LATENCY_AUTO_ADJUST' flag in the
>> omap_device_pm_latency struct, the omap_device layer automatically
>> adjusts the activate/deactivate latencies to the worst-case measured
>> values.
>>
>> Anytime a new worst-case value is found, it is printed to the console.
>> Here is an example log during boot using UART2 s an example.  After
>> boot, the OPP is manually changed to the 125MHz OPP:
>>
>> [...]
>> Freeing init memory: 128K
>> omap_device: serial8250.2: new worst case deactivate latency 0: 30517
>> omap_device: serial8250.2: new worst case activate latency 0: 30517
>> omap_device: serial8250.2: new worst case activate latency 0: 218139648
>> omap_device: serial8250.2: new worst case deactivate latency 0: 61035
>> omap_device: serial8250.2: new worst case activate latency 0: 278076171
>> omap_device: serial8250.2: new worst case activate latency 0: 298614501
>> omap_device: serial8250.2: new worst case activate latency 0: 327331542
>>
>> / # echo 125000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
>>
>> omap_device: serial8250.2: new worst case deactivate latency 0: 91552
>>
>> Motivation: this can be used as a technique to automatically determine
>> the worst case latency values.  The current method of printing a
>> warning on every violation is too noisy to actually interact the
>> console in order to set low OPP to discover latencies.
>>
>> Another motivation for this patch is that the activate/deactivate
>> latenices can vary depending on the idlemode of the device.  While
>> working on the UARTs, I noticed that when using no-idle, the activate
>> latencies were as high as several hundred msecs as shown above.  When
>> the UARTs are in smart-idle, the max latency is well under 100 usecs.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/plat-omap/include/plat/omap_device.h |    4 ++
>>  arch/arm/plat-omap/omap_device.c              |   41 ++++++++++++++++++++-----
>>  2 files changed, 37 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
>> index dc1fac1..76d4917 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -131,11 +131,15 @@ int omap_device_enable_clocks(struct omap_device *od);
>>   */
>>  struct omap_device_pm_latency {
>>  	u32 deactivate_lat;
>> +	u32 deactivate_lat_worst;
>>  	int (*deactivate_func)(struct omap_device *od);
>>  	u32 activate_lat;
>> +	u32 activate_lat_worst;
>>  	int (*activate_func)(struct omap_device *od);
>> +	u32 flags;
>>  };
>>  +#define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
>>   /* Get omap_device pointer from platform_device pointer */
>>  #define to_omap_device(x) container_of((x), struct omap_device, pdev)
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>> index 1e5648d..d8c75c8 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -148,10 +148,22 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
>>  			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
>>  			 act_lat);
>>  -		WARN(act_lat > odpl->activate_lat, "omap_device:
>> %s.%d: "
>> -		     "activate step %d took longer than expected (%llu > %d)\n",
>> -		     od->pdev.name, od->pdev.id, od->pm_lat_level,
>> -		     act_lat, odpl->activate_lat);
>> +		if (act_lat > odpl->activate_lat) {
>> +			odpl->activate_lat_worst = act_lat;
>> +			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
>> +				odpl->activate_lat = act_lat;
>> +				pr_warning("omap_device: %s.%d: new worst case "
>> +					   "activate latency %d: %llu\n",
>> +					   od->pdev.name, od->pdev.id,
>> +					   od->pm_lat_level, act_lat);
>>   
> nitpicky dumb comment: since the flags say auto adjust, do you care to
> make this just a pr_info instead of a warning. it is not the same
> severity as latency>activate_latency without AUTO_ADJUST right?

Agreed, will change to pr_info()

>> +			} else
>> +				pr_warning("omap_device: %s.%d: activate "
>> +					   "latency %d higher than exptected. "
>> +					   "(%llu > %d)\n",
>> +					   od->pdev.name, od->pdev.id,
>> +					   od->pm_lat_level, act_lat,
>> +					   odpl->activate_lat);
>>   
> nitpick: I think you need {} for the else part too now a days..

you mean as a CodingStyle issue, or a compiler issue?
do you have a reference for this requirement? 

do you mean if the 'if' part has {}, the else part should too, even if
it's a single line?

I don't really care one way or the other, just want to know more about
what you're suggesting.

Thanks,

Kevin
