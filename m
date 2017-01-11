From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 08/11] dmaengine: cppi41: Implement the glue for da8xx
Date: Wed, 11 Jan 2017 10:16:34 +0100
Message-ID: <eccebdeb-a864-87ce-41de-be67ef42fdeb@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-9-abailon@baylibre.com>
 <fbc7f9f3-9b14-bc7f-0b40-15a6fedd48ea@ti.com>
 <b3f902e0-ed08-dbee-52b8-e81afda082ac@baylibre.com>
 <53a40635-2652-64fc-b20d-1cd6d813eacb@ti.com>
 <43b9585d-a22f-a2ff-15d4-5d878bd1586a@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43b9585d-a22f-a2ff-15d4-5d878bd1586a-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/10/2017 04:22 PM, Alexandre Bailon wrote:
> On 01/10/2017 11:05 AM, Sekhar Nori wrote:
>> On Tuesday 10 January 2017 03:08 PM, Alexandre Bailon wrote:
>>> On 01/09/2017 07:08 PM, Grygorii Strashko wrote:
>>>>
>>>>
>>>> On 01/09/2017 10:06 AM, Alexandre Bailon wrote:
>>>>> The da8xx has a cppi41 dma controller.
>>>>> This is add the glue layer required to make it work on da8xx,
>>>>> as well some changes in driver (e.g to manage clock).
>>>>>
>>>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>>> ---
>>>>>  drivers/dma/cppi41.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 95 insertions(+)
>>>>>
>>>>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>>>>> index 939398e..4318e53 100644
>>>>> --- a/drivers/dma/cppi41.c
>>>>> +++ b/drivers/dma/cppi41.c
>>>>> @@ -1,3 +1,4 @@
>>>>> +#include <linux/clk.h>
>>>>>  #include <linux/delay.h>
>>>>>  #include <linux/dmaengine.h>
>>>>>  #include <linux/dma-mapping.h>
>>>>> @@ -86,10 +87,19 @@
>>>>>  
>>>>>  #define USBSS_IRQ_PD_COMP	(1 <<  2)
>>>>>  
>>>>> +/* USB DA8XX */
>>>>> +#define DA8XX_INTR_SRC_MASKED	0x38
>>>>> +#define DA8XX_END_OF_INTR	0x3c
>>>>> +
>>>>> +#define DA8XX_QMGR_PENDING_MASK	(0xf << 24)
>>>>> +
>>>>> +
>>>>> +
>>>>>  /* Packet Descriptor */
>>>>>  #define PD2_ZERO_LENGTH		(1 << 19)
>>>>>  
>>>>>  #define AM335X_CPPI41		0
>>>>> +#define DA8XX_CPPI41		1
>>>>>  
>>>>>  struct cppi41_channel {
>>>>>  	struct dma_chan chan;
>>>>> @@ -158,6 +168,9 @@ struct cppi41_dd {
>>>>>  
>>>>>  	/* context for suspend/resume */
>>>>>  	unsigned int dma_tdfdq;
>>>>> +
>>>>> +	/* da8xx clock */
>>>>> +	struct clk *clk;
>>>>>  };
>>>>>  
>>>>>  static struct chan_queues am335x_usb_queues_tx[] = {
>>>>> @@ -232,6 +245,20 @@ static const struct chan_queues am335x_usb_queues_rx[] = {
>>>>>  	[29] = { .submit = 30, .complete = 155},
>>>>>  };
>>>>>  
>>>>> +static const struct chan_queues da8xx_usb_queues_tx[] = {
>>>>> +	[0] = { .submit =  16, .complete = 24},
>>>>> +	[1] = { .submit =  18, .complete = 24},
>>>>> +	[2] = { .submit =  20, .complete = 24},
>>>>> +	[3] = { .submit =  22, .complete = 24},
>>>>> +};
>>>>> +
>>>>> +static const struct chan_queues da8xx_usb_queues_rx[] = {
>>>>> +	[0] = { .submit =  1, .complete = 26},
>>>>> +	[1] = { .submit =  3, .complete = 26},
>>>>> +	[2] = { .submit =  5, .complete = 26},
>>>>> +	[3] = { .submit =  7, .complete = 26},
>>>>> +};
>>>>> +
>>>>>  struct cppi_glue_infos {
>>>>>  	irqreturn_t (*isr)(int irq, void *data);
>>>>>  	const struct chan_queues *queues_rx;
>>>>> @@ -366,6 +393,26 @@ static irqreturn_t am335x_cppi41_irq(int irq, void *data)
>>>>>  	return cppi41_irq(cdd);
>>>>>  }
>>>>>  
>>>>> +static irqreturn_t da8xx_cppi41_irq(int irq, void *data)
>>>>> +{
>>>>> +	struct cppi41_dd *cdd = data;
>>>>> +	u32 status;
>>>>> +	u32 usbss_status;
>>>>> +
>>>>> +	status = cppi_readl(cdd->qmgr_mem + QMGR_PEND(0));
>>>>> +	if (status & DA8XX_QMGR_PENDING_MASK)
>>>>> +		cppi41_irq(cdd);
>>>>> +	else
>>>>> +		return IRQ_NONE;
>>>>> +
>>>>> +	/* Re-assert IRQ if there no usb core interrupts pending */
>>>>> +	usbss_status = cppi_readl(cdd->usbss_mem + DA8XX_INTR_SRC_MASKED);
>>>>> +	if (!usbss_status)
>>>>> +		cppi_writel(0, cdd->usbss_mem + DA8XX_END_OF_INTR);
>>>>> +
>>>>> +	return IRQ_HANDLED;
>>>>> +}
>>>>> +
>>>>>  static dma_cookie_t cppi41_tx_submit(struct dma_async_tx_descriptor *tx)
>>>>>  {
>>>>>  	dma_cookie_t cookie;
>>>>> @@ -972,8 +1019,19 @@ static const struct cppi_glue_infos am335x_usb_infos = {
>>>>>  	.platform = AM335X_CPPI41,
>>>>>  };
>>>>>  
>>>>> +static const struct cppi_glue_infos da8xx_usb_infos = {
>>>>> +	.isr = da8xx_cppi41_irq,
>>>>> +	.queues_rx = da8xx_usb_queues_rx,
>>>>> +	.queues_tx = da8xx_usb_queues_tx,
>>>>> +	.td_queue = { .submit = 31, .complete = 0 },
>>>>> +	.first_completion_queue = 24,
>>>>> +	.qmgr_num_pend = 2,
>>>>> +	.platform = DA8XX_CPPI41,
>>>>> +};
>>>>> +
>>>>>  static const struct of_device_id cppi41_dma_ids[] = {
>>>>>  	{ .compatible = "ti,am3359-cppi41", .data = &am335x_usb_infos},
>>>>> +	{ .compatible = "ti,da8xx-cppi41", .data = &da8xx_usb_infos},
>>>>>  	{},
>>>>>  };
>>>>>  MODULE_DEVICE_TABLE(of, cppi41_dma_ids);
>>>>> @@ -995,6 +1053,13 @@ static int is_am335x_cppi41(struct device *dev)
>>>>>  	return cdd->platform == AM335X_CPPI41;
>>>>>  }
>>>>>  
>>>>> +static int is_da8xx_cppi41(struct device *dev)
>>>>> +{
>>>>> +	struct cppi41_dd *cdd = dev_get_drvdata(dev);
>>>>> +
>>>>> +	return cdd->platform == DA8XX_CPPI41;
>>>>> +}
>>>>> +
>>>>>  #define CPPI41_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
>>>>>  				BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
>>>>>  				BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
>>>>> @@ -1058,6 +1123,21 @@ static int cppi41_dma_probe(struct platform_device *pdev)
>>>>>  	cdd->first_completion_queue = glue_info->first_completion_queue;
>>>>>  	cdd->platform = glue_info->platform;
>>>>>  
>>>>> +	if (is_da8xx_cppi41(dev)) {
>>>>> +		cdd->clk = devm_clk_get(&pdev->dev, "usb20");
>>>>> +		ret = PTR_ERR_OR_ZERO(cdd->clk);
>>>>> +		if (ret) {
>>>>> +			dev_err(&pdev->dev, "failed to get clock\n");
>>>>> +			goto err_clk_en;
>>>>> +		}
>>>>> +
>>>>> +		ret = clk_prepare_enable(cdd->clk);
>>>>> +		if (ret) {
>>>>> +			dev_err(dev, "failed to enable clock\n");
>>>>> +			goto err_clk_en;
>>>>> +		}
>>>>> +	}
>>>>
>>>> if this is functional clock then why not to use ./arch/arm/mach-davinci/pm_domain.c ?
>>>> wouldn't it work for use if you will just rename "usb20" -> "fck" -
>>>> so PM runtime should manage this clock for you?
>>> As is, I don't think it will work.
>>> The usb20 is shared by the cppi41 and the usb otg.
>>> So, if we rename "usb20" to "fck", clk_get() won't be able to find the
>>> clock.
>>> But may be adding "usb20" to "con_ids" in
>>> arch/arm/mach-davinci/pm_domain.c could work.
>>> But I think it will require some changes in da8xx musb driver.
>>> I will take look.
>>
>> On DA8xx, CPPI 4.1 DMAengine is not an independent system resource, but
>> embedded within the USB 2.0 controller. So, I think all that is needed
>> is for MUSB DA8xx glue to trigger probe of CPPI 4.1 dmaengine driver
>> when it is ready. I am not sure all this DA850-specific clock handling
>> is really necessary.
> Actually, we have a circular dependency.
> USB core tries to get DMA channels during the probe, which fails because
> CPPI 4.1 driver is not ready.
> But it will never be ready because the USB clock must be enabled before
> DMA driver probe, what will not happen because USB driver have disabled
> the clock when probe failed.
> 
> Someone in the office suggested me to use the component API,
> that could help me to probe the DMA from the USB probe.
> 
> Another way to workaround the dependency would be to do defer the
> function calls that access to hardware to avoid to control clock from
> DMA driver.
>>
>> Even in DT, the CPPI 4.1 node should be a child node of USB 2.0 node.
> I agree, it should a child but it would require some changes in CPPI 4.1
> driver. But except to have a better hardware description, I don't see
> any benefit to do it.
Finally, I have been able to do it and there is real benefit to do it
(unlike I thought).
Now that the CPPI 4.1 is a child of USB 2.0, I only have to update
the DA8xx glue driver to support PM runtime and let PM runtime do
everything in CPPI 4.1 driver.
>>
>> Thanks,
>> sekhar
>>
> Thanks,
> Alexandre
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
