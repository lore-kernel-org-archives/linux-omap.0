From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Tue, 12 Jun 2012 10:28:42 +0100
Message-ID: <20120612092842.GA2991@mudshark.cambridge.arm.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
 <20120608094708.GC19062@mudshark.cambridge.arm.com>
 <4FD21930.4000800@ti.com>
 <20120611173930.GD28235@mudshark.cambridge.arm.com>
 <4FD64083.3020800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:48053 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448Ab2FLJ26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 05:28:58 -0400
Content-Disposition: inline
In-Reply-To: <4FD64083.3020800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 11, 2012 at 08:01:23PM +0100, Jon Hunter wrote:
> Hi Will,

Hello,

> On 06/11/2012 12:39 PM, Will Deacon wrote:
> > This looks better to me, so I took it for a spin on my 4460 (thanks Nicolas!)
> > and noticed that only the cycle counter seems to tick -- the event counters
> > always return 0 deltas (that is, they don't increment). Booting the same SD
> > card on a 4430 (same MLO, u-boot, kernel and filesystem) I see that the
> > event counters function correctly there.
> 
> Thanks for the feedback. Being somewhat new to PMU, I was mainly using
> PERF to test and verify that with "perf top" I was seeing interrupts.
> How do I check what the event counters are returning? Any perf tests I
> could use?

You can continue to use perf top, just specify an event other than cycles:

# perf top -e instructions

for example. You can also use perf stat, but that probably won't be
triggering irqs.

> By the way, as a quick test you could modify the code in omap_init_pmu()
> to call omap4430_init_pmu() for all omap4 devices as follows ...
> 
> 	if (cpu_is_omap44xx())
>  		return omap4430_init_pmu();
> 
> I was hoping for 4460/70 we would not need to keep the debugss and other
> domains on and hence, I called the above function omap4430_init_pmu().
> However this function works for all omap4 devices, it just turns on more
> power domains.

Well, I tried that and the results are pretty whacky: the event counters do
indeed tick but interrupts only fire if I pin the perf task to CPU1! What's
more, the interrupts do fire on both cores when they're working...

Without the above change, I can generate cycle counter interrupts regardless
of which CPU I run execute perf.

> > It also seems that we can remove the dependency on CONFIG_OMAP3_EMU with these
> > patches but I don't have any OMAP3 hardware to check if we get any regressions
> > on older platforms. Do your patches only deal with OMAP4?
> 
> It *should* work for all omap2+. So far I have tested an omap3 beagle
> but I have not tested an omap2 device. Again the extent of my testing
> was to run "perf top" and verify interrupts we being generated. I
> realise that this may not be sufficient and so if you have a more
> exhaustive test you recommend let me know.

Well, try the above as well as what you're currently doing and that should
test the basics. If that works, I'll happily drop the Kconfig dependency on
OMAP3_EMU (which has been a regular source of confusion).

Cheers,

Will
