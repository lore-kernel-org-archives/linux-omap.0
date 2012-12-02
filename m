From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 13/22] mfd: omap-usb-host: override number of ports
 from platform data
Date: Sun, 02 Dec 2012 21:14:27 +0400
Message-ID: <50BB8C73.7060008@mvista.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com> <1354114150-11941-14-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354114150-11941-14-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 28-11-2012 18:49, Roger Quadros wrote:

> Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
> but they have different number of ports i.e. 2 and 3 respectively.
> So we can't rely on REVISION register for number of ports on OMAP5
> and depend on platform data (or device tree) instead.

> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
[...]

> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 87b574b..fda235a 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -495,19 +495,27 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>   	 */
>   	pm_runtime_put_sync(dev);
>
> -	switch (omap->usbhs_rev) {
> -	case OMAP_USBHS_REV1:
> -		omap->nports = 3;
> -		break;
> -	case OMAP_USBHS_REV2:
> -		omap->nports = 2;
> -		break;
> -	default:
> -		omap->nports = OMAP3_HS_USB_PORTS;
> -		dev_dbg(dev,
> -		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
> -		   omap->usbhs_rev, omap->nports);
> -		break;
> +	/*
> +	 * If platform data contains nports then use that
> +	 * else make out number of ports from USBHS revision
> +	 */
> +	if (pdata->nports) {
> +			omap->nports = pdata->nports;

    Overindented line?

> +	} else {
> +		switch (omap->usbhs_rev) {
> +		case OMAP_USBHS_REV1:
> +			omap->nports = 3;
> +			break;
> +		case OMAP_USBHS_REV2:
> +			omap->nports = 2;
> +			break;
> +		default:
> +			omap->nports = OMAP3_HS_USB_PORTS;
> +			dev_dbg(dev,
> +			"USB HOST Rev:0x%d not recognized, assuming %d ports\n",

    Indent this string a bit to the right please.

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
