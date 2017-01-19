From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 2/3] dmaengine: cppi41: Add support of DA8xx to CPPI
 4.1
Date: Thu, 19 Jan 2017 21:15:28 +0300
Message-ID: <6cfcff3a-e485-65c0-048a-f2f1b133d2e9@cogentembedded.com>
References: <20170119111334.14718-1-abailon@baylibre.com>
 <20170119111334.14718-3-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119111334.14718-3-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/19/2017 02:13 PM, Alexandre Bailon wrote:

> The DA8xx has a CPPI 4.1 DMA controller.
> This is add the glue layer required to make it work on DA8xx.
>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/dma/Kconfig  |  6 +++---
>  drivers/dma/cppi41.c | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 0d6a96e..03ae2a1 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -514,12 +514,12 @@ config TIMB_DMA
>  	  Enable support for the Timberdale FPGA DMA engine.
>
>  config TI_CPPI41
> -	tristate "AM33xx CPPI41 DMA support"
> -	depends on ARCH_OMAP
> +	tristate "CPPI41 DMA support"

    Grr... CPPI 4.1, please.

> +	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX)
>  	select DMA_ENGINE
>  	help
>  	  The Communications Port Programming Interface (CPPI) 4.1 DMA engine
> -	  is currently used by the USB driver on AM335x platforms.
> +	  is currently used by the USB driver on AM335x and DA8xx platforms.
>
>  config TI_DMA_CROSSBAR
>  	bool
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 9767b97..f6f2d84 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
[...]
> @@ -951,8 +965,18 @@ static const struct cppi_glue_infos am335x_usb_infos = {
>  	.qmgr_num_pend = 5,
>  };
>
> +static const struct cppi_glue_infos da8xx_usb_infos = {
> +	.isr = cppi41_irq,

    Isn't the ISR the same for all glues now?

[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
