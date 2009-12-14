From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization delay
Date: Mon, 14 Dec 2009 11:34:03 -0800
Message-ID: <87my1lgxjo.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com>
	<87skbhjwjo.fsf@deeprootsystems.com>
	<87my1pggok.fsf@deeprootsystems.com> <4B25FF04.4040306@ti.com>
	<873a3dfse2.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD07FD36@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:59486 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZLNTeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 14:34:06 -0500
Received: by pxi4 with SMTP id 4so2024425pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 11:34:06 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD07FD36@dbde02.ent.ti.com> (Romit Dasgupta's message of "Mon\, 14 Dec 2009 22\:11\:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Dasgupta, Romit" <romit@ti.com> writes:

>>>
>>> I tried to find the code in LO but I think it is not yet present.
>
>>Right, it is still being discussed.
>
>>> So with that in mind may I propose that the pmc functions we
>>> introduce in plat-omap will be present as __init code (so that we
>>> ensure no one uses it after the system finishes booting up) as long
>>> as the pmc infrastructure is not available for non-Oprofile uses?
>
>>Personally, I don't like this idea.
>
>>IMHO, the PMC is not OMAP specific and does not belong in plat-omap
>>even as init code.  Either generalize and use existing PMC
>>infrastructure, or use a different timer.
>
> Ftrace/Oprofile/Perf are all initialized later during the boot
> process.  Actually if you see where we are using pmc it is in
> init_IRQ.  So until the pmc libraries I think it would be fair to
> use it. I do not see any problem.

I'm not against using the PMC, per se.  I'm against the way you've
coded it as an OMAP specific library.

> Can you point out with any concrete code from the latest OMAP tree?

The current PMC code in mainline is in oprofile and would need to be
generalized to be used by more users (e.g. oprofile, perf, your code,
etc.)

Jamie Iles has done the heavy lifting on this alrady for ARMv6[1], and
there are already discussions flowing on on linux-arm-kernel on how to
extend this for ARMv7.

A generalized PMC infrastructure is clearly needed (not just for your
code) so adding something that is OMAP specific is not the right
approach IMO.

>>You didn't answer my other question about whether or not a GPtimer
>>could be used for this.  You could quickly request/program/free a
>>GPtimer for this too using the omap_dm_timer* API.
>
> May be possibe but IMHO it is ugly to setup and more complicated to
> use than the pmc approach. 

What would be ugly?  All you need is a start, read and stop API.  This
is provided cleanly by the DM timer API.  

Here's an uncompiled, untested version of 'measure_sram_delay' using
the DM Timer API:

unsigned int measure_sram_delay(unsigned int loop)
{
	unsigned long start, end, flags;
	void (*_omap3_sram_delay)(unsigned long);
	_omap3_sram_delay = omap_sram_push(__sram_wait_delay,
						__sram_wait_delay_sz);

	gpt = omap_dm_timer_request();
	if (!gpt)
		pr_err("foo");
	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
	omap_dm_timer_set_load_start(gptimer, 0, 0);

        local_irq_save(flags);
        start = omap_dm_timer_read_counter(gpt);
	_omap3_sram_delay(loop);
        end = omap_dm_timer_read_counter(gpt);
        local_irq_restore(flags);
  
	omap_dm_timer_stop(gpt);
        omap_dm_timer_free(gpt);

	return end - start;
}

Since your needs are very short lived, I didn't bother setting
up any interrupt handling for timer overflow etc., I just start
the timer at zero.

> The other indirect way is like how
> bogomips is calculated. But that is a different story. We need
> accuracy in the delay and __may be__ interrupt latency would skew
> the results. If someone can implement it using Interrupt we would
> like to see how much access delay they get using irq technique.
>
>>> As I mentioned in an earlier thread, the pmc is used and stopped
>>> very early during the kernel boot and AFAICT there should not be any
>>> problem (probably we need to check its behavior on EMU/HS devices).
>
>>This isn't very convicing.
>
>>Also, it's not just oprofile we have to be worried about.  The
>>perf/trace infrastructure arm is also using the PMC.  It will not be
>>uncommon to use perf on early boot/init and the use of the PMC in this
>>patch will clearly interfere with that.
>
> Wrong! See above.

OK, I'm wrong about the init sequence.

However, in your approach, the SRAM delay timing *must* be done very early
in the init.  In a generalized approach, with a reserve mechanism it could
be done later, or not until needed.  

Depending on early init has implicit assumptions about other
subsystems whose ordering may change, and is in general not a good
idea.

>
>>In summary, the PMC is a shared resource and should be treated as such
>>using common code and common APIs. 
>
> Where is it today?

Under proposal and discussion[1].  If you want to use PMC, you'll need
to use a generalized approach.

IMO, an OMAP specific approach to PMC is unacceptable.

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/006065.html

