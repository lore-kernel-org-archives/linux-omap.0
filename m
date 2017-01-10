From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 02/11] dmaengine: cppi41: Split out the interrupt handler
Date: Tue, 10 Jan 2017 20:39:45 +0300
Message-ID: <f7cf88bd-0d10-8c94-6490-46070d3c7949@cogentembedded.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-3-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-3-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 01/09/2017 07:06 PM, Alexandre Bailon wrote:

> The current interrupt handler do some actions specifics to am335x.
> These actions should be made by the platform interrupt handler.
> Split out the interrupt handler in two:
> one for the am335x platform and a generic one.
>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 25ee71d..42744ed 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -284,18 +284,11 @@ static u32 cppi41_pop_desc(struct cppi41_dd *cdd, unsigned queue_num)
>  	return desc;
>  }
>
> -static irqreturn_t cppi41_irq(int irq, void *data)
> +static irqreturn_t cppi41_irq(struct cppi41_dd *cdd)
>  {
> -	struct cppi41_dd *cdd = data;
>  	struct cppi41_channel *c;
> -	u32 status;
>  	int i;
>
> -	status = cppi_readl(cdd->usbss_mem + USBSS_IRQ_STATUS);
> -	if (!(status & USBSS_IRQ_PD_COMP))
> -		return IRQ_NONE;
> -	cppi_writel(status, cdd->usbss_mem + USBSS_IRQ_STATUS);
> -

    I fail to understand why non-CPPI 4.1 regs are used here (and that 
positioning itself as an "abstract" CPPI 4.1 driver).

[...]
> @@ -351,6 +344,19 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>
> +static irqreturn_t am335x_cppi41_irq(int irq, void *data)
> +{
> +	struct cppi41_dd *cdd = data;
> +	u32 status;
> +
> +	status = cppi_readl(cdd->usbss_mem + USBSS_IRQ_STATUS);
> +	if (!(status & USBSS_IRQ_PD_COMP))
> +		return IRQ_NONE;
> +	cppi_writel(status, cdd->usbss_mem + USBSS_IRQ_STATUS);
> +
> +	return cppi41_irq(cdd);
> +}
> +

    IMHO this stuff just needs to move to the MUSB glue.

[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
