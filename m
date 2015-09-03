From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 9/9] usb: dwc3: core: don't break during suspend/resume
 while we're dual-role
Date: Thu, 3 Sep 2015 17:10:19 +0300
Message-ID: <55E854CB.5080900@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-10-git-send-email-rogerq@ti.com>
 <55E7303D.8080904@cogentembedded.com> <55E852BC.9000502@ti.com>
 <55E853BC.5060708@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55E853BC.5060708@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/09/15 17:05, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/03/2015 05:01 PM, Roger Quadros wrote:
> 
>>>> We can't rely just on dr_mode to decide if we're in host or gadget
>>>> mode when we're configured as otg/dual-role. So while dr_mode is
>>>> OTG, we find out from  the otg state machine if we're in host
>>>> or gadget mode and take the necessary actions during suspend/resume.
>>>>
>>>> Also make sure that we disable OTG irq and events during system suspend
>>>> so that we don't lockup the system during system suspend/resume.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 27 +++++++++------------------
>>>>    1 file changed, 9 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 654aebf..25891e3 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -1455,18 +1455,15 @@ static int dwc3_suspend(struct device *dev)
>>>>            dwc->octl = dwc3_readl(dwc->regs, DWC3_OCTL);
>>>>            dwc->oevt = dwc3_readl(dwc->regs, DWC3_OEVT);
>>>>            dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
>>>> +        dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
>>>> +        disable_irq(dwc->otg_irq);
>>>>        }
>>>>
>>>> -    switch (dwc->dr_mode) {
>>>> -    case USB_DR_MODE_PERIPHERAL:
>>>> -    case USB_DR_MODE_OTG:
>>>> +    if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
>>>> +        ((dwc->dr_mode == USB_DR_MODE_OTG) && (dwc->fsm->protocol == PROTO_GADGET)))
>>>
>>>     Hm, you're not very consistent about your parens. :-)
>>
>> You're right. Should be
>>
>> if ((dwc->dr_mode == USB_DR_MODE_PERIPHERAL) ||
>>      ((dwc->dr_mode == USB_DR_MODE_OTG) && (dwc->fsm->protocol == PROTO_GADGET)))
> 
>    Parens around == are useless, I'd prefer if you deleted them. But if you'd like to keep them, let it be so. :-)

OK, how about this then?

if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
    (dwc->dr_mode == USB_DR_MODE_OTG && dwc->fsm->protocol == PROTO_GADGET))

cheers,
-roger
