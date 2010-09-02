From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Thu, 02 Sep 2010 10:55:23 -0700
Message-ID: <87mxs06nec.fsf@deeprootsystems.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<20100902075605.GB2962@matterhorn.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39701 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0IBRz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 13:55:27 -0400
Received: by pvg2 with SMTP id 2so257030pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Sep 2010 10:55:26 -0700 (PDT)
In-Reply-To: <20100902075605.GB2962@matterhorn.lan> (Amit Kucheria's message
	of "Thu, 2 Sep 2010 10:56:05 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vishwanath.sripathy@linaro.org
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

Amit Kucheria <amit.kucheria@linaro.org> writes:

> On 10 Aug 27, Kevin Hilman wrote:
>> vishwanath.sripathy@linaro.org writes:
>> 
>> > From: Vishwanath BS <vishwanath.sripathy@linaro.org>
>> >
>> > This patch has instrumentation code for measuring latencies for
>> > various CPUIdle C states for OMAP. Idea here is to capture the
>> > timestamp at various phases of CPU Idle and then compute the sw
>> > latency for various c states.  For OMAP, 32k clock is chosen as
>> > reference clock this as is an always on clock.  wkup domain memory
>> > (scratchpad memory) is used for storing timestamps.  One can see the
>> > worstcase latencies in below sysfs entries (after enabling
>> > CONFIG_CPU_IDLE_PROF in .config). This information can be used to
>> > correctly configure cpu idle latencies for various C states after
>> > adding HW latencies for each of these sw latencies.
>> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
>> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
>> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>> >
>> > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>> >
>> > Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
>> > Cc: linaro-dev@lists.linaro.org
>> 
>> While I have many problems with the implementation details, I won't go
>> into them because in general this is the wrong direction for kernel
>> instrumentation.
>> 
>> This approach adds quite a bit overhead to the idle path itself.  With
>> all the reads/writes from/to the scratchpad(?) and all the multiplications
>> and divides in every idle path, as well as the wait-for-idlest in both
>> the sleep and resume paths.  The additional overhead added is non trivial.
>> 
>> Basically, I'd like get away from custom instrumentation and measurement
>> coded inside the kernel itself.  This kind of code never stops growing
>> and morphing into ugliness, and rarely scales well when new SoCs are
>> added.
>> 
>> With ftrace/perf, we can add tracepoints at specific points and use
>> external tools to extract and analyze the delays, latencys etc.
>> 
>> The point is to keep the minimum possible in the kernel: just the
>> tracepoints we're interested in.   The rest (calculations, averages,
>> analysis, etc.) does not need to be in the kernel and can be done easier
>> and with more powerful tools outside the kernel.
>
> Kevin,
>
> I agree. We discussed this a little in our weekly meeting. Vishwa's main
> concern was the lack of ability to instrument the last bit of SRAM code.
>
> I have a feeling that even with caches on when we enter this code, we won't
> see too much variance in the latency to execute this bit of code. Vishwa is
> going to confirm that now. If that hypothesis is true, we can indeed move to
> using tracepoints in the idle path and use external tools to track latency.
>
> Even if it isn't true, the rest of the idle path could still contain tracepoints.

Yes.

As Santosh pointed out, that low-level code be a fixed latency and can
likely be profiled once.

That being said, it should still be possible to trace the low-level code.
Jean Pihet and I discussed implementing a "fake" tracepoint in SRAM
during that part of the execution which could then be copied out later.
This would minimize the custom tracing code and allow us to continue to
use userspace tools to analyze the entire path.

Jean is investigating this now.

Kevin


