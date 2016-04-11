From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 02/10] usb: dwc3: omap: Make the wrapper interrupt
 shared
Date: Mon, 11 Apr 2016 15:51:05 +0300
Message-ID: <570B9DB9.8050807@ti.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com>
 <1460374506-9779-3-git-send-email-rogerq@ti.com> <87h9f8ny14.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h9f8ny14.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/04/16 15:13, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> The wrapper interrupt is shared with OTG core so mark it IRQF_SHARED.
>>
>> Use request_threaded_irq() to ensure that irqflags match for the
>> shared interrupt handlers. If we don't use request_treaded_irq() then
>> forced threaded irq will set IRQF_ONESHOT and this won't match with
>> the OTG irq handler.
> 
> then it seems you need to _first_ fix the OTG IRQ handler. Why does it

There is no OTG irq handler yet.

> defer ? At a minimum, first switch to threaded IRQ handler, then (in
> another patch) switch to IRQF_SHARED

OK.

> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/dwc3/dwc3-omap.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index 22e9606..51ca098 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -274,19 +274,25 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
>>  {
>>  	struct dwc3_omap	*omap = _omap;
>>  	u32			reg;
>> +	int			ret = IRQ_NONE;
>>  
>>  	reg = dwc3_omap_read_irqmisc_status(omap);
>>  
>> +	if (reg)
>> +		ret = IRQ_HANDLED;
> 
> you can avoid the local variable by returning early here.

How can we return early? we need to check irq0_status as well right?

> 
> 	if (!reg)
>         	return IRQ_NONE;
> 
>>  	if (reg & USBOTGSS_IRQMISC_DMADISABLECLR)
>>  		omap->dma_status = false;
>>  
>>  	dwc3_omap_write_irqmisc_status(omap, reg);
>>  
>>  	reg = dwc3_omap_read_irq0_status(omap);
>> +	if (reg)
>> +		ret = IRQ_HANDLED;
> 
> and this check is probably unnecessary.
> 
>> @@ -506,8 +512,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>  	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>>  	omap->dma_status = !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
>>  
>> -	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
>> -			"dwc3-omap", omap);
>> +	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
> 
> this switch to threaded IRQ is not part of $subject.
> 
OK.

cheers,
-roger
