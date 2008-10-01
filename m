From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 1 Oct 2008 18:57:55 +0300
Message-ID: <20081001155755.GG7412@gandalf.research.nokia.com>
References: <1222857363-25055-1-git-send-email-felipe.balbi@nokia.com> <1222857363-25055-2-git-send-email-felipe.balbi@nokia.com> <200810010851.47774.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42692 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbYJAP62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 11:58:28 -0400
Content-Disposition: inline
In-Reply-To: <200810010851.47774.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, Oct 01, 2008 at 08:51:46AM -0700, David Brownell wrote:
> On Wednesday 01 October 2008, Felipe Balbi wrote:
> > +/**
> > + * clk_associate - associates a user to a clock so device drivers don't
> > + * have to care about clock names
> > + *
> > + * @id: clock id as defined in arch/arm/mach-omapX/clkxxxx.h
> > + * @dev: device pointer for the clock user
> > + * @f: a function for the clock (uart_[if]ck, musb_ick, ehci_[if]ck, etc)
> > + */
> > +void __init clk_associate(const char *id, struct device *dev, const char *f)
> 
> Heh.  I remember coming up with that same abstraction
> for mach-at91/clock.c a few years back.  It seems to
> have worked fairly well in that far simpler environment,
> and I can't imagine why it wouldn't work here too.

aha, so it was you. I was reading clk implementations from other arm
architectures and found that at91_clk_associate() which seemed really
nice. So I decided to move to linux-omap since it'll solve some clk
issues we have here :-)

> The name might be confusing though, since it's not part
> of the standard clk_*() interface ... and the name might
> be needed there, eventually.

I suppose clk_associate() could become part of the clk api, yes. It's
quite useful when you have different version of the SoC with different
clk names (omap1/2/3, for instance).

> So mirroring "at91_clock_associate()" ... maybe this
> should be "omap_clock_associate()" not "clk_associate()".

Well, I'm ok with that but I'd rather see clk_associate() moving to
clk api so anyone who needs that, could use it.

-- 
balbi
