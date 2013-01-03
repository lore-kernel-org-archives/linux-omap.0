From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 13/22] mfd: omap-usb-host: override number of ports
 from platform data
Date: Thu, 03 Jan 2013 16:52:32 +0400
Message-ID: <50E57F10.6030402@mvista.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com> <1357138842-28964-14-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357138842-28964-14-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, bjorn-yOkvZcmFvRU@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 02-01-2013 19:00, Roger Quadros wrote:

> Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
> but they have different number of ports i.e. 2 and 3 respectively.
> So we can't rely on REVISION register for number of ports on OMAP5
> and depend on platform data (or device tree) instead.

> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
[...]

> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 5edb828..710460d 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -497,19 +497,27 @@ static int usbhs_omap_probe(struct platform_device *pdev)
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
> +		omap->nports = pdata->nports;
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

    Please indent the string to the right somewhat, as it was before.

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
