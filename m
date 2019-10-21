From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fbdev/omap: fix max fclk divider for omap36xx
Date: Mon, 21 Oct 2019 11:42:16 +0300
Message-ID: <7b8b6eba-2cb3-9b25-66e2-e128cc09ceb4@ti.com>
References: <20191018124938.29313-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191018124938.29313-1-aford173@gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, adam.ford@logicpd.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 18/10/2019 15:49, Adam Ford wrote:
> The OMAP36xx and AM/DM37x TRMs say that the maximum divider for DSS fclk
> (in CM_CLKSEL_DSS) is 32. Experimentation shows that this is not
> correct, and using divider of 32 breaks DSS with a flood or underflows
> and sync losts. Dividers up to 31 seem to work fine.
> 
> There is another patch to the DT files to limit the divider correctly,
> but as the DSS driver also needs to know the maximum divider to be able
> to iteratively find good rates, we also need to do the fix in the DSS
> driver.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: stable@vger.kernel.org #linux-4.9.y+
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> index 48c6500c24e1..4429ad37b64c 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -843,7 +843,7 @@ static const struct dss_features omap34xx_dss_feats = {
>   };
>   
>   static const struct dss_features omap3630_dss_feats = {
> -	.fck_div_max		=	32,
> +	.fck_div_max		=	31,
>   	.dss_fck_multiplier	=	1,
>   	.parent_clk_name	=	"dpll4_ck",
>   	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
