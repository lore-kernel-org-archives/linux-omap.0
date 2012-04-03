From: Kevin Hilman <khilman@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 03 Apr 2012 07:27:52 -0700
Message-ID: <878vicsxef.fsf@ti.com>
References: <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
	<CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
	<CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
	<CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
	<CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
	<CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
	<20120403092524.GD17741@mudshark.cambridge.arm.com>
	<CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47631 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752897Ab2DCO1z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 10:27:55 -0400
Received: by pbcum15 with SMTP id um15so4705585pbc.6
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 07:27:53 -0700 (PDT)
In-Reply-To: <20120403123444.GL17741@mudshark.cambridge.arm.com> (Will
	Deacon's message of "Tue, 3 Apr 2012 13:34:45 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Hi Will,

Will Deacon <will.deacon@arm.com> writes:

> On Tue, Apr 03, 2012 at 11:01:53AM +0100, Shilimkar, Santosh wrote:
>> On Tue, Apr 3, 2012 at 3:17 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > It seems that they're both needed to get reliable PMU operation. Without the
>> > CLKDM_CAN_SWSUP fix, no interrupts are generated at all. Without the patch
>> > below ([1]), it seems that we don't generate enough. So it looks like we
>> > need them both.
>> >
>> I see. Can you please confirm if it is still the case with [1].
>
> Right, ignore my previous comment, I was using a vanilla 3.3 kernel without
> realising and therefore what I thought were PMU/CTI interrupts were actually
> just from a timer. Sorry for the confusion.
>
> So I've gone back to basics. Here is a branch containing what I believe
> should be all the patches required for the OMAP4 PMU:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/omap4
>
> I've omitted the SWSUSP patch since you say it breaks pm, which is clearly not
> acceptable.
>
> The problem is, trying to boot this on my pandaboard results in a hang (see
> dmesg below). Even worse, the problem isn't easily bisectable since rebuilding
> a working image can give you something that no longer boots and I haven't found
> a reliable way to cause the lockup.
>
> I'll take JTAG for a whirl to see where we are. If anything looks wrong in
> my dmesg, please shout (there are plenty of things in there that look like
> they've gone awry).

Not sure why it hangs for you, but it worked for me both with your
branch on v3.3 and merging with v3.4-rc1[1]

Below is a Kconfig snippet[2] which I append to my .config after
building omap2plus_defconfig in order to build a perf/trace/PMU enabled
kernel for my Panda.

Kevin

[1]
# perf stat sleep 1

 Performance counter stats for 'sleep 1':

          9.582520 task-clock                #    0.009 CPUs utilized          
                 1 context-switches          #    0.104 K/sec                  
                 0 CPU-migrations            #    0.000 K/sec                  
               147 page-faults               #    0.015 M/sec                  
           5096283 cycles                    #    0.532 GHz                    
            607876 stalled-cycles-frontend   #   11.93% frontend cycles idle   
           3285045 stalled-cycles-backend    #   64.46% backend  cycles idle   
           2722485 instructions              #    0.53  insns per cycle        
                                             #    1.21  stalled cycles per insn
            259247 branches                  #   27.054 M/sec                  
             84274 branch-misses             #   32.51% of all branches        

       1.015919088 seconds time elapsed


[2]
CONFIG_ARCH_OMAP2=n
CONFIG_ARCH_OMAP3=n       # need to disable OMAP3 for CPU_HAS_PMU support, needed for perf on OMAP4
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_NET_SMSC95XX=y

CONFIG_PROFILING=y
CONFIG_HW_PERF_EVENTS=y
CONFIG_PERF_EVENTS=y
CONFIG_PERF_COUNTERS=y
CONFIG_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_ENABLE_DEFAULT_TRACERS=y
CONFIG_STACK_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_EVENT_POWER_TRACING_DEPRECATED=n
