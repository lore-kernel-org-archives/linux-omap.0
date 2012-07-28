From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Sat, 28 Jul 2012 13:11:03 +0100
Message-ID: <20120728121103.GA11370@mudshark.cambridge.arm.com>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org>
 <20120625005134.GA2342@S2101-09.ap.freescale.net>
 <20120625084905.GD19226@n2100.arm.linux.org.uk>
 <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com>
 <5012CC98.60206@ti.com>
 <20120727204447.GA10024@mudshark.cambridge.arm.com>
 <20120727210637.GA16377@n2100.arm.linux.org.uk>
 <20120727214024.GA10249@mudshark.cambridge.arm.com>
 <20120728100831.GC7405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46346 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752299Ab2G1MLl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 Jul 2012 08:11:41 -0400
Content-Disposition: inline
In-Reply-To: <20120728100831.GC7405@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jon Hunter <jon-hunter@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Jul 28, 2012 at 11:08:31AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 27, 2012 at 10:40:24PM +0100, Will Deacon wrote:
> > On Fri, Jul 27, 2012 at 10:06:37PM +0100, Russell King - ARM Linux wrote:
> > > We support booting a kernel on systems with or without SMP support, even
> > > with a SMP kernel.  When the kernel is booted on such a system, it is
> > > undefined whether smp_cross_call() is a valid function pointer.
> > 
> > So let's define it to point at a dummy function which explodes with a BUG if
> > the cpumask passed in isn't empty. That allows SMP kernels to do things like
> > `cross call to all other cores' without having to worry about whether there
> > are any other cores or not.
> 
> We should not be even attempting to do any cross calls when there aren't
> any other CPUs in the system - that's rather the point of leaving it as
> a NULL pointer so it does explode on such systems.
> 
> . the scheduler won't call smp_send_reschedule() when there are no other
>   CPUs in the system.
> . timer ticks won't be broadcast to other CPUs if there are no other CPUs
>   in the system.
> . function calls will not be issued to other CPUs if there are no other
>   CPUs in the system.
> 
> There is only one case where this doesn't happen, and that's the shutdown
> path.

Ok, that's a pretty compelling argument you've got there :)

> For instance, smp_call_function*() all check that the target CPUs are
> marked online before the arch code is requested to issue an IPI to the
> target CPU.

Yes, thanks for making the case for the original patch. Consistency is the
most important thing with these APIs, so I'll go full circle and offer my
ack for the original patch:

Acked-by: Will Deacon <will.deacon@arm.com>

The next question is: who's putting this into the patch system?

Will
