From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC/PATCHv2 1/4] gpiolib: introduce set_debounce method
Date: Wed, 5 May 2010 21:37:41 +0300
Message-ID: <20100505183741.GD2274@gandalf>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270049712-28272-2-git-send-email-felipe.balbi@nokia.com>
 <20100402123454.GD27613@sirena.org.uk>
 <20100504224029.GP29604@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39915 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0EEShC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 14:37:02 -0400
Content-Disposition: inline
In-Reply-To: <20100504224029.GP29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, May 04, 2010 at 03:40:30PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [100402 05:30]:
> > On Wed, Mar 31, 2010 at 06:35:09PM +0300, Felipe Balbi wrote:
> > > Few architectures, like OMAP, allow you to set
> > > a debouncing time for the gpio before generating
> > > the IRQ. Teach gpiolib about that.
> > > 
> > > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > This looks useful - for what it's worth
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Ping, looks like this series is pretty close to being mergeable.
> Felipe, care to repost one more time without RFC and with the
> acks if you think you have updated version that's ready for
> the upcoming merge window.

will do it tomorrow, but it would be good to hear from Dave before.

-- 
balbi
