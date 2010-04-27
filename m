From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS: ensure clocks are disabled on failed init
Date: Tue, 27 Apr 2010 13:40:29 +0300
Message-ID: <1272364829.2529.109.camel@tubuntu.research.nokia.com>
References: <1272309166-698-1-git-send-email-khilman@deeprootsystems.com>
	 <p2x6ed0b2681004270214yc64459e4g2e0d15dcac84bd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60662 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657Ab0D0Kkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 06:40:49 -0400
In-Reply-To: <p2x6ed0b2681004270214yc64459e4g2e0d15dcac84bd2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-04-27 at 11:14 +0200, ext Grazvydas Ignotas wrote:
> CC Tomi in case he missed this.

Thanks =)

> 
> On Mon, Apr 26, 2010 at 10:12 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> > Currently, if init fails for whatever reason, various DSS related
> > clocks will be left enabled and prevent the chip from hitting
> > retention or off-mode.
> >
> > This patch ensures the clocks are disabled on a failed init.
> >
> > For this to work, a check had to be added to dispc_save_context()
> > to not save context if it has not yet been initialized.

The code in omap_dss_probe() is actually quite broken, as the /* XXX
fail correctly */ hints... At least clocks should be put(), debugfs
should be uninitialized etc. So this patch is ok quick fix, but I'll try
to find time to fix the fail path properly.

 Tom 

> >
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> > Patch against v2.6.34-rc5.
> >
> > Discovered when testing n900 with current PM branch + Roger's
> > series for the LCC panel.  DPI init fails since it can't find
> > VDDS_DSI regulator, and as a result init fails out and leaves
> > clocks enabled.
> >
> >  drivers/video/omap2/dss/core.c  |    1 +
> >  drivers/video/omap2/dss/dispc.c |    3 +++
> >  2 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> > index 7ebe50b..62f7ee2 100644
> > --- a/drivers/video/omap2/dss/core.c
> > +++ b/drivers/video/omap2/dss/core.c
> > @@ -584,6 +584,7 @@ static int omap_dss_probe(struct platform_device *pdev)
> >
> >        /* XXX fail correctly */
> >  fail0:
> > +       dss_clk_disable_all();
> >        return r;
> >  }
> >
> > diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> > index e777e35..4cc54ef 100644
> > --- a/drivers/video/omap2/dss/dispc.c
> > +++ b/drivers/video/omap2/dss/dispc.c
> > @@ -195,6 +195,9 @@ void dispc_save_context(void)
> >        if (cpu_is_omap24xx())
> >                return;
> >
> > +       if (!dispc.base)
> > +               return;
> > +
> >        SR(SYSCONFIG);
> >        SR(IRQENABLE);
> >        SR(CONTROL);
> > --
> > 1.7.0.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


