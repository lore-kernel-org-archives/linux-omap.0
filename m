From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V3 7/7] ARM: DRA: Enable Crossbar IP support for DRA7XX
Date: Wed, 13 Nov 2013 09:32:44 -0600
Message-ID: <52839B9C.8090707@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com> <1383657257-3458-8-git-send-email-r.sricharan@ti.com> <5281BF70.4050708@ti.com> <5281C0E9.8020104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5281C0E9.8020104-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/11/2013 11:47 PM, Sricharan R wrote:
> Hi Rajendra,
> 
> On Tuesday 12 November 2013 11:11 AM, Rajendra Nayak wrote:
>> On Tuesday 05 November 2013 06:44 PM, Sricharan R wrote:
>>> Enable the crossbar IP support for DRA7xx soc.
>>>
>>> Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>>> Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  arch/arm/mach-omap2/Kconfig        |    1 +
>>>  arch/arm/mach-omap2/omap4-common.c |    4 ++++
>>>  2 files changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>> index b5fb5f7..2086c65 100644
>>> --- a/arch/arm/mach-omap2/Kconfig
>>> +++ b/arch/arm/mach-omap2/Kconfig
>>> @@ -141,6 +141,7 @@ config SOC_DRA7XX
>>>  	select ARM_GIC
>>>  	select HAVE_SMP
>>>  	select COMMON_CLK
>>> +	select IRQ_CROSSBAR
>>>  
>>>  comment "OMAP Core Type"
>>>  	depends on ARCH_OMAP2
>>> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
>>> index 5791143..274cbfa 100644
>>> --- a/arch/arm/mach-omap2/omap4-common.c
>>> +++ b/arch/arm/mach-omap2/omap4-common.c
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/of_platform.h>
>>>  #include <linux/export.h>
>>>  #include <linux/irqchip/arm-gic.h>
>>> +#include <linux/irqchip/irq-crossbar.h>
>>>  #include <linux/of_address.h>
>>>  #include <linux/reboot.h>
>>>  
>>> @@ -282,9 +283,12 @@ void __init omap_gic_of_init(void)
>>>  
>>>  skip_errata_init:
>>>  	omap_wakeupgen_init();
>>> +	if (soc_is_dra7xx())
>>> +		crossbar_init();
>> Its good if this is called irqcrossbar_init() to avoid confusion
>> with the dma crossbar which also exists in dra7 devices.
>>
>  Ya makes sense. Will change this.
Also why not call it without explicit soc check? there is already
parse for of_find_matching_node(NULL, crossbar_match); to see if we
have a match in the crossbar_init. OR call it from dra7 init without
SoC check dependency?

Rationale - with more TI SoCs trending towards crossbar, we dont need
to keep adding to the soc_is checks, further, we intend to remove
soc_is checks in it's entirety..


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
