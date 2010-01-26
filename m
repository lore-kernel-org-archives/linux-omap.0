From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM: VDD2 OPPs
Date: Tue, 26 Jan 2010 15:47:09 -0800
Message-ID: <87fx5szawy.fsf@deeprootsystems.com>
References: <0C997DD87CC88A4F86C897F52650B52B02807701@MOLSON.mpc-data.co.uk>
	<4B5F5378.9020800@ti.com>
	<0C997DD87CC88A4F86C897F52650B52B02807703@MOLSON.mpc-data.co.uk>
	<87636o1ocq.fsf@deeprootsystems.com>
	<0C997DD87CC88A4F86C897F52650B52B0280770D@MOLSON.mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:39618 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab0AZXrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 18:47:12 -0500
Received: by pxi12 with SMTP id 12so3925356pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 15:47:11 -0800 (PST)
In-Reply-To: <0C997DD87CC88A4F86C897F52650B52B0280770D@MOLSON.mpc-data.co.uk> (Andrew Murray's message of "Tue\, 26 Jan 2010 23\:22\:03 -0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Murray <amurray@mpc-data.co.uk>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

"Andrew Murray" <amurray@mpc-data.co.uk> writes:

> For some reason I thought that enable_off_mode, voltage_off_when_idle
> and sleep_when_idle are disabled by default - thus the only way to make
> use of these features in a production system would be to mount debugfs
> and use the controls.
>
> The documentation on the elinux wiki suggests this is the case
> (http://elinux.org/OMAP_Power_Management#Features_2). Also the
> corresponding u32 variables for these properties don't appear to be
> initialised anywhere in the kernel. Unless I've missed something?

Yes, they are disabled by default because current linux-omap PM branch
does not have full off-mode support, so if they were enabled by
default there would likely be more complaints due to drivers without
off-mode support etc.

As we approach a kernel that has full off-mode support, we will likely
change the defaults to enabled and eventually remove the options
completely.

Kevin

>
> Many Thanks,
> 	
> Andrew Murray
>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: 26 January 2010 22:41
> To: Andrew Murray
> Cc: Nishanth Menon; linux-omap@vger.kernel.org
> Subject: Re: PM: VDD2 OPPs
>
> "Andrew Murray" <amurray@mpc-data.co.uk> writes:
>
> [...]
>
>> I've noticed that other than using the debugfs there is no way for a
>> user to configure sleep_when_idle, enable_off_mode,
>> voltage_off_when_idle. Do you think it would be worthwhile to add
>> these options to the KConfigs? I'd be happy to make these
>> modifications if so.  :)
>
> Hi Andrew,
>
> I'm curious what benefit you to having them as compile-time options
> instead of run-time?
>
> In general, these options are all under debugfs for debug during PM
> development, but they should not be considered as PM knobs for a
> production system.
>
> For a production system, the assumption is that the kernel is *always*
> trying to sleep-while-idle and enter off-mode.  Preventing low-power
> states is intended to be directed by drivers using constraints
> (latency, throughput, etc.)  When using constraints, the deeper sleep
> states are prevented while the constraints are in place and then
> (re)allowed after the constraints are removed.
>
> Kevin
>
>
>
>>
>> Many Thanks,
>>
>> Andrew Murray
>> 	
>> -----Original Message-----
>> From: Nishanth Menon [mailto:nm@ti.com] 
>> Sent: 26 January 2010 20:41
>> To: Andrew Murray
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: PM: VDD2 OPPs
>>
>> Andrew Murray had written, on 01/26/2010 02:34 PM, the following:
>>> Hello,
>>> 
>>> With regards to the OMAP2 (or at least the 3530 EVM) -the TRM and
>>> various whitepapers suggest that they are 3 OPP levels available for
>>> VDD2 (L3). However, from looking at the sources (linux-omap-pm / pm
>>> branch) it seems that only 2 OPP levels are supported (@166Mhz and
>>> @83Mhz) and used. I also notice that these rates are different to
>> those
>>> in a whitepaper (166, 100 and 41.5). Is there any particular reason
>> why
>> on OMAP34/35xx, I believe it should be s/100/83/.
>>> only 2 OPPs are used? 
>> to my knowledge 41.5Mhz is not known to provide any performance 
>> benefits. you can also see [1] and add 41.5 (pm-wip-opp is the new 
>> branch where we are introducing opp layer.
>>
>>> 
>>> I understand that the OPP level of VDD2 may be set by changes to the
>> OPP
>>> level of VDD1 (i.e. resource34xx.c:set_opp) - and modifying VDD1's
> OPP
>>> via cpufreq seems to be the only way to adjust the VDD2 OPP from
>>> user-land - is this correct?
>> The old /sys/power/vdd2_[opp|lock] was deprecated out. currently the 
>> control is for vdd1 OPP using cpufreq and indirect dependency for
> VDD2, 
>> is there a need for direct control of VDD2 freq?
>> -- 
>> Regards,
>> Nishanth Menon
>>
>> Ref:
>> [1] 
>>
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=bl
>>
> ob;f=arch/arm/mach-omap2/cpufreq34xx.c;h=07873e87ffc0fef97b4554efc3f17dc
>> 696cb25e3;hb=4f54a09e0ed9b2ee8e1adfe1716297792310d1c6#l46
>>
>>
>> No virus found in this incoming message.
>> Checked by AVG - www.avg.com 
>> Version: 8.5.432 / Virus Database: 271.1.1/2641 - Release Date:
> 01/25/10
>> 19:36:00
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> No virus found in this incoming message.
> Checked by AVG - www.avg.com 
> Version: 8.5.432 / Virus Database: 271.1.1/2641 - Release Date: 01/25/10
> 19:36:00
