From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 29 Sep 2010 00:05:18 +0200
Message-ID: <201009290005.18704.rjw@sisk.pl>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <201009282322.16291.rjw@sisk.pl> <4CA261F4.5070803@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CA261F4.5070803@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, September 28, 2010, Arjan van de Ven wrote:
>   On 9/28/2010 2:22 PM, Rafael J. Wysocki wrote:
> > On Tuesday, September 28, 2010, Jean Pihet wrote:
> >> Hi,
> > Hi,
> >
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
> 
> so it's slightly more complex than "just" suspend :)

That's exactly why I used the conditional above. :-)
