From: nick <xerofoify@gmail.com>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Wed, 29 Jul 2015 08:13:24 -0400
Message-ID: <55B8C364.4030203@gmail.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
 <1436531019-18088-4-git-send-email-rogerq@ti.com>
 <20150713071008.GC26485@atomide.com> <55A38D2E.9010500@ti.com>
 <20150713124059.GF26485@atomide.com> <55B8C1D5.3090807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <55B8C1D5.3090807@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, bcousson@baylibre.com, computersforpeace@gmail.com, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org



On 2015-07-29 08:06 AM, Roger Quadros wrote:
> Tony,
> 
> On 13/07/15 15:40, Tony Lindgren wrote:
>> * Roger Quadros <rogerq@ti.com> [150713 03:07]:
>>> Tony,
>>>
>>> On 13/07/15 10:10, Tony Lindgren wrote:
>>>> * Roger Quadros <rogerq@ti.com> [150710 05:26]:
>>>>> Since the Interrupt Events are used only by the NAND driver,
>>>>> there is no point in managing the Interrupt registers
>>>>> in the GPMC driver and complicating it with irqchip modeling.
>>>>
>>>> I don't think it's a good idea to allow external drivers to
>>>> tinker directly with GPMC registers. How about just set up GPMC
>>>> as an irqchip for the edge detection interrupts?
>>>>
>>>> I think we already have devices with multiple NAND chips. And
>>>> there's nothing stopping other drivers from using the edge
>>>> detection interrupts.
>>>
>>> OK. The GPMC_IRQ registers manage 2 NAND specific interrupts
>>> (terminalcount and fifo) and 'n' WAIT pin edge interrupts.
>>>
>>>  So we can model this as a irqchip with 'n + 2' interrupts.
>>
>> OK
> 
> For the wait pins irqchip is not sufficient and it needs to be gpiochip
> with irqchip. Waitpin status can be read from GPIO_STATUS register.
> 
> Just getting the interrupt is not enough and we want to know if the
> line is high or low. That is how nand->dev_ready works.
> 
> How about having 2 IRQ domains?
> One is irqchip with 2 interrupts (terminalcount and fifo) and second is
> gpiochip + irqchip for the n wait pins.
> 
> The nand driver can then be modified to use GPIO to get Read/Busy
> pin status from the wait pin.
> 
> cheers,
> -roger
> 
Doesn't OMAP boards support shared IRQs and if so why not share them across one
IRQ domain if possible to save IRQ domains for other hardware that needs its 
own IRQ domain. This is just a suggestion through as I don't have the hardware
spec sheet on me Roger.
Nick 
>>  
>>> We need to take care that if a GPMC chip select needs a
>>> wait pin then it can't be used as a generic interrupt.
>>>
>>> We need to get rid of omap_dev_ready() in nand/omap2.c as
>>> it accesses the GPMC_STATUS register directly. Plus it is
>>> hard coded to only monitor wait0 pin.
>>
>> OK
>>  
>>> What is the best map we should use for irqchip?
>>> Some Socs have 4 WAIT pins, some have 3 and some have 2.
>>>
>>> Should we start with 0,1,2, for the wait pins and use the next
>>> available free one for the NAND?
>>
>> Maybe we can just use the bits defined for each SoC in the
>> GPMC_IRQSTATUS register for the mapping?  
>> Regards,
>>
>> Tony
>>
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
