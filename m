From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 2/3] ARM: OMAP3+: clockdomain33xx: Add clockdomain
 data and respective operations
Date: Thu, 26 Apr 2012 16:22:02 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FF79B@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241725430.24864@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FD30E@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204252118170.30642@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FE75B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204260252240.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36732 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757996Ab2DZQWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 12:22:08 -0400
In-Reply-To: <alpine.DEB.2.00.1204260252240.10308@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 26, 2012 at 14:27:20, Paul Walmsley wrote:
> On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:
> 
> > On Thu, Apr 26, 2012 at 08:49:28, Paul Walmsley wrote:
> 
> (attribution lost)
> 
> > > > > Also, since we're not defining any autodeps for the AM335x platform, we 
> > > > > shouldn't need the CLKDM_NO_AUTODEPS flag either?  Since no autodeps are 
> > > > > defined, the default will be to not set any autodeps.
> > > > > 
> > > > 
> > > > This is required to avoid few "pr_debug", if you don't provide it.
> > > > For example, without this flag set, you will get,
> > > > 
> > > > pr_debug("clockdomain: hardware cannot set/clear sleep "
> > > > 		"dependency affecting %s from %s\n", clkdm1->name,
> > > >              clkdm2->name);
> > > > 
> > > > Refer to the file omap_hwmod.c, function, _enable(), the call sequence is,
> > > > 
> > > > _enable() => _add_initiator_dep() => clkdm_add_sleepdep() =>leads to warning
> > > 
> > > Seems like the better thing to do is to just avoid calling
> > > _{add,del}_initiator_dep() on the AM335x.
> > > 
> > 
> > Don't you think, if flag is doing all the job, why to pollute code with
> > cpu_is_am33xx() checks.
> 
> That's not what that flag was intended to do.  It was originally intended 
> for OMAP3xxx, to allow autodeps to be disabled for some clockdomains, 
> while leaving them enabled for others.
> 
> If autodeps are completely unneeded, as they are for AM335x, for slower 
> cores like the Cortex-A8, it seems best to avoid executing any 
> superfluous code.
> 
> > Yeah, I realized it, after your comment; its copy thing...Will correct in 
> > next version.
> 
> I've dropped those lines from the description in the local copy here.
> 
> > I am thinking of separating clocktree patch (PATCH-V3 3/3) from this series, 
> > so that clockdomain stuff can get in independently, and clocktree anyway 
> > will follow them (it may take some time in review cycle).
> 
> Yes, I was thinking of doing this too.  The only aspect that gave me pause 
> is that the clockdomain changes are not 100% separate from the clock tree.  
> So we may have to update the clockdomain data as the clock tree changes.
> 

Why do you say that, clockdomain changes are not 100% separate from 
clocktree? It is completely independent...


Thanks,
Vaibhav

