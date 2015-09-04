From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 4/9] usb: dwc3: core: Adapt to named interrupts
Date: Fri, 4 Sep 2015 12:11:32 +0300
Message-ID: <55E96044.5060705@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-5-git-send-email-rogerq@ti.com>
 <20150902143457.GF8299@saruman.tx.rr.com> <55E84133.9070704@ti.com>
 <20150903154849.GB4031@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150903154849.GB4031@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

On 03/09/15 18:48, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Sep 03, 2015 at 03:46:43PM +0300, Roger Quadros wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> On 02/09/15 17:34, Felipe Balbi wrote:
>>> On Wed, Sep 02, 2015 at 05:24:19PM +0300, Roger Quadros wrote:
>>>> From: Felipe Balbi <balbi@ti.com>
>>>>
>>>> Add support to use interrupt names,
>>>>
>>>> Following are the interrupt names
>>>>
>>>> Peripheral Interrupt - peripheral
>>>> HOST Interrupt - host
>>>> OTG Interrupt - otg
>>>>
>>>> [Roger Q]
>>>> - If any of these are missing we use the
>>>> first available IRQ resource so that we don't
>>>> break with older DTBs.
>>>
>>> this is what original commit did:
>>>
>>> commit ecd5f71cfd663bcd4efd2f29824acd8b2ba9715d
>>> Author: Felipe Balbi <balbi@ti.com>
>>> Date:   Fri Jan 3 13:49:38 2014 -0600
>>>
>>>     usb: dwc3: cleanup IRQ resources
>>>     
>>>     In order to make it easier for the driver to
>>>     figure out which modes of operation it has,
>>>     and because some dwc3 integrations have rather
>>>     fuzzy IRQ routing, we now require three different
>>>     IRQ numbers (peripheral, host, otg).
>>>     
>>>     In order to do that and maintain backwards compatibility,
>>>     we still maintain support for the old IRQ resource name,
>>>     but if you *really* want to have proper peripheral/host/otg
>>>     support, you should make sure your resources are correct.
>>>     
>>>     Signed-off-by: Felipe Balbi <balbi@ti.com>
>>
>> This is better since we request the resource only if needed and bail out
>> if it is not present.
>>
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 60580a01cdd2..1f01031873b7 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -556,10 +556,22 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>>>  static int dwc3_core_init_mode(struct dwc3 *dwc)
>>>  {
>>>  	struct device *dev = dwc->dev;
>>> +	struct platform_device *pdev = to_platform_device(dev);
>>>  	int ret;
>>>  
>>>  	switch (dwc->dr_mode) {
>>>  	case USB_DR_MODE_PERIPHERAL:
>>> +		dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc3_peripheral");
>>
>> Shall we just name it just "peripheral"?
> 
> sure, why not :-)
> 
>>> +		if (dwc->gadget_irq < 0) {
>>> +			dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc_usb3");
>>
>> How will this work? Currently we don't have a name for the IRQ in the DT.
> 
> we can just add interrupt-names, right ? Or, the fallback could be what
> is already done today: just fetch it by index.
> 
>>
>>> +			if (dwc->gadget_irq < 0) {
>>> +				dev_err(dev, "missing IRQ\n");
>>> +				return dwc->gadget_irq;
>>> +			} else {
>>> +				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
>>
>> Do we want to warn about legacy nodes?
> 
> Sure :-)
> 
> Now, do you want me to update it, or will you do it ? BTW, if you decide
> to do it, we need to patch all users :-)

Would appreciate if you can do it. It is independent of dual-role support and can go in early.
BTW omap users are already using the named interrupt property.

> 
>>> @@ -576,6 +604,28 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>>  		}
>>>  		break;
>>>  	case USB_DR_MODE_OTG:
>>> +		dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc3_peripheral");
>>> +		if (dwc->gadget_irq < 0) {
>>> +			dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc_usb3");
>>> +			if (dwc->gadget_irq < 0) {
>>> +				dev_err(dev, "missing IRQ\n");
>>> +				return dwc->gadget_irq;
>>> +			} else {
>>> +				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
>>> +			}
>>> +
>>> +			dwc->xhci_irq = dwc->gadget_irq;
>>> +			dwc->otg_irq = dwc->gadget_irq;
>>> +		} else {
>>> +			dwc->xhci_irq = platform_get_irq_byname(pdev, "dwc3_host");
>>> +			if (dwc->xhci_irq < 0) {
>>> +				dev_err(dev, "missing Host IRQ\n");
>>> +				return dwc->xhci_irq;
>>> +			}
>>> +
>>> +			dwc->otg_irq = platform_get_irq_byname(pdev, "dwc3_otg");
>>
>> need to check if error?
> 
> right
> 
>>> +		}
>>
>> Need to setup xhci_resource[1]?
> 
> isn't it done above ?
> 

It is done in the USB_DR_MODE_HOST case, but that won't be executed for USB_DR_MODE_OTG case, no?
I'm talking about this part

+			dwc->xhci_resources[1].start = dwc->xhci_irq;
+			dwc->xhci_resources[1].end = dwc->xhci_irq;
+			dwc->xhci_resources[1].flags = IORESOURCE_IRQ;
+			dwc->xhci_resources[1].name = "xhci";

cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6WBDAAoJENJaa9O+djCTXW4QAIx6ok9D/bGqz8F++KKdIJmQ
Kj7cedP1B4el/+OQ20n38g9U8HosrY5wtB9n0VdBc99bLGbBFMOheeamLQw8u6rU
WKT4zcXjbasDURE25eqmAu3Nc7EiXVebiu07GEVR82/zl2H6edSddaf9Bx/3+yzm
VV6gwIXBISbkTuTfw5Nsh9GR4+X3KTOE78Nygtv7MfbLpMrfbABGHhWnGpCRn5oO
SHMvZd1HUHFKb0Z2nKrBXV9yzayQtfjAjNjKn2rIxwirKdMAk96z+32Ql3lh06Aq
jxe+UK/KXH9+Cd25FFEQlazBxcd7gnbugS+MYroUW8dPSWsX0LjfIkzjDbwwfh12
DqLMhwa+ouCvJMjrU5ifRvtmVvNS5LUY3Em6ZQW+3nzXrFdiaAuzOTc8WeMGKL9T
Hl63yKsc1kGgtkpoxvMlNdkQABIN7B7mMlJTZ3GKLBcneRcWjc/nPmsCV+ASuukg
K5Cck/RVtB2KBhh8e1vrZIFJOVrtoB6T22MwJf3Lrw+uVxxprM9w9SbE1nibWU/G
7AebuHXtM08Hon999j4odQaAmKU1zS0EfSm6bdy6/7cTDfhicidkK4w3d9MxR9oo
kOTIE/ti3tppH94CiTN6fjT6I0Z9en6lEPnUv1X1pypbRKWCQw0o7/GxCrhkkbE/
eHH1noaEXEGyoTzmrlrW
=fDSz
-----END PGP SIGNATURE-----
