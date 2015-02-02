From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Mon, 2 Feb 2015 14:39:36 +0100
Message-ID: <20150202133936.GA26985@amd>
References: <201501232239.55801@pali>
 <201501232336.36187@pali>
 <20150126161454.GE28663@atomide.com>
 <201501261723.10505@pali>
 <20150126170323.GF28663@atomide.com>
 <alpine.LFD.2.11.1501261318590.1322@knanqh.ubzr>
 <20150127133739.GB25306@amd>
 <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tony Lindgren <tony@atomide.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue 2015-01-27 10:16:24, Nicolas Pitre wrote:
> On Tue, 27 Jan 2015, Pavel Machek wrote:
> 
> > 
> > > > > I would say, problem is because omap3-n900 binary DT is too large
> > > 
> > > I agree.
> > > 
> > > > OK if that's the case, then your patch makes sense to me. It also
> > > > seems we can have the temporary stack be larger than the initial
> > > > stack just for atags_to_fdt.
> > > 
> > > The stack size isn't the issue, but rather its location.  We need to 
> > > position it away from the DT data.  The DT size is known and we could 
> > > use that, plus some room for the insertion of new data coming from the
> > > ATAG conversion.
> > > 
> > > Something like the following would be a more robust solution:
> > 
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > 
> > (Note, that in 3.19 dts for n900 got too big, so we are actually
> > triggering old bugs. That means that this is a regression fix, and
> > should go in ASAP).
> 
> It is queued here:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8294/1

Hmm, but it should be on kernel.org, not in private arm trees, as it
fixes a regression. Russell, you are the ARM maintainer, can you push
it to Linus?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
