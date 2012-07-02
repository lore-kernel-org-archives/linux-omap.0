From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Mon, 2 Jul 2012 10:55:39 +0100
Message-ID: <20120702095539.GD22239@mudshark.cambridge.arm.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
 <20120608094708.GC19062@mudshark.cambridge.arm.com>
 <4FD21930.4000800@ti.com>
 <20120611173930.GD28235@mudshark.cambridge.arm.com>
 <4FD64083.3020800@ti.com>
 <20120612092842.GA2991@mudshark.cambridge.arm.com>
 <4FD7B1DC.30108@ti.com>
 <20120612213150.GC24380@mudshark.cambridge.arm.com>
 <4FD7C597.7060501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37019 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754482Ab2GBJz5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 05:55:57 -0400
Content-Disposition: inline
In-Reply-To: <4FD7C597.7060501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

Did you have any luck getting to the bottom of this?

It would be good to take your PMU suspend/resume patches once we know that
they will get used.

On Tue, Jun 12, 2012 at 11:41:27PM +0100, Jon Hunter wrote:
> On 06/12/2012 04:31 PM, Will Deacon wrote:
> > That's understandable -- one of the CPUs is likely more loaded than the
> > other. However, I'd like to confirm whether or not you see what I see. With
> > the 4430_init hack on a 4460, if I run:
> > 
> > # taskset 0x2 perf top
> > 
> > then I get no samples. If I do:
> > 
> > # taskset 0x1 perf top
> > 
> > then I *do* get samples and from *both* CPUs. So it smells more like an
> > issue poking some configuration registers from CPU1 rather than the IRQ
> > path being broken. As I said before, if I don't do the extra init hack
> > then I don't get this problem (but event counters don't tick).
> 
> In both cases, I see interrupts on both CPUs. However, typically more on
> the CPU that perf is running on (which is probably to be expected). And
> I confirm that the only change I made was ...

[...]

> When you boot the kernel what 4460 rev does it show (very early in the
> kernel boot log)? Mine shows ...
> 
> [    0.000000] OMAP4460 ES1.1

Snap: [    0.000000] OMAP4460 ES1.1

> However, the A9 version has not changed between ES1.0 and ES1.1. Both
> should be r2p10.

Yup, that's what /proc/cpuinfo says.

Will
