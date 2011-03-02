From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend] omap: Fix linker error in
 drivers/video/omap/lcd_2430sdp.c
Date: Wed, 2 Mar 2011 09:36:10 -0800
Message-ID: <20110302173610.GV20560@atomide.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
 <1298232248-347-1-git-send-email-jhnikula@gmail.com>
 <20110224212644.GN20560@atomide.com>
 <20110228164715.e34a965e.jhnikula@gmail.com>
 <1298905757.9809.135.camel@deskari>
 <20110301013928.GL20560@atomide.com>
 <1298960962.2011.11.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16080 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287Ab1CBRgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:36:16 -0500
Content-Disposition: inline
In-Reply-To: <1298960962.2011.11.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110228 22:27]:
> On Mon, 2011-02-28 at 19:39 -0600, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [110228 07:07]:
> > > 
> > > Well, it's a bit ugly, but I'm fine with it. It's for the old omapfb,
> > > which hopefully nobody uses anymore (right =), and there's no simple way
> > > to make it modular and neat.
> > 
> > How about let's make mach-omap2 boards all use the new code?
> > That way the old code can be omap1 only.
> 
> That has been my long term plan, but I've never had time to start
> working on it. Some (many?) of the old panel drivers are trivial to
> port, needs just copying the panel timings. 

OK, that will probably make things a lot easier in the long run.
 
> Some are much more complex, and porting them without having the hardware
> may be a bit of a guesswork. But perhaps we can find testers for those
> after the code has been ported.

Sure, once we get one working others should be easy..

Tony
