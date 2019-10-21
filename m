From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] fbdev/omap: fix max fclk divider for omap36xx
Date: Mon, 21 Oct 2019 06:07:01 -0500
Message-ID: <CAHCN7xLBY4bCkzEWEgcrdY0SrvMJv4Y2fSzVHO86P9+hUoZi0Q@mail.gmail.com>
References: <20191018130507.29893-1-aford173@gmail.com> <712504cb-c0ad-2e3e-bc3b-5cc1b70dd005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <712504cb-c0ad-2e3e-bc3b-5cc1b70dd005@ti.com>
Sender: stable-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 21, 2019 at 3:44 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 18/10/2019 16:05, Adam Ford wrote:
> > The OMAP36xx and AM/DM37x TRMs say that the maximum divider for DSS fclk
> > (in CM_CLKSEL_DSS) is 32. Experimentation shows that this is not
> > correct, and using divider of 32 breaks DSS with a flood or underflows
> > and sync losts. Dividers up to 31 seem to work fine.
> >
> > There is another patch to the DT files to limit the divider correctly,
> > but as the DSS driver also needs to know the maximum divider to be able
> > to iteratively find good rates, we also need to do the fix in the DSS
> > driver.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: stable@vger.kernel.org # linux-4.4.y only
> >
> > diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
> > index 9200a8668b49..a57c3a5f4bf8 100644
> > --- a/drivers/video/fbdev/omap2/dss/dss.c
> > +++ b/drivers/video/fbdev/omap2/dss/dss.c
> > @@ -843,7 +843,7 @@ static const struct dss_features omap34xx_dss_feats = {
> >   };
> >
> >   static const struct dss_features omap3630_dss_feats = {
> > -     .fck_div_max            =       32,
> > +     .fck_div_max            =       31,
> >       .dss_fck_multiplier     =       1,
> >       .parent_clk_name        =       "dpll4_ck",
> >       .dpi_select_source      =       &dss_dpi_select_source_omap2_omap3,
> >
>
> To clarify, this patch is only for the v4.4 stable, whereas the previous
> patch was for next merge window and v4.9+ stable. Right?

That is correct.  The patch I did for 4.9+ didn't apply cleanly on
4.4, so I had to do a separate patch for 4.4.

adam
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
>   Tomi
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
