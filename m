From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Mon, 26 Jan 2009 15:17:03 -0800
Message-ID: <200901261517.03644.david-b@pacbell.net>
References: <20090122131602.18315.84862.stgit@tikku> <200901261340.05286.david-b@pacbell.net> <20090126215254.GA15757@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:21954 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752210AbZAZXRF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jan 2009 18:17:05 -0500
In-Reply-To: <20090126215254.GA15757@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kalle Valo <kalle.valo@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Monday 26 January 2009, Tony Lindgren wrote:
> > 
> > That means all drivers which the OMAP tree has in that
> > directory should be pushed upstream, or at least moved
> > to a better home, soon ... :)
> 
> Or else we'll just remove them until somebody patches them back
> against the mainline tree.

Right:

 - lp5521.c
 - tsl2563.c
 - twl4030-madc.c
 - twl4030-poweroff.c
 - twl4030-pwrbutton.c
