From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: kernel panic with latest DSS
Date: Fri, 19 Mar 2010 19:41:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0E3BB@dbde02.ent.ti.com>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>
	 <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
	 <5e088bd91003101042t236c5d90p62c700c424d83e12@mail.gmail.com>
	 <3647DBDA80551C4696E9E4506F0BE08E255DC2F2A7@NOK-EUMSG-02.mgdnok.nokia.com>
	 <5e088bd91003101148o82a07e2j4df803d23ee78d83@mail.gmail.com>
 <1268391093.28571.137.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41288 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0CSOLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 10:11:55 -0400
In-Reply-To: <1268391093.28571.137.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ext Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> Sent: Friday, March 12, 2010 4:22 PM
> To: ext Steve Sakoman
> Cc: linux-omap@vger.kernel.org
> Subject: Re: kernel panic with latest DSS
> 
> Can you try this patch?
> 
> I haven't run into this earlier as I always have DSI compiled in. It
> possibly doesn't behave correctly in that case either, but doesn't
> crash.
> 
>  Tomi
> 
> 
> >From c065bb82e1358105d57d80974ce71d3e5aeabf35 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Date: Fri, 12 Mar 2010 12:46:05 +0200
> Subject: [PATCH] OMAP: DSS2: initialize dss clk sources properly
> 
> Clk sources were not initialized, leading to kernel crash, or possibly to
> strange behaviour if DSI was compiled in.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/dss/dss.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 8254a42..5434418 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -590,6 +590,9 @@ int dss_init(bool skip_init)
>  		}
>  	}
> 
> +	dss.dsi_clk_source = DSS_SRC_DSS1_ALWON_FCLK;
> +	dss.dispc_clk_source = DSS_SRC_DSS1_ALWON_FCLK;
> +
[Hiremath, Vaibhav] This patch is required.

Actually when I rebased my V4L2 driver with latest linux-omap/master and I got a kernel crash in dispc_fck_rate API. And after some round of debugging it turns out to be the same fix, with this it seems to be ok and working for me.

Thanks,
Vaibhav

>  	dss_save_context();
> 
>  	rev = dss_read_reg(DSS_REVISION);
> --
> 1.6.5
> 
> 
> 
> 
> 
> 
> On Wed, 2010-03-10 at 20:48 +0100, ext Steve Sakoman wrote:
> > On Wed, Mar 10, 2010 at 10:58 AM,  <Tomi.Valkeinen@nokia.com> wrote:
> >
> > > I haven't had time to look at this, but I don't think your analysis is
> correct.
> >
> > You are correct of course.  My sleepy eyes neglected to notice that
> > double = and that makes a big difference :-)
> >
> > > What first comes to my mind is that dss.dispc_clk_source is, for some
> reason, uninitialized. Could you put prints to dss_select_dispc_clk_source
> to see if it's called, and if so, what is assigned to dss.dispc_clk_source?
> >
> > I did a build with that change and it does seem that
> > dss_select_dispc_clk_source is never called.
> >
> > Steve
> >
> > >  Tomi
> > >
> > > ________________________________________
> > > From: ext Steve Sakoman [sakoman@gmail.com]
> > > Sent: Wednesday, March 10, 2010 20:42
> > > To: linux-omap@vger.kernel.org; Valkeinen Tomi (Nokia-D/Helsinki)
> > > Subject: Re: kernel panic with latest DSS
> > >
> > > On Wed, Mar 10, 2010 at 10:16 AM, Steve Sakoman <sakoman@gmail.com>
> wrote:
> > >
> > >> The issue occurs in the following section of code in
> > >> drivers/video/omap2/dss/dispc.c:
> > >>
> > >> unsigned long dispc_fclk_rate(void)
> > >> {
> > >>        unsigned long r = 0;
> > >>
> > >>        if (dss_get_dispc_clk_source() == DSS_SRC_DSS1_ALWON_FCLK)
> > >>                r = dss_clk_get_rate(DSS_CLK_FCK1);
> > >>        else
> > >> #ifdef CONFIG_OMAP2_DSS_DSI
> > >>                r = dsi_get_dsi1_pll_rate();
> > >> #else
> > >>        BUG();
> > >> #endif
> > >>        return r;
> > >> }
> > >>
> > >> Since my machines don't have DSI displays CONFIG_OMAP2_DSS_DSI is not
> > >> defined and the BUG() call is triggered.
> > >
> > > The issue seems to be the test for DSS_SRC_DSS1_ALWON_FCLK.
> > >
> > > Looking at  drivers/video/omap2/dss/dispc.c I see that
> > > DSS_SRC_DSS1_ALWON_FCLK will never be returned since clk_src is always
> > > set to 0 or 1 based on a test of DSS_SRC_DSS1_ALWON_FCLK :
> > >
> > > void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
> > > {
> > >        int b;
> > >
> > >        BUG_ON(clk_src != DSS_SRC_DSI1_PLL_FCLK &&
> > >                        clk_src != DSS_SRC_DSS1_ALWON_FCLK);
> > >
> > >        b = clk_src == DSS_SRC_DSS1_ALWON_FCLK ? 0 : 1;
> > >
> > >        REG_FLD_MOD(DSS_CONTROL, b, 0, 0);      /* DISPC_CLK_SWITCH */
> > >
> > >        dss.dispc_clk_source = clk_src;
> > > }
> > >
> > > It seems to me that the test should return to the way it was in the
> > > previous DSS version, i.e. a test for 0:
> > >
> > > diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> > > index e777e35..be9b3de 100644
> > > --- a/drivers/video/omap2/dss/dispc.c
> > > +++ b/drivers/video/omap2/dss/dispc.c
> > > @@ -2218,7 +2218,7 @@ unsigned long dispc_fclk_rate(void)
> > >  {
> > >        unsigned long r = 0;
> > >
> > > -       if (dss_get_dispc_clk_source() == DSS_SRC_DSS1_ALWON_FCLK)
> > > +       if (dss_get_dispc_clk_source() == 0)
> > >                r = dss_clk_get_rate(DSS_CLK_FCK1);
> > >        else
> > >  #ifdef CONFIG_OMAP2_DSS_DSI
> > >
> > > A test build confirms that this change restores my ability to play
> > > DVD's and display webcam streams.  My understanding of this code is
> > > superficial, so hopefully Tomi can comment on whether this is a good
> > > fix or not.
> > >
> > > Steve
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
