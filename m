From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 9/9] usb: dwc3: core: don't break during suspend/resume
 while we're dual-role
Date: Wed, 8 Jul 2015 17:44:57 +0300
Message-ID: <559D3769.7020909@ti.com>
References: <1436351524-28385-1-git-send-email-rogerq@ti.com> <1436351860-28813-1-git-send-email-rogerq@ti.com> <559D217B.5000500@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559D217B.5000500-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/07/15 16:11, Sergei Shtylyov wrote:
> Hello.
> 
> On 7/8/2015 1:37 PM, Roger Quadros wrote:
> 
>> We can't rely just on dr_mode to decide if we're in host or gadget
>> mode when we're configured as otg/dual-role. So while dr_mode is
>> OTG, we find out from  the otg state machine if we're in host
>> or gadget mode and take the necessary actions during suspend/resume.
> 
>> Also make sure that we disable OTG irq and events during system suspend
>> so that we don't lockup the system during system suspend/resume.
> 
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/dwc3/core.c | 27 +++++++++------------------
>>   1 file changed, 9 insertions(+), 18 deletions(-)
> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index e3c094d..3784287 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1444,18 +1444,15 @@ static int dwc3_suspend(struct device *dev)
>>           dwc->octl = dwc3_readl(dwc->regs, DWC3_OCTL);
>>           dwc->oevt = dwc3_readl(dwc->regs, DWC3_OEVT);
>>           dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
>> +        dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
>> +        disable_irq(dwc->otg_irq);
>>       }
>>
>> -    switch (dwc->dr_mode) {
>> -    case USB_DR_MODE_PERIPHERAL:
>> -    case USB_DR_MODE_OTG:
>> +    if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
>> +        ((dwc->dr_mode == USB_DR_MODE_OTG) && dwc->fsm->protocol == PROTO_GADGET))
> 
>    Hum, enclosing the first == op into parens and not doing it to the second == op doesn't look very consistent... :-)

Agreed :). Will fix it. Thanks.

> 
> [...]
>> @@ -1495,18 +1492,12 @@ static int dwc3_resume(struct device *dev)
>>           dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
>>           dwc3_writel(dwc->regs, DWC3_OEVT, dwc->oevt);
>>           dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
>> +        enable_irq(dwc->otg_irq);
>>       }
>>
>> -    switch (dwc->dr_mode) {
>> -    case USB_DR_MODE_PERIPHERAL:
>> -    case USB_DR_MODE_OTG:
>> +    if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
>> +        ((dwc->dr_mode == USB_DR_MODE_OTG) && dwc->fsm->protocol == PROTO_GADGET))
> 
>    Same here...

OK.

> 
> [...]
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
