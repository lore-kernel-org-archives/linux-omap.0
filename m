From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 8 Apr 2011 10:50:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104081036310.22291@utopia.booyaka.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
 <1301900022.2715.12.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46714 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203Ab1DHQu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 12:50:59 -0400
In-Reply-To: <1301900022.2715.12.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Tomi,

On Mon, 4 Apr 2011, Tomi Valkeinen wrote:

> On Fri, 2011-04-01 at 20:12 -0600, Paul Walmsley wrote:
> 
> > Of course, at some point soon, those clock aliases are going to go away.  
> > But hopefully you all will have converted the driver over to PM runtime at 
> > that point.
> > 
> > Once that happens, there's another problem: omap_hwmod_enable() is defined 
> > that the hardware registers should be accessible by the MPU after it 
> > completes.  So by that definition, the hwmod code should be 
> > enabling/disabling that dss_clk clock too when it enables/idles/shuts down 
> > the hwmod.  Probably we'd need to mark that struct omap_hwmod_opt_clk with 
> > some flag.  Then we'd need some kind of way for the DSS to tell the hwmod 
> > code whether it is or isn't reliant on the PRCM-provided functional clock 
> > for its internal functional clock.  Maybe something like 
> > omap_hwmod_{release,require}_system_fclk()?
> 
> Hmm, right. I guess no other HW module has clock setups like this?

I think McBSP can have an optional main functional clock.  So something 
like that should be usable for that case too. (In the McBSP case, the 
optional clock isn't controlled by the PRCM, it's controlled by the SCM, 
but that doesn't really matter to the hwmod code.)

> Currently DSS can use clk_enable/disable() for the system fclk when its
> using DSI PLL for the fclk. So omap_hwmod_{release,require}_system_fclk
> sounds like a simple solution to this.

OK.  The only problem with those functions (actually 
omap_device_{release,require}_system_fclk()) is that they will need to be 
called through platform_data function pointers for now.  Maybe it is 
possible to handle something like this simply with the clock framework 
also.

> Not directly related, but something I've been wondering about is how to
> abstract the DSI/HDMI PLLs in DSS. What do you think, would it be
> possible/worth it to create struct clks for the clocks coming out of
> those PLLs? These would, of course, be DSS internal clks. I'm not very
> familiar with the clock framework, so I don't really have any idea what
> this would require and what would be the pros and cons.

Yes, I think it would be good to try to implement the entire DSS clock 
tree in the clock framework.  One change to the clock code that we know 
we'll need is to put a hwmod pointer in the struct clk which tells the 
clock code that the hwmod needs to be enabled in order to access the 
clock's registers.  Right now, the clock code assumes that all of the 
clock registers are accessible, all of the time.


- Paul
