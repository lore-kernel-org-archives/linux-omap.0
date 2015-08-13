From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 6/6] irqchip: crossbar: fix irq masking at suspend
Date: Thu, 13 Aug 2015 12:04:29 +0100
Message-ID: <55CC79BD.4030001@arm.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com> <1439401562-28874-7-git-send-email-grygorii.strashko@ti.com> <55CC63D0.8030707@arm.com> <55CC6EB8.3050906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55CC6EB8.3050906@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "nsekhar@ti.com" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 13/08/15 11:17, Grygorii Strashko wrote:
> On 08/13/2015 12:30 PM, Sudeep Holla wrote:
>>
>>
>> On 12/08/15 18:46, Grygorii Strashko wrote:
>>> All ARM GIC IRQs have to masked during suspend if they are not
>>> wakeup source. Now this is not happen, since switching to
>>> use IRQ domain hierarchy, because suspend_device_irq() only checks flags
>>> in the last IRQ chip in hierarchy for IRQCHIP_MASK_ON_SUSPEND
>>> bit set. And in the case of TI OMAP DRA7 the last IRQ chip is TI Crossbar
>>> which do not have this flag set.
>>>
>>> In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
>>>     ARM GIC <- OMAP wakeupgen <- TI CBAR
>>> ARM GIC - IRQCHIP_MASK_ON_SUSPEND=n
>>
>> May be this won't affect your platform or this patch but even GIC marks
>> IRQCHIP_MASK_ON_SUSPEND=y now since GIC doesn't provide any facility to
>> configure the wakeup source and keeps all the interrupt source enabled.
>
> That's true for next, bur not true for 4.2-rc6 or 4.1 :(
>

True, I just wanted to ensure there is no assumption.

[...]
>>
>> Also the beginning of the commit message contradicts when you also say
>> in the following statement IRQCHIP_MASK_ON_SUSPEND=n. So you may need to
>> update the log.
>
> I'll try to reword. What I've tried to mention that IRQs masking on
> suspend is default expected behavior and that how it was before
> switching to IRQ domain hierarchy.
>
> "All ARM GIC IRQs have to masked during suspend if they are not
>   wakeup source - this is expected behavior and that's how it was before
>   switching to IRQ domain hierarchy. ..."
> ok?
>

My mistake I referred the code after it was converted to use stack
domains. So I missed to understand that you were using gic_arch_extn
flags before to override GIC flags as gic_set_irqchip_flags was not
used when I removed it. Sorry for the noise, you can retain the commit
log as is.

Regards,
Sudeep
