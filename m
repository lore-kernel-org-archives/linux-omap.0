From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 4/4] perf: provide a DEPRECTAED power trace API to user space
Date: Mon, 4 Oct 2010 18:47:55 +0200
Message-ID: <AANLkTikxEFiAQM8JkP4YwL2nB+vhNTDTGR9exJ367XsT@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<1286205661-24448-5-git-send-email-jean.pihet@newoldbits.com>
	<20101004161051.GF16489@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41954 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab0JDQr4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 12:47:56 -0400
In-Reply-To: <20101004161051.GF16489@redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, mathieu.desnoyers@efficios.com, Jean Pihet <j-pihet@ti.com>

Hi,

On Mon, Oct 4, 2010 at 6:10 PM, Frank Ch. Eigler <fche@redhat.com> wrot=
e:
> Hi -
>
>> Provide a CONFIG_DEPRECATED_POWER_EVENT_TRACING =A0option in order
>> to provide backward compatibility with the user space tracing tools.
>
> This is clever:
>
>> +/* Map new events trace points calls to old ones */
>> +#define trace_processor_idle(state, cpu_id) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (state !=3D 0) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_power_start(POWER_CS=
TATE, state, cpu_id); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_power_end(cpu_id); =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 } while (0)
>
> but with this code, are the new tracepoints firing at all? =A0In othe=
r
> words, does this backward-compatibility config option effectively
> disable the newer ones? =A0If so, this is probably avoidable.
Yes the events are fired. In fact with the CONFIG option defined the
trace_processor_* trace points are not defined, only the macro remaps
them (at compile time) to the old ones.

> Instead of redirecting the new tracepoint calls to these macros, an
> alternative may intercept (un)registration for the old tracepoint
> names, and map them to (un)registration of the real tracepoints. =A0S=
ee
> how syscall tracepoints map to a special (un)registration callback in
> include/trace/events/syscalls.h (syscall_*regfunc). =A0Instead of
> setting a TIF flag, the new functions can call
> register_processor_idle() et al., and their respective callbacks can
> call the backward-compatibility tracepoints.
>
> The starting point would be to recast the power_start, power_end,
> power_frequency tracepoints via TRACE_EVENT_FN() instead of
> TRACE_EVENT().
That could be done but it is not easy to do. In fact the power.h is
included and parsed multiple times in order to generate the trace
points prototype function _and_ the trace generation code. Please
check 'include/trace/ftrace.h' which is really smart but rather
complicated.

I am aiming at simple to read and maintainable code. Furthermore the
code is going to be removed soon or later.

Thanks for the suggestion!

>
> - FChE
>
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
