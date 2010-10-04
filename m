From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] tracing, perf: add more power related events
Date: Mon, 4 Oct 2010 19:55:36 +0200
Message-ID: <20101004175536.GD1518@ucw.cz>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
 <201009222049.18154.rjw@sisk.pl>
 <AANLkTinJU5+s_1S6i4GpRuiOfsAPiL9UFtrxCCbtoumt@mail.gmail.com>
 <201009282322.16291.rjw@sisk.pl>
 <4CA261F4.5070803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CA261F4.5070803@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, arjan@infradead.org
List-Id: linux-omap@vger.kernel.org

Hi!

> >> Here is what I am proposing, in reply to all your comments:
> >>
> >> 1) rename the events to match Thomas's proposal:
> >>     power:power_cpu_cstate
> >>     power:power_cpu_pstate
> >>     power:power_cpu_sstate
> > If that sstate thing is going to mean "suspend", then please drop it.
> > "Suspend" is not a state, let alone a CPU state.  It is a procedure by which
> > the (entire) system is put into a sleep state (that is not confined to CPUs).
> 
> there are also non-suspend S states, like S0i1 and S0i3 (supported in 
> the current Intel "Moorestown" platform)

Where can one learn more?
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
