From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [RFC PATCH 1/6] usb: musb: omap: Configure OTG_INTERFSEL for
 proper charger detection
Date: Fri, 16 Sep 2011 13:48:29 +0400
Message-ID: <4E731B6D.2040007@ru.mvista.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com> <1316096403-6013-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52770 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab1IPJtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 05:49:16 -0400
In-Reply-To: <1316096403-6013-2-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, heikki.krogerus@linux.intel.com, gregkh@suse.de, p-basak2@ti.com, balajitk@ti.com, x0153364@ti.com, m-sonasath@ti.com, vishp@ti.com, hemahk@ti.com

Hello.

On 15-09-2011 18:19, Kishon Vijay Abraham I wrote:

> Setting OTG_INTERFSEL to UTMI interferes with charger detection resulting
> in incorrect detection of charger type. Hence OTG_INTERFSEL is configured to
> ULPI initially and changed to UTMI only after receiving USB_EVENT_ID or
> USB_EVENT_VBUS notification.

> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> Signed-off-by: Balaji T K<balajitk@ti.com>

    AFAIK, full name is needed here.

> [sandesh.gowda@ti.com: The interface selection has to be done before the PHY
> is activated and is not allowed to change when the PHY clock is already
> running]

    No signoff from him?

> ---
>   drivers/usb/musb/omap2430.c |   50 +++++++++++++++++++++++++++++++++++-------
>   1 files changed, 41 insertions(+), 9 deletions(-)

> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index fc9377c..724450b 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -228,6 +228,7 @@ static inline void omap2430_low_level_init(struct musb *musb)
>   static int musb_otg_notifications(struct notifier_block *nb,
>   		unsigned long event, void *unused)
>   {
> +	u32 val;
>   	struct musb	*musb = container_of(nb, struct musb, nb);
>   	struct device *dev = musb->controller;
>   	struct musb_hdrc_platform_data *pdata = dev->platform_data;
> @@ -240,11 +241,32 @@ static int musb_otg_notifications(struct notifier_block *nb,
>   		if (is_otg_enabled(musb)) {
>   			if (musb->gadget_driver) {
>   				pm_runtime_get_sync(musb->controller);
> +
> +				val = musb_readl(musb->mregs, OTG_INTERFSEL);
> +				if (data->interface_type ==
> +							MUSB_INTERFACE_UTMI) {
> +					val&= ~ULPI_12PIN;
> +					val |= UTMI_8BIT;
> +				} else {
> +					val |= ULPI_12PIN;
> +				}
> +				musb_writel(musb->mregs, OTG_INTERFSEL, val);
> +
>   				usb_phy_init(musb->xceiv);
>   				omap2430_musb_set_vbus(musb, 1);
>   			}
>   		} else {
>   			pm_runtime_get_sync(musb->controller);
> +
> +			val = musb_readl(musb->mregs, OTG_INTERFSEL);
> +			if (data->interface_type == MUSB_INTERFACE_UTMI) {
> +				val&= ~ULPI_12PIN;
> +				val |= UTMI_8BIT;
> +			} else {
> +				val |= ULPI_12PIN;
> +			}
> +			musb_writel(musb->mregs, OTG_INTERFSEL, val);
> +
>   			usb_phy_init(musb->xceiv);
>   			omap2430_musb_set_vbus(musb, 1);
>   		}
> @@ -255,6 +277,16 @@ static int musb_otg_notifications(struct notifier_block *nb,
>
>   		if (musb->gadget_driver)
>   			pm_runtime_get_sync(musb->controller);
> +
> +		val = musb_readl(musb->mregs, OTG_INTERFSEL);
> +		if (data->interface_type == MUSB_INTERFACE_UTMI) {
> +			val&= ~ULPI_12PIN;
> +			val |= UTMI_8BIT;
> +		} else {
> +			val |= ULPI_12PIN;
> +		}
> +		musb_writel(musb->mregs, OTG_INTERFSEL, val);
> +
>   		usb_phy_init(musb->xceiv);
>   		break;

    Why repeat the same sequence 3 times. Couldn't you factor it out into a 
subroutine?

> @@ -272,6 +304,11 @@ static int musb_otg_notifications(struct notifier_block *nb,
>   				otg_set_vbus(musb->xceiv->otg, 0);
>   		}
>   		usb_phy_shutdown(musb->xceiv);
> +
> +		val = musb_readl(musb->mregs, OTG_INTERFSEL);
> +		val |= ULPI_12PIN;
> +		musb_writel(musb->mregs, OTG_INTERFSEL, val);
> +
>   		break;
>   	default:
>   		dev_dbg(musb->controller, "ID float\n");
> @@ -304,16 +341,11 @@ static int omap2430_musb_init(struct musb *musb)
>   		goto err1;
>   	}
>
> +	/* Set OTG_INTERFSEL to ULPI for correct charger detection.
> +	 * This should be later set to UTMI.
> +	 */
>   	l = musb_readl(musb->mregs, OTG_INTERFSEL);
> -
> -	if (data->interface_type == MUSB_INTERFACE_UTMI) {
> -		/* OMAP4 uses Internal PHY GS70 which uses UTMI interface */
> -		l&= ~ULPI_12PIN;       /* Disable ULPI */
> -		l |= UTMI_8BIT;         /* Enable UTMI  */
> -	} else {
> -		l |= ULPI_12PIN;
> -	}
> -
> +	l |= ULPI_12PIN;
>   	musb_writel(musb->mregs, OTG_INTERFSEL, l);

    This also seems to be the same code repeated twice...

WBR, Sergei
