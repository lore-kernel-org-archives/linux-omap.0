From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 15:08:14 -0700
Message-ID: <20100513220814.GP3428@atomide.com>
References: <20100513214739.GM3428@atomide.com>
 <Pine.LNX.4.44L0.1005131756420.1731-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005131756420.1731-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul Walmsley <paul@pwsan.com>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [100513 14:56]:
> On Thu, 13 May 2010, Tony Lindgren wrote:
> 
> > > > And that's why 
> > > > it should be handled by runtime power management instead.
> > > 
> > > Runtime PM is not capable of freezing userspace and shutting down CPUs.  
> > > More or less by definition -- if it could then it wouldn't be "runtime" 
> > > any more, since the processor wouldn't be running.
> > 
> > Not true. We are already powering off CPUs and rebooting them for
> > at least omaps in every idle loop using cpuidle. The memory stays on.
> 
> Okay, that's a valid point.  But is that approach usable in general 
> (i.e., on non-OMAP systems)?

Yes if your system wakes to interrupts at least. If your system does
not wake to timer events, then you'll get missed timers. So it should
work on PC too with CONFIG_NO_HZ and if RTC was used for the timer
wake event.
 
> How do you handle situations where the CPU is currently idle but an 
> event (such as I/O completion) is expected to occur in the near future?  
> You don't want to power-off and reboot then, do you?

The idle code looks at next_timer_interrupt() value, then if the
next timer event if far enough ahead, the system powers down and
wakes to the timer interrupt. It also wakes to device interrupts.

For the drivers to block hitting off-idle custom idle functions
can be used. Paul Walmsley and Kevin Hilman have some ideas on
having generic latency information available for that. So there
are similar issues to opportunistic suspend + suspend blocks
that should be sorted out in a generic way.

For the drivers to power down, some timeout value seems to work
best.

Regards,

Tony
