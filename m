From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] drm/omap: fix max fclk divider for omap36xx
Date: Thu, 17 Oct 2019 13:05:31 -0500
Message-ID: <CAHCN7xKN7CePgajQLH61dBaoLWZ4VMxo39_xJOWHyvM3x_0i=A@mail.gmail.com>
References: <20191002122542.8449-1-tomi.valkeinen@ti.com> <CAHCN7xLjGkLHMWejEk-3vJ-OwzjB+BXtnPWoonh4mAVxbkzMWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xLjGkLHMWejEk-3vJ-OwzjB+BXtnPWoonh4mAVxbkzMWQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 13, 2019 at 10:56 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Oct 2, 2019 at 7:25 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
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
>
> Tomi,
>
> Is there any way you can do a patch for the FB version for the older
> 4.9 and 4.14 kernels?  I think they are still defaulting to the omapfb
> instead of DRM, so the underflow issue still appears by default and
> the patch only impacts the DRM version of the driver.  If not, do you
> have any objections if I submit a patch to stable for those two LTS
> branches?

Gentle nudge on this question.  I can do the work, but I just
permission so don't overstep.

adam
>
> thanks,
>
> adam
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Adam Ford <aford173@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/gpu/drm/omapdrm/dss/dss.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
> > index e226324adb69..4bdd63b57100 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/dss.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dss.c
> > @@ -1083,7 +1083,7 @@ static const struct dss_features omap34xx_dss_feats = {
> >
> >  static const struct dss_features omap3630_dss_feats = {
> >         .model                  =       DSS_MODEL_OMAP3,
> > -       .fck_div_max            =       32,
> > +       .fck_div_max            =       31,
> >         .fck_freq_max           =       173000000,
> >         .dss_fck_multiplier     =       1,
> >         .parent_clk_name        =       "dpll4_ck",
> > --
> > Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> > Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >
