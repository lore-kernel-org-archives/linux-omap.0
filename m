From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 08/11] dmaengine: cppi41: Implement the glue for da8xx
Date: Mon, 9 Jan 2017 12:08:54 -0600
Message-ID: <fbc7f9f3-9b14-bc7f-0b40-15a6fedd48ea@ti.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-9-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-9-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 01/09/2017 10:06 AM, Alexandre Bailon wrote:
> The da8xx has a cppi41 dma controller.
> This is add the glue layer required to make it work on da8xx,
> as well some changes in driver (e.g to manage clock).
> 
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 939398e..4318e53 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -1,3 +1,4 @@
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> @@ -86,10 +87,19 @@
>  
>  #define USBSS_IRQ_PD_COMP	(1 <<  2)
>  
> +/* USB DA8XX */
> +#define DA8XX_INTR_SRC_MASKED	0x38
> +#define DA8XX_END_OF_INTR	0x3c
> +
> +#define DA8XX_QMGR_PENDING_MASK	(0xf << 24)
> +
> +
> +
>  /* Packet Descriptor */
>  #define PD2_ZERO_LENGTH		(1 << 19)
>  
>  #define AM335X_CPPI41		0
> +#define DA8XX_CPPI41		1
>  
>  struct cppi41_channel {
>  	struct dma_chan chan;
> @@ -158,6 +168,9 @@ struct cppi41_dd {
>  
>  	/* context for suspend/resume */
>  	unsigned int dma_tdfdq;
> +
> +	/* da8xx clock */
> +	struct clk *clk;
>  };
>  
>  static struct chan_queues am335x_usb_queues_tx[] = {
> @@ -232,6 +245,20 @@ static const struct chan_queues am335x_usb_queues_rx[] = {
>  	[29] = { .submit = 30, .complete = 155},
>  };
>  
> +static const struct chan_queues da8xx_usb_queues_tx[] = {
> +	[0] = { .submit =  16, .complete = 24},
> +	[1] = { .submit =  18, .complete = 24},
> +	[2] = { .submit =  20, .complete = 24},
> +	[3] = { .submit =  22, .complete = 24},
> +};
> +
> +static const struct chan_queues da8xx_usb_queues_rx[] = {
> +	[0] = { .submit =  1, .complete = 26},
> +	[1] = { .submit =  3, .complete = 26},
> +	[2] = { .submit =  5, .complete = 26},
> +	[3] = { .submit =  7, .complete = 26},
> +};
> +
>  struct cppi_glue_infos {
>  	irqreturn_t (*isr)(int irq, void *data);
>  	const struct chan_queues *queues_rx;
> @@ -366,6 +393,26 @@ static irqreturn_t am335x_cppi41_irq(int irq, void *data)
>  	return cppi41_irq(cdd);
>  }
>  
> +static irqreturn_t da8xx_cppi41_irq(int irq, void *data)
> +{
> +	struct cppi41_dd *cdd = data;
> +	u32 status;
> +	u32 usbss_status;
> +
> +	status = cppi_readl(cdd->qmgr_mem + QMGR_PEND(0));
> +	if (status & DA8XX_QMGR_PENDING_MASK)
> +		cppi41_irq(cdd);
> +	else
> +		return IRQ_NONE;
> +
> +	/* Re-assert IRQ if there no usb core interrupts pending */
> +	usbss_status = cppi_readl(cdd->usbss_mem + DA8XX_INTR_SRC_MASKED);
> +	if (!usbss_status)
> +		cppi_writel(0, cdd->usbss_mem + DA8XX_END_OF_INTR);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static dma_cookie_t cppi41_tx_submit(struct dma_async_tx_descriptor *tx)
>  {
>  	dma_cookie_t cookie;
> @@ -972,8 +1019,19 @@ static const struct cppi_glue_infos am335x_usb_infos = {
>  	.platform = AM335X_CPPI41,
>  };
>  
> +static const struct cppi_glue_infos da8xx_usb_infos = {
> +	.isr = da8xx_cppi41_irq,
> +	.queues_rx = da8xx_usb_queues_rx,
> +	.queues_tx = da8xx_usb_queues_tx,
> +	.td_queue = { .submit = 31, .complete = 0 },
> +	.first_completion_queue = 24,
> +	.qmgr_num_pend = 2,
> +	.platform = DA8XX_CPPI41,
> +};
> +
>  static const struct of_device_id cppi41_dma_ids[] = {
>  	{ .compatible = "ti,am3359-cppi41", .data = &am335x_usb_infos},
> +	{ .compatible = "ti,da8xx-cppi41", .data = &da8xx_usb_infos},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, cppi41_dma_ids);
> @@ -995,6 +1053,13 @@ static int is_am335x_cppi41(struct device *dev)
>  	return cdd->platform == AM335X_CPPI41;
>  }
>  
> +static int is_da8xx_cppi41(struct device *dev)
> +{
> +	struct cppi41_dd *cdd = dev_get_drvdata(dev);
> +
> +	return cdd->platform == DA8XX_CPPI41;
> +}
> +
>  #define CPPI41_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
>  				BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
>  				BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
> @@ -1058,6 +1123,21 @@ static int cppi41_dma_probe(struct platform_device *pdev)
>  	cdd->first_completion_queue = glue_info->first_completion_queue;
>  	cdd->platform = glue_info->platform;
>  
> +	if (is_da8xx_cppi41(dev)) {
> +		cdd->clk = devm_clk_get(&pdev->dev, "usb20");
> +		ret = PTR_ERR_OR_ZERO(cdd->clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to get clock\n");
> +			goto err_clk_en;
> +		}
> +
> +		ret = clk_prepare_enable(cdd->clk);
> +		if (ret) {
> +			dev_err(dev, "failed to enable clock\n");
> +			goto err_clk_en;
> +		}
> +	}

if this is functional clock then why not to use ./arch/arm/mach-davinci/pm_domain.c ?
wouldn't it work for use if you will just rename "usb20" -> "fck" -
so PM runtime should manage this clock for you?

> +
>  	ret = of_property_read_u32(dev->of_node,
>  				   "#dma-channels", &cdd->n_chans);
>  	if (ret)
> @@ -1112,6 +1192,9 @@ static int cppi41_dma_probe(struct platform_device *pdev)
>  err_init_cppi:
>  	pm_runtime_dont_use_autosuspend(dev);
>  err_get_n_chans:
> +	if (is_da8xx_cppi41(dev))
> +		clk_disable_unprepare(cdd->clk);
> +err_clk_en:
>  err_get_sync:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> @@ -1146,6 +1229,8 @@ static int cppi41_dma_remove(struct platform_device *pdev)
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	if (is_da8xx_cppi41(&pdev->dev))
> +		clk_disable_unprepare(cdd->clk);
>  	return 0;
>  }
>  
> @@ -1158,6 +1243,9 @@ static int __maybe_unused cppi41_suspend(struct device *dev)
>  		cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
>  	disable_sched(cdd);
>  
> +	if (is_da8xx_cppi41(dev))
> +		clk_disable_unprepare(cdd->clk);
> +
>  	return 0;
>  }
>  
> @@ -1165,8 +1253,15 @@ static int __maybe_unused cppi41_resume(struct device *dev)
>  {
>  	struct cppi41_dd *cdd = dev_get_drvdata(dev);
>  	struct cppi41_channel *c;
> +	int ret;
>  	int i;
>  
> +	if (is_da8xx_cppi41(dev)) {
> +		ret = clk_prepare_enable(cdd->clk);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i = 0; i < DESCS_AREAS; i++)
>  		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
>  
> 

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
