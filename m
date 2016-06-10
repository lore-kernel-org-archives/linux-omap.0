From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Fri, 10 Jun 2016 11:04:26 +0300
Message-ID: <575A748A.4060009@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <57501E0D.4010007@ti.com> <575A7407.1090403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575A7407.1090403@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/06/16 11:02, Roger Quadros wrote:
> Grygorii,
> 
> On 02/06/16 14:52, Grygorii Strashko wrote:
>> On 06/01/2016 10:46 AM, Roger Quadros wrote:
>>> Implementations might use different IRQs for
>>> host, gadget and OTG so use named interrupt resources
>>> to allow Device tree to specify the 3 interrupts.
>>>
>>> Following are the interrupt names
>>>
>>> Peripheral Interrupt - peripheral
>>> HOST Interrupt - host
>>> OTG Interrupt - otg
>>
>> or "dwc_usb3"??
>>
>>>
>>> We still maintain backward compatibility for a single named
>>> interrupt for all 3 interrupts (e.g. for dwc3-pci) and
>>> single unnamed interrupt for all 3 interrupts (e.g. old DT).
>>
>> bindings
>>
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>> v9: rebased on top of balbi/testing/next
>>>
>>>   drivers/usb/dwc3/core.c   | 10 ----------
>>>   drivers/usb/dwc3/gadget.c | 20 ++++++++++++++++++--
>>>   drivers/usb/dwc3/host.c   | 19 +++++++++++++++++++
>>>   3 files changed, 37 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 9c4e1d8d..5cedf3d 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -843,16 +843,6 @@ static int dwc3_probe(struct platform_device *pdev)
>>>       dwc->mem = mem;
>>>       dwc->dev = dev;
>>>
>>> -    res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>> -    if (!res) {
>>> -        dev_err(dev, "missing IRQ\n");
>>> -        return -ENODEV;
>>> -    }
>>> -    dwc->xhci_resources[1].start = res->start;
>>> -    dwc->xhci_resources[1].end = res->end;
>>> -    dwc->xhci_resources[1].flags = res->flags;
>>> -    dwc->xhci_resources[1].name = res->name;
>>> -
>>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>       if (!res) {
>>>           dev_err(dev, "missing memory resource\n");
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index c37168d..c18c72f 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -1726,7 +1726,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>>>       int            ret = 0;
>>>       int            irq;
>>>
>>> -    irq = platform_get_irq(to_platform_device(dwc->dev), 0);
>>> +    irq = dwc->irq_gadget;
>>>       ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
>>>               IRQF_SHARED, "dwc3", dwc->ev_buf);
>>>       if (ret) {
>>> @@ -1734,7 +1734,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>>>                   irq, ret);
>>>           goto err0;
>>>       }
>>> -    dwc->irq_gadget = irq;
>>>
>>>       spin_lock_irqsave(&dwc->lock, flags);
>>>       if (dwc->gadget_driver) {
>>> @@ -2853,6 +2852,23 @@ static irqreturn_t dwc3_interrupt(int irq, void *_evt)
>>>   int dwc3_gadget_init(struct dwc3 *dwc)
>>>   {
>>>       int                    ret;
>>> +    struct resource *res;
>>> +    struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
>>> +
>>> +    dwc->irq_gadget = platform_get_irq_byname(dwc3_pdev, "peripheral");
>>> +    if (dwc->irq_gadget <= 0) {
>>
>> Is it expected to get -EPROBE_DEFER here?
>>
>>> +        dwc->irq_gadget = platform_get_irq_byname(dwc3_pdev,
>>> +                              "dwc_usb3");
>>> +        if (dwc->irq_gadget <= 0) {
>>> +            res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ,
>>> +                            0);
>>
>> It's better to use platform_get_irq().
>>
>>> +            if (!res) {
>>> +                dev_err(dwc->dev, "missing peripheral IRQ\n");
>>> +                return -ENODEV;
>>> +            }
>>> +            dwc->irq_gadget = res->start;
>>> +        }
>>> +    }
>>>
>>>       dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
>>>               &dwc->ctrl_req_addr, GFP_KERNEL);
>>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>>> index c679f63..f2b60a4 100644
>>> --- a/drivers/usb/dwc3/host.c
>>> +++ b/drivers/usb/dwc3/host.c
>>> @@ -25,6 +25,25 @@ int dwc3_host_init(struct dwc3 *dwc)
>>>       struct platform_device    *xhci;
>>>       struct usb_xhci_pdata    pdata;
>>>       int            ret;
>>> +    struct resource        *res;
>>> +    struct platform_device    *dwc3_pdev = to_platform_device(dwc->dev);
>>> +
>>> +    res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ, "host");
>>> +    if (!res) {
>>> +        res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
>>> +                           "dwc_usb3");
>>> +        if (!res) {
>>> +            res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ,
>>> +                            0);
>>> +            if (!res)
>>
>>> +                return -ENOMEM;
>>> +        }
>>> +    }
>>
>> Is it expected to have more than one IRQ here?
>>
>> if not - it will better to use platform_get_irq[_byname]().
>>
> 
> The reason I used platform_get_resource variant is that i'm passing the
> resource directly to the XHCI platform device below.
>>
>>> +
>>> +    dwc->xhci_resources[1].start = res->start;
>>> +    dwc->xhci_resources[1].end = res->end;
>>> +    dwc->xhci_resources[1].flags = res->flags;
>>> +    dwc->xhci_resources[1].name = res->name;
> 
> This could just change to
> 
> 	dwc->xhci_resource[1] = *res;

Probably not as we don't want to change parent/child members.

> 
>>>
>>>       xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
>>>       if (!xhci) {
>>>
>>
>>
> 
