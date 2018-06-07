From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Common config for N900 and D4
Date: Thu, 7 Jun 2018 12:26:07 +0200
Message-ID: <20180607102607.GA4372@localhost>
References: <20180603104839.GA21197@amd>
 <20180603165336.GA26995@amd>
 <20180603210115.GA7438@amd>
 <20180605042627.GB5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180605042627.GB5738@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi!

> > > > [    0.000000] L2C-310 erratum 727915 enabled
> > > > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > > > [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> > > 
> > > I tried disabling outer cache to get rid of this. That got me further
> > > in boot, but not to working system:
> > 
> > I now have config that works.
> > 
> > My kernels were probably grossly misconfigured (OMAP4 not enabled on
> > droid4)... still I'd expect some kind of panic explaining board is not
> > compatible with kernel, not a random oops...
> 
> Like "clk-provider not found" error? :) I agree it's not very
> descriptive and I think we could easily print something from
> after the SoC detection for missing pdata.

If you had patch for testing, or pointer where such check would
belong, that would be nice. I might try to do something, but now it
boots so it is not too high priority for me.

Thanks,
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
