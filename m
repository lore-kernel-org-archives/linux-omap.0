From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 02/10] usb: dwc3: omap: Make the wrapper interrupt
 shared
Date: Mon, 11 Apr 2016 16:15:33 +0300
Message-ID: <570BA375.2040203@ti.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com>
 <1460374506-9779-3-git-send-email-rogerq@ti.com> <87h9f8ny14.fsf@intel.com>
 <570B9DB9.8050807@ti.com> <87zit0mhdy.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zit0mhdy.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/04/16 15:58, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>>>> index 22e9606..51ca098 100644
>>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>>> @@ -274,19 +274,25 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
>>>>  {
>>>>  	struct dwc3_omap	*omap = _omap;
>>>>  	u32			reg;
>>>> +	int			ret = IRQ_NONE;
>>>>  
>>>>  	reg = dwc3_omap_read_irqmisc_status(omap);
>>>>  
>>>> +	if (reg)
>>>> +		ret = IRQ_HANDLED;
>>>
>>> you can avoid the local variable by returning early here.
>>
>> How can we return early? we need to check irq0_status as well right?
> 
> Oh, that's true.
> 
> There's one thing that I noticed though. dma_status is only written to,
> never read, so you should be able to remove it completely (a bit
> off-topic, sorry).
> 
I'll send a patch for that. Can it go in -rc as well along with the other 2?

cheers,
-roger
