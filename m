From: Thomas Renninger <trenn@suse.de>
Subject: Are there CPU sleep residency HW counters in OMAP?    Was: Re: [PATCH] perf: add OMAP support for the new power events
Date: Fri, 11 Feb 2011 15:38:43 +0100
Message-ID: <201102111538.43372.trenn@suse.de>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com> <AANLkTim7H_RZ2pSjSuYB1nCUkDx5K59r_i2JuSpjHVuK@mail.gmail.com> <f3244f4cf3ff7a11a1f15d01ccae1608@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57295 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811Ab1BKOiq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 09:38:46 -0500
In-Reply-To: <f3244f4cf3ff7a11a1f15d01ccae1608@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

Hi,

I use this thread as I expect people following it, is exactly
the audience I am looking out for.

I am currently implementing a generic framework for CPU idle
state accounting.

X86 CPUs can do quite some magic behind the OS and might enter
deeper sleep states or might not enter them, even the OS requested
(not) to do so.

Intel and AMD provide, depending on the CPU family, different HW
counters to read out which state the HW really entered.

One can also use some counters which are not explicitly made for
that. For example in X86 there is the mperf counter ticking at
max frequency like TSC, but unlike the TSC it stops when entering
any sleep state. This for example will also be one of the counters
to account C0 vs Cx time the HW really resided in.

The stuff is intended for the cpupowerutils (new branch on the
cpufrequtils tree) package. It should replace the turbostat tool
which is doing this for some Intel x86 cpus only and recently got
merged into the kernel:
linux-2.6/tools/power/x86/turbostat/

I still have to make sure to compile out X86 specific stuff
(accessing MSRs, cpuid..) for other archs and with a next, cleaned up 
patch series the accounting statistics from 
/sys/devices/system/cpu/cpu*/cpuidle/* should work on other archs as 
well.

Anyway, if there are facilities to read out sleep state residency from
HW for omap based cpus and you like to have a tool showing them,
it would be great if someone likes to help with the implementation.

The framework will be there already, I would just need some help with
a omap_monitor.c file filling up some callback functions and there could
be one tool with the same format for all archs showing sleep states...

Thanks,

     Thomas


On Monday, February 07, 2011 05:12:18 PM Santosh Shilimkar wrote:
> Jean,
> > -----Original Message-----
> > From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> > Sent: Monday, February 07, 2011 9:36 PM
> > To: Santosh Shilimkar; Tony Lindgren
> > Cc: Thomas Renninger; linux-omap@vger.kernel.org; Jean Pihet-XID
> > Subject: Re: [PATCH] perf: add OMAP support for the new power events
> >
> > Hi Santosh, Tony,
> >
> > On Wed, Jan 26, 2011 at 11:06 AM, Santosh Shilimkar
> > <santosh.shilimkar@ti.com> wrote:
> > >> -----Original Message-----
> > >> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> > >> Sent: Wednesday, January 26, 2011 3:20 PM
> > >> To: Santosh Shilimkar
> > >> Cc: Thomas Renninger; linux-omap@vger.kernel.org; Jean Pihet-XID
> > >> Subject: Re: [PATCH] perf: add OMAP support for the new power
> > events
> > >>
> > > [...]
> > >
> > >> > We need to track the actual power domain transitions as well
> > >> > at hardware level.
> > >> Agree
> > >>
> > >> > Can you please look at "pwrdm_pre_transition()" and
> > >> > "pwrdm_post_transition()"
> > >> > This code keep track of it using the next power state
> > >> > and prev-power state.
> > >> The current API only has 'trace_power_domain_target' which tracks
> > >> the
> > >> desired target state.
> > >> I think we need an extra tracer 'trace_power_domain_hitstate' so
> > >> that
> > >> the trace parser can compare the desired ('target') and actually
> > hit
> > >> ('hitstate') states.
> > >>
> > > We use next state and previous state. 'hitstate' doesn't sound
> > > well that's really secondary.
> > >
> > > Do you plan to add that additional trace then ?
> > Yes that is idea, although adding new events in the power trace API
> > has been proved as quite difficult to get accepted. In any case this
> > will be done separately (iow it is not part of this patch).
> >
> > Also this patch also supports OMAP4 since the changes are in the
> > generic PM frameworks. Thanks to the OMAP PM arch guys ;p
> >
> > Is the patch OK? If so can it be queued in the l-o tree?
> >
> I just looked at from the current need of DEBUG counters
> and commented what needs to be supported.
> 
> Am ok with the patch, but that means we still need to keep using
> and supporting PM debug counters till we support the additional
> trace events.
> 
> May be Kevin/Paul can take a call on this.
> 
> Regards,
> Santosh
> 

