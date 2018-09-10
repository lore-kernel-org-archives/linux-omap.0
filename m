From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Date: Mon, 10 Sep 2018 07:00:14 -0700
Message-ID: <20180910140014.GS5662@atomide.com>
References: <20180425142922.128233-1-tony@atomide.com>
 <20180830221853.GX7523@atomide.com>
 <20180910111408.GK28860@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910111408.GK28860@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [180910 11:18]:
> On Thu, 30 Aug 2018, Tony Lindgren wrote:
> 
> > Lee,
> > 
> > * Tony Lindgren <tony@atomide.com> [180425 07:31]:
> > > It currently only works if the parent bus uses "simple-bus". We
> > > currently try to probe children with non-existing compatible values.
> > > And we're missing .probe.
> > > 
> > > I noticed this while testing devices configured to probe using ti-sysc
> > > interconnect target module driver. For that we also may want to rebind
> > > the driver, so let's remove __init and __exit.
> > > 
> > > Cc: Roger Quadros <rogerq@ti.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > > 
> > > This is OK to wait for v4.18 merge window as the related dts node has
> > > not yet been updated to probe via ti-sysc interconnect target driver.
> > 
> > Sorry I just noticed this is still pending, it should be
> > applied as a fix for the -rc series.
> > 
> > Do you want me to resend the patch?
> 
> Just back from vacation.

Welcome back :)

> No thanks, I'll get to it.

OK thanks!

Tony
