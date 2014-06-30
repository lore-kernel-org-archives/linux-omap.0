From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 09/13] uio: uio_pruss: add devicetree support
Date: Mon, 30 Jun 2014 10:36:06 +0100
Message-ID: <20140630093606.GU7262@leverpostej>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-10-git-send-email-a.heider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62149 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147AbaF3Jgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2014 05:36:53 -0400
Content-Disposition: inline
In-Reply-To: <1404058907-21112-10-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Heider <a.heider@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sun, Jun 29, 2014 at 05:21:43PM +0100, Andre Heider wrote:
> Add support to probe via devicetree.
> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  drivers/uio/uio_pruss.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
> index afaf726..2df54ab 100644
> --- a/drivers/uio/uio_pruss.c
> +++ b/drivers/uio/uio_pruss.c
> @@ -26,6 +26,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/genalloc.h>
> +#include <linux/of_device.h>
>  
>  #define DRV_NAME "pruss_uio"
>  #define DRV_VERSION "1.0"
> @@ -70,6 +71,27 @@ struct uio_pruss_dev {
>  	struct gen_pool *sram_pool;
>  };
>  
> +#ifdef CONFIG_OF
> +struct uio_pruss_params {
> +	u32 pintc_offset;
> +};
> +
> +static const struct uio_pruss_params uio_pruss_v1_params = {
> +	.pintc_offset = 0x4000,
> +};
> +
> +static const struct uio_pruss_params uio_pruss_v2_params = {
> +	.pintc_offset = 0x20000,
> +};
> +
> +static const struct of_device_id pruss_of_match_table[] = {
> +	{ .compatible = "ti,pruss-v1", .data = &uio_pruss_v1_params, },
> +	{ .compatible = "ti,pruss-v2", .data = &uio_pruss_v2_params, },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pruss_of_match_table);
> +#endif
> +
>  static irqreturn_t pruss_handler(int irq, struct uio_info *info)
>  {
>  	struct uio_pruss_dev *gdev = info->priv;
> @@ -111,6 +133,8 @@ static int pruss_probe(struct platform_device *pdev)
>  	struct uio_pruss_dev *gdev;
>  	struct resource *regs_prussio;
>  	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	const struct uio_pruss_params *params;
>  	int ret = -ENODEV, cnt = 0, i;
>  	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
>  	dma_addr_t ddr_paddr;
> @@ -123,13 +147,21 @@ static int pruss_probe(struct platform_device *pdev)
>  	if (!gdev->info)
>  		return -ENOMEM;
>  
> -	/* Power on PRU in case its not done as part of boot-loader */
> -	gdev->pruss_clk = clk_get(dev, "pruss");
> -	if (IS_ERR(gdev->pruss_clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> -		return PTR_ERR(gdev->pruss_clk);
> +	if (dev->of_node) {
> +		match = of_match_device(pruss_of_match_table, dev);
> +		params = match->data;
> +		gdev->pintc_base = params->pintc_offset;
>  	} else {
> +		/* Power on PRU in case its not done as part of boot-loader */
> +		gdev->pruss_clk = clk_get(dev, "pruss");
> +		if (IS_ERR(gdev->pruss_clk)) {
> +			dev_err(dev, "Failed to get clock\n");
> +			return PTR_ERR(gdev->pruss_clk);
> +		}

The "pruss" clock was not documented in the binding.

Is the clock really called "pruss", or is it given a specific name in
the manual?

Cheers,
Mark.
