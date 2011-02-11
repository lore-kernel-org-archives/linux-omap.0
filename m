From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Are there CPU sleep residency HW counters in OMAP? Was: Re:
 [PATCH] perf: add OMAP support for the new power events
Date: Fri, 11 Feb 2011 20:37:13 +0530
Message-ID: <4af9720e7693765b8a9b75279d4675c8@mail.gmail.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com>
 <AANLkTim7H_RZ2pSjSuYB1nCUkDx5K59r_i2JuSpjHVuK@mail.gmail.com>
 <f3244f4cf3ff7a11a1f15d01ccae1608@mail.gmail.com> <201102111538.43372.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58806 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab1BKPHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 10:07:16 -0500
Received: by mail-wy0-f181.google.com with SMTP id 22so2557847wyf.12
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 07:07:15 -0800 (PST)
In-Reply-To: <201102111538.43372.trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

(+ Kevin, Paul)

> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Friday, February 11, 2011 8:09 PM
> To: Santosh Shilimkar
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; Jean Pihet-XID
> Subject: Are there CPU sleep residency HW counters in OMAP? Was: Re:
> [PATCH] perf: add OMAP support for the new power events
>
> Hi,
>
> I use this thread as I expect people following it, is exactly
> the audience I am looking out for.
>
> I am currently implementing a generic framework for CPU idle
> state accounting.
>
> X86 CPUs can do quite some magic behind the OS and might enter
> deeper sleep states or might not enter them, even the OS requested
> (not) to do so.
>
> Intel and AMD provide, depending on the CPU family, different HW
> counters to read out which state the HW really entered.
>
> One can also use some counters which are not explicitly made for
> that. For example in X86 there is the mperf counter ticking at
> max frequency like TSC, but unlike the TSC it stops when entering
> any sleep state. This for example will also be one of the counters
> to account C0 vs Cx time the HW really resided in.
>
I assume HW means CPU here. The current OMAP's doesn't have
hardware counter registers to measure CPU residency time in
deeper sleep states. Intrusive instrumentation using always
running counter is possible buts no good. Hence Jean is
trying to have common trace framework do some of these.

> The stuff is intended for the cpupowerutils (new branch on the
> cpufrequtils tree) package. It should replace the turbostat tool
> which is doing this for some Intel x86 cpus only and recently got
> merged into the kernel:
> linux-2.6/tools/power/x86/turbostat/
>
> I still have to make sure to compile out X86 specific stuff
> (accessing MSRs, cpuid..) for other archs and with a next, cleaned
> up
> patch series the accounting statistics from
> /sys/devices/system/cpu/cpu*/cpuidle/* should work on other archs as
> well.
>
> Anyway, if there are facilities to read out sleep state residency
> from
> HW for omap based cpus and you like to have a tool showing them,
> it would be great if someone likes to help with the implementation.
>
> The framework will be there already, I would just need some help
> with
> a omap_monitor.c file filling up some callback functions and there
> could
> be one tool with the same format for all archs showing sleep
> states...
>

Various IPs in OMAP are grouped in different Powerdomains. The
Powerdomain states targeted and reached can be read from the
hardware registers and that's what we use more often. Currently
some debug counters can show these stats.

For e.g
OMAP CPU supports below power domains.
1. CPU PD ON/INACTIVE
2. CPU PD RETENTION (2 levels)
3. CPU PD OFF.

C-states can attempt one of these states based available sleep
time and up down latencies. Whether attempted target CPU PD
states was reached or not can be read  using hardware registers.
But then we still can't read the exact CPU residency time in
a particular sleep state.

Hope this gives some idea about what's supported by OMAP
hardware for cpuidle residency measurements.

I let Kevin/Pual comment more in case I have missed some
information.

Regards,
Santosh
