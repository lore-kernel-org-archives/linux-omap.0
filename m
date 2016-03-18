From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 06/15] irqdomain: Ensure type settings match for an
 existing mapping
Date: Fri, 18 Mar 2016 12:03:30 +0200
Message-ID: <56EBD272.1040404@ti.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-7-git-send-email-jonathanh@nvidia.com>
 <56EAF4E1.5020201@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EAF4E1.5020201@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/17/2016 08:18 PM, Jon Hunter wrote:
>
> On 17/03/16 14:19, Jon Hunter wrote:
>> When mapping an IRQ, if a mapping already exists, then we simply return
>> the virtual IRQ number. However, we do not check that the type settings
>> for the existing mapping match those for the mapping that is about to be
>> created. It may be unlikely that the type settings would not match, but
>> check for this and don't return a valid IRQ mapping if the type settings
>> do not match.
>>
>> WARN if the type return by irq_domain_translate() has bits outside the
>> sense mask set and then clear these bits. If these bits are not cleared
>> then this will cause the comparision of the type settings for an
>> existing mapping to fail with that of the new mapping even if the sense
>> bit themselves match. The reason being is that the existing type
>> settings are read by calling irq_get_trigger_type() which will clear
>> any bits outside the sense mask. This will allow us to detect irqchips
>> that are not correctly clearing these bits and fix them.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   kernel/irq/irqdomain.c | 59 ++++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 43 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 3a519a01118b..0ea285baa619 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -549,6 +549,13 @@ static int irq_domain_translate(struct irq_domain *d,
>>   				     fwspec->param, fwspec->param_count,
>>   				     hwirq, type);
>>


>> +	/*
>> +	 * WARN if the irqchip returns a type with bits
>> +	 * outside the sense mask set and clear these bits.
>> +	 */
>> +	if (WARN_ON(*type & ~IRQ_TYPE_SENSE_MASK))
>> +		*type &= IRQ_TYPE_SENSE_MASK;

Not sure that this warn and in this place make sense.
type will come unchanged here from caller irq_create_fwspec_mapping()



[...]


-- 
regards,
-grygorii
