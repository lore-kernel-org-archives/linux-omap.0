From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Sun, 29 Jan 2012 18:36:11 +0100
Message-ID: <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
References: <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
	<CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
	<20120127155454.GH2347@mudshark.cambridge.arm.com>
	<CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
	<20120127165941.GK2347@mudshark.cambridge.arm.com>
	<CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
	<20120127171009.GL2347@mudshark.cambridge.arm.com>
	<CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55629 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab2A2RgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jan 2012 12:36:12 -0500
Received: by vcbgb30 with SMTP id gb30so2205174vcb.19
        for <linux-omap@vger.kernel.org>; Sun, 29 Jan 2012 09:36:11 -0800 (PST)
In-Reply-To: <CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Ming Lei <ming.lei@canonical.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

Hi,

Ok, so I did a few more tests and there is a serious issue when sampling
in frequency mode (the default). I noticed wrong number of samples, so
I investigated this some more and instrumented the perf_event kernel code.
I found some erratic timer ticks causing broken period adjustments.

In fact, the problem is visible using top.
I am running a noploop program on CPU0 and nothing else besides top.
The noploop program  does: for(;;);. That is 100% user. On a 2-way
system otherwise idle, I expect top to return 50% user 50% idle.

Top with the commit:

top - 16:19:21 up 5 min,  1 user,  load average: 0.23, 0.15, 0.07
Tasks:  70 total,   2 running,  68 sleeping,   0 stopped,   0 zombie
Cpu(s): 31.1%us,  2.0%sy,  0.0%ni, 66.2%id,  0.0%wa,  0.0%hi,  0.7%si,  0.0%st
            ^^^^^^^^ That's WRONG

Mem:    940292k total,    74984k used,   865308k free,     8020k buffers
Swap:   524240k total,        0k used,   524240k free,    37420k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3770 eranian   20   0   644  160  128 R   99  0.0   0:14.21 noploop
 3771 eranian   20   0  2184 1052  804 R    2  0.1   0:00.32 top
    1 root      20   0  2564 1528  952 S    0  0.2   0:01.26 init


I removed that one liner patch from Ming. The one fiddling with the
clockdomains:

--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
        .prcm_partition   = OMAP4430_PRM_PARTITION,
        .cm_inst          = OMAP4430_PRM_EMU_CM_INST,
        .clkdm_offs       = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-       .flags            = CLKDM_CAN_HWSUP,
+       .flags            = CLKDM_CAN_SWSUP,


When I rerun, the test, it now work:

top - 16:02:51 up 15 min,  1 user,  load average: 1.02, 0.46, 0.21
Tasks:  70 total,   2 running,  68 sleeping,   0 stopped,   0 zombie
Cpu(s): 47.2%us,  1.0%sy,  0.0%ni, 50.8%id,  0.0%wa,  0.0%hi,  1.0%si,  0.0%st
           ^^^^^^^^ close enough (in it stabilize somehow around 49%
which is good)

Mem:    940292k total,    75288k used,   865004k free,     8004k buffers
Swap:   524240k total,        0k used,   524240k free,    37408k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3771 eranian   20   0   644  160  128 R  100  0.0   0:34.44 noploop

Although the patch fixes PMU interrupts, it breaks the timer tick logic somehow.
The perf problem is related to timer tick.

I am hoping that the tradeoff is not:
     PMU interrupts but broken timer ticks
vs.
    No PMU interrupts but working timer ticks


On Fri, Jan 27, 2012 at 6:16 PM, stephane eranian
<eranian@googlemail.com> wrote:
> On Fri, Jan 27, 2012 at 6:10 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Fri, Jan 27, 2012 at 05:03:28PM +0000, stephane eranian wrote:
>>> On Fri, Jan 27, 2012 at 5:59 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> > That said, if you see any bugs in the code please do shout!
>>> >
>>> I suspect there is something wrong, we shouldn't hit the max_rate_limit.
>>> You may have bursts of interrupts (samples). I'll check on that this week-end.
>>
>> Ok, thanks. Keep in mind that you probably have variable rate clocks, which
>> will affect the cycle counter frequency.
>>
> I assume it does not vary the clock if the workload is steady and just burning
> cycles, e.g.: for(;;);
>
>>> >> > A7 and A15 have the ability to filter counters based on privilege level, so
>>> >> > you can get more accurate userspace counts there.
>>> >>
>>> >> Ok, that's better. Need to update libpfm4 for A15 with priv levels then!
>>> >
>>> > How do you handle that in libpfm4? On ARM, the event encodings remain the same,
>>> > you just need to set some extra bits to determine which levels are included or
>>> > excluded (you can do this with the perf tool by using the :{u,k,h} suffix on an
>>> > event description).
>>> >
>>> It depends what you call the encoding? If the priv level can be encoded in the
>>> attr->config field, then that's easy. If it needs to be set somewhere else, then
>>> we need to figure out how you encode it in the attr struct. Either in some other
>>> bits in attr->config or use attr->config1, for instance. You tell me.
>>
>> The way it's done with perf is to set the exclude{user,kernel,hv} fields in
>> the attr. The ARM perf backend then translates these into the relevant bits
>> which get orred into the config_base before hitting the hardware.
>>
> Well, that's also how we do it with libpfm4 on X86. This is because
> with perf_events,
> the exclude_* fields have priority over what you set in the attr->config field.
>
>> Will
