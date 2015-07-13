From: nick <xerofoify@gmail.com>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Mon, 13 Jul 2015 09:32:19 -0400
Message-ID: <55A3BDE3.2080004@gmail.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
 <1436531019-18088-4-git-send-email-rogerq@ti.com>
 <20150713071008.GC26485@atomide.com> <55A38D2E.9010500@ti.com>
 <20150713124059.GF26485@atomide.com> <55A3B467.8030409@gmail.com>
 <20150713130109.GG26485@atomide.com> <55A3B73C.9040604@gmail.com>
 <55A3B931.1050706@ti.com> <55A3B9DD.60705@gmail.com>
 <55A3BB4D.3080003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <55A3BB4D.3080003@ti.com>
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



On 2015-07-13 09:21 AM, Roger Quadros wrote:
> On 13/07/15 16:15, nick wrote:
>>
>>
>> On 2015-07-13 09:12 AM, Roger Quadros wrote:
>>> On 13/07/15 16:03, nick wrote:
>>>>
>>>>
>>>> On 2015-07-13 09:01 AM, Tony Lindgren wrote:
>>>>> * nick <xerofoify@gmail.com> [150713 05:54]:
>>>>>> On 2015-07-13 08:40 AM, Tony Lindgren wrote:
>>>>>>> * Roger Quadros <rogerq@ti.com> [150713 03:07]:
>>>>>>>  
>>>>>>>> What is the best map we should use for irqchip?
>>>>>>>> Some Socs have 4 WAIT pins, some have 3 and some have 2.
>>>>>>>>
>>>>>>>> Should we start with 0,1,2, for the wait pins and use the next
>>>>>>>> available free one for the NAND?
>>>>>>>
>>>>>>> Maybe we can just use the bits defined for each SoC in the
>>>>>>> GPMC_IRQSTATUS register for the mapping?  
>>>>>>> Regards,
>>>>>>
>>>>>> Is that a good idea as to my knowledge of OMAP platforms that register is hardware
>>>>>> dependent and therefore that may be an issue unless your idea is to create device
>>>>>> tables like the way they do in the nand subsystems to support various vendor's 
>>>>>> nand flash expect here for the pins on OMAP SOCs.
>>>>>
>>>>> Do you mean mapping irqs based on the GPMC_IRQSTATUS register
>>>>> bits? If so, that's pretty much how all the GPIO drivers
>>>>> handle them. We can have a SoC specific irqmask of the valid
>>>>> bits passed from the dts files, and if necessary we can also
>>>>> add custom SoC specific IRQ handlers to the GPMC driver if
>>>>> needed.
>>>>>
>>>>> The idea is that the NAND driver can just request the irq
>>>>> from the GPMC driver and do whatever it wants with the
>>>>> interrupt.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Tony
>>>>>
>>>> Tony,
>>>> That is what I was hoping the code was doing. So what appears to be the problem with the 
>>>> patches related to irq requesting from the GPMC driver.
>>>> Cheers,
>>>> Nick 
>>>>
>>>
>>> The problem with this patch is that it expects GPMC_IRQ registers
>>> to be accessible by the NAND driver and looses the 2 to 4 pins
>>> of WAIT pin edge detection interrupt capability if it is needed
>>> for generic use. (not NAND/GPMC memory specific)
>>>
>>> cheers,
>>> -roger
>>>
>> I am not sure if this is possible with OMAP boards but can we split the pins
>> into 1 or 2 for NAND/GPMC memory specific and use the others for WAIT interrupt
>> capability.
>> Nick
>>
> Yes if the wait pins are not used for NAND/GPMC memory then they can be used
> as generic edge detect interrupt or probably even a GPI.
> I don't see what would prevent it.
> 
> I'm not sure if anyone will dare to use them though as they weren't originally meant
> for that use and none of the existing kernels support that. So it is really a
> chicken and egg situation here. :)
> 
> But I see value in doing it the way Tony says cause it is much cleaner to specify
> which interrupt (or wait pin) you want for NAND use.
> 
> cheers,
> -roger
> 
I would also have to agree with Tony about this issue and feel his solution 
seems fine. However why don't recent kernel's support this feature?
Nick 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
