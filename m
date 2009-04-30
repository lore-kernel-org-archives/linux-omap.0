From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v3
Date: Thu, 30 Apr 2009 16:17:38 +0900
Message-ID: <4d34a0a70904300017p1ff38048oae675a4e93e68124@mail.gmail.com>
References: <4d34a0a70904030343h4f1562b5y3dbc9467aac9967@mail.gmail.com>
	<87tz4i981a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:32591 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbZD3HR6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 03:17:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1306335rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2009 00:17:58 -0700 (PDT)
In-Reply-To: <87tz4i981a.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: OMAP <linux-omap@vger.kernel.org>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, Paul Walmsley <paul@pwsan.com>

Hi Kevin,
Thank you for showing steady interest in this driver.

On Tue, Apr 21, 2009 at 9:15 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>
> Hi Kyuwon,
>
> While I still like the concept of this driver, I'm still not quite
> happy about how it is implemented for various reasons.  Most of which
> have to do with the fact that this driver does many things that really
> should be the job of other layers.  In particular, the list of
> omap3_wake_events is a bit troubling.  It really should be handled by
> the omapdev layer.  You'll see that you are duplicating the data that
> is handled there.  Rather, we should just extend the omapdev data to
> handle the wakeup events for that device.

If you allow me to insert a new field whose name is "mask" in the
omapdev struct, I think I can extend the omapdev to handle the wakeup
events.

> Also, I still think the WKST register reading should be done in the
> PRCM interrupt handler.  In your previous attempt, you were seeing a
> bunch of non-device wakeup related interrupts.   Can you try again
> with the attached patch (thanks to Paul Walmseley) which should help
> us debug why you were seeing spurious PRCM interrupts.

First of all, sorry for giving you the wrong information in the
previous mail. I found that we actually have configured GPTIMER12 as
the system timer.
And I tried with the attached patch, but I can't see any debug message.
However even now, PRCM interrupt handler is invoked quite often due to
the system timer.

As far as I know, after Peter's [OMAP3: PM: CPUidle: Add new
lower-latency C1 state] patch is applied, the system is in 'wfi' state
in every idle state. So whenever the system timer wake up the system
from idle, I think PRCM interrupt occurs. Do you think still the WKST
register should be read in the PRCM interrupt handler? ;)

> Also, I know we discussed this before, but I think the GPIO wakeup
> source stuff really belongs in a separate patch, and if you think it
> is still useful, and cannot be done by just enabling a GPIO IRQ from
> the board file, I suggest you propose a patch to the generic GPIO
> layer to add this interface.

OK, I will remove this GPIO wakeup feature. But I want to know more
detailed information about wakeup event . So, instead of using the
GPIO wakeup, I'm planning using WAKEUPEVENT bit in CONTROL_PADCONF_x
registers.

>> diff --git a/arch/arm/mach-omap2/prcm-common.h
>> b/arch/arm/mach-omap2/prcm-common.h
>> index cb1ae84..1f340aa 100644
>> --- a/arch/arm/mach-omap2/prcm-common.h
>> +++ b/arch/arm/mach-omap2/prcm-common.h
>> @@ -273,6 +273,10 @@
>>  #define OMAP3430_ST_D2D_SHIFT                                3
>>  #define OMAP3430_ST_D2D_MASK                         (1 << 3)
>>
>> +/* PM_WKST3_CORE, CM_IDLEST3_CORE shared bits */
>> +#define OMAP3430_ST_USBTLL_SHIFT                     2
>> +#define OMAP3430_ST_USBTLL_MASK                              (1 << 2)
>> +
>>  /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
>>  #define OMAP3430_EN_GPIO1                            (1 << 3)
>>  #define OMAP3430_EN_GPIO1_SHIFT                              3
>> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h
>> b/arch/arm/mach-omap2/prm-regbits-34xx.h
>> index 06fee29..f0a6395 100644
>> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
>> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
>> @@ -332,6 +332,8 @@
>>  /* PM_IVA2GRPSEL1_CORE specific bits */
>>
>>  /* PM_WKST1_CORE specific bits */
>> +#define OMAP3430_ST_MMC3_SHIFT                               30
>> +#define OMAP3430_ST_MMC3_MASK                                (1 << 30)
>>
>>  /* PM_PWSTCTRL_CORE specific bits */
>>  #define OMAP3430_MEM2ONSTATE_SHIFT                   18
>> @@ -432,6 +434,9 @@
>>
>>  /* PM_PREPWSTST_PER specific bits */
>>
>> +/* PM_WKST_USBHOST specific bits */
>> +#define OMAP3430_ST_USBHOST                          (1 << 0)
>> +
>>  /* RM_RSTST_EMU specific bits */
>
> All these new bit defines should all be 3430ES2_*.
OK, I will fix it.

Thanks & Regards,
Kyuwon
