From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Thu, 2 Sep 2010 13:41:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCED1488@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<20100902075605.GB2962@matterhorn.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20100902075605.GB2962-HeifvKp/9wrwg6x6O6sdfg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org [mailto:linaro-dev-
> bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org] On Behalf Of Amit Kucheria
> Sent: Thursday, September 02, 2010 1:26 PM
> To: Kevin Hilman
> Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
> 
> On 10 Aug 27, Kevin Hilman wrote:
> > vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org writes:
> >
> > > From: Vishwanath BS <vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > >
> > > This patch has instrumentation code for measuring latencies for
> > > various CPUIdle C states for OMAP. Idea here is to capture the
> > > timestamp at various phases of CPU Idle and then compute the sw
> > > latency for various c states.  For OMAP, 32k clock is chosen as
> > > reference clock this as is an always on clock.  wkup domain memory
> > > (scratchpad memory) is used for storing timestamps.  One can see the
> > > worstcase latencies in below sysfs entries (after enabling
> > > CONFIG_CPU_IDLE_PROF in .config). This information can be used to
> > > correctly configure cpu idle latencies for various C states after
> > > adding HW latencies for each of these sw latencies.
> > > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> > > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> > > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
> > >
> > > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
> > >
> > > Signed-off-by: Vishwanath BS <vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> >
> > While I have many problems with the implementation details, I won't go
> > into them because in general this is the wrong direction for kernel
> > instrumentation.
> >
> > This approach adds quite a bit overhead to the idle path itself.  With
> > all the reads/writes from/to the scratchpad(?) and all the
> multiplications
> > and divides in every idle path, as well as the wait-for-idlest in both
> > the sleep and resume paths.  The additional overhead added is non
> trivial.
> >
> > Basically, I'd like get away from custom instrumentation and measurement
> > coded inside the kernel itself.  This kind of code never stops growing
> > and morphing into ugliness, and rarely scales well when new SoCs are
> > added.
> >
> > With ftrace/perf, we can add tracepoints at specific points and use
> > external tools to extract and analyze the delays, latencys etc.
> >
> > The point is to keep the minimum possible in the kernel: just the
> > tracepoints we're interested in.   The rest (calculations, averages,
> > analysis, etc.) does not need to be in the kernel and can be done easier
> > and with more powerful tools outside the kernel.
> 
> Kevin,
> 
> I agree. We discussed this a little in our weekly meeting. Vishwa's main
> concern was the lack of ability to instrument the last bit of SRAM code.
> 
> I have a feeling that even with caches on when we enter this code, we
> won't
> see too much variance in the latency to execute this bit of code. Vishwa
> is
> going to confirm that now. If that hypothesis is true, we can indeed move
> to
> using tracepoints in the idle path and use external tools to track latency.
There will be difference with and without caches but the delta latency will be constant with caches and without caches. Another important point is
he lowest level code should be just profiled once and for worst CPU/BUS clock speed.
> 
> Even if it isn't true, the rest of the idle path could still contain
> tracepoints.
> 
I also think this would be better approach considering a generic solution.

Regards,
Santosh
