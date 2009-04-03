From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Fri, 3 Apr 2009 19:20:19 +0900
Message-ID: <4d34a0a70904030320g197f836cld9c94b113a9fdffd@mail.gmail.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
	<87ocvhtesx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:23819 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbZDCKUh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 06:20:37 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1135664wff.4
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 03:20:35 -0700 (PDT)
In-Reply-To: <87ocvhtesx.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

Hi Kevin!

Thanks for reviewing this driver again. it is getting better, thanks to you.
I will send the new patch very soon and please feel free to criticize it.

my answers below:

On Wed, Apr 1, 2009 at 9:09 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

<snip>

> Hi Kim,
>
> Thanks for addressing my comments.  This is now more streamlined
> during the wakeup/resume path as I suggested.  Thanks.  A few more
> minor comments below...
>

<snip>

>>
>> +void omap_get_pending_irqs(u32 *pending_irqs, unsigned len)
>> +{
>> +     int i, idx = 0;
>> +
>
> minor detail, but how about the more common 'j' instead of idx.

Ok. changed it.

<snip>
>>
>> +static struct pm_wakeup_status omap3_pm_wkst;
>> +
>> +void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst)
>> +{
>> +     *pm_wkst = &omap3_pm_wkst;
>> +}
>> +
>
> Can you rename this to omap3_get_last_wake_state()

Actually, I removed this function and I didn't get the WKST registers
from the last PRCM interrupt in the new patch. Sorry that I don't
address your suggestion. But I found that the PRCM interrupt is being
generated in normal state on the latest PM branch and, from OMAP34XX
TRM (4.9 PRCM Interrupts), PRCM Interrupts can be generated in many
cases in addition to wake-up from suspend. So if my wakeup code gets
the WSKT values from PRCM interrupt, I think it could show the wrong
information.

<snip>

>> +     if (len > count) {
>> +             printk(KERN_ERR "Can't strncat: %s\n", src);
>
> pr_err(...)

OK, thanks. I changed it.

<snip>

>> +
>> +static int omap_wake_lookup_event(u32 wkst, char *event,
>> +                             struct wake_event *events, unsigned len)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < len; i++)
>> +             if (wkst & events[i].mask) {
>> +                     strncpy(event, events[i].name, WAKE_BUF_LEN - 1);
>> +                     return 0;
>> +             }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static void omap_wake_detect_wkup(u32 wkst, char *event)
>> +{
>> +     int error = omap_wake_lookup_event(wkst, event,
>> +             omap3_wkup_events, ARRAY_SIZE(omap3_wkup_events));
>> +     if (error)
>> +             snprintf(event, WAKE_BUF_LEN, "WKUP:0x%08x", wkst);
>> +}
>> +
>> +static void omap_wake_detect_per(u32 wkst, char *event)
>> +{
>> +     int error = omap_wake_lookup_event(wkst, event,
>> +             omap3_per_events, ARRAY_SIZE(omap3_per_events));
>> +     if (error)
>> +             snprintf(event, WAKE_BUF_LEN, "PER:0x%08x", wkst);
>> +}
>> +
>> +static void omap_wake_detect_core1(u32 wkst, char *event)
>> +{
>> +     int error;
>> +
>> +     error = omap_wake_lookup_event(wkst, event,
>> +             omap3_core1_events, ARRAY_SIZE(omap3_core1_events));
>> +     if (!error)
>> +             return;
>> +
>> +     if (omap_rev() == OMAP3430_REV_ES1_0) {
>> +             error = omap_wake_lookup_event(wkst, event,
>> +                                     omap3es1_core1_events,
>> +                                     ARRAY_SIZE(omap3es1_core1_events));
>> +     } else {
>> +             error = omap_wake_lookup_event(wkst, event,
>> +                                     omap3es2_core1_events,
>> +                                     ARRAY_SIZE(omap3es2_core1_events));
>> +     }
>> +     if (!error)
>> +             return;
>> +
>> +     snprintf(event, WAKE_BUF_LEN, "CORE1:0x%08x", wkst);
>> +}
>> +
>> +static void omap_wake_detect_core3(u32 wkst, char *event)
>> +{
>> +     int error = omap_wake_lookup_event(wkst, event,
>> +             omap3_core3_events, ARRAY_SIZE(omap3_core3_events));
>> +     if (error)
>> +             snprintf(event, WAKE_BUF_LEN, "CORE3:0x%08x", wkst);
>> +}
>> +
>> +static void omap_wake_detect_usbhost(u32 wkst, char *event)
>> +{
>> +     int error = omap_wake_lookup_event(wkst, event,
>> +             omap3_usbhost_events, ARRAY_SIZE(omap3_usbhost_events));
>> +     if (error)
>> +             snprintf(event, WAKE_BUF_LEN, "USBHOST:0x%08x", wkst);
>> +}
>
> I'm still not liking this method of multiple functions that are
> basically the same.   The only thing different is CORE1 which has some
> conditional code based on cpu_rev.
>
> To make this a little cleaner, you could have an array that contains
> the WKST, powerdomain name, and CPU rev flags, then have a common
> function that walks that array and dumps all.

What a nice idea! I fixed it.

>> +/* Detect wake-up events */
>> +static void omap_wake_detect_wakeup(struct omap_wake *wake,
>> +                                     char *wake_irq, char *wake_event,
>> +                                     size_t irq_size, size_t event_size)
>> +{
>
> None of these functions really "detect" wakeups.  They are merely
> converting the wakeup into a string.  Maybe "show" or "dump" is a
> better word than detect.

OK. Thanks. I choose "dump".

<snip>

>> +
>> +     /* WKUP */
>> +     if (pm_wkst->wkup) {
>> +             omap_wake_detect_wkup(pm_wkst->wkup, buf);
>> +             omap_wake_strncat(wake_event, buf, event_size - 1);
>> +     }
>> +
>> +     /* PER */
>> +     if (pm_wkst->per) {
>> +             omap_wake_detect_per(pm_wkst->per, buf);
>> +             omap_wake_strncat(wake_event, buf, event_size - 1);
>> +     }
>> +
>> +     /* CORE */
>> +     if (pm_wkst->core1) {
>> +             omap_wake_detect_core1(pm_wkst->core1, buf);
>> +             omap_wake_strncat(wake_event, buf, event_size - 1);
>> +     }
>> +     if (pm_wkst->core3) {
>> +             omap_wake_detect_core3(pm_wkst->core3, buf);
>> +             omap_wake_strncat(wake_event, buf, event_size - 1);
>> +     }
>> +
>> +     /* USBHOST */
>> +     if ((omap_rev() > OMAP3430_REV_ES1_0) && (pm_wkst->usbhost)) {
>> +             omap_wake_detect_usbhost(pm_wkst->usbhost, buf);
>> +             omap_wake_strncat(wake_event, buf, event_size - 1);
>> +     }
>
> Here is where you would just walk the array of WKST/domain tuples.

OK.

>
<snip>

>> +
>> +static irqreturn_t omap_wake_detect_gpio(int irq, void *dev_id)
>> +{
>> +     omap_wake_strncat(wakeup_gpio, dev_id, sizeof(wakeup_gpio) - 1);
>> +
>> +     return IRQ_HANDLED;
>> +}
>
> Again this is not a "detect".  How about omap_wake_gpio_interrupt()

OK. I used "omap_wake_gpio_interrupt()"

<snip>

>> +                             sizeof(wakeup_irq), sizeof(wakeup_event));
>> +     printk(KERN_INFO "OMAP resume IRQ: %s\n", wakeup_irq);
>> +     printk(KERN_INFO "OMAP resume event: %s\n", wakeup_event);
>
> pr_info(...)

OK. Thanks.

>>
>> +config OMAP_WAKE
>> +     tristate "OMAP34xx wakeup source support"
>> +     depends on ARCH_OMAP34XX && PM
>> +     default n
>> +     help
>> +       Select this option if you want to know what kind of wake-up event
>> +       wakes up your board from the low power mode. And this option
>> +       provides the unified GPIO wake-up source configuration.
>> +
>
> Update this as well to say that it only affects wakeup from suspend.

OK. Thanks

<snip>

>> diff --git a/arch/arm/plat-omap/include/mach/pm.h
>> b/arch/arm/plat-omap/include/mach/pm.h
>> index 9df0175..b10f5b0 100644
>> --- a/arch/arm/plat-omap/include/mach/pm.h
>> +++ b/arch/arm/plat-omap/include/mach/pm.h
>> @@ -175,6 +175,16 @@ extern void omap_serial_wake_trigger(int enable);
>>  #define omap_serial_wake_trigger(x)  {}
>>  #endif       /* CONFIG_OMAP_SERIAL_WAKE */
>>
>> +struct pm_wakeup_status {
>> +     u32 wkup;
>> +     u32 core1;
>> +     u32 core3;
>> +     u32 per;
>> +     u32 usbhost;
>> +};
>> +
>> +extern void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst);
>> +
>
> This should probably just go in wake34xx.h since this is all very
> OMAP3 specific.  pm.h is for OMAP1/2/3 common code.

Yes, I moved it to wake34xx.c

>>  #define ARM_SAVE(x) arm_sleep_save[ARM_SLEEP_SAVE_##x] = omap_readl(x)
>>  #define ARM_RESTORE(x) omap_writel((arm_sleep_save[ARM_SLEEP_SAVE_##x]), (x))
>>  #define ARM_SHOW(x) arm_sleep_save[ARM_SLEEP_SAVE_##x]
>> diff --git a/arch/arm/plat-omap/include/mach/wake.h
>> b/arch/arm/plat-omap/include/mach/wake.h
>> new file mode 100644
>> index 0000000..7da8ec8
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/mach/wake.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * wake.h
>> + *
>> + * Copyright (c) 2009 Samsung Eletronics
>> + *
>> + * Author: Kim Kyuwon <q1.kim@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#ifndef _WAKE_H_
>> +#define _WAKE_H_
>> +
>> +struct gpio_wake {
>> +     unsigned int    gpio;
>> +     unsigned long   irqflag;
>> +     const char      *name;
>> +     int             request;
>> +};
>> +
>> +struct omap_wake_platform_data{
>> +     struct gpio_wake        *gpio_wakes;
>> +     int                     gpio_wake_num;
>> +};
>> +
>> +#endif /* _WAKE_H_ */
>> +
>
> Do you need this common wake.h here?  Again, this dir is for common
> code accoss OMAP1/2/3 and this code is pretty OMAP3 specific.

Yes, I think I want to locate 'wake.h' here, so that board files can
include 'wake.h'
(I'm considering extending this driver to take charge of the board
specific wake-up policy.)
But If you know the better location, please let me know.

> Kevin
>

-- 
Kyuwon
