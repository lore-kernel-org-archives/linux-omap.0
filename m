From: nick <xerofoify@gmail.com>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Mon, 13 Jul 2015 08:51:51 -0400
Message-ID: <55A3B467.8030409@gmail.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
 <1436531019-18088-4-git-send-email-rogerq@ti.com>
 <20150713071008.GC26485@atomide.com> <55A38D2E.9010500@ti.com>
 <20150713124059.GF26485@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20150713124059.GF26485@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, bcousson@baylibre.com, computersforpeace@gmail.com, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org



On 2015-07-13 08:40 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150713 03:07]:
>> Tony,
>>
>> On 13/07/15 10:10, Tony Lindgren wrote:
>>> * Roger Quadros <rogerq@ti.com> [150710 05:26]:
>>>> Since the Interrupt Events are used only by the NAND driver,
>>>> there is no point in managing the Interrupt registers
>>>> in the GPMC driver and complicating it with irqchip modeling.
>>>
>>> I don't think it's a good idea to allow external drivers to
>>> tinker directly with GPMC registers. How about just set up GPMC
>>> as an irqchip for the edge detection interrupts?
>>>
>>> I think we already have devices with multiple NAND chips. And
>>> there's nothing stopping other drivers from using the edge
>>> detection interrupts.
>>
>> OK. The GPMC_IRQ registers manage 2 NAND specific interrupts
>> (terminalcount and fifo) and 'n' WAIT pin edge interrupts.
>>
>>  So we can model this as a irqchip with 'n + 2' interrupts.
> 
> OK
>  
>> We need to take care that if a GPMC chip select needs a
>> wait pin then it can't be used as a generic interrupt.
>>
>> We need to get rid of omap_dev_ready() in nand/omap2.c as
>> it accesses the GPMC_STATUS register directly. Plus it is
>> hard coded to only monitor wait0 pin.
> 
> OK
>  
>> What is the best map we should use for irqchip?
>> Some Socs have 4 WAIT pins, some have 3 and some have 2.
>>
>> Should we start with 0,1,2, for the wait pins and use the next
>> available free one for the NAND?
> 
> Maybe we can just use the bits defined for each SoC in the
> GPMC_IRQSTATUS register for the mapping?  
> Regards,
> 
> Tony
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
Tony,
Is that a good idea as to my knowledge of OMAP platforms that register is hardware
dependent and therefore that may be an issue unless your idea is to create device
tables like the way they do in the nand subsystems to support various vendor's 
nand flash expect here for the pins on OMAP SOCs.
Nick  

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
