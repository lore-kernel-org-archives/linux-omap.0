From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Tue, 10 May 2016 13:21:10 +0300
Message-ID: <5731B616.8020906@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
 <1462873919-20532-2-git-send-email-rogerq@ti.com>
 <87a8jyi6ad.fsf@linux.intel.com> <5731B235.80505@ti.com>
 <87y47igr1g.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87y47igr1g.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/05/16 13:12, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>> @@ -497,8 +503,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>>>  	/* check the DMA Status */
>>>>  	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>>>>  
>>>> -	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
>>>> -			"dwc3-omap", omap);
>>>> +	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
>>>> +					NULL, 0, "dwc3-omap", omap);
>>>
>>> if you're using threaded_irq, it's better to have a NULL top half and
>>> valid bottom half.
>>
>> But in this case we don't need a bottom half as there is nothing to do :).
>>
>>>
>>> In fact, since this will be shared, you could do a proper preparation
>>> and on top half check if $this device generated the IRQ and
>>> conditionally schedule the bottom half. Don't forget to mask device's
>>> interrupts from top half so you can run without IRQF_ONESHOT.
>>>
>>
>> Why do this at all if there is nothing to do in the bottom half?
> 
> oh, but there is :-)
> 
> The whole idea of threaded IRQs is that you spend as little time as
> possible on top half and the (strong) recommendation is that you *only*
> check if $this device generated the interrupt. Note that "checking if
> $this device generated the interrupt" will be mandatory as soon as you
> mark the IRQ line as shared ;-)
> 
> So here's how this should look like:
> 
> static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
> {
>         struct dwc3_omap *omap = _omap;
>         u32 reg;
> 
>         reg = readl(IRQSTATUS)
>         if (reg) {
>                 mask_interrupts(omap);
>         	return IRQ_WAKE_THREAD;
>         }
> 
> 	return IRQ_HANDLED;
> }
> 
> static irqreturn_t dwc3_omap_threaded_interrupt(int irq, void *_omap)
> {
>         struct dwc3_omap *omap = _omap;
>         u32 reg;
> 
>         spin_lock(&omap->lock);
>         reg = readl(IRQSTATUS);
> 
>         if (reg & BIT0)
>         	handle_bit_0(omap);
> 
> 	if (reg & BIT1)
>         	handle_bit_1(omap);
> 
> 	unmask_interrupts(omap);
> 	spin_unlock(&omap->lock);
> 
> 	return IRQ_HANDLED;
> }
> 
> this will *always* behave well with RT and non-RT kernels. It also
> allows for the user to change priorities on these interrupt handlers if
> necessary.
> 

No problem, I can implement a bottom half. We are not handling anything
there at the moment so it is a bit of an overkill :)
It might help in the future if someone wants to handle something.

cheers,
-roge
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
