From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Sat, 28 Jul 2012 11:08:31 +0100
Message-ID: <20120728100831.GC7405@n2100.arm.linux.org.uk>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org> <20120625005134.GA2342@S2101-09.ap.freescale.net> <20120625084905.GD19226@n2100.arm.linux.org.uk> <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com> <5012CC98.60206@ti.com> <20120727204447.GA10024@mudshark.cambridge.arm.com> <20120727210637.GA16377@n2100.arm.linux.org.uk> <20120727214024.GA10249@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50831 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab2G1KIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Jul 2012 06:08:46 -0400
Content-Disposition: inline
In-Reply-To: <20120727214024.GA10249@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 27, 2012 at 10:40:24PM +0100, Will Deacon wrote:
> On Fri, Jul 27, 2012 at 10:06:37PM +0100, Russell King - ARM Linux wrote:
> > We support booting a kernel on systems with or without SMP support, even
> > with a SMP kernel.  When the kernel is booted on such a system, it is
> > undefined whether smp_cross_call() is a valid function pointer.
> 
> So let's define it to point at a dummy function which explodes with a BUG if
> the cpumask passed in isn't empty. That allows SMP kernels to do things like
> `cross call to all other cores' without having to worry about whether there
> are any other cores or not.

We should not be even attempting to do any cross calls when there aren't
any other CPUs in the system - that's rather the point of leaving it as
a NULL pointer so it does explode on such systems.

. the scheduler won't call smp_send_reschedule() when there are no other
  CPUs in the system.
. timer ticks won't be broadcast to other CPUs if there are no other CPUs
  in the system.
. function calls will not be issued to other CPUs if there are no other
  CPUs in the system.

There is only one case where this doesn't happen, and that's the shutdown
path.

For instance, smp_call_function*() all check that the target CPUs are
marked online before the arch code is requested to issue an IPI to the
target CPU.

The only place which is missing this check is smp_send_stop().

Now, we could make machine_shutdown() do this instead:

	if (is_smp())
		smp_send_stop();

but why bother calling into smp_send_stop(), and ultimately end up with
the _only_ site which calls smp_cross_call() with an empty CPU mask when
we can avoid the call when the CPU mask is empty - and prevent this
special case of smp_cross_call() being called with an empty CPU mask
ever occuring.
