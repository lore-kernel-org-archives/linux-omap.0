From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Tue, 27 Jan 2015 07:26:53 -0800
Message-ID: <20150127152653.GI28663@atomide.com>
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
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [150127 07:19]:
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

Thanks for fixing that one!

Regards,

Tony
