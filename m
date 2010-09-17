From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Fri, 17 Sep 2010 15:08:45 +0200
Message-ID: <201009171508.46471.trenn@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <20100909075403.GA10798@elte.hu> <AANLkTimCy8pB6JZ2bkGutTou8-oXc1yjweqCxVrLw=Kk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTimCy8pB6JZ2bkGutTou8-oXc1yjweqCxVrLw=Kk@mail.gmail.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

I had a quick look at this and it's amazing how broken
the whole power event tracing interfaces are.
It's not your fault, Jean, they always were and adding your stuff is 
fine.

Some questions, maybe I've overseen something:

Why does this event:
DEFINE_EVENT(power, power_frequency,
exist and takes a C-/P-state, now also an S-state type as argument?

It should be named more generic, like:
DEFINE_EVENT(power, power_switch,
then it could get invoked when any P-/C-/S-/X- state
switch happened.

What kind of hack is this:
TRACE_EVENT(power_end,
showing up as:
power_end: dummy=65535
What ends here?
I know it's a workaround/hack for userspace apps to be
able to detect leaving of a sleep state, but how would someone
know or how would someone describe this in a proper API documentation?
Apropos documentation..., are the power trace events documented 
somewhere?

At least the state should still be passed, then the _start/_end thing 
can be reused by something else than C-states.

I can't see the use of having _start/_end events at all.
You are always in a state, having one:
power_switch
as suggested above, is enough to track everything.

Examples:

Today's C-state tracking:
power_start: type=1 state=1  -> C1 entered
power_end: dummy=65535       -> C-state left
power_start: type=1 state=2  -> C2 entered
power_end: dummy=65535       -> C-state left
would then be:
power_switch: type=1 state=1  -> C1 entered
power_switch: type=1 state=0  -> C0 entered -> means C1 left...
power_switch: type=1 state=2  -> C2 entered
power_switch: type=1 state=0  -> C0 entered -> means C2 left...
...

Todays P-state tracking:
power_frequency: type=2 state=125000000     -> P-state change to 125 MHz
power_frequency: type=2 state=90000000      -> P-state change to 90 MHz
would then be:
power_switch: type=2 state=125000000       -> P-state change to 125 MHz
power_switch: type=2 state=90000000        -> P-state change to 90 MHz

The S-state and T-state tracking would fit into that without 
modification.
Thinking one step further, a possibility to track D-states would
need an additional field, a pointer to the device, best a sysfs path
or similar.

Jean, I do not think tracing the S-state with power_start is a
good idea. Best would be the power_frequency gets renamed (yes, breaks
userspace, but those have to be adjusted) and used for P- and S-
state tracking (and C-state tracking as well, but this would need
additional userspace modifications).
How do you track when the S-states end?

        Thomas

