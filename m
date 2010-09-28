From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: RFC: mixing device idle and CPUidle or non-atomic idle notifiers
Date: Wed, 29 Sep 2010 00:24:01 +0200
Message-ID: <201009290024.01381.rjw@sisk.pl>
References: <87iq1uwvtd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <87iq1uwvtd.fsf@deeprootsystems.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Saturday, September 25, 2010, Kevin Hilman wrote:
> Now that we have runtime PM for devices, I'm exploring ways of how to
> couple the runtime PM of certain devices with CPUidle transitions.
> Ideally, CPUidle should only manage CPU idle states, and device idle
> states would be managed separately using runtime PM.  However, there are
> cases where the device idle transistions need to be coordinated with CPU
> idle transistions.  This is already a proposed topic for the PM
> mini-conf at Plumbers'[1], so this RFC is to get the discussion started.

OK

> In the wild west (before runtime PM), we managed these special cases on
> OMAP by having some special hacks^Whooks for certain drivers that were
> called during idle.  When these devices are converted to using runtime
> PM, ideally we'd like initiate device runtime PM transitions for these
> devices somehow coordinated with CPU idle transitions.
> 
> So, I started to explore how to coordinate device runtime PM transitions
> with CPU idle transitions.
> 
> One of the fundamental problems is that by the time CPUidle is entered,
> interrupts are already disabled, and runtime PM cannot be used from
> interrupts disabled context (c.f. thread on linux-pm[1].)

This issue should be addressed by Alan, by adding the new flag to struct
dev_pm_info that will tell the runtime PM framework that to work with the
assumption that interrupts are off.

> So that led me down the path of exploring whether we really need to have
> interrupts disabled during the early part of CPUidle.  It seems to me
> that during the time when the governor is selecting a state, and when
> the platform-specific code is checking for device/bus activity,
> interrupts do not really need to be disabled yet.  At least, I didn't
> come up with a good reason why they need to be disabled so early, hence
> the RFC.
> 
> Here's a simplified version how it works today:
> 
> /* arch/arm/kernel/process.c, arch/x86/kernel/process_*.c */
> cpu_idle()  
>     local_irq_disable()    
>     pm_idle()  --> cpuidle_idle_call()
> 
> cpuidle_idle_call()
>     dev->prepare()
>     target_state = governor->select()  /* selects next state */
>     target_state->enter()
>         /* the ->enter hook must enable IRQs before returning */
> 
> As a quick hack, I just (re)enabled interrupts in our CPUidle
> ->prepare() hook (they're later disabled again before the core idle is
> run.)  This allowed the calling of device-specific idle functions which
> then use runtime PM and thus allows device-specific idle to be
> coordinated with the CPU idle.
> 
> So back to the main question... do we really need interrupts disabled so
> early in the idle path? 
> 
> I'm sure I'm missing something obvious about why this can't work, but
> it's Friday and my brain prefers to think about beer rather than
> CPUidle.
> 
> Or, as another potential option...
> 
> I just discovered that x86_64 has an atomic idle_notifier called just
> before idle (c.f. arch/x86/kernel/process_64.c.)  However this is also
> done with interrupts disabled, so using this has the same problems with
> interrupts disabled.  But, what about adding an additional notifier
> chain that happens with interrupts still enabled....  hmm, will
> ponder that over that beer...

I must admit I haven't looked very deeply into the cpuidle code, but
certainly there are good reasons to make it collaborate with the I/O runtime PM.

It would be good to know if we can relax the handling of interrupts in the
cpuidle framework a bit, this way or another.

[Added a few CCs to people that may be interested.]

Thanks,
Rafael
