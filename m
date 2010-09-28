From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 29 Sep 2010 00:05:51 +0200
Message-ID: <201009290005.51644.rjw@sisk.pl>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <201009282322.16291.rjw@sisk.pl> <AANLkTin7yoSArdMTMSxKyamMP-dk7bubPiCEgWGb6RCc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin7yoSArdMTMSxKyamMP-dk7bubPiCEgWGb6RCc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, September 28, 2010, Jean Pihet wrote:
> Hi,
> 
> On Tue, Sep 28, 2010 at 11:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, September 28, 2010, Jean Pihet wrote:
> >> Hi,
> >
> > Hi,
> >
> >> Here is what I am proposing, in reply to all your comments:
> >>
> >> 1) rename the events to match Thomas's proposal:
> >>    power:power_cpu_cstate
> >>    power:power_cpu_pstate
> >>    power:power_cpu_sstate
> >
> > If that sstate thing is going to mean "suspend", then please drop it.
> > "Suspend" is not a state, let alone a CPU state.  It is a procedure by which
> > the (entire) system is put into a sleep state (that is not confined to CPUs).
> 
> Since suspend is tied to the power management of the system, is it ok
> to rename it to e.g. power:system_suspend?

I think so.

Thanks,
Rafael
