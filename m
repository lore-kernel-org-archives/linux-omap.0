From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH v1 1/5] ARM: cache-l2x0: add 'smc' identifier
Date: Wed, 30 Jan 2013 10:36:43 +0530
Message-ID: <20130130050642.GA11075@bnru10>
References: <20130129101328.GA11878@bnru10>
 <20130129113325.GG2637@n2100.arm.linux.org.uk>
 <20130129114926.GA14624@bnru10>
 <20130129122255.GI2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130129122255.GI2637@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "avorontsov@mvista.com" <avorontsov@mvista.com>, "gregory.clement@free-electrons.com" <gregory.clement@free-electrons.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "rubini@unipv.it" <rubini@unipv.it>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Shiraz HASHIM <shiraz.hashim@st.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 29, 2013 at 13:22:56 +0100, Russell King - ARM Linux wrote:
> On Tue, Jan 29, 2013 at 05:19:27PM +0530, Srinidhi Kasagar wrote:
> > On Tue, Jan 29, 2013 at 12:33:25 +0100, Russell King - ARM Linux wrote:
> > > On Tue, Jan 29, 2013 at 03:43:31PM +0530, srinidhi kasagar wrote:
> > > > Add 'smc' (Secure Monitor Call) identifier to differentiates
> > > > the platforms which implements this.
> > > 
> > > This patch makes no sense.
> > > 
> > > So, if setting 'smc' in the DT description is supposed to mean that
> > > the platform has a secure monitor then...
> > > 
> > > > +	is_smc = of_property_read_bool(np, "smc");
> > > > +
> > > > +	if (is_smc) {
> > > > +		/* set the debug interface */
> > > > +		outer_cache.set_debug = pl310_set_debug;
> > > > +	}
> > > 
> > > Now, let's look at what pl310_set_debug() does:
> > > 
> > > static void pl310_set_debug(unsigned long val)
> > > {
> > >         writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
> > 
> > You can do this operation (write to DEBUG_CTRL) only if SMC is implemented.
> 
> Err... no.  You can do it if you're running in secure mode without a
> secure monitor, because the security stuff doesn't get in the way.

Yes, you are right as always. I was totally wrong, I overlooked the code.
I will drop this patch, it does not make sense.

> 
> What other platforms do is up to them, and up to *how* the secure monitor
> is implemented, not *if*.
> 
> > > }
> > > 
> > > Can you explain where the secure monitor call is there please, because
> > > I can't see one.  In fact, this is the function used when there _isn't_
> > > a secure monitor.  So this patch just seems totally wrong to me.
> 
> So this is going to be difficult because you only ever answer half an
> email?  So, I repeat the question above.
Yes, there is no secure monitor call. I mixed up two things and end up in a mess.

Thanks,srinidhi
