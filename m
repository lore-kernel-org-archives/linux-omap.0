From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Wed, 29 Jul 2015 18:39:21 +0300
Message-ID: <55B8F3A9.8010000@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com> <1436531019-18088-4-git-send-email-rogerq@ti.com> <20150713071008.GC26485@atomide.com> <55A38D2E.9010500@ti.com> <20150713124059.GF26485@atomide.com> <55B8C1D5.3090807@ti.com> <55B8C364.4030203@gmail.com> <55B8DAB9.7070602@ti.com> <55B8DE44.4070608@gmail.com> <55B8ED49.6050304@ti.com> <55B8F0B3.5000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B8F0B3.5000009-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nick <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 29/07/15 18:26, nick wrote:
> 
> 
> On 2015-07-29 11:12 AM, Roger Quadros wrote:
>> On 29/07/15 17:08, nick wrote:
>>>
>>>
>>> On 2015-07-29 09:52 AM, Roger Quadros wrote:
>>>> On 29/07/15 15:13, nick wrote:
>>>>>
>>>>>
>>>>> On 2015-07-29 08:06 AM, Roger Quadros wrote:
>>>>>> Tony,
>>>>>>
>>>>>> On 13/07/15 15:40, Tony Lindgren wrote:
>>>>>>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150713 03:07]:
>>>>>>>> Tony,
>>>>>>>>
>>>>>>>> On 13/07/15 10:10, Tony Lindgren wrote:
>>>>>>>>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150710 05:26]:
>>>>>>>>>> Since the Interrupt Events are used only by the NAND driver,
>>>>>>>>>> there is no point in managing the Interrupt registers
>>>>>>>>>> in the GPMC driver and complicating it with irqchip modeling.
>>>>>>>>>
>>>>>>>>> I don't think it's a good idea to allow external drivers to
>>>>>>>>> tinker directly with GPMC registers. How about just set up GPMC
>>>>>>>>> as an irqchip for the edge detection interrupts?
>>>>>>>>>
>>>>>>>>> I think we already have devices with multiple NAND chips. And
>>>>>>>>> there's nothing stopping other drivers from using the edge
>>>>>>>>> detection interrupts.
>>>>>>>>
>>>>>>>> OK. The GPMC_IRQ registers manage 2 NAND specific interrupts
>>>>>>>> (terminalcount and fifo) and 'n' WAIT pin edge interrupts.
>>>>>>>>
>>>>>>>>  So we can model this as a irqchip with 'n + 2' interrupts.
>>>>>>>
>>>>>>> OK
>>>>>>
>>>>>> For the wait pins irqchip is not sufficient and it needs to be gpiochip
>>>>>> with irqchip. Waitpin status can be read from GPIO_STATUS register.
>>>>>>
>>>>>> Just getting the interrupt is not enough and we want to know if the
>>>>>> line is high or low. That is how nand->dev_ready works.
>>>>>>
>>>>>> How about having 2 IRQ domains?
>>>>>> One is irqchip with 2 interrupts (terminalcount and fifo) and second is
>>>>>> gpiochip + irqchip for the n wait pins.
>>>>>>
>>>>>> The nand driver can then be modified to use GPIO to get Read/Busy
>>>>>> pin status from the wait pin.
>>>>>>
>>>>>> cheers,
>>>>>> -roger
>>>>>>
>>>>> Doesn't OMAP boards support shared IRQs and if so why not share them across one
>>>>> IRQ domain if possible to save IRQ domains for other hardware that needs its 
>>>>> own IRQ domain. This is just a suggestion through as I don't have the hardware
>>>>> spec sheet on me Roger.
>>>>
>>>> IRQ domain is a virtual abstraction introduced to prevent kernel irq number overlapping
>>>> in a single flat domain. I don't see what you can save by domain reuse.
>>>> Some memory maybe at most.
>>>>
>>>> Shared interrupt is something totally different but we're trying to add real
>>>> hardware interrupts here. Didn't understand what you will share it with.
>>>>
>>>> cheers,
>>>> -roger
>>>>
>>> My question then is do these hardware interrupts need to be on their own interrupt line
>>> for the CPU or can they share a CPU line as my concern is if possible we may be able to
>>> save a interrupt line for other use. I known on Intel CPUs this is a very limited resource
>>> but not sure on OMAP based boards if not then just avoid my recommendations.
>>
>> It is like adding an external interrupt controller to expand the number of available
>> hardware interrupts.
>> This interrupt controller will still use the same GPMC IRQ line to propagate the
>> irq event upwards.
>>
>> cheers,
>> -roger
>>
> That was my other suggestion for IRQ issues. Would you mind sending me a link to a spec sheet so
> I can review your patches better as you stated you wanted me to do this for you.

Sure. You can pick up any of omap3/4 or 5 Technical Reference Manuals.
e.g. omap5 TRM is here
http://www.ti.com/product/OMAP5432/technicaldocuments

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
