From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 07/15] irqdomain: Don't set type when mapping an IRQ
Date: Thu, 17 Mar 2016 15:06:30 +0000
Message-ID: <56EAC7F6.8000504@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-8-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1603171553170.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1603171553170.3978@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 17/03/16 14:55, Thomas Gleixner wrote:
> On Thu, 17 Mar 2016, Jon Hunter wrote:
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1117,6 +1117,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>>  	new->irq = irq;
>>  
>>  	/*
>> +	 * If the trigger type is not specified by the caller,
>> +	 * then use the default for this interrupt.
>> +	 */
>> +	if (!(new->flags & IRQF_TRIGGER_MASK))
>> +		new->flags |= irqd_get_trigger_type(&desc->irq_data);
>> +
> 
> This change is independent of the irqdomain part and should be in a seperate
> patch because it affects all callers.

Ok, I will put this into a separate patch.

Cheers
Jon
