From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 24 Apr 2012 07:29:37 -0700
Message-ID: <877gx5dwz2.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
	<CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:48557 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754568Ab2DXO3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:29:37 -0400
Received: by pbcum15 with SMTP id um15so174893pbc.34
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:29:29 -0700 (PDT)
In-Reply-To: <CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
	(Jean Pihet's message of "Tue, 24 Apr 2012 11:50:06 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Grazvydas, Kevin,
>
> I did some gather some performance measurements and statistics using
> custom tracepoints in __omap3_enter_idle.
> All the details are at
> http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#C1_performance_problem:_analysis
> .

This is great, thanks.

[...]

> Here are the results (BW in MB/s) on Beagleboard:
> - 4.7: without using DMA,
>
> - Using DMA
>   2.1: [0]
>   2.1: [1] only C1
>   2.6: [1]+[2] no pre_ post_
>   2.3: [1]+[5] no pwrdm_for_each_clkdm
>   2.8: [1]+[5]+[2]
>   3.1: [1]+[5]+[6] no omap_sram_idle
>   3.1: No IDLE, no omap_sram_idle, all pwrdms to ON
>
> So indeed this shows there is some serious performance issue with the
> C1 C-state.

Yes, this confirms what both Grazvytas and I are seeing as well.

[...]

> From the list of contributors, the main ones are:
>     (140us) pwrdm_pre_transition and pwrdm_post_transition,

See the series I just posted to address this one:
[PATCH/RFT 0/3] ARM: OMAP: PM: reduce overhead of pwrdm pre/post transitions

>     (105us) omap2_gpio_prepare_for_idle and
> omap2_gpio_resume_after_idle. This could be avoided if PER stays ON in
> the latency-critical C-states,
>     (78us) pwrdm_for_each_clkdm(mpu, core, deny_idle/allow_idle),
>     (33us estimated) omap_set_pwrdm_state(mpu, core, neon),
>     (11 us) clkdm_allow_idle(mpu). Is this needed?

In that same series, I removed this as it appears to be a remnant of a
code move (c.f. patch 3 in above series.)

> Here are a few questions and suggestions:
> - In case of latency critical C-states could the high-latency code be
> bypassed in favor of a much simpler version? Pushing the concept a bit
> farther one could have a C1 state that just relaxes the cpu (no WFI),
> a C2 state which bypasses a lot of code in __omap3_enter_idle, and the
> rest of the C-states as we have today,

I was thinking a "WFI only" state, with *all* powerdomains staying on is
probably sufficient for C1.  Do you see the enter/exit latency from that
as even being too hight?

> - Is it needed to iterate through all the power and clock domains in
> order to keep them active?

No.  My series above starts to addresses this, but I think Tero's
use-counting series is the final solution since this should really be
done when we know the powerdomains are transitioning.

Kevin
