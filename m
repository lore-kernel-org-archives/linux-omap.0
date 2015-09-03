From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 4/9] usb: dwc3: core: Adapt to named interrupts
Date: Thu, 3 Sep 2015 15:46:43 +0300
Message-ID: <55E84133.9070704@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-5-git-send-email-rogerq@ti.com>
 <20150902143457.GF8299@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150902143457.GF8299-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/09/15 17:34, Felipe Balbi wrote:
> On Wed, Sep 02, 2015 at 05:24:19PM +0300, Roger Quadros wrote:
>> From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>
>> Add support to use interrupt names,
>>
>> Following are the interrupt names
>>
>> Peripheral Interrupt - peripheral
>> HOST Interrupt - host
>> OTG Interrupt - otg
>>
>> [Roger Q]
>> - If any of these are missing we use the
>> first available IRQ resource so that we don't
>> break with older DTBs.
> 
> this is what original commit did:
> 
> commit ecd5f71cfd663bcd4efd2f29824acd8b2ba9715d
> Author: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Date:   Fri Jan 3 13:49:38 2014 -0600
> 
>     usb: dwc3: cleanup IRQ resources
>     
>     In order to make it easier for the driver to
>     figure out which modes of operation it has,
>     and because some dwc3 integrations have rather
>     fuzzy IRQ routing, we now require three different
>     IRQ numbers (peripheral, host, otg).
>     
>     In order to do that and maintain backwards compatibility,
>     we still maintain support for the old IRQ resource name,
>     but if you *really* want to have proper peripheral/host/otg
>     support, you should make sure your resources are correct.
>     
>     Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

This is better since we request the resource only if needed and bail out
if it is not present.

> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 60580a01cdd2..1f01031873b7 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -556,10 +556,22 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  static int dwc3_core_init_mode(struct dwc3 *dwc)
>  {
>  	struct device *dev = dwc->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>  	int ret;
>  
>  	switch (dwc->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
> +		dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc3_peripheral");

Shall we just name it just "peripheral"?

> +		if (dwc->gadget_irq < 0) {
> +			dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc_usb3");

How will this work? Currently we don't have a name for the IRQ in the DT.

> +			if (dwc->gadget_irq < 0) {
> +				dev_err(dev, "missing IRQ\n");
> +				return dwc->gadget_irq;
> +			} else {
> +				dev_warn(dev, "dwc_usb3 resource is deprecated\n");

Do we want to warn about legacy nodes?

> +			}
> +		}
> +
>  		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  		ret = dwc3_gadget_init(dwc);
>  		if (ret) {
> @@ -568,6 +580,22 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_HOST:
> +		dwc->xhci_irq = platform_get_irq_byname(pdev, "dwc3_host");
> +		if (dwc->xhci_irq < 0) {
> +			dwc->xhci_irq = platform_get_irq_byname(pdev, "dwc_usb3");
> +			if (dwc->xhci_irq < 0) {
> +				dev_err(dev, "missing Host IRQ\n");
> +				return dwc->xhci_irq;
> +			} else {
> +				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
> +			}
> +
> +			dwc->xhci_resources[1].start = dwc->xhci_irq;
> +			dwc->xhci_resources[1].end = dwc->xhci_irq;
> +			dwc->xhci_resources[1].flags = IORESOURCE_IRQ;
> +			dwc->xhci_resources[1].name = "xhci";
> +		}
> +
>  		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>  		ret = dwc3_host_init(dwc);
>  		if (ret) {
> @@ -576,6 +604,28 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_OTG:
> +		dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc3_peripheral");
> +		if (dwc->gadget_irq < 0) {
> +			dwc->gadget_irq = platform_get_irq_byname(pdev, "dwc_usb3");
> +			if (dwc->gadget_irq < 0) {
> +				dev_err(dev, "missing IRQ\n");
> +				return dwc->gadget_irq;
> +			} else {
> +				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
> +			}
> +
> +			dwc->xhci_irq = dwc->gadget_irq;
> +			dwc->otg_irq = dwc->gadget_irq;
> +		} else {
> +			dwc->xhci_irq = platform_get_irq_byname(pdev, "dwc3_host");
> +			if (dwc->xhci_irq < 0) {
> +				dev_err(dev, "missing Host IRQ\n");
> +				return dwc->xhci_irq;
> +			}
> +
> +			dwc->otg_irq = platform_get_irq_byname(pdev, "dwc3_otg");

need to check if error?

> +		}

Need to setup xhci_resource[1]?

> +
>  		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>  		ret = dwc3_otg_init(dwc);
>  		if (ret) {
> @@ -647,18 +697,6 @@ static int dwc3_probe(struct platform_device *pdev)
>  	dwc->mem = mem;
>  	dwc->dev = dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> -		dev_err(dev, "missing IRQ\n");
> -		return -ENODEV;
> -	}
> -	dwc->xhci_resources[1].start = res->start;
> -	dwc->xhci_resources[1].end = res->end;
> -	dwc->xhci_resources[1].flags = res->flags;
> -	dwc->xhci_resources[1].name = res->name;
> -
> -	dwc->otg_irq = platform_get_irq_byname(pdev, "dwc3_otg");
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(dev, "missing memory resource\n");
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8e2e579b4b1e..0b02186fad6f 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -671,6 +671,8 @@ struct dwc3_scratchpad_array {
>   * @maximum_speed: maximum speed requested (mainly for testing purposes)
>   * @revision: revision register contents
>   * @dr_mode: requested mode of operation
> + * @gadget_irq: IRQ number for Peripheral IRQs
> + * @xhci_irq: IRQ number for Host IRQs
>   * @otg_irq: IRQ number for OTG IRQs
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
> @@ -747,6 +749,8 @@ struct dwc3 {
>  
>  	enum usb_dr_mode	dr_mode;
>  
> +	int			gadget_irq;
> +	int			xhci_irq;
>  	int			otg_irq;
>  
>  	/* used for suspend/resume */
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index a8cf87b3de01..2a6e5155fc89 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1567,15 +1567,13 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  	struct dwc3_ep		*dep;
>  	unsigned long		flags;
>  	int			ret = 0;
> -	int			irq;
>  	u32			reg;
>  
> -	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
> -	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
> -			IRQF_SHARED, "dwc3", dwc);
> +	ret = request_threaded_irq(dwc->gadget_irq, dwc3_interrupt,
> +			dwc3_thread_interrupt, IRQF_SHARED, "dwc3", dwc);
>  	if (ret) {
>  		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
> -				irq, ret);
> +				dwc->gadget_irq, ret);
>  		goto err0;
>  	}
>  
> @@ -1668,7 +1666,7 @@ err2:
>  err1:
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  
> -	free_irq(irq, dwc);
> +	free_irq(dwc->gadget_irq, dwc);
>  
>  err0:
>  	return ret;
> @@ -1679,7 +1677,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g,
>  {
>  	struct dwc3		*dwc = gadget_to_dwc(g);
>  	unsigned long		flags;
> -	int			irq;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
>  
> @@ -1691,8 +1688,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g,
>  
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  
> -	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
> -	free_irq(irq, dwc);
> +	free_irq(dwc->gadget_irq, dwc);
>  
>  	return 0;
>  }
> 

- --
cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6EEzAAoJENJaa9O+djCT2CYQALOJ+zhWZ1fw8z1FEHnouTT7
6riR0KkGkptuGiRCfUTZYNA+YSMLK2vaZbgH6YWqOrrgK2T45kEAsvoO66byN/2W
XistUWUDRR3X5vhxS4Jsc6euHU7+zKVioTog+qmfFgu/NUJrSUg2w4Q8IR/YGq29
7En5WjGSagd9EoSrS6q9GxYY5m/WOR2Nt/pqOvdtd+izJiRkKrYNfCBzv47majv7
Pdyh6VMBLGjLpQDzKJ+dC8pRzBKI5MpGPNsCFuCNGhjrS5KIv+nMnrtezNRHrU9m
BRzcaYjPj90+zF52BeYPsk+e+r4DqZrnsCw8JWAf/Z+dSiHDcllnNHFjmjyxEWVE
QSVKX6rzq2ADGlCjklEUiy/iFlVV4tF+BzdS+ykEHAT4H7F6h3uAnLCZIE31DEZ/
SL7AfBxzO9xp4hweiQfz8VfpjrI7GWv6kR2A8zWV2pPD5TPo0pSNghI+r0eK1mJ8
rt1IlQnaxqFxNJjYtdVpvppV/ATihqXX+6e3Zgr3rvr8nA/rMEQZ5ePid0tPh4yM
r4r5JAfrP0ROIkvHkQ/otEey2yK5YBMiQ0kqKWZAOztAZTsEeEP0zrJWKIJXtKt5
7P3kOTuZNko4INO7i+F3bb2zBL1ies/mKhdsuvu65QJi7KMDYvLfLdtHTudSwkfX
mtsHh+60Nc0pqqIqH12t
=M0TG
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
