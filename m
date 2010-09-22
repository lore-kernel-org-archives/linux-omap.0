From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 19:36:01 +0200
Message-ID: <201009221936.02245.trenn@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <1285173835.2275.1026.camel@laptop> <4C9A37AE.2010509@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54277 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab0IVRgU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 13:36:20 -0400
In-Reply-To: <4C9A37AE.2010509@linux.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org

On Wednesday 22 September 2010 19:06:54 Arjan van de Ven wrote:
>   On 9/22/2010 9:43 AM, Peter Zijlstra wrote:
> > On Wed, 2010-09-22 at 09:32 -0700, Arjan van de Ven wrote:
> >>> What are the apps that are using it? I know about builtin-timechart,
> >>> pytimechart. Is powertop using this as well?
> >> powertop 2.x codebase is as well.
> >>
> >> and a bunch of tools we have internal here at Intel.
> >>
> >> the thing with ABIs is that you don't know how many users you have.. at
> >> least here you know the lower bound is 3 different tools that are open
> >> source.
> >> .... and likely many local tools that aren't.
> > These tools should be smart enough to look up the tracepoint name, fail
> > it its not available, read the tracepoint format, again fail if not
> > compatible.
> it's not very useful if none of the critical information is available.
> 
> you can't at the one hand push people to use perf for critical pieces 
> (like machine checks etc etc) and on
> the other hand say that it's not ABI stable and should not be used really.
I provided an ABI stable solution, by marking the broken parts deprecated, etc.
I'll rework the CONFIG_DEPRECATED_POWER_EVENTS (or similar config).

> In this case we're talking about basically a suprious rename of 
> something that isn't really an improvement
...

> (because it makes it harder to subscribe to only one type of event)... 
> that's not a good thing.
Finally there is some talking about the details.
You say they should be differed by the name and not the type?
Why does the type= attribute exist at all then?

/sys/kernel/debug/tracing/:[0]# cat available_events  |grep power
power:power_start
power:power_frequency
power:power_end

So which one do I set to get C-, processor sleep, state traces?

What you mean is that instead of passing the type= as attribute, an
additional macro layer could be put in or each type is statically defined.
The type itself needs not to get passed anymore then, because this
info is already in the name and you get:
power:power_cstates
power:power_pstates
power:power_sstates
or
power:power_processor_sleep
power:power_processor_frequency
power:power_machine_suspend
...
right?
This more looks like an interface that can get exposed
to userspace...

       Thomas
