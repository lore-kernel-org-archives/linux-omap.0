From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 12:15:18 -0700
Message-ID: <87bp8nn9yx.fsf@deeprootsystems.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab0H0TPU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 15:15:20 -0400
Received: by pvg2 with SMTP id 2so1195059pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 12:15:20 -0700 (PDT)
In-Reply-To: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	(vishwanath sripathy's message of "Sat, 28 Aug 2010 03:38:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vishwanath.sripathy@linaro.org
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

vishwanath.sripathy@linaro.org writes:

> From: Vishwanath BS <vishwanath.sripathy@linaro.org>
>
> This patch has instrumentation code for measuring latencies for
> various CPUIdle C states for OMAP. Idea here is to capture the
> timestamp at various phases of CPU Idle and then compute the sw
> latency for various c states.  For OMAP, 32k clock is chosen as
> reference clock this as is an always on clock.  wkup domain memory
> (scratchpad memory) is used for storing timestamps.  One can see the
> worstcase latencies in below sysfs entries (after enabling
> CONFIG_CPU_IDLE_PROF in .config). This information can be used to
> correctly configure cpu idle latencies for various C states after
> adding HW latencies for each of these sw latencies.
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>
> THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>
> Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
> Cc: linaro-dev@lists.linaro.org

While I have many problems with the implementation details, I won't go
into them because in general this is the wrong direction for kernel
instrumentation.

This approach adds quite a bit overhead to the idle path itself.  With
all the reads/writes from/to the scratchpad(?) and all the multiplications
and divides in every idle path, as well as the wait-for-idlest in both
the sleep and resume paths.  The additional overhead added is non trivial.

Basically, I'd like get away from custom instrumentation and measurement
coded inside the kernel itself.  This kind of code never stops growing
and morphing into ugliness, and rarely scales well when new SoCs are
added.

With ftrace/perf, we can add tracepoints at specific points and use
external tools to extract and analyze the delays, latencys etc.

The point is to keep the minimum possible in the kernel: just the
tracepoints we're interested in.   The rest (calculations, averages,
analysis, etc.) does not need to be in the kernel and can be done easier
and with more powerful tools outside the kernel.

Kevin

