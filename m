From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 4/5] usb: musb: dsps: add support for suspend and resume
Date: Fri, 18 Oct 2013 11:58:27 +0200
Message-ID: <52610643.1000607@linutronix.de>
References: <1382089175-13487-1-git-send-email-zonque@gmail.com> <1382089175-13487-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39596 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab3JRJ6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 05:58:32 -0400
In-Reply-To: <1382089175-13487-5-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 10/18/2013 11:39 AM, Daniel Mack wrote:

> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index da21a4e..ce5bbc6 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -632,11 +648,54 @@ static const struct of_device_id musb_dsps_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
>  
> +#ifdef CONFIG_PM
> +static int dsps_suspend(struct device *dev)
> +{
> +	struct dsps_glue *glue = dev_get_drvdata(dev);
> +	const struct dsps_musb_wrapper *wrp = glue->wrp;
> +	struct musb *musb = platform_get_drvdata(glue->musb);
> +	void __iomem *mbase = musb->ctrl_base;
> +
> +	glue->context.control = dsps_readl(mbase, wrp->control);
> +	glue->context.epintr = dsps_readl(mbase, wrp->epintr_set);
> +	glue->context.coreintr = dsps_readl(mbase, wrp->coreintr_set);
> +	glue->context.phy_utmi = dsps_readl(mbase, wrp->phy_utmi);
> +	glue->context.mode = dsps_readl(mbase, wrp->mode);
> +	glue->context.tx_mode = dsps_readl(mbase, wrp->tx_mode);
> +	glue->context.rx_mode = dsps_readl(mbase, wrp->rx_mode);

Looking at this made me wonder, what about

   drivers/usb/phy/phy-am335x-control.c

Since it seems to work for you, maybe we don't need this after all :P

Sebastian
