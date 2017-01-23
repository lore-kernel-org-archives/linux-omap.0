From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in
 dsps
Date: Mon, 23 Jan 2017 10:38:23 +0100
Message-ID: <71307976-51ef-9ff1-6f11-3903a613c20b@baylibre.com>
References: <20170119100659.11370-1-abailon@baylibre.com>
 <20170119100659.11370-4-abailon@baylibre.com>
 <20170120201717.GE14571@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170120201717.GE14571@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/20/2017 09:17 PM, Bin Liu wrote:
> On Thu, Jan 19, 2017 at 11:06:59AM +0100, Alexandre Bailon wrote:
>> Despite the CPPI 4.1 is a generic DMA, it is tied to USB.
>> On the dsps, CPPI 4.1 interrupt's registers are in USBSS (the MUSB glue).
>> Currently, to enable / disable and clear interrupts, the CPPI 4.1 driver
>> maps and accesses to USBSS's register, which making CPPI 4.1 driver not
>> really generic.
>> Move the interrupt management to dsps driver.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/dma/cppi41.c         | 28 ++++------------
>>  drivers/usb/musb/musb_dsps.c | 77 ++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 82 insertions(+), 23 deletions(-)
> 
> This patch touches both dma and musb modules, I know it makes review
> easier, but how we get it merged? One maintainer ACK it and the other
> pick it up? Sorry for the dumb question, I am new as a maintainer...
> 
>>
>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>> index d5ba43a..4999e7d 100644
>> --- a/drivers/dma/cppi41.c
>> +++ b/drivers/dma/cppi41.c
> 
> [...]
> 
>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
>> index 9f125e1..9dad3a6 100644
>> --- a/drivers/usb/musb/musb_dsps.c
>> +++ b/drivers/usb/musb/musb_dsps.c
>> @@ -121,6 +121,7 @@ struct dsps_glue {
>>  	struct timer_list timer;	/* otg_workaround timer */
>>  	unsigned long last_timer;    /* last timer data for each instance */
>>  	bool sw_babble_enabled;
>> +	void __iomem *usbss_base;
>>  
>>  	struct dsps_context context;
>>  	struct debugfs_regset32 regset;
>> @@ -145,6 +146,13 @@ static const struct debugfs_reg32 dsps_musb_regs[] = {
>>  	{ "mode",		0xe8 },
>>  };
>>  
>> +/* USBSS  / USB AM335x */
>> +#define USBSS_IRQ_STATUS	0x28
>> +#define USBSS_IRQ_ENABLER	0x2c
>> +#define USBSS_IRQ_CLEARR	0x30
>> +
>> +#define USBSS_IRQ_PD_COMP	(1 <<  2)
> 
> Please fix the double white spaces bwteen '<' and '2' this time.
> 
>> +
>>  /**
>>   * dsps_musb_enable - enable interrupts
>>   */
>> @@ -619,14 +627,72 @@ static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_USB_TI_CPPI41_DMA
>> +static void dsps_dma_controller_callback(struct dma_controller *c)
>> +{
>> +	struct musb *musb = c->musb;
>> +	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
>> +	void __iomem *usbss_base = glue->usbss_base;
>> +	u32 status;
>> +
>> +	status = musb_readl(usbss_base, USBSS_IRQ_STATUS);
>> +	if (status & USBSS_IRQ_PD_COMP)
>> +		musb_writel(usbss_base, USBSS_IRQ_STATUS, USBSS_IRQ_PD_COMP);
>> +}
>> +
>> +static struct dma_controller *
>> +dsps_dma_controller_create(struct musb *musb, void __iomem *base)
>> +{
>> +	struct dma_controller *controller;
>> +	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
>> +	void __iomem *usbss_base = glue->usbss_base;
>> +
>> +	controller = cppi41_dma_controller_create(musb, base);
>> +	if (IS_ERR_OR_NULL(controller))
>> +		return controller;
>> +
>> +	musb_writel(usbss_base, USBSS_IRQ_ENABLER, USBSS_IRQ_PD_COMP);
>> +	controller->dma_callback = dsps_dma_controller_callback;
>> +
>> +	return controller;
>> +}
>> +
>> +static void dsps_dma_controller_destroy(struct dma_controller *c)
>> +{
>> +	struct musb *musb = c->musb;
>> +	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
>> +	void __iomem *usbss_base = glue->usbss_base;
>> +
>> +	musb_writel(usbss_base, USBSS_IRQ_CLEARR, USBSS_IRQ_PD_COMP);
>> +	cppi41_dma_controller_destroy(c);
>> +}
>> +
>> +static void dsps_dma_controller_suspend(struct dsps_glue *glue)
>> +{
>> +	void __iomem *usbss_base = glue->usbss_base;
>> +
>> +	musb_writel(usbss_base, USBSS_IRQ_CLEARR, USBSS_IRQ_PD_COMP);
>> +}
>> +
>> +static void dsps_dma_controller_resume(struct dsps_glue *glue)
>> +{
>> +	void __iomem *usbss_base = glue->usbss_base;
>> +
>> +	musb_writel(usbss_base, USBSS_IRQ_ENABLER, USBSS_IRQ_PD_COMP);
>> +}
> 
> The two functions above need to be wrapped in CONFIG_PM_SLEEP.
> 
>> +#else
>> +static void dsps_dma_controller_suspend(struct dsps_glue *glue) {}
>> +static void dsps_dma_controller_resume(struct dsps_glue *glue) {}
>> +#endif
>> +
>>  static struct musb_platform_ops dsps_ops = {
>>  	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
>>  	.init		= dsps_musb_init,
>>  	.exit		= dsps_musb_exit,
>>  
>>  #ifdef CONFIG_USB_TI_CPPI41_DMA
>> -	.dma_init	= cppi41_dma_controller_create,
>> -	.dma_exit	= cppi41_dma_controller_destroy,
>> +	.dma_init	= dsps_dma_controller_create,
>> +	.dma_exit	= dsps_dma_controller_destroy,
>>  #endif
>>  	.enable		= dsps_musb_enable,
>>  	.disable	= dsps_musb_disable,
>> @@ -792,6 +858,9 @@ static int dsps_probe(struct platform_device *pdev)
>>  
>>  	glue->dev = &pdev->dev;
>>  	glue->wrp = wrp;
>> +	glue->usbss_base = of_iomap(pdev->dev.parent->of_node, 0);
>> +	if (!glue->usbss_base)
> 
> use IS_ERR()?
I don't we can use it here. As far I know, of_iomap() only return NULL
in the case of error.
> 
>> +		return -ENXIO;
> 
> and return PTR_ERR()?
Again, I don't think we can use it here. THough, may be -ENXIO is not
the best error code to return. I used it because it was the used in DMA
driver.
> 
> Regards,
> -Bin.
> 
Regards,
Alexandre

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
