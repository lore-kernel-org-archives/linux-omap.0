From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Subject: RE: [PATCH] usb: dwc3: Keeping 'resource' related code together
Date: Tue, 3 Jun 2014 19:11:54 +0000
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E0304844B2141@US01WEMBX2.internal.synopsys.com>
References: <1401791978-3555-1-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401791978-3555-1-git-send-email-gautam.vivek@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "kishon@ti.com" <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Vivek Gautam
> Sent: Tuesday, June 03, 2014 3:40 AM
> 
> Putting together the code related to getting the 'IORESOURCE_MEM'
> and assigning the same to dwc->xhci_resources, for increasing
> the readability.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
> 
> Based on 'next' branch of Felipe's usb tree.
> Also cleanly applies to 'usb-next' branch of Greg's usb tree.
> 
>  drivers/usb/dwc3/core.c |   38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 3f59c12..4ca925d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -656,6 +656,25 @@ static int dwc3_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> +	dwc->xhci_resources[0].start = res->start;
> +	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
> +					DWC3_XHCI_REGS_END;
> +	dwc->xhci_resources[0].flags = res->flags;
> +	dwc->xhci_resources[0].name = res->name;
> +
> +	res->start += DWC3_GLOBALS_REGS_START;
> +
> +	/*
> +	 * Request memory region but exclude xHCI regs,
> +	 * since it will be requested by the xhci-plat driver.
> +	 */
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	dwc->regs	= regs;
> +	dwc->regs_size	= resource_size(res);
> +
>  	if (node) {
>  		dwc->maximum_speed = of_usb_get_maximum_speed(node);

I think this will break if the following dwc3_core_get_phy() call returns
-EPROBE_DEFER. Since you have incremented res->start above, the next time
this probe function is called, res->start will have the wrong value.
Provided I'm reading the code correctly of course :)

I think you could fix that by decrementing res->start back to its
original value just after the call to resource_size() above.

-- 
Paul
