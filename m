From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: core: modify IO memory resource after deferred
 probe completes
Date: Thu, 25 Jul 2013 21:21:09 +0400
Message-ID: <51F15E85.1050808@cogentembedded.com>
References: <1374769590-14491-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374769590-14491-1-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/25/2013 08:26 PM, Ivan T. Ivanov wrote:

> From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>

> When deferred probe happens driver will try to ioremap multiple times
> and will fail. Memory resource.start variable is a global variable,
> modifications in this field will be accumulated on every probe.
> Fix this by moving the above operations after driver hold all
> required PHY's.

> Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/usb/dwc3/core.c |   31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 607bef8..50c833f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
[...]
> @@ -452,6 +437,22 @@ static int dwc3_probe(struct platform_device *pdev)
>   		return -EPROBE_DEFER;
>   	}
>
> +	dwc->xhci_resources[0].start = res->start;
> +	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
> +					DWC3_XHCI_REGS_END;
> +	dwc->xhci_resources[0].flags = res->flags;
> +	dwc->xhci_resources[0].name = res->name;
> +
> +	res->start += DWC3_GLOBALS_REGS_START;
> +
> +	 /*
> +	  * Request memory region but exclude xHCI regs,
> +	  * since it will be requested by the xhci-plat driver.
> +	  */

     Please remove an extra space after a tab on each comment line.
It seems like a good time to do it, while you're moving this code.

> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
