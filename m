From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Tue, 12 Jun 2012 22:31:50 +0100
Message-ID: <20120612213150.GC24380@mudshark.cambridge.arm.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
 <20120608094708.GC19062@mudshark.cambridge.arm.com>
 <4FD21930.4000800@ti.com>
 <20120611173930.GD28235@mudshark.cambridge.arm.com>
 <4FD64083.3020800@ti.com>
 <20120612092842.GA2991@mudshark.cambridge.arm.com>
 <4FD7B1DC.30108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63775 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696Ab2FLVcC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 17:32:02 -0400
Content-Disposition: inline
In-Reply-To: <4FD7B1DC.30108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 12, 2012 at 10:17:16PM +0100, Jon Hunter wrote:
> Hi Will,

Hi Jon,

> On 06/12/2012 04:28 AM, Will Deacon wrote:
> > 
> > Well, I tried that and the results are pretty whacky: the event counters do
> > indeed tick but interrupts only fire if I pin the perf task to CPU1! What's
> > more, the interrupts do fire on both cores when they're working...
> 
> I tried this, and I see that interrupts occur on both, however, it seems
> that the majority occur on one CPU and only a few on the other. So it
> does appear that one CPU is getting a lot more interrupts.

That's understandable -- one of the CPUs is likely more loaded than the
other. However, I'd like to confirm whether or not you see what I see. With
the 4430_init hack on a 4460, if I run:

# taskset 0x2 perf top

then I get no samples. If I do:

# taskset 0x1 perf top

then I *do* get samples and from *both* CPUs. So it smells more like an
issue poking some configuration registers from CPU1 rather than the IRQ
path being broken. As I said before, if I don't do the extra init hack
then I don't get this problem (but event counters don't tick).

> From a PMU programming standpoint, if we just use "perf top" are the
> event counters not used/programmed?

Just using perf top should use the cycle counter as the event source.

> And when we use "perf top -e instructions" is it the "software
> increment" event that the event counter(s) are monitoring? I am just
> trying to understand how the counters are being programmed and then I
> can ask the design folks an intelligent question :-)

It depends on the CPU. For Cortex-A9, `instructions' maps to event 0x68,
which isn't a perfect match. If you want to specify a hex value for the
event code, you can do:

# perf top -e rNN

where NN is the hex event number. On A9, r11 would give you cycles via
an event counter.

> By the way, I don't suppose there is any debugfs entry to dump the PMU
> registers?

'fraid not, but there is some debug code in perf_event_v7.c that you
could call if you wanted to (just #define DEBUG at the top of the file).

Will
