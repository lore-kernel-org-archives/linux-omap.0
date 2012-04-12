From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 15:03:34 -0700
Message-ID: <87sjg87gll.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com>
	<4F86B227.90802@mlbassoc.com> <87aa2hjavi.fsf@ti.com>
	<4F86F4B2.3080101@mlbassoc.com> <87aa2ganwj.fsf@ti.com>
	<4F870C6D.3030203@mlbassoc.com> <877gxk962e.fsf@ti.com>
	<4F87276F.6070504@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:59245 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751119Ab2DLWDi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 18:03:38 -0400
Received: by dadz8 with SMTP id z8so3089205dad.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 15:03:36 -0700 (PDT)
In-Reply-To: <4F87276F.6070504@mlbassoc.com> (Gary Thomas's message of "Thu,
	12 Apr 2012 13:05:19 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

Gary Thomas <gary@mlbassoc.com> writes:

> On 2012-04-12 12:08, Kevin Hilman wrote:
>> Gary Thomas<gary@mlbassoc.com>  writes:
>>
>>> On 2012-04-12 10:57, Kevin Hilman wrote:
>>>> +Felipe for EHCI question
>>>>
>>>> Gary Thomas<gary@mlbassoc.com>   writes:
>>>>
>>>> [...]
>>>>
>>>>> This worked a treat, thanks.  My network performance is better
>>>>> now, but still not what it was.  The same TFTP transfer now takes
>>>>> 71 seconds, so about 50% slower than on the 3.0 kernel.  Applying the
>>>>> second [unnamed] patch (arch/arm/mach-omap2/cpuidle34xx.c) made no difference.
>>>>
>>>> And does a CONFIG_PM=n kernel get you back to your v3.0 performance?
>>>
>>> Correct.
>>>
>>
>> OK, I just tried your TFTP experiment on a 3530/Overo board with the
>> same smsc911x NIC that has GPIO interrupts, and I don't see much
>> difference between a PM-enabled v3.0 and a PM-enabled v3.3.
>>
>> Are you TFTP'ing the file to an MMC filesystem?    Can you try to a
>> ramdisk[1]?  If you're using MMC, it could be MMC driver changes since
>> v3.0 that are actually causing your performance hit.
>
> I'm testing to a ramdisk, so we're on the same page.
>
> Could you send me your config file so I can compare?  Maybe I have something
> "dumb" in my settings that aggravates things.

Below is the Kconfig snippet[1] I append to a default
omap2plus_defconfig to enable CPUidle, CPUfreq and some debug.  Rebuild
with that appended and these settings override the default ones.  I used
omap2plus_defcnfig plus this snippit for v3.0, v3.3 and v3.4-rc2 tests.

> Also, what's your performance on 3.4-rc2?  The linux-media tree I started
> from is a bit post v3.3, so there might be something else causing this.

I just tried with vanilla v3.4-rc2, and I see basically the same
results.  Between 35 and 50 seconds for the 24Mb file transfer, which is
similar to the v3.0 and v3.3 results.

Kevin

[1] 
CONFIG_CPU_IDLE=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_ADVANCED_DEBUG=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_OMAP_SMARTREFLEX=y
CONFIG_OMAP_SMARTREFLEX_CLASS3=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_ARM_OMAP2PLUS_CPUFREQ=y
CONFIG_REGULATOR_OMAP_SMPS=y

CONFIG_DEBUG_LL=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_USER=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_SECTION_MISMATCH=y

