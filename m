From: Jean Pihet <jpihet@mvista.com>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 19:52:20 +0200
Message-ID: <200906291952.20624.jpihet@mvista.com>
References: <200906291631.19562.jpihet@mvista.com> <200906291936.57703.siarhei.siamashka@nokia.com> <20090629173757.GC9042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:61738 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZF2Rwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 13:52:39 -0400
In-Reply-To: <20090629173757.GC9042@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>

On Monday 29 June 2009 19:37:57 Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2009 at 07:36:57PM +0300, Siarhei Siamashka wrote:
> > On Monday 29 June 2009 17:31:18 ext Jean Pihet wrote:
> > > I am trying to get the latest IRQ registers from a timer or a work
> > > queue but I am running into problems:
> > > - get_irq_regs() returns NULL in some cases, so it is unsuable and even
> > > causes crash when trying to get the registers values from the returned
> > > ptr - I never get user space registers, only kernel
> > >
> > > The use case is that the performance unit (PMNC) of the Cortex A8 has
> > > some serious bug, in short the performance counters overflow IRQ is to
> > > be avoided. The solution I am implementing is to read and reset the
> > > counters from a work queue that is triggered by a timer.
> >
> > Regarding this oprofile related part. I wonder how you can get oprofile
> > working properly (providing non-bogus results) without performance
> > counters overflow IRQ generation?
>
> I don't think you can - triggering capture on overflow is precisely how
> oprofile works.
>
> The erratum talks about polling for overflow.  By doing this, you are in
> a well defined part of the kernel, which is obviously going to be shown
> as a hot path for every counter, thus making oprofile useless for kernel
> work.
I think it is possible, well if you except the get_irq_regs() problem.
The idea is to read and reset the counters before the overflow, instead of 
loading them with a small negative value and waiting for the overflow to 
happen.

> Deferring the interrupt to a workqueue doesn't resolve the problem either.
> The problem has nothing to do with what happens after the interrupt
> occurs - it's about interrupts themselves being lost.
The errata is about a lost event and/or a lock-up of the PMNC unit at the time 
of overflow.

> I think just accepting that this erratum breaks oprofile is the only
> realistic solution. ;(
Completely agree. However it would be nice to have a workaround, as un-elegant 
as it can be ;(
