From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 06/17] irqdomain: Don't set type when mapping an IRQ
Date: Tue, 10 May 2016 13:20:51 +0100
Message-ID: <5731D223.2080503@arm.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
 <1462379130-11742-7-git-send-email-jonathanh@nvidia.com>
 <5730813B.7060206@arm.com> <57308D0D.4080800@nvidia.com>
 <5730A867.9070504@arm.com> <5730B078.8090908@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5730B078.8090908-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/05/16 16:44, Jon Hunter wrote:
> 
> On 09/05/16 16:10, Marc Zyngier wrote:
>> On 09/05/16 14:13, Jon Hunter wrote:
>>> On 09/05/16 13:23, Marc Zyngier wrote:
> 
> [snip]
> 
>>>> This patch have the effect of making misconfigured PPIs absolutely
>>>> obvious. I still need to wrap my head around the root cause, but here's
>>>> the findings I have so far:
>>>>
>>>> - kvmtool generates a DT with the wrong trigger information (edge
>>>> instead of level) for the timer.
>>>> - with this patch applied, "cyclictest -S" reliably locks up when run in
>>>> a guest (missing a timer interrupt, goodbye CPU).
>>>> - Either fixing kvmtool or reverting that patch makes it work reliably
>>>> again.
>>>>
>>>> My gut feeling is that until that patch, the failing irq_set_irq_type()
>>>> wasn't affecting the kernel's view of the trigger (it was still treated
>>>> as level). With this patch, the kernel now trusts whatever is coming
>>>> from the firmware, and the misconfiguration becomes obvious. And just
>>>> grepping through the DT files for arm and arm64 sends makes me thing
>>>> "Holly effin' crap!".
>>>>
>>>> I'm not saying that we shouldn't perform this change though. But it is
>>>> quite obvious that it is going to break an awful lot of existing code
>>>> and platforms. I'm also cooking a small patch for the arch timer (which
>>>> seems to be described in DT with a fairly high level of brokenness), so
>>>> that we can mop-up most of the brain damage.
>>>
>>> Hmmm ... yes I see. I wonder if we should make the setting of the type
>>> here dependent upon PM being enabled for an irqchip? We could check to
>>> see if the .parent_device is populated and if so only then save the type
>>> and otherwise just set it as we do today.
>>
>> I don't really like the idea of having multiple code paths for the same thing.
>> This is very error prone, and likely to bitrot pretty quickly.
> 
> True. However, we really need this change for irqchips and runtime-pm.
> So to confirm what are you suggesting we do? We could add a WARN around
> irq_set_irq_type() in irq_create_fwspec_mapping() for v4.7 and see how
> many complaints we get :-)

Let's add a pr_warn(), and see how noisy this becomes. We may have to
remove it if it becomes too loud though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
