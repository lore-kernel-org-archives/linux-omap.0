From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] OMAP3:PM:Fix for Silicon bug on Context restore on
 OMAP3430
Date: Thu, 22 Oct 2009 02:37:08 -0500
Message-ID: <4AE00BA4.20000@ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA23E5A7@dbde02.ent.ti.com> <87y6n4onxq.fsf@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A511127@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZJVHhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 03:37:05 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A511127@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gopinath, Thara had written, on 10/22/2009 01:49 AM, the following:
> 
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>> Hilman
>>> Sent: Wednesday, October 21, 2009 7:21 PM
>>> Is this patch still needed with this fix recently postd by Nokia:
[...]
>>>
>>>   http://marc.info/?l=linux-omap&m=125569123004013&w=2
> 
> This patch is still needed. The problem is with accessing SAVEDONE bit while the save is happening.
> 
>>> Also, this description is still missing the Errata reference.  After
>>> reading the errata, I don't think a Kconfig option is the right
>>> answer.  Rather, the delay should be inserted iff the pin is enabled,
>>> set as output, and set to high.
> 
> Why should this affect only if the pin is output and set to high? The problem is the padconf values for this pin will not be saved and any junk can be restored back irrespective of what state the pin was configured to be in.

Why do we care to enable this if the pin is unused and not connected in 
any way? Is there an added consumption even if the pin is NCed?

> There is no errata released for this yet. 300 us was found by the Silicon team to be a safe value and was recommended to be used. This will probably be formally relased as an errata in a while. Also 300 us might get optimized. But this is the available fix today as per h/w recommendations. We can probably put a comment as per errata xyz where xyz can be populated later.

Yes, a comment to that effect will be informative.

[...]
>>>
>>> Re: Subject, would be better as
Ack.
>>>
>>> OMAP3: PM: PADCONF restore fix for Errata x.xxx
>>>
>>>> --- arch/arm/mach-omap2/pm34xx.c | 25 +++++++++++++++++++++++++
>>>> arch/arm/plat-omap/Kconfig | 17 +++++++++++++++++ 2 files changed,
>>>> 42 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>>> index cea3bca..4f9671a 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -26,6 +26,7 @@
>>>>  #include <linux/err.h>
>>>>  #include <linux/gpio.h>
>>>>  #include <linux/clk.h>
>>>> +#include <linux/delay.h>
>>>>
>>>>  #include <mach/sram.h>
>>>>  #include <mach/prcm.h>
>>>> @@ -54,10 +55,19 @@
>>>>
>>>>  static int regset_save_on_suspend;
>>>>
>>>> +/* A extra variable to store value of pad_config register if
>>>> + * delay is not to be inserted and value is explicitly restored
>>>> + * in resume path.
>>>> + */
>>>> +#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
>>>> +static u32 store_pad_config;
>>>> +#endif
>>>> +

could we use the FEATURE() infrastructure for this? I mean if we 
introduce an API set_feature() - I just wanted to probe a possible 
alternative here. and use the has_feature()?? I guess it might be a 
misuse of the initial intention of FEATURE.. just wanted to think a 
little wild here..

>>>>  /* Scratchpad offsets */
>>>>  #define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
>>>>  #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
>>>>  #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
>>>> +#define CONTROL_PADCONF_ETK_D14			0x480025F8
Aieee... hardcoded value!!!! please avoid and use
arch/arm/plat-omap/include/plat/control.h

>>>>
>>>>  u32 enable_off_mode;
>>>>  u32 sleep_while_idle;
>>>> @@ -202,6 +212,17 @@ static void omap3_core_save_context(void)
>>>>  	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
>>>>  	control_padconf_off |= START_PADCONF_SAVE;
>>>>  	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
>>>> +#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
>>>> +	store_pad_config = omap_readl(CONTROL_PADCONF_ETK_D14);
                            ^^^^^^^^^^
                            omap_ctrl_readl??
>>> omap_read* deprecated.  Use omap_ctrl_readl(<offset>) as is done in
>>> the rest of the code.
unreadable patch :( git send-email might help?
>>>
>>>> +#else
>>>> +	/* Due to Silicon Bug on context restore it is found
>>>> +	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
>>>> +	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
                                                              ^^^^^    ^^
I am perhaps a lil nitpicky ->                               access  MPU
>>>> +	 * for 300us for scm to finish saving task
                          ^^^
                          SCM
>>>> +	 */
>>>> +	udelay(300);
>>>> +#endif
>>>> +
>>>>  	/* wait for the save to complete */
>>>>  	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
>>>>  			& PADCONF_SAVE_DONE)
>>>> @@ -217,6 +238,10 @@ static void omap3_core_save_context(void)
>>>>
>>>>  static void omap3_core_restore_context(void)
>>>>  {
>>>> +	/* Restore the last padconf value if needed */
>>>> +#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
>>>> +	omap_writel(store_pad_config, CONTROL_PADCONF_ETK_D14);
         ^^^^^^^^^^^
        omap_ctrl_writel?

-- 
Regards,
Nishanth Menon
