From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] HACK: OMAP: DSS2: Fix OMAP2_DSS_USE_DSI_PLL
Date: Wed, 2 Mar 2011 10:37:38 +0200
Message-ID: <1299055058.2226.54.camel@deskari>
References: <1299054015-1070-1-git-send-email-tomi.valkeinen@ti.com>
	 <AANLkTin9L6YWG5j=OsjBzhvtaVTttYdE_Xs8G-xs2Kip@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33001 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab1CBIhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 03:37:43 -0500
In-Reply-To: <AANLkTin9L6YWG5j=OsjBzhvtaVTttYdE_Xs8G-xs2Kip@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John S <john.schi15@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "steve@sakoman.com" <steve@sakoman.com>

On Wed, 2011-03-02 at 02:30 -0600, John S wrote:
> On Wed, Mar 2, 2011 at 1:50 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> > When using OMAP2_DSS_USE_DSI_PLL, which selects DSI PLL as source clock
> > for DISPC, the DSI needs the vdds_dsi regulator. Latest regulator
> > changes broke this, causing the the code to not acquire the regulator
> > when using OMAP2_DSS_USE_DSI_PLL.
> >
> > This patch acquires the vdds_dsi regulator in dsi_pll_init(), fixing the
> > issue. This is is just a quick hack to get the OMAP2_DSS_USE_DSI_PLL
> > option working. There shouldn't be any other downside in this solution
> > than some extra lines of code.
> >
> > OMAP2_DSS_USE_DSI_PLL is itself a big hack, and should be removed, and
> > the feature itself should be implemented in a more sane way. However,
> > the solution is not trivial, and people are using DSI PLL to get more
> > exact pixel clocks, so this hack is an acceptable temporary solution for
> > the time being.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  drivers/video/omap2/dss/dsi.c |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> > index c3019d9..6f4f19d 100644
> > --- a/drivers/video/omap2/dss/dsi.c
> > +++ b/drivers/video/omap2/dss/dsi.c
> > @@ -1105,6 +1105,26 @@ int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
> >
> >        DSSDBG("PLL init\n");
> >
> > +#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
> > +       /*
> > +        * HACK: this is just a quick hack to get the USE_DSI_PLL
> > +        * option working. USE_DSI_PLL is itself a big hack, and
> > +        * should be removed.
> > +        */
> > +       if (dsi.vdds_dsi_reg == NULL) {
> > +               struct regulator *vdds_dsi;
> > +
> > +               vdds_dsi = regulator_get(&dsi.pdev->dev, "vdds_dsi");
> > +
> > +               if (IS_ERR(vdds_dsi)) {
> > +                       DSSERR("can't get VDDS_DSI regulator\n");
> > +                       return PTR_ERR(vdds_dsi);
> > +               }
> > +
> > +               dsi.vdds_dsi_reg = vdds_dsi;
> > +       }
> > +#endif
> > +
> >        enable_clocks(1);
> >        dsi_enable_pll_clock(1);
> >
> 
> The hack might be temporarily acceptable.
> But I think there should be a matching regulator_put in dsi_pll_uinit.

The regulator_put() is in dsi_exit().

The reasoning here is that we only want to get the regulator if the DSI
is actually used. Otherwise every board file should define all the
regulators, even if the board in question wouldn't even use DSI. Thus we
cannot regulator_get() in the probe of DSI driver, but only later when a
display actually uses DSI.

But when we have the regulator, we keep a reference to it until the DSI
driver is unloaded (dsi_exit). It is asymmetric, but I don't see any
reason to release the regulator when, for example, the display is
blanked.

 Tomi


