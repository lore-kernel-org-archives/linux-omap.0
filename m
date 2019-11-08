From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] fbdev/omap: fix max fclk divider for omap36xx
Date: Fri, 8 Nov 2019 07:10:45 -0600
Message-ID: <CAHCN7xJ9aAHjHToM5mGixWvJb7hAOenST7Fkett84nNQdUghmA@mail.gmail.com>
References: <20191018130507.29893-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191018130507.29893-1-aford173@gmail.com>
Sender: stable-owner@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Adam Ford <adam.ford@logicpd.com>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 18, 2019 at 8:05 AM Adam Ford <aford173@gmail.com> wrote:
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
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: stable@vger.kernel.org # linux-4.4.y only

This is basically the same patch as the only Tomi reviewed for 4.9,
but it is based on 4.4.

Is there any way these can be integrated?

thank you,

adam
>
> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
> index 9200a8668b49..a57c3a5f4bf8 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> @@ -843,7 +843,7 @@ static const struct dss_features omap34xx_dss_feats = {
>  };
>
>  static const struct dss_features omap3630_dss_feats = {
> -       .fck_div_max            =       32,
> +       .fck_div_max            =       31,
>         .dss_fck_multiplier     =       1,
>         .parent_clk_name        =       "dpll4_ck",
>         .dpi_select_source      =       &dss_dpi_select_source_omap2_omap3,
> --
> 2.17.1
>
