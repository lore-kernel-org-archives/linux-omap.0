From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCHv2 1/4] gpiolib: introduce set_debounce method
Date: Tue, 4 May 2010 15:40:30 -0700
Message-ID: <20100504224029.GP29604@atomide.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270049712-28272-2-git-send-email-felipe.balbi@nokia.com>
 <20100402123454.GD27613@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51212 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934342Ab0EDWkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 18:40:36 -0400
Content-Disposition: inline
In-Reply-To: <20100402123454.GD27613@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [100402 05:30]:
> On Wed, Mar 31, 2010 at 06:35:09PM +0300, Felipe Balbi wrote:
> > Few architectures, like OMAP, allow you to set
> > a debouncing time for the gpio before generating
> > the IRQ. Teach gpiolib about that.
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> This looks useful - for what it's worth
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Ping, looks like this series is pretty close to being mergeable.
Felipe, care to repost one more time without RFC and with the
acks if you think you have updated version that's ready for
the upcoming merge window.

Regards,

Tony
