From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP: Fix McBSP spin_lock deadlock.
Date: Thu, 06 Nov 2008 20:41:21 +0800
Message-ID: <1225975281.7337.8.camel@localhost>
References: <1225886429-28058-1-git-send-email-stanley.miao@windriver.com>
	 <200811051546.51707.david-b@pacbell.net>
	 <20081106011621.GJ21736@atomide.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55070 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbYKFMfw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Nov 2008 07:35:52 -0500
In-Reply-To: <20081106011621.GJ21736@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

On Wed, 2008-11-05 at 17:16 -0800, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [081105 15:53]:
> > On Wednesday 05 November 2008, Stanley.Miao wrote:
> > > @@ -333,7 +333,8 @@ struct omap_mcbsp_platform_data {
> > >         u8 dma_rx_sync, dma_tx_sync;
> > >         u16 rx_irq, tx_irq;
> > >         struct omap_mcbsp_ops *ops;
> > > -       char const *clk_name;
> > > +       char const *ick_name;
> > > +       char const *fck_name;
> > >  };
> > >  
> > >  struct omap_mcbsp {
> > 
> > I thought the idea was to fix this using the clock aliasing
> > facility ... so that the mcbsp driver would just
> > 
> > 	ick = clk_get(dev, "ick");
> > 	fck = clk_get(dev, "fck");
> > 
> > (with IS_ERR checks of course) and the platform data would
> > no longer need to hold those names.
> > 
> > That approach can work on OMAP1 too ... I think this patch
> > breaks OMAP1 boards.
> 
> Russell also has some ideas, so despite the nasty bug, let's put
> the clock aliasing and virtual clocks stuff on hold for a little
> while. Meanwhile, maybe we can just add some function for the
> virtual clock that does not cause the recursion?

After considering your suggestions, I change to another solution and
will re-send the patch.

Stanley.

> 
> Tony
