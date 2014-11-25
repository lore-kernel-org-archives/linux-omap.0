From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH] ARM: DRA: hwmod: RTC: Add reset function for RTC
Date: Tue, 25 Nov 2014 09:32:48 +0530
Message-ID: <5473FF68.3070805@ti.com>
References: <1416199402-3865-1-git-send-email-lokeshvutla@ti.com> <546DB513.6000104@ti.com> <alpine.DEB.2.02.1411201644470.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53919 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaKYEEY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2014 23:04:24 -0500
In-Reply-To: <alpine.DEB.2.02.1411201644470.9204@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com

Hi Paul,
On Thursday 20 November 2014 10:26 PM, Paul Walmsley wrote:
> On Thu, 20 Nov 2014, Lokesh Vutla wrote:
> 
>> On Monday 17 November 2014 10:13 AM, Lokesh Vutla wrote:
>>> RTC IP have kicker feature which prevents spurious writes to its registers.
>>> In order to write into any of the RTC registers, KICK values has te be
>>> written to KICK registers. Currently hwmod is updating the IDLEMODE in rtc
>>> sysconfig register without writing into any kick register which is a noop.
>>> When autoidle is allowed for rtc, interruts are not received until IDLEMODE
>>> is set to SIDLE_SMART_WKUP.
>>> Adding a reset function to unlock RTC registers so that IDLEMODE is
>>> updated.
>> Ping..!!
>> Is this patch acceptable?
> 
> Lokesh
> 
> 1. This looks like a fix.  Is this intended to go in as a v3.18-rc patch, 
> or against v3.19?  If so it would be very helpful for the maintainers if 
> you were to state that somewhere.
Yes. This is a fix, intended to go in 3.18-rc. Sorry should have
mentioned it.
> 
> 2. Your patch unlocks the RTC registers, but never relocks it.  This seems 
> to defeat the point of the spurious write protection.  Shouldn't your 
> patch only unlock the RTC immediately before the hwmod code touches the 
> RTC registers, and then relock it immediately afterwards, per SPRUHZ6 
> section 23.4.3.3?  If so then the .reset function pointer is the wrong 
> place for this; I would suggest adding some .lock and .unlock function 
> pointers that are to be called before and after any register write to the 
> IP block.
Yeah I agree with you.
Currently rtc driver unlocks these kick registers in probe and leaves it unlocks for
further use.
But if hwmod does unlock and lock for every sysconfig write driver should also
implement unlock and lock for every rtc register write, which adds an extra overhead.
I am not sure if some one writes into rtc registers other than hwmod and driver.
IMO we can leave it unlocked as the driver does.
> 
> 3. Your macros don't mention DRA7xx specifically.  Does this sequence 
> apply to some other TI chips, or just DRA7xx?  Please document this in a 
> comment above the macros, and possibly change the name of the macros to 
> refer to DRA7XX.
This sequence applies to AM43xx and AM33xx also. So made it generic.
Ill document it.

Thanks and regards,
Lokesh
> 
> 
> - Paul
> 
>>
>> Thanks and regards,
>> Lokesh
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/omap_hwmod.h          |  1 +
>>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  1 +
>>>  arch/arm/mach-omap2/omap_hwmod_reset.c    | 23 +++++++++++++++++++++++
>>>  3 files changed, 25 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
>>> index 512f809..3703f99 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.h
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.h
>>> @@ -744,6 +744,7 @@ const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
>>>   */
>>>  
>>>  extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
>>> +int omap_hwmod_rtc_unlock(struct omap_hwmod *oh);
>>>  
>>>  /*
>>>   * Chip variant-specific hwmod init routines - XXX should be converted
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>> index 5684f11..90e1df4 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>> @@ -1584,6 +1584,7 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
>>>  static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
>>>  	.name	= "rtcss",
>>>  	.sysc	= &dra7xx_rtcss_sysc,
>>> +	.reset	= &omap_hwmod_rtc_unlock,
>>>  };
>>>  
>>>  /* rtcss */
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/omap_hwmod_reset.c
>>> index 65e186c..b825a28 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_reset.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
>>> @@ -30,6 +30,12 @@
>>>  
>>>  #include "omap_hwmod.h"
>>>  
>>> +#define RTC_KICK0_REG_OFFSET	0x6c
>>> +#define RTC_KICK1_REG_OFFSET	0x70
>>> +
>>> +#define RTC_KICK0_VALUE		0x83E70B13
>>> +#define RTC_KICK1_VALUE		0x95A4F1E0
>>> +
>>>  /**
>>>   * omap_hwmod_aess_preprogram - enable AESS internal autogating
>>>   * @oh: struct omap_hwmod *
>>> @@ -51,3 +57,20 @@ int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
>>>  
>>>  	return 0;
>>>  }
>>> +
>>> +/**
>>> + * omap_hwmod_rtc_unlock - Reset and unlock the Kicker mechanism.
>>> + * @oh: struct omap_hwmod *
>>> + *
>>> + * RTC IP have kicker feature.  This prevents spurious writes to its registers.
>>> + * In order to write into any of the RTC registers, KICK values has te be
>>> + * written in respective KICK registers. This is needed for hwmod to write into
>>> + * sysconfig register.
>>> + */
>>> +int omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
>>> +{
>>> +	omap_hwmod_write(RTC_KICK0_VALUE, oh, RTC_KICK0_REG_OFFSET);
>>> +	omap_hwmod_write(RTC_KICK1_VALUE, oh, RTC_KICK1_REG_OFFSET);
>>> +
>>> +	return 0;
>>> +}
>>>
>>
> 
> 
> - Paul
> 

