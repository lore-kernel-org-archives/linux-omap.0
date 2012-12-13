From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC 1/5] ARM: CORESIGHT: Add generic lock/unlock helpers
Date: Thu, 13 Dec 2012 20:36:56 +0100
Message-ID: <CAORVsuXmKFNuHG+RoDaLehX0-1m=F5Uayvrs9NDRHW4C+9U4Lw@mail.gmail.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
	<1355348588-22318-2-git-send-email-jon-hunter@ti.com>
	<20121213145803.GL26540@mudshark.cambridge.arm.com>
	<50CA2A13.9090005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:43524 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab2LMTg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Dec 2012 14:36:59 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so2313326iad.41
        for <linux-omap@vger.kernel.org>; Thu, 13 Dec 2012 11:36:58 -0800 (PST)
In-Reply-To: <50CA2A13.9090005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>

Hi Jon, Will,

On Thu, Dec 13, 2012 at 8:18 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 12/13/2012 08:58 AM, Will Deacon wrote:
>> Hi Jon,
>>
>> On Wed, Dec 12, 2012 at 09:43:04PM +0000, Jon Hunter wrote:
>>> The Cross Trigger Interface (CTI) helpers in cti.h include definitions
>>> for the Coresight Lock Access Register (LAR) and Lock Status Register
>>> (LSR). These registers are already defined in coresight.h and so rather
>>> than having multiple definitions, just use the definitions from
>>> coresight.h.
>>>
>>> Add the following coresight macros ...
>>> - coresight_unlock() --> Unlocks coresight module
>>> - coresight_lock()   --> Locks coresight module
>>>
>>> Use the above macros for ETB, ETM and CTI. The do-while(0) statement
>>> has been removed from the macro as it is not a multi-line macro.
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>  arch/arm/include/asm/cti.h                |   16 +++-------------
>>>  arch/arm/include/asm/hardware/coresight.h |   16 ++++++++--------
>>>  2 files changed, 11 insertions(+), 21 deletions(-)
>>
>> [...]
>>
>>> diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
>>> index 7ecd793..dcd0e66 100644
>>> --- a/arch/arm/include/asm/hardware/coresight.h
>>> +++ b/arch/arm/include/asm/hardware/coresight.h
>>> @@ -141,17 +141,17 @@
>>>  #define ETBFF_TRIGEVT               BIT(9)
>>>  #define ETBFF_TRIGFL                BIT(10)
>>>
>>> -#define etb_writel(t, v, x) \
>>> -    (__raw_writel((v), (t)->etb_regs + (x)))
>>> +#define etb_writel(t, v, x) (__raw_writel((v), (t)->etb_regs + (x)))
>>>  #define etb_readl(t, x) (__raw_readl((t)->etb_regs + (x)))
>>>
>>> -#define etm_lock(t) do { etm_writel((t), 0, CSMR_LOCKACCESS); } while (0)
>>> -#define etm_unlock(t) \
>>> -    do { etm_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
>>> +#define etb_lock(t) coresight_lock((t)->etb_regs)
>>> +#define etb_unlock(t) coresight_unlock((t)->etb_regs)
>>> +#define etm_lock(t) coresight_lock((t)->etm_regs)
>>> +#define etm_unlock(t) coresight_unlock((t)->etm_regs)
>>>
>>> -#define etb_lock(t) do { etb_writel((t), 0, CSMR_LOCKACCESS); } while (0)
>>> -#define etb_unlock(t) \
>>> -    do { etb_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
>>> +#define coresight_lock(base) (__raw_writel(0, base + CSMR_LOCKACCESS))
>>> +#define coresight_unlock(base) \
>>> +    (__raw_writel(UNLOCK_MAGIC, base + CSMR_LOCKACCESS))
>>>
>>>  #endif /* __ASM_HARDWARE_CORESIGHT_H */
>>
>> How about we take this opportunity to divorce the more general coresight
>> bits from the etb specific parts, like you've done for the cti. We could
>> move the ETB stuff out into asm/etb.h (although it might be nice to keep all
>> the coresight device headers in one place... answers on a postcard) and just
>> have the architected coresight functionality in this header.
>
> Yes I have been wondering about that too. Long term it would be good to
> find a home in the drivers directory for all these coresight devices
> too. For now, we could extract the etb/etm parts from coresight.h into
> etb.h and etm.h, respectively.

I am now writing a HW trace driver that extracts traces from the CMI
and PMI IP blocks (and later L2CC). It is still in early development
status.

The idea I have in mind is to have the implementation in
drivers/power/hw_trace. Eventually this directory would contain the
drivers for ETM/ETB, CMI, PMI and also the coresight support. It would
be architected so that the lower level drivers export the necessary
functions for the higher level code to use the resource. Example: the
PMI driver would use the ETB and coresight drivers.

What do you think?

Regards,
Jean

>
> Cheers
> Jon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
