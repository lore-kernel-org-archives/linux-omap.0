From: Lee Jones <lee.jones@linaro.org>
Subject: Re: linux-next 2017-08-08 keyboard failure on Nokia N900
Date: Wed, 9 Aug 2017 13:45:56 +0100
Message-ID: <20170809124556.3u6b2fqlxabykgs4@dell>
References: <20170808101756.GA12922@amd>
 <20170808103444.GA18247@amd>
 <20170808111243.GA20328@amd>
 <61264d43-eda3-df9d-0c06-28611f373ce7@ti.com>
 <alpine.DEB.2.20.1708082203510.2095@hadrien>
 <43d915d2-3260-88b6-095d-4de8240ff29e@ti.com>
 <alpine.DEB.2.20.1708082228400.4939@hadrien>
 <20170808214400.GA18961@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170808214400.GA18961@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Grygorii Strashko <grygorii.strashko@ti.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tue, 08 Aug 2017, Pavel Machek wrote:

> Hi!
> 
> > > > > I've not precisely checked it, but smth is telling me that below
> > > > > patch  can cause this:
> > > > >
> > > > > commit 78daaca78ee57dead0f4aa5ee399f0499e81cd9e
> ...
> > > > >      mfd: twl4030-irq: Drop unnecessary static
> > > > >
> > > > >      Drop static on a local variable, when the variable is initialized
> > > > > before
> > > > >      any use, on every possible execution path through the function.
> > > > >
> > > > > --- a/drivers/mfd/twl4030-irq.c
> > > > > +++ b/drivers/mfd/twl4030-irq.c
> ...
> > > > >   int twl4030_init_irq(struct device *dev, int irq_num)
> > > > >   {
> > > > > -       static struct irq_chip  twl4030_irq_chip;
> > > > > +       struct irq_chip twl4030_irq_chip;
> > > > >
> > > > >
> > > > > but if we will look at code - it can be seen that this variable is passed
> > > > > by reference to
> > > > > irq_set_chip_and_handler().
> > > > > Ops. And what will happen when twl4030_init_irq() returns ;)
> > > >
> > > > The patch is not correct as was already noted when it was submitted:
> ..
> > > Hm. This one is in linux-next, but shouldn't. Right?
> > >
> > >  git log --oneline  -10 linux-next/master
> > > c0b96db Add linux-next specific files for 20170808
> > >
> > > git log --oneline  linux-next/master | grep "Drop unnecessary static"
> > > 78daaca mfd: twl4030-irq: Drop unnecessary static
> > 
> > OK, it seems like the patch was made twice, the second one was commented
> > on and the first one was applied.  78daaca should not be there.
> 
> Lee, it has your sign-off, can you drop the patch from your tree? It
> is known bad.

Done, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
