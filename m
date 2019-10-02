From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] drm/omap: fix max fclk divider for omap36xx
Date: Wed, 2 Oct 2019 07:44:10 -0500
Message-ID: <CAHCN7xKCSVSJ2h7Y-NF_TNDhB-LKH=aMmma4g8dH56POqDVWUA@mail.gmail.com>
References: <20191002122542.8449-1-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191002122542.8449-1-tomi.valkeinen@ti.com>
Sender: stable-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 2, 2019 at 7:25 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
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

When combined with the cock divider patch [1], this fixes a hanging
issue on a DM3730 with a 480x272 screen where the pixel clock is set
to 9MHz and the clock divider attempts to calculate a fclk and hangs.
I have always had to hack the divider to prevent the hang.

If possible, it would be nice to have this applied to 5.4 branch since
it will be an LTS kernel.

[1] - https://patchwork.kernel.org/cover/11170951/

Tested-by: Adam Ford <aford173@gmail.com>

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: stable@vger.kernel.org
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
>         .model                  =       DSS_MODEL_OMAP3,
> -       .fck_div_max            =       32,
> +       .fck_div_max            =       31,
>         .fck_freq_max           =       173000000,
>         .dss_fck_multiplier     =       1,
>         .parent_clk_name        =       "dpll4_ck",
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
