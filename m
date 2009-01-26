From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Tue, 27 Jan 2009 01:19:22 +0200
Message-ID: <20090126231922.GH4185@frodo>
References: <20090122131602.18315.84862.stgit@tikku> <200901261340.05286.david-b@pacbell.net> <20090126215254.GA15757@atomide.com> <200901261517.03644.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57243 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbZAZXTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 18:19:33 -0500
Content-Disposition: inline
In-Reply-To: <200901261517.03644.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Kalle Valo <kalle.valo@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Mon, Jan 26, 2009 at 03:17:03PM -0800, David Brownell wrote:
> On Monday 26 January 2009, Tony Lindgren wrote:
> > > 
> > > That means all drivers which the OMAP tree has in that
> > > directory should be pushed upstream, or at least moved
> > > to a better home, soon ... :)
> > 
> > Or else we'll just remove them until somebody patches them back
> > against the mainline tree.
> 
> Right:
> 
>  - lp5521.c
>  - tsl2563.c

at least these two I had patched them and moved to other locations,
looks the patches weren't applied.

-- 
balbi
