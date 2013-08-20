From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 5/8] usb: musb: omap2430: Don't use omap_get_control_dev()
Date: Tue, 20 Aug 2013 21:57:24 +0400
Message-ID: <5213AE04.1070907@cogentembedded.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com> <1377010577-19355-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377010577-19355-6-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 08/20/2013 06:56 PM, Roger Quadros wrote:

> omap_get_control_dev() is being deprecated as it doesn't support
> multiple instances. As control device is present only from OMAP4
> onwards which supports DT only, we use phandles to get the
> reference to the control device.

> Also get rid of "ti,has-mailbox" property as it is redundant and
> we can determine that from whether "ctrl-module" property is present
> or not. Get rid of has_mailbox from musb_hdrc_platform_data as well.

> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
[...]

> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index ebb46ec..516795b 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
[...]
> @@ -509,8 +510,12 @@ static int omap2430_probe(struct platform_device *pdev)
>   	glue->dev			= &pdev->dev;
>   	glue->musb			= musb;
>   	glue->status			= OMAP_MUSB_UNKNOWN;
> +	glue->control_otghs = ERR_PTR(-ENODEV);

    Could you please align = with the others above?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
