From: Peter Barada <peterb@logicpd.com>
Subject: RE: Question on how to best access a chip on init that needs VAUX1
	power?
Date: Fri, 16 Jan 2009 16:05:02 -0500
Message-ID: <1232139902.347.64.camel@blackhole>
References: <1232134287.347.44.camel@blackhole>
	 <13B9B4C6EF24D648824FF11BE8967162036D6A1527@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:22166 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759726AbZAPVFF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 16:05:05 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D6A1527@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Fri, 2009-01-16 at 14:17 -0600, Woodruff, Richard wrote:
> Subject: Question on how to best access a chip on init that needs VAUX1 power?
> >
> > On the OMAP board I have, I want to access production information
> > (model, serial number, MAC addresses, etc), and the part requires 3v
> > which is powered off of VAUX1.
> >
> > I need to pull this out at initialization time, but I have to wait until
> > the twl4030 driver is running or I get "twl4030: client 3 is not
> > initialized" when I try to turn on the power.   Looking at the
> > twl4030-core.c code, I see its invoked via initcall_subsys().  I'd like
> > to have my code invoked before the other devices come up (so I can
> > provide a MAC address to the ethernet, etc).  I'm trying
> > initcall_sysbys_sync() to have my code called after the twl4040
> > initializes, but before the devices come up.
> 
> You can access this info from u-boot with i2c api.  For development you want the mac address available at that time anyway.

> When you program it into Ethernet chip for many it will stick so kernel will see the right thing.

That is if I initialize the ethernet in u-boot.  To save on power, I'd
like to leave the ethernet alone until the user needs it(and at that
point can modprobe the driver).  I still need the data to setup wireless
in the kernel (its mac address, trim values, etc)...

> u-boot also has simple utility to read from mtd which has u-boot environment where you could have stored it away.

Ultimately I should just pull the block of data in u-boot, extract what
I need for u-boot, and then pass it to the kernel.  Outside of creating
a specific ATAG for this, what's the best way to pass a block of data
from u-boot to the kernel?

> Regards,
> Richard W.
-- 
Peter Barada <peterb@logicpd.com>
