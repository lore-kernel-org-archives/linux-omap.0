From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 4/9] omap: clocks: Add checks to see if enable/disable
 ops are supported
Date: Tue, 8 Feb 2011 08:55:52 +0530
Message-ID: <85772086dbd5bbd435fe7779ded71b3b@mail.gmail.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
 <1296813544-25170-5-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102071846570.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43861 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754138Ab1BHD0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 22:26:21 -0500
Received: by fxm11 with SMTP id 11so5355992fxm.1
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 19:26:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102071846570.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 08, 2011 7:18 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; b-cousson@ti.com;
rnayak@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 4/9] omap: clocks: Add checks to see if
enable/disable ops are supported
>
> On Fri, 4 Feb 2011, Santosh Shilimkar wrote:
>
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > Check if enable/disable operations are supported for a given
> > clock node before attempting to call them.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock.c |   14 +++++++++-----
> >  1 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> > index 2a2f152..5c08c18 100644
> > --- a/arch/arm/mach-omap2/clock.c
> > +++ b/arch/arm/mach-omap2/clock.c
> > @@ -261,7 +261,8 @@ void omap2_clk_disable(struct clk *clk)
> >
> >  	pr_debug("clock: %s: disabling in hardware\n", clk->name);
> >
> > -	clk->ops->disable(clk);
> > +	if (clk->ops && clk->ops->enable)
> > +		clk->ops->disable(clk);
>
> Shouldn't that read:
>
>     if (clk->ops && clk->ops->disable)
>
> ?

Oops.. I guess it should. Will fix that and repost.

>
>
> - Paul
