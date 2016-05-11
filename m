From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Wed, 11 May 2016 14:46:13 +0300
Message-ID: <57331B85.2000003@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
 <1462873919-20532-2-git-send-email-rogerq@ti.com>
 <87a8jyi6ad.fsf@linux.intel.com> <5731B235.80505@ti.com>
 <87y47igr1g.fsf@linux.intel.com> <5732EA85.6050601@ti.com>
 <87y47hexja.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y47hexja.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/05/16 12:47, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>> @@ -497,8 +503,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>>>>>  	/* check the DMA Status */
>>>>>>  	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>>>>>>  
>>>>>> -	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
>>>>>> -			"dwc3-omap", omap);
>>>>>> +	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
>>>>>> +					NULL, 0, "dwc3-omap", omap);
>>>>>
>>>>> if you're using threaded_irq, it's better to have a NULL top half and
>>>>> valid bottom half.
>>>>
>>>> But in this case we don't need a bottom half as there is nothing to do :).
>>>>
>>>>>
>>>>> In fact, since this will be shared, you could do a proper preparation
>>>>> and on top half check if $this device generated the IRQ and
>>>>> conditionally schedule the bottom half. Don't forget to mask device's
>>>>> interrupts from top half so you can run without IRQF_ONESHOT.
>>>>>
>>>>
>>>> Why do this at all if there is nothing to do in the bottom half?
>>>
>>> oh, but there is :-)
>>>
>>> The whole idea of threaded IRQs is that you spend as little time as
>>> possible on top half and the (strong) recommendation is that you *only*
>>> check if $this device generated the interrupt. Note that "checking if
>>> $this device generated the interrupt" will be mandatory as soon as you
>>> mark the IRQ line as shared ;-)
>>>
>>> So here's how this should look like:
>>>
>>> static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
>>> {
>>>         struct dwc3_omap *omap = _omap;
>>>         u32 reg;
>>>
>>>         reg = readl(IRQSTATUS)
>>>         if (reg) {
>>>                 mask_interrupts(omap);
>>>         	return IRQ_WAKE_THREAD;
>>>         }
>>>
>>> 	return IRQ_HANDLED;
>>
>> This should be IRQ_NONE right?
> 
> possibly, testing will say ;-)
> 
>>> static irqreturn_t dwc3_omap_threaded_interrupt(int irq, void *_omap)
>>> {
>>>         struct dwc3_omap *omap = _omap;
>>>         u32 reg;
>>>
>>>         spin_lock(&omap->lock);
>>
>> Do we really need a spin_lock for the dwc3-omap driver?
>> Currently we won't be doing anything other than just
>> clearing the irqstatus and re-enabling the interrupts.
> 
> well, if there's no possibility of races, then no. But only testing will
> say for sure, I guess. I didn't really go through the entire thing just
> to a write a quick little template :-p
> 
OK. Another hurdle I have is that how do I mask/unmask the interrupts?
I do not see any masking bits, only enable/disable bits.

I don't think we can use the enable/disable bits to mask as we'd loose
events while the event is disabled.

cheers,
-roger
