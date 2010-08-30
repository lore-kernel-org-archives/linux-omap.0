From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Mon, 30 Aug 2010 18:29:56 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870310FA8865@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
 <87bp8nn9yx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58153 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213Ab0H3NAH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 09:00:07 -0400
In-Reply-To: <87bp8nn9yx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

Kevin,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Saturday, August 28, 2010 12:45 AM
> To: vishwanath.sripathy@linaro.org
> Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
> 
> vishwanath.sripathy@linaro.org writes:
> 
> > From: Vishwanath BS <vishwanath.sripathy@linaro.org>
> >
> > This patch has instrumentation code for measuring latencies for
> > various CPUIdle C states for OMAP. Idea here is to capture the
> > timestamp at various phases of CPU Idle and then compute the sw
> > latency for various c states.  For OMAP, 32k clock is chosen as
> > reference clock this as is an always on clock.  wkup domain memory
> > (scratchpad memory) is used for storing timestamps.  One can see the
> > worstcase latencies in below sysfs entries (after enabling
> > CONFIG_CPU_IDLE_PROF in .config). This information can be used to
> > correctly configure cpu idle latencies for various C states after
> > adding HW latencies for each of these sw latencies.
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
> >
> > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
> > Cc: linaro-dev@lists.linaro.org
> 
> While I have many problems with the implementation details, I won't go
> into them because in general this is the wrong direction for kernel
> instrumentation.
> 
> This approach adds quite a bit overhead to the idle path itself.  With
> all the reads/writes from/to the scratchpad(?) and all the multiplications
> and divides in every idle path, as well as the wait-for-idlest in both
> the sleep and resume paths.  The additional overhead added is non trivial.
> 
> Basically, I'd like get away from custom instrumentation and measurement
> coded inside the kernel itself.  This kind of code never stops growing
> and morphing into ugliness, and rarely scales well when new SoCs are
> added.
> 
> With ftrace/perf, we can add tracepoints at specific points and use
> external tools to extract and analyze the delays, latencys etc.
> 
> The point is to keep the minimum possible in the kernel: just the
> tracepoints we're interested in.   The rest (calculations, averages,
> analysis, etc.) does not need to be in the kernel and can be done easier
> and with more powerful tools outside the kernel.
The challenge here is that we need to take time stamp at the fag end of CPU Idle which means we have no access to DDR, MMU/Caches are disabled etc (on OMAP3). So I am not sure if we will be able to use ftrace/perf kind of tools here. If we choose to exclude assembly code part for measurement, then we will be omitting major contributor to CPU Idle latency namely ARM context save/restoration part. 

Also these calculations are done only when we enable CPUIDLE profiling feature. 
In the normal production system, these will not come into picture at all. So I am not sure latencies involved in these calculations are still an issue when we are just doing profiling.

Regards
Vishwa
> 
> Kevin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
