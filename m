From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Wed, 11 May 2016 16:52:34 +0300
Message-ID: <57333922.1010003@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
 <1462873919-20532-2-git-send-email-rogerq@ti.com>
 <87a8jyi6ad.fsf@linux.intel.com> <5731B235.80505@ti.com>
 <87y47igr1g.fsf@linux.intel.com> <5732EA85.6050601@ti.com>
 <87y47hexja.fsf@linux.intel.com> <57331B85.2000003@ti.com>
 <87r3d8g44i.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r3d8g44i.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/05/16 15:39, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>>>>> static irqreturn_t dwc3_omap_threaded_interrupt(int irq, void *_omap)
>>>>> {
>>>>>         struct dwc3_omap *omap = _omap;
>>>>>         u32 reg;
>>>>>
>>>>>         spin_lock(&omap->lock);
>>>>
>>>> Do we really need a spin_lock for the dwc3-omap driver?
>>>> Currently we won't be doing anything other than just
>>>> clearing the irqstatus and re-enabling the interrupts.
>>>
>>> well, if there's no possibility of races, then no. But only testing will
>>> say for sure, I guess. I didn't really go through the entire thing just
>>> to a write a quick little template :-p
>>>
>> OK. Another hurdle I have is that how do I mask/unmask the interrupts?
>> I do not see any masking bits, only enable/disable bits.
>>
>> I don't think we can use the enable/disable bits to mask as we'd loose
>> events while the event is disabled.
> 
> I'm pretty sure your TRM discusses the usage of IRQSTATUS_RAW*
> registers, doesn't it ? :-)

It does and also says that it is mostly for debug. But I don't mind using it
if it solves our problem :).

> 
> Those registers should be modified by HW even when interrupts are
> disabled/masked. Note that, the IRQSTATUS_SET* and IRQSTATUS_CLR*
> registers act more like mask/unmask than enable/disable considering we
> can still read IRQ status using *RAW* registers.
> 
> See if below works fine for OMAP5, AM4 and AM5 SoCs:
> 
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index af264493bbae..ece2f25ad2c3 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -165,20 +165,20 @@ static void dwc3_omap_write_utmi_ctrl(struct dwc3_omap *omap, u32 value)
>  
>  static u32 dwc3_omap_read_irq0_status(struct dwc3_omap *omap)
>  {
> -	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_0 -
> +	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_RAW_0 -
>  						omap->irq0_offset);
>  }
>  
>  static void dwc3_omap_write_irq0_status(struct dwc3_omap *omap, u32 value)
>  {
> -	dwc3_omap_writel(omap->base, USBOTGSS_IRQSTATUS_0 -
> +	dwc3_omap_writel(omap->base, USBOTGSS_IRQSTATUS_RAW_0 -
>  						omap->irq0_offset, value);

We shouldn't write to RAW here as it will trigger a software IRQ instead of
clearing the event.
>  
>  }
>  
>  static u32 dwc3_omap_read_irqmisc_status(struct dwc3_omap *omap)
>  {
> -	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_MISC +
> +	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_RAW_MISC +
>  						omap->irqmisc_offset);
>  }
>  
> 

The rest is fine. It seemed to work on omap5. I'll do more tests though.
Thanks for the hint :)

cheers,
-roger
