From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Fri, 10 Jun 2016 13:39:25 +0300
Message-ID: <c59b5dcf-87ff-df86-897c-8c7a9f4beb20@cogentembedded.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <575A8EB0.1050706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575A8EB0.1050706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, balbi@kernel.org, grygorii.strashko@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 6/10/2016 12:56 PM, Roger Quadros wrote:

> Implementations might use different IRQs for
> host, gadget so use named interrupt resources
> to allow device tree to specify the interrupts.
>
> Following are the interrupt names
>
> Peripheral Interrupt - peripheral
> HOST Interrupt - host
>
> Maintain backward compatibility for a single named
> interrupt ("dwc3_usb3") for all interrupts as well as
> unnamed interrupt at index 0 for all interrupts.
>
> As platform_get_irq_() variants are used, tackle

    platform_get_irq().

> the -EPROBE_DEFER case as well.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> v10:
> - don't mention otg irq since we are not using it yet
> - use platform_get_irq() and friends and check -EPROBE_DEFER case.
>
>  drivers/usb/dwc3/core.c   | 22 ++++++++--------------
>  drivers/usb/dwc3/gadget.c | 29 ++++++++++++++++++++++++++---
>  drivers/usb/dwc3/host.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 8fceeb1..131e7eb 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
[...]
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 0f6fb8e..774a0d8 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
[...]
> @@ -2866,7 +2865,31 @@ static irqreturn_t dwc3_interrupt(int irq, void *_evt)
>   */
>  int dwc3_gadget_init(struct dwc3 *dwc)
>  {
> -	int					ret;
> +	int ret, irq;
> +	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
> +
> +	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +
> +	if (irq <= 0) {
> +		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
> +
> +		if (irq <= 0) {
> +			irq = platform_get_irq(dwc3_pdev, 0);
> +			if (irq <= 0) {
> +				if (irq != -EPROBE_DEFER) {
> +					dev_err(dwc->dev,
> +						"missing peripheral IRQ\n");
> +				}
> +				return irq;

    Iff irq == 0, you'll return success despite IRQ was "invalid". Was that 
intended?

> +			}
> +		}
> +	}
> +
> +	dwc->irq_gadget = irq;
>
>  	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
>  			&dwc->ctrl_req_addr, GFP_KERNEL);
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index c679f63..eb5e8f9 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -24,7 +24,46 @@ int dwc3_host_init(struct dwc3 *dwc)
>  {
>  	struct platform_device	*xhci;
>  	struct usb_xhci_pdata	pdata;
> -	int			ret;
> +	int			ret, irq;
> +	struct resource		*res;
> +	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
> +
> +	irq = platform_get_irq_byname(dwc3_pdev, "host");
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +
> +	if (irq <= 0) {
> +		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
> +
> +		if (irq <= 0) {
> +			irq = platform_get_irq(dwc3_pdev, 0);
> +			if (irq <= 0) {
> +				if (irq != -EPROBE_DEFER) {
> +					dev_err(dwc->dev,
> +						"missing host IRQ\n");
> +				}
> +				return irq;

    Iff irq == 0, you'll return success despite IRQ was "invalid". Was that 
intended?

> +			} else {
> +				res = platform_get_resource(dwc3_pdev,
> +							    IORESOURCE_IRQ, 0);
> +			}
> +		} else {
> +			res = platform_get_resource_byname(dwc3_pdev,
> +							   IORESOURCE_IRQ,
> +							   "dwc_usb3");
> +		}
> +
> +	} else {
> +		res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
> +						   "host");
> +	}
> +
> +	dwc->xhci_resources[1].start = irq;
> +	dwc->xhci_resources[1].end = irq;
> +	dwc->xhci_resources[1].flags = res->flags;
> +	dwc->xhci_resources[1].name = res->name;
>
>  	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
>  	if (!xhci) {

MBR, Sergei
