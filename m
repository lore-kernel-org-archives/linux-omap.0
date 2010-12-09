From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v8 01/11] OMAP: GPIO: prepare for platform driver
Date: Thu, 9 Dec 2010 23:29:33 +0100
Message-ID: <4D01584D.8080606@ti.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>	<1290689318-10191-2-git-send-email-charu@ti.com>	<8762v292ld.fsf@deeprootsystems.com> <4D014B3C.7040806@ti.com> <871v5q7fn4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56221 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab0LIW3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 17:29:43 -0500
In-Reply-To: <871v5q7fn4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

On 12/9/2010 11:19 PM, Kevin Hilman wrote:
> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>
>> Salut Kevin,
>>
>> On 12/9/2010 8:18 PM, Kevin Hilman wrote:
>>> Hi Charu,
>>>
>>> "Varadarajan, Charulatha"<charu@ti.com>   writes:
>>>
>>>> Prepare for implementing GPIO as a platform driver.
>>>>
>>>> Modifies omap_gpio_init() to make use of omap_gpio_chip_init()
>>>> and omap_gpio_mod_init(). omap_gpio_mod_init() does the module init
>>>> by clearing the status register and initializing the GPIO control register.
>>>> omap_gpio_chip_init() initializes the chip request, free, get, set and
>>>> other function pointers and sets the gpio irq handler.
>>>>
>>>> This is only to reorganize the code so that the "omap gpio platform driver
>>>> implementation patch" looks cleaner and better to review.
>>>>
>>>> Signed-off-by: Charulatha V<charu@ti.com>
>>>
>>> I just noticed while testing on 36xx/Zoom3 that GPIO wakeups are no
>>> longer working after this series.
>>>
>>> The problem seems to be that for OMAP2+, this series removed manual
>>> SYSCONFIG register setting in favor of using omap_hwmod (which is good),
>>> however some of the SYSCONFIG values, specifically, in the current code,
>>> the ENAWAKEUP bit was set in each bank, but this is no longer the
>>> default with omap_hwmod.
>>
>> That part is strange, because Rajendra did a patch to enable the
>> wakeup bit during _omap_hwmod_enable as soon as the idlemode is set to
>> smartidle.
>>
>> /* If slave port is in SMARTIDLE, also enable wakeup */
>> if ((sf&  SYSC_HAS_SIDLEMODE)&&  (s_idlemode == HWMOD_IDLEMODE_SMART))
>> 	_enable_wakeup(oh);
>>
>> The _disable_wakeup is never called, so in theory once it is set, it
>> should remain enabled.
>>
>> Does that mean that this the GPIO is not in smartidle anymore in your case?
>
> Looks like a bug in the patch that added automatic wakeup enables.
> Basically, wakeups are enabled, but are promptly disabled if
> SYSC_HAS_AUTOIDLE.  Here's the code:
>
> 	/*
> 	 * XXX The clock framework should handle this, by
> 	 * calling into this code.  But this must wait until the
> 	 * clock structures are tagged with omap_hwmod entries
> 	 */
> 	if ((oh->flags&  HWMOD_SET_DEFAULT_CLOCKACT)&&
> 	(sf&  SYSC_HAS_CLOCKACTIVITY))
> 		_set_clockactivity(oh, oh->class->sysc->clockact,&v);
>
> 	_write_sysconfig(v, oh);
>
> OK, so here, 'v' has wakeups disabled.
>
> 	/* If slave is in SMARTIDLE, also enable wakeup */
> 	if ((sf&  SYSC_HAS_SIDLEMODE)&&  !(oh->flags&  HWMOD_SWSUP_SIDLE))
> 		_enable_wakeup(oh);
>
> Here we enabled them directly in SYSC (but 'v' is not updated)
>
> 	/*
> 	 * Set the autoidle bit only after setting the smartidle bit
> 	 * Setting this will not have any impact on the other modules.
> 	 */
> 	if (sf&  SYSC_HAS_AUTOIDLE) {
> 		idlemode = (oh->flags&  HWMOD_NO_OCP_AUTOIDLE) ?
> 			0 : 1;
> 		_set_module_autoidle(oh, idlemode,&v);
> 		_write_sysconfig(v, oh);
> 	}
>
> And here, SYSCONFIG is updated again using 'v', which does not have
> wakeups enabled.
>
> A quick patch (below) shows that if I update 'v' after enabling wakeups,
> the problem is fixed.
>
> I'll cook up a cleaner patch for this, but I think the solution is
> probably to change _enable_wakeup() to take the 'v' argument and modify
> it instead of directly writing SYSCONFIG.  That will make it more like
> all the other helper functions.

Funny, I did a patch that does that yesterday just because the wakeup 
enable on some OMAP4 IPs does require changing the idlemode as well.

So I added a new _set_enawakeup API to use the same programming model.

+static int _set_enawakeup(struct omap_hwmod *oh, u8 enawakeup, u32 *v)
  {
-	u32 v, wakeup_mask;
+	u32 wakeup_mask;
+	u8 wakeup_shift;

  	if (!oh->class->sysc ||
  	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
@@ -401,10 +402,44 @@ static int _enable_wakeup(struct omap_hwmod *oh)
  		return -EINVAL;
  	}

-	wakeup_mask = (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
+	wakeup_shift = oh->class->sysc->sysc_fields->enwkup_shift;
+	wakeup_mask = 0x1 << wakeup_shift;
+
+	*v &= ~wakeup_mask;
+	*v |= enawakeup << wakeup_shift;
+
+	return 0;
+}
+

That does not solve the issue I was trying to fix with the McPDM driver, 
that's why I didn't send it yet, but that might be enough for the GPIO.

Regards,
Benoit

>
> Kevin
>
>
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 12856eb..adcb1fc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -791,8 +791,10 @@ static void _enable_sysc(struct omap_hwmod *oh)
>   	_write_sysconfig(v, oh);
>
>   	/* If slave is in SMARTIDLE, also enable wakeup */
> -	if ((sf&  SYSC_HAS_SIDLEMODE)&&  !(oh->flags&  HWMOD_SWSUP_SIDLE))
> +	if ((sf&  SYSC_HAS_SIDLEMODE)&&  !(oh->flags&  HWMOD_SWSUP_SIDLE)) {
>   		_enable_wakeup(oh);
> +		v = oh->_sysc_cache;
> +	}
>
>   	/*
>   	 * Set the autoidle bit only after setting the smartidle bit

