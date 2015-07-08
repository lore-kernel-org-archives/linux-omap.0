From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 4/9] usb: dwc3: core: Adapt to named interrupts
Date: Wed, 8 Jul 2015 17:43:48 +0300
Message-ID: <559D3724.9040806@ti.com>
References: <1436351524-28385-1-git-send-email-rogerq@ti.com> <1436351795-28556-1-git-send-email-rogerq@ti.com> <559D2068.90208@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <559D2068.90208@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 08/07/15 16:06, Sergei Shtylyov wrote:
> Hello.
> 
> On 7/8/2015 1:36 PM, Roger Quadros wrote:
> 
>> From: Felipe Balbi <balbi@ti.com>
> 
>> Add support to use interrupt names,
> 
>> Following are the interrupt names
> 
>> Peripheral Interrupt - peripheral
>> HOST Interrupt - host
>> OTG Interrupt - otg
> 
>> [Roger Q]
>> - If any of these are missing we use the
>> first available IRQ resource so that we don't
>> break with older DTBs.
> 
>> - Use gadget_irq in gadget driver.
> 
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/usb/dwc3/core.c   | 12 ++++++++++++
>>   drivers/usb/dwc3/core.h   |  7 +++++++
>>   drivers/usb/dwc3/gadget.c |  2 +-
>>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index a7498e0..7b33d7b 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -941,6 +941,18 @@ static int dwc3_probe(struct platform_device *pdev)
>>       dwc->xhci_resources[1].flags = res->flags;
>>       dwc->xhci_resources[1].name = res->name;
>>
>> +    dwc->otg_irq = platform_get_irq_byname(pdev, "otg");
>> +    if (!dwc->otg_irq)
> 
>    The usual mistake repeated again: that function reutrns error # on failure, not 0.
> 
>> +        dwc->otg_irq = res->start;
>> +
>> +    dwc->gadget_irq = platform_get_irq_byname(pdev, "peripheral");
>> +    if (!dwc->gadget_irq)
>> +        dwc->gadget_irq = res->start;
> 
>    Likewise.
> 
>> +
>> +    dwc->xhci_irq = platform_get_irq_byname(pdev, "host");
>> +    if (!dwc->xhci_irq)
> 
>    Likewise.

Right. I'll fix it up. Thanks.

cheers,
-roger
