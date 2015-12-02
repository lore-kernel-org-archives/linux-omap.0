From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 2 Dec 2015 10:42:12 +0530
Message-ID: <565E7DAC.7060401@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <20151026212346.GJ13239@google.com> <562F45BF.8020205@ti.com>
 <20151130195449.GI64635@google.com> <565DB18C.7040505@ti.com>
 <20151202032643.GF64635@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151202032643.GF64635@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Brian,

On 02/12/15 08:56, Brian Norris wrote:
> Hi Roger,
> 
> On Tue, Dec 01, 2015 at 04:41:16PM +0200, Roger Quadros wrote:
>> On 30/11/15 21:54, Brian Norris wrote:
>>> On Tue, Oct 27, 2015 at 11:37:03AM +0200, Roger Quadros wrote:
>>>> On 26/10/15 23:23, Brian Norris wrote:
>>>>> On Fri, Sep 18, 2015 at 05:53:22PM +0300, Roger Quadros wrote:
>>>>>> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
>>>>>> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
>>>>>> This causes performance increase when using prefetch-irq mode.
>>>>>> 30% increase in read, 17% increase in write in prefetch-irq mode.
>>>>>
>>>>> Have you pinpointed the exact causes for the performance increase, or
>>>>> can you give an educated guess? AIUI, you're reducing the number of
>>>>> interrupts needed for NAND prefetch mode, but you're also removing a bit
>>>>> of abstraction and implementing hooks that look awfully like the
>>>>> existing abstractions:
>>>>>
>>>>> +       int (*nand_irq_enable)(enum gpmc_nand_irq irq);
>>>>> +       int (*nand_irq_disable)(enum gpmc_nand_irq irq);
>>>>> +       void (*nand_irq_clear)(enum gpmc_nand_irq irq);
>>>>> +       u32 (*nand_irq_status)(void);
>>>>>
>>>>> That's not really a problem if there's a good reason for them (brcmnand
>>>>> implements similar hooks because of quirks in the implementation of
>>>>> interrupts across various BRCM SoCs, and it's not worth writing irqchip
>>>>> drivers for those cases). I'm mainly curious for an explanation.
>>>>
>>>> I have both implementations with me. My guess is that the 20% performance
>>>> gain is due to absence of irqchip/irqdomain translation code.
>>>> I haven't investigated further though.
>>>
>>> I don't have much context for whether this makes sense or not. According
>>> to your tests, you're getting ~800K interrupts over ~15 seconds. So
>>> should you start noticing performance hits due to abstraction at 53K
>>> interrupts per second?
>>
>> Yes, this was my understanding.
> 
> Am I computing wrong, or is that a pretty insane rate of interrupts?

I don't have the test board with me right now and so can't tell you
for sure if the mtd tests took 15 seconds or more.

I can try it out on a different board that I have and let you know
for sure about how many interrupts we get per second.
> 
>>> But anyway, I'm not sure that completely answered my question. My
>>> question was whether you were removing the irqchip code solely for
>>> performance reasons, or are there others?
>>
>> Yes. Only for performance reasons.
> 
> Hmm, that's not my favorite answer. I'd prefer that more analysis was
> done here before scrapping irqchip...

I agree. We could retain the irqchip model till we have more satisfying
analysis.

> 
> But maybe that's not too bad. It seems like your patch set overall is a
> net positive for disentangling some of arch/ and drivers/.

:)

> 
> I'll take another pass over your patch set, but if things are looking
> better, how do you expect to merge this? There are significant portions
> that touch at least 2 or 3 different subsystem trees, AFAICT.

Tony could create an immutable branch with all the dts and memory changes.
You could base the mtd changes on top of that?

cheers,
-roger
