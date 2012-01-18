From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
Date: Wed, 18 Jan 2012 14:38:07 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A9C39@DBDE01.ent.ti.com>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
 <20120118115952.GM16726@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A8317A9AA2@DBDE01.ent.ti.com>
 <20120118141147.GN16726@n2100.arm.linux.org.uk> <4F16D66F.2000602@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43091 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719Ab2AROil convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jan 2012 09:38:41 -0500
In-Reply-To: <4F16D66F.2000602@arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 18, 2012 at 19:55:51, Marc Zyngier wrote:
> On 18/01/12 14:11, Russell King - ARM Linux wrote:
> > On Wed, Jan 18, 2012 at 01:34:55PM +0000, Hiremath, Vaibhav wrote:
> >> On Wed, Jan 18, 2012 at 17:29:52, Russell King - ARM Linux wrote:
> >>> On Wed, Jan 18, 2012 at 04:58:02PM +0530, Vaibhav Hiremath wrote:
> >>>> Convert counter_32k clocksource driver to standard platform_driver
> >>>> and move it drivers/clocksource/ directory.
> >>>>
> >>>> Also, rename it to more generic name "omap-32k.c".
> >>>
> >>> NAK.  sched_clock is supposed to be available early.  Platform device
> >>> driver initialization is FAR too late.
> >>>
> >> Russell,
> >>
> >> Sched_clock is available very early during boot sequence. Initially gp-timer 
> >> (dmtimer) will get registered as a clocksource. Please refer to the file
> >> mach-omap2/timer.c
> >>
> >> 32k_sync timer (omap-32k.c) will come get registered during arch_init.
> >>
> >> Just FYI, the way I tested it is, I used kernel parameter 
> >> "clocksourse=counter-32k", the switch from gp-timer to 32k timer
> >> will happen once it gets registered.
> > 
> > So please delete the sched_clock code from the 32k timer stuff you've
> > moved to a platform driver.  It will cause sched_clock to reset to zero,
> > and that's bad news.
> > 
> > Only one sched_clock() should ever be registered, and that should only be
> > registered very early at boot time.
> 
> The kernel will WARN if two sched_clock() are registered. I hope this
> will be enough for people not to persist with such a thing...
> 
Marc,

This code-snippet is not registering multiple sched_clock() functions,
Here we have 2 timers
  - gp-timer (available on all devices)
  - 32k-sync timer (may not available on all devices, like AM33xx)

So we are registering both the timers as a clocksource and kernel
Chooses one based on kernel-parameter or rating.
>From sched_clock perspective, we have only one function exported in
mach-omap2/timer.c, which in-turn calls omap-32k.c timer api.

Something like this,


unsigned long long notrace sched_clock(void)
{
	U32 cyc;

	/* First call 32k-sync timer sched_clock() */
	/* return 0 means, the device doesn't have 32k-sync timer available */
	cyc = sched_clock_32k();
	if (cyc)
		return cyc;

	/* Fall back to gp-timer approach */
}

So there is and will not be any warning from kernel here.

Thanks,
Vaibhav
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
> 
> 

