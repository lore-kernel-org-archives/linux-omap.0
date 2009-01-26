From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Tue, 27 Jan 2009 01:31:59 +0200
Message-ID: <20090126233158.GJ4185@frodo>
References: <20090122131602.18315.84862.stgit@tikku> <200901261340.05286.david-b@pacbell.net> <20090126215254.GA15757@atomide.com> <200901261517.03644.david-b@pacbell.net> <20090126231922.GH4185@frodo> <20090126232749.GB15757@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55185 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbZAZXcK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 18:32:10 -0500
Content-Disposition: inline
In-Reply-To: <20090126232749.GB15757@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Kalle Valo <kalle.valo@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Mon, Jan 26, 2009 at 03:27:50PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <me@felipebalbi.com> [090126 15:19]:
> > On Mon, Jan 26, 2009 at 03:17:03PM -0800, David Brownell wrote:
> > > On Monday 26 January 2009, Tony Lindgren wrote:
> > > > > 
> > > > > That means all drivers which the OMAP tree has in that
> > > > > directory should be pushed upstream, or at least moved
> > > > > to a better home, soon ... :)
> > > > 
> > > > Or else we'll just remove them until somebody patches them back
> > > > against the mainline tree.
> > > 
> > > Right:
> > > 
> > >  - lp5521.c
> > >  - tsl2563.c
> > 
> > at least these two I had patched them and moved to other locations,
> > looks the patches weren't applied.
> 
> Maybe try to send them to the right drivers lists for mainline
> integration?

but then you'd have to drop them from l-o ;-)

-- 
balbi
