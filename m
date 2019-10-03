From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] drm/omap: fix max fclk divider for omap36xx
Date: Thu, 3 Oct 2019 09:44:18 +0300
Message-ID: <13677fc4-3497-3494-5ac6-1cb88ac91728@ti.com>
References: <20191002122542.8449-1-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191002122542.8449-1-tomi.valkeinen@ti.com>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, Adam Ford <aford173@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/10/2019 15:25, Tomi Valkeinen wrote:
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
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jyri Sarha <jsarha@ti.com>

> ---
>  drivers/gpu/drm/omapdrm/dss/dss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
> index e226324adb69..4bdd63b57100 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dss.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dss.c
> @@ -1083,7 +1083,7 @@ static const struct dss_features omap34xx_dss_feats = {
>  
>  static const struct dss_features omap3630_dss_feats = {
>  	.model			=	DSS_MODEL_OMAP3,
> -	.fck_div_max		=	32,
> +	.fck_div_max		=	31,
>  	.fck_freq_max		=	173000000,
>  	.dss_fck_multiplier	=	1,
>  	.parent_clk_name	=	"dpll4_ck",
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
