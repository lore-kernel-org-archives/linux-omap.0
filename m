From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3 v5] usb: musb: Add support for ti81xx platform
Date: Wed, 08 Feb 2012 11:46:00 +0530
Message-ID: <4F321320.8010709@ti.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328675212-29693-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 08 February 2012 09:56 AM, Ajay Kumar Gupta wrote:
> +static int dsps_musb_init(struct musb *musb)
> +{
> +	struct device *dev = musb->controller;
> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
> +	struct platform_device *pdev = to_platform_device(dev->parent);
> +	struct dsps_glue *glue = platform_get_drvdata(pdev);
> +	const struct dsps_musb_wrapper *wrp = glue->wrp;
> +	struct omap_musb_board_data *data = plat->board_data;
> +	void __iomem *reg_base = musb->ctrl_base;
> +	u32 rev, val;
> +	int status;
> +
> +	/* mentor core register starts at offset of 0x400 from musb base */
> +	musb->mregs += wrp->musb_core_offset;
> +
> +	/* NOP driver needs change if supporting dual instance */
> +	usb_nop_xceiv_register();
> +	musb->xceiv = otg_get_transceiver();
> +	if (!musb->xceiv)
> +		return -ENODEV;
> +
> +	status = pm_runtime_get_sync(dev);
> +	if (status < 0) {
> +		dev_err(dev, "pm_runtime_get_sync FAILED");
> +		goto err0;
> +	}
So you are doing a get_sync at init and you cut the clocks at exit only.
Any particular reason for that.
> +

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
