From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 08/15] genirq: Add runtime power management support for
 IRQ chips
Date: Thu, 17 Mar 2016 15:28:33 +0000
Message-ID: <56EACD21.20309@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
 <56EAC6E8.1070806@arm.com> <56EAC98A.7090405@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EAC98A.7090405@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17/03/16 15:13, Jon Hunter wrote:
> Hi Marc,
> 
> On 17/03/16 15:02, Marc Zyngier wrote:
>> Hi Jon,
>>
>> On 17/03/16 14:19, Jon Hunter wrote:
>>> Some IRQ chips may be located in a power domain outside of the CPU
>>> subsystem and hence will require device specific runtime power
>>> management. In order to support such IRQ chips, add a pointer for a
>>> device structure to the irq_chip structure, and if this pointer is
>>> populated by the IRQ chip driver and CONFIG_PM is selected in the kernel
>>> configuration, then the pm_runtime_get/put APIs for this chip will be
>>> called when an IRQ is requested/freed, respectively.
>>>
>>> When entering system suspend and each interrupt is disabled if there is
>>> no wake-up set for that interrupt. For an IRQ chip that utilises runtime
>>> power management, print a warning message for each active interrupt that
>>> has no wake-up set because these interrupts may be unnecessarily keeping
>>> the IRQ chip enabled during system suspend.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>  include/linux/irq.h    |  5 +++++
>>>  kernel/irq/chip.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  kernel/irq/internals.h |  1 +
>>>  kernel/irq/manage.c    | 14 +++++++++++---
>>>  kernel/irq/pm.c        |  3 +++
>>>  5 files changed, 72 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>>> index c4de62348ff2..82f36390048d 100644
>>> --- a/include/linux/irq.h
>>> +++ b/include/linux/irq.h
>>> @@ -315,6 +315,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>>>  /**
>>>   * struct irq_chip - hardware interrupt chip descriptor
>>>   *
>>> + * @parent:		pointer to associated device
>>>   * @name:		name for /proc/interrupts
>>>   * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
>>>   * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
>>> @@ -354,6 +355,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>>>   * @flags:		chip specific flags
>>>   */
>>>  struct irq_chip {
>>> +	struct device	*parent;
>>
>> Nit: Please don't call this just "parent". We have parent fields in
>> irq_data and irq_domain structures, and they always are a pointer to the
>> same type, indicating some form of stacking. Here, we're pointing to a
>> different type altogether...
>>
>> How about calling it "dev", or "device" instead? It would make it much
>> clearer that when crossing that pointer, we're in another subsystem
>> altogether.
> 
> I will defer to Linus W here, as it was his request we make this
> 'parent' and not 'dev'. See ...
> 
> http://marc.info/?l=linux-kernel&m=145035839623442&w=2

Well, that contradicts the way use use the word "parent" in the IRQ
subsystem, I guess. I'd settle for parent_device or something along
those lines (but keep in mind I'm really bad at naming things).

Anyway, enough bikeshedding... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
