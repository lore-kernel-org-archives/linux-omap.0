From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 26 Apr 2012 02:40:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204260226060.10308@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com> <4F97B891.1020601@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com> <4F97E243.6000500@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com> <4F97EF11.4020300@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDAE7@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204250755020.29696@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FDD1D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34069 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab2DZIkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 04:40:47 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FDD1D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 25 Apr 2012, Hiremath, Vaibhav wrote:

> On Wed, Apr 25, 2012 at 19:25:29, Paul Walmsley wrote:
> > On Wed, 25 Apr 2012, Hiremath, Vaibhav wrote:
> > 
> > > Thanks for describing it for me. I will change AM33XX clock tree for this
> > > And submit the next version soon.
> > 
> > Well I can just remove those leaf clock entries from my copy here, if 
> > you're okay with that ?
> > 
> 
> Great...
> 
> More that OK :)

I have taken a first pass at this.  The updated patch is below.  It has 
been compile-tested only.  Could you please review this and try testing 
it?  It is also in the branch 'am33xx_support_3.5' of 
git://git.pwsan.com/linux-2.6.

Here are a few notes:

- Leaf nodes with MODULEMODE clock enable bits were removed, where there 
were no obvious driver dependencies.  Removing these may not be the 
correct thing to do, considering strange clocks like the CLKDIV32K.  It 
may be that the underlying clockdomain control for this device is very 
different than the OMAP4, and if so, we need to find this out sooner 
rather than later.

- Clock nodes with no direct hardware control have been dropped.  This has 
the unfortunate consequence of making the clock tree slightly harder to 
follow, but, in combination with the MODULEMODE clock removals, reduces 
the diffstat burden by about 1000 lines.

- Many clksel clocks were missing .init, .set_rate, and .round_rate 
function pointers; these have been added where it appeared to be 
appropriate.  Also, many clksel clocks had incorrect .recalc function 
pointers that did not take the clksel fields into consideration; these 
have been fixed.

- Several common struct clksel_rate blocks were shared with the OMAP4 
clock tree.

- The non-inlineable function am33xx_init_timer_parent() was moved from
clock33xx.h to clock33xx.c.

- Some multi-line comment formatting and mach-omap2/control.h formatting 
was cleaned up.

- AM33XX_CONTROL_STATUS_SYSBOOT1_MASK/SHIFT macros were added to remove 
a magic number from the clock tree.

- The "clk_sel" nomenclature in the original patch was changed to "clksel" 
to conform with the use in OMAP2/3/4 clock trees.

- The timer mux clock nodes have been split from the timer MODULEMODE 
nodes.

Still to be done:

* Some clocks seem to be missing clockdomain names.  These probably should 
be added.

* The clkdiv32k clock needs to be revised, depending on feedback from the 
hardware team.


- Paul
