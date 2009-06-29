From: Jean Pihet <jpihet@mvista.com>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 19:57:34 +0200
Message-ID: <200906291957.34392.jpihet@mvista.com>
References: <200906291631.19562.jpihet@mvista.com> <200906291858.41151.jpihet@mvista.com> <20090629174633.GD9042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:6499 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbZF2R5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 13:57:51 -0400
In-Reply-To: <20090629174633.GD9042@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>

On Monday 29 June 2009 19:46:33 Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2009 at 06:58:41PM +0200, Jean Pihet wrote:
> > I am trying to get a different approach, starting from the errata
> > description.  The idea is to avoid the counters from overflowing,
> > which could cause a PMNC unit reset or lock-up (or both).
>
> But this can't work.
>
> Oprofile essentially works as follows:
>
>   You set the number (N) of events you wish to occur between each sample.
>   When N events have occured, you record the stacktrace and reset the
>   counter so it fires after another N events.
>
> Now, you could start the counters at zero every time, and then poll them
> via a timer.  When the counter value is larger than N, you could log a
> stacktrace and zero the counter.
>
> However, this suffers one very serious problem - if you're wanting to
> measure something at an interval which occurs faster than your timer,
> you're going to get misleading results.
The counters are 32-bit wide and the maximum counting frequency is 2 events 
per cycle (cf. errata). That means you get plenty of time before the counters 
overflow.

> You could set the timer to fire at a high rate, but then that's going
> to upset things like cache miss, cache hit, etc measurements.
Correct.
You need a tradeoff for the timer period.

> > Here are the implementation details:
> > - use a timer to read and reset the counters, then fire a work queue
> > - in the work queue the counters values are converted to oprofile samples
> > - the proper locking is used to avoid some races between the various
> > tasks
>
> This sounds over complicated. 
It is ;p

> I see no reason for a workqueue to be 
> involved anywhere near the oprofile sample code.
Got it.

> > I am nearly done with it but I am now running into problems with PM
> > (suspend/resume) and get_irq_regs().
>
> You really really really can't use get_irq_regs() outside of IRQ context.
> The stored registers just do not exist anymore - they've been overwritten
> by whatever exception or system call you're currently in.
>
> You can't create a copy of them - copies will be overwritten on the very
> next (nested) interrupt.  You don't know which interrupt is the first
> interrupt to occur.
Doh!

> I really think that the only option here is to just accept that oprofile
> is crucified by this errata.
Amen!

Thanks,
Jean
