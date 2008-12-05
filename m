From: Tony Lindgren <tony@atomide.com>
Subject: Re: Setting dss1_alwon_fck rate
Date: Fri, 5 Dec 2008 15:07:20 -0800
Message-ID: <20081205230718.GL9714@atomide.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140154D464@vaebe104.NOE.Nokia.com> <5e088bd90812051457r43136ecdqedb2ed7a574208f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57800 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbYLEXHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 18:07:24 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90812051457r43136ecdqedb2ed7a574208f4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>

* Steve Sakoman <sakoman@gmail.com> [081205 14:57]:
> On Fri, Dec 5, 2008 at 1:02 AM,  <Tomi.Valkeinen@nokia.com> wrote:
> > Hi,
> >
> > Any comments on these two patches from Mans, that enable setting
> > dss1_alwon_fck? I've been using them with the new DSS, works fine for
> > me.
> 
> I've been using them on recent Overo builds (using current DSS) and
> they work for me too.

Paul, have you had a chance to look at Mans' patches?

Tony


> 
> Steve
> 
> >
> > http://marc.info/?l=linux-omap&m=122454507816731&w=2
> >
> > Filling the set_rate and round_rate fields of dpll4_m4_ck makes
> > this clock programmable through clk_set_rate().  This is needed
> > to give omapfb control over the dss1_alwon_fck rate.
> >
> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> >
> > http://marc.info/?l=linux-omap&m=122454507816734&w=2
> >
> > This makes clk_get_parent() work on OMAP2/3.
> >
> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> > ---
> >  arch/arm/mach-omap2/clock.c     |    5 +++++
> >  arch/arm/mach-omap2/clock.h     |    1 +
> >  arch/arm/mach-omap2/clock24xx.c |    1 +
> >  arch/arm/mach-omap2/clock34xx.c |    1 +
> >  4 files changed, 8 insertions(+), 0 deletions(-)
> >
> >  Tomi
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
