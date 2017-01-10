From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 08/11] dmaengine: cppi41: Implement the glue for da8xx
Date: Tue, 10 Jan 2017 20:53:15 +0300
Message-ID: <2d8b3a2b-859d-bfda-74cf-f22471927fc4@cogentembedded.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-9-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-9-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 07:06 PM, Alexandre Bailon wrote:

> The da8xx has a cppi41 dma controller.

    It's called CPPI 4.1. :-)

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
[...]
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

    One empty line is enough.

>  /* Packet Descriptor */
>  #define PD2_ZERO_LENGTH		(1 << 19)
>
>  #define AM335X_CPPI41		0
> +#define DA8XX_CPPI41		1
>
>  struct cppi41_channel {
>  	struct dma_chan chan;
[...]
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

    Seems correct...

> +
> +	/* Re-assert IRQ if there no usb core interrupts pending */
> +	usbss_status = cppi_readl(cdd->usbss_mem + DA8XX_INTR_SRC_MASKED);
> +	if (!usbss_status)
> +		cppi_writel(0, cdd->usbss_mem + DA8XX_END_OF_INTR);

    I don't understand this...

> +
> +	return IRQ_HANDLED;
> +}
> +
>  static dma_cookie_t cppi41_tx_submit(struct dma_async_tx_descriptor *tx)
>  {
>  	dma_cookie_t cookie;
[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
