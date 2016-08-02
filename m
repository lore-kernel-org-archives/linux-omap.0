From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1271/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 16:25:15 +0300
Message-ID: <4bc851b0-73a2-f206-09e7-e6cc1f60cb9f@ti.com>
References: <20160802123326.2771-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160802123326.2771-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>, jarkko.nikula@bitmer.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, fabio.estevam@nxp.com, linus.walleij@linaro.org, zidan.wang@freescale.com, sachinpandhare@gmail.com, lars@metafoo.de
List-Id: linux-omap@vger.kernel.org

On 08/02/16 15:33, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  sound/soc/omap/mcbsp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 4a16e77..3938336 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -857,7 +857,7 @@ unlock:
>  	return size;
>  }
>  
> -static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
> +static DEVICE_ATTR(dma_op_mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dma_op_mode_show, dma_op_mode_store);

I prefer to have the octal representation, more compact, easier to understand.

>  
>  static const struct attribute *additional_attrs[] = {
>  	&dev_attr_max_tx_thres.attr,
> @@ -926,7 +926,7 @@ out:
>  	return size;
>  }
>  
> -static DEVICE_ATTR(st_taps, 0644, st_taps_show, st_taps_store);
> +static DEVICE_ATTR(st_taps, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, st_taps_show, st_taps_store);
>  
>  static const struct attribute *sidetone_attrs[] = {
>  	&dev_attr_st_taps.attr,
> 

-- 
Péter
