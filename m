From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
	driver to platform_driver
Date: Wed, 18 Jan 2012 14:11:47 +0000
Message-ID: <20120118141147.GN16726@n2100.arm.linux.org.uk>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com> <1326886086-27313-2-git-send-email-hvaibhav@ti.com> <20120118115952.GM16726@n2100.arm.linux.org.uk> <79CD15C6BA57404B839C016229A409A8317A9AA2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41661 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584Ab2AROMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jan 2012 09:12:06 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A9AA2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 18, 2012 at 01:34:55PM +0000, Hiremath, Vaibhav wrote:
> On Wed, Jan 18, 2012 at 17:29:52, Russell King - ARM Linux wrote:
> > On Wed, Jan 18, 2012 at 04:58:02PM +0530, Vaibhav Hiremath wrote:
> > > Convert counter_32k clocksource driver to standard platform_driver
> > > and move it drivers/clocksource/ directory.
> > > 
> > > Also, rename it to more generic name "omap-32k.c".
> > 
> > NAK.  sched_clock is supposed to be available early.  Platform device
> > driver initialization is FAR too late.
> > 
> Russell,
> 
> Sched_clock is available very early during boot sequence. Initially gp-timer 
> (dmtimer) will get registered as a clocksource. Please refer to the file
> mach-omap2/timer.c
> 
> 32k_sync timer (omap-32k.c) will come get registered during arch_init.
> 
> Just FYI, the way I tested it is, I used kernel parameter 
> "clocksourse=counter-32k", the switch from gp-timer to 32k timer
> will happen once it gets registered.

So please delete the sched_clock code from the 32k timer stuff you've
moved to a platform driver.  It will cause sched_clock to reset to zero,
and that's bad news.

Only one sched_clock() should ever be registered, and that should only be
registered very early at boot time.
