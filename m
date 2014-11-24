From: Apelete Seketeli <apelete@seketeli.net>
Subject: Re: [PATCH 6/8] usb: musb: Pass fifo_mode in platform data
Date: Tue, 25 Nov 2014 00:40:36 +0100
Message-ID: <20141124234036.GC14728@tao>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
 <1416855906-13931-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from seketeli.net ([94.23.218.202]:42379 "EHLO ms.seketeli.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbaKXXta (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2014 18:49:30 -0500
Content-Disposition: inline
In-Reply-To: <1416855906-13931-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>

Hi Tony,

Thanks for this one too.

On Mon, Nov-24-2014 at 11:05:04 AM -0800, Tony Lindgren wrote:
> This allows setting the correct fifo_mode when multiple
> MUSB glue layers are built-in.

Applied on top of 3.18-rc6 mainline and tested successfully on JZ4740.
Been able to use ethernet-over-usb to access the internet on
device. No issue as far as I'm concerned.

Acked-by: Apelete Seketeli <apelete@seketeli.net>

> Cc: Fabio Baltieri <fabio.baltieri@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Apelete Seketeli <apelete@seketeli.net>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/usb/musb/blackfin.c  |  1 +
>  drivers/usb/musb/da8xx.c     |  1 +
>  drivers/usb/musb/jz4740.c    |  1 +
>  drivers/usb/musb/musb_core.c | 21 ++++++---------------
>  drivers/usb/musb/ux500.c     |  1 +
>  5 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
> index c55fcfd..b8442b9 100644
> --- a/drivers/usb/musb/blackfin.c
> +++ b/drivers/usb/musb/blackfin.c
> @@ -474,6 +474,7 @@ static const struct musb_platform_ops bfin_ops = {
>  	.writew		= bfin_writew,
>  	.readl		= bfin_readl,
>  	.writel		= bfin_writel,
> +	.fifo_mode	= 2,
>  	.read_fifo	= bfin_read_fifo,
>  	.write_fifo	= bfin_write_fifo,
>  	.enable		= bfin_musb_enable,
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index c9079c8..5f9b486 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -462,6 +462,7 @@ static const struct musb_platform_ops da8xx_ops = {
>  	.init		= da8xx_musb_init,
>  	.exit		= da8xx_musb_exit,
>  
> +	.fifo_mode	= 2,
>  	.enable		= da8xx_musb_enable,
>  	.disable	= da8xx_musb_disable,
>  
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index 40e9874..bb7b263 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -107,6 +107,7 @@ static int jz4740_musb_exit(struct musb *musb)
>  
>  static const struct musb_platform_ops jz4740_musb_ops = {
>  	.quirks		= MUSB_INDEXED_EP,
> +	.fifo_mode	= 2,
>  	.init		= jz4740_musb_init,
>  	.exit		= jz4740_musb_exit,
>  };
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 48ddc82..0875365 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1116,21 +1116,7 @@ static void musb_shutdown(struct platform_device *pdev)
>   * We don't currently use dynamic fifo setup capability to do anything
>   * more than selecting one of a bunch of predefined configurations.
>   */
> -#if defined(CONFIG_USB_MUSB_TUSB6010)			\
> -	|| defined(CONFIG_USB_MUSB_TUSB6010_MODULE)	\
> -	|| defined(CONFIG_USB_MUSB_OMAP2PLUS)		\
> -	|| defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE)	\
> -	|| defined(CONFIG_USB_MUSB_AM35X)		\
> -	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)	\
> -	|| defined(CONFIG_USB_MUSB_DSPS)		\
> -	|| defined(CONFIG_USB_MUSB_DSPS_MODULE)
> -static ushort fifo_mode = 4;
> -#elif defined(CONFIG_USB_MUSB_UX500)			\
> -	|| defined(CONFIG_USB_MUSB_UX500_MODULE)
> -static ushort fifo_mode = 5;
> -#else
> -static ushort fifo_mode = 2;
> -#endif
> +static ushort fifo_mode;
>  
>  /* "modprobe ... fifo_mode=1" etc */
>  module_param(fifo_mode, ushort, 0);
> @@ -2040,6 +2026,11 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  		musb->io.ep_select = musb_flat_ep_select;
>  	}
>  
> +	if (musb->ops->fifo_mode)
> +		fifo_mode = musb->ops->fifo_mode;
> +	else
> +		fifo_mode = 4;
> +
>  	if (musb->ops->fifo_offset)
>  		musb->io.fifo_offset = musb->ops->fifo_offset;
>  	else
> diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
> index c170501..c372518 100644
> --- a/drivers/usb/musb/ux500.c
> +++ b/drivers/usb/musb/ux500.c
> @@ -191,6 +191,7 @@ static const struct musb_platform_ops ux500_ops = {
>  	.quirks		= MUSB_INDEXED_EP,
>  	.init		= ux500_musb_init,
>  	.exit		= ux500_musb_exit,
> +	.fifo_mode	= 5,
>  
>  	.set_vbus	= ux500_musb_set_vbus,
>  };
> -- 
> 2.1.3
> 

-- 
        Apelete
