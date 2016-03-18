From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 06/15] irqdomain: Ensure type settings match for an
 existing mapping
Date: Fri, 18 Mar 2016 10:33:26 +0000
Message-ID: <56EBD976.7090107@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-7-git-send-email-jonathanh@nvidia.com>
 <56EAF4E1.5020201@nvidia.com> <56EBD272.1040404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56EBD272.1040404-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 18/03/16 10:03, Grygorii Strashko wrote:
> On 03/17/2016 08:18 PM, Jon Hunter wrote:
>>
>> On 17/03/16 14:19, Jon Hunter wrote:
>>> When mapping an IRQ, if a mapping already exists, then we simply return
>>> the virtual IRQ number. However, we do not check that the type settings
>>> for the existing mapping match those for the mapping that is about to be
>>> created. It may be unlikely that the type settings would not match, but
>>> check for this and don't return a valid IRQ mapping if the type settings
>>> do not match.
>>>
>>> WARN if the type return by irq_domain_translate() has bits outside the
>>> sense mask set and then clear these bits. If these bits are not cleared
>>> then this will cause the comparision of the type settings for an
>>> existing mapping to fail with that of the new mapping even if the sense
>>> bit themselves match. The reason being is that the existing type
>>> settings are read by calling irq_get_trigger_type() which will clear
>>> any bits outside the sense mask. This will allow us to detect irqchips
>>> that are not correctly clearing these bits and fix them.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>   kernel/irq/irqdomain.c | 59
>>> ++++++++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 43 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>> index 3a519a01118b..0ea285baa619 100644
>>> --- a/kernel/irq/irqdomain.c
>>> +++ b/kernel/irq/irqdomain.c
>>> @@ -549,6 +549,13 @@ static int irq_domain_translate(struct
>>> irq_domain *d,
>>>                        fwspec->param, fwspec->param_count,
>>>                        hwirq, type);
>>>
> 
> 
>>> +    /*
>>> +     * WARN if the irqchip returns a type with bits
>>> +     * outside the sense mask set and clear these bits.
>>> +     */
>>> +    if (WARN_ON(*type & ~IRQ_TYPE_SENSE_MASK))
>>> +        *type &= IRQ_TYPE_SENSE_MASK;
> 
> Not sure that this warn and in this place make sense.
> type will come unchanged here from caller irq_create_fwspec_mapping()

Yes you are right. I missed the return statement. I can move to
irq_create_fwspec_mapping().

Cheers
Jon
