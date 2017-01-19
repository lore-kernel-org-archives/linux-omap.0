From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 4/4] dmaengine: cppi41: init_sched(): Get number of
 channels from DT
Date: Thu, 19 Jan 2017 14:03:16 +0300
Message-ID: <88701e2c-1c1e-e8a9-980a-bc80a47734c2@cogentembedded.com>
References: <20170119103705.13532-1-abailon@baylibre.com>
 <20170119103705.13532-5-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119103705.13532-5-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 1/19/2017 1:37 PM, Alexandre Bailon wrote:

> Despite the driver is already using DT to get the number of channels,
> init_sched() is using an hardcoded value to get it.
> Use DT to get the number of channels.
>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 5a40653..9767b97 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
[...]
> @@ -832,7 +829,7 @@ static int init_descs(struct device *dev, struct cppi41_dd *cdd)
>  	return 0;
>  }
>
> -static void init_sched(struct cppi41_dd *cdd)
> +static void init_sched(struct device *dev, struct cppi41_dd *cdd)

    I don't see where 'dev' is used...

>  {
>  	unsigned ch;
>  	unsigned word;
> @@ -840,7 +837,7 @@ static void init_sched(struct cppi41_dd *cdd)
>
>  	word = 0;
>  	cppi_writel(0, cdd->sched_mem + DMA_SCHED_CTRL);
> -	for (ch = 0; ch < 15 * 2; ch += 2) {
> +	for (ch = 0; ch < cdd->n_chans; ch += 2) {
>
>  		reg = SCHED_ENTRY0_CHAN(ch);
>  		reg |= SCHED_ENTRY1_CHAN(ch) | SCHED_ENTRY1_IS_RX;
> @@ -850,7 +847,7 @@ static void init_sched(struct cppi41_dd *cdd)
>  		cppi_writel(reg, cdd->sched_mem + DMA_SCHED_WORD(word));
>  		word++;
>  	}
> -	reg = 15 * 2 * 2 - 1;
> +	reg = cdd->n_chans * 2 - 1;
>  	reg |= DMA_SCHED_CTRL_EN;
>  	cppi_writel(reg, cdd->sched_mem + DMA_SCHED_CTRL);
>  }
[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
