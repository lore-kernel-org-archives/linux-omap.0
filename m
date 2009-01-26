From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Mon, 26 Jan 2009 13:52:55 -0800
Message-ID: <20090126215254.GA15757@atomide.com>
References: <20090122131602.18315.84862.stgit@tikku> <20090123022334.GN7172@atomide.com> <877i4iqp00.fsf@nokia.com> <200901261340.05286.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52607 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbZAZVxA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 16:53:00 -0500
Content-Disposition: inline
In-Reply-To: <200901261340.05286.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Kalle Valo <kalle.valo@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090126 13:41]:
> On Monday 26 January 2009, Kalle Valo wrote:
> > > I'll also remove drivers/i2c/chips/menelaus.c.
> > 
> > Thanks. It's nice to see drivers going to upstream.
> 
> That driver has been upstream for quite a long time now.
> This change was just helping scrub drivers/i2c/chips,
> since it's going away.
> 
> That means all drivers which the OMAP tree has in that
> directory should be pushed upstream, or at least moved
> to a better home, soon ... :)

Or else we'll just remove them until somebody patches them back
against the mainline tree.

Tony
