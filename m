From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Mon, 26 Jan 2009 15:27:50 -0800
Message-ID: <20090126232749.GB15757@atomide.com>
References: <20090122131602.18315.84862.stgit@tikku> <200901261340.05286.david-b@pacbell.net> <20090126215254.GA15757@atomide.com> <200901261517.03644.david-b@pacbell.net> <20090126231922.GH4185@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52934 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZAZX15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 18:27:57 -0500
Content-Disposition: inline
In-Reply-To: <20090126231922.GH4185@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, Kalle Valo <kalle.valo@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [090126 15:19]:
> On Mon, Jan 26, 2009 at 03:17:03PM -0800, David Brownell wrote:
> > On Monday 26 January 2009, Tony Lindgren wrote:
> > > > 
> > > > That means all drivers which the OMAP tree has in that
> > > > directory should be pushed upstream, or at least moved
> > > > to a better home, soon ... :)
> > > 
> > > Or else we'll just remove them until somebody patches them back
> > > against the mainline tree.
> > 
> > Right:
> > 
> >  - lp5521.c
> >  - tsl2563.c
> 
> at least these two I had patched them and moved to other locations,
> looks the patches weren't applied.

Maybe try to send them to the right drivers lists for mainline
integration?

Tony
