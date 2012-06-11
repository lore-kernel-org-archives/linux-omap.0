From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Mon, 11 Jun 2012 14:01:23 -0500
Message-ID: <4FD64083.3020800@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-2-git-send-email-jon-hunter@ti.com> <20120608094708.GC19062@mudshark.cambridge.arm.com> <4FD21930.4000800@ti.com> <20120611173930.GD28235@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48140 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab2FKTBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 15:01:30 -0400
In-Reply-To: <20120611173930.GD28235@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Will,

On 06/11/2012 12:39 PM, Will Deacon wrote:
> On Fri, Jun 08, 2012 at 04:24:32PM +0100, Jon Hunter wrote:
>> Hi Will,
> 
> Hi Jon,
> 
>> Here is an updated version. I was going to send out a V3, but I wanted
>> to wait to see if others had more comments first.
> 
> This looks better to me, so I took it for a spin on my 4460 (thanks Nicolas!)
> and noticed that only the cycle counter seems to tick -- the event counters
> always return 0 deltas (that is, they don't increment). Booting the same SD
> card on a 4430 (same MLO, u-boot, kernel and filesystem) I see that the
> event counters function correctly there.

Thanks for the feedback. Being somewhat new to PMU, I was mainly using
PERF to test and verify that with "perf top" I was seeing interrupts.
How do I check what the event counters are returning? Any perf tests I
could use?

By the way, as a quick test you could modify the code in omap_init_pmu()
to call omap4430_init_pmu() for all omap4 devices as follows ...

	if (cpu_is_omap44xx())
 		return omap4430_init_pmu();

I was hoping for 4460/70 we would not need to keep the debugss and other
domains on and hence, I called the above function omap4430_init_pmu().
However this function works for all omap4 devices, it just turns on more
power domains.

> It also seems that we can remove the dependency on CONFIG_OMAP3_EMU with these
> patches but I don't have any OMAP3 hardware to check if we get any regressions
> on older platforms. Do your patches only deal with OMAP4?

It *should* work for all omap2+. So far I have tested an omap3 beagle
but I have not tested an omap2 device. Again the extent of my testing
was to run "perf top" and verify interrupts we being generated. I
realise that this may not be sufficient and so if you have a more
exhaustive test you recommend let me know.

Cheers
Jon

