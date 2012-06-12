From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Tue, 12 Jun 2012 17:41:27 -0500
Message-ID: <4FD7C597.7060501@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
 <20120608094708.GC19062@mudshark.cambridge.arm.com> <4FD21930.4000800@ti.com>
 <20120611173930.GD28235@mudshark.cambridge.arm.com> <4FD64083.3020800@ti.com>
 <20120612092842.GA2991@mudshark.cambridge.arm.com> <4FD7B1DC.30108@ti.com>
 <20120612213150.GC24380@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120612213150.GC24380@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


On 06/12/2012 04:31 PM, Will Deacon wrote:
> On Tue, Jun 12, 2012 at 10:17:16PM +0100, Jon Hunter wrote:
>> Hi Will,
> 
> Hi Jon,
> 
>> On 06/12/2012 04:28 AM, Will Deacon wrote:
>>>
>>> Well, I tried that and the results are pretty whacky: the event counters do
>>> indeed tick but interrupts only fire if I pin the perf task to CPU1! What's
>>> more, the interrupts do fire on both cores when they're working...
>>
>> I tried this, and I see that interrupts occur on both, however, it seems
>> that the majority occur on one CPU and only a few on the other. So it
>> does appear that one CPU is getting a lot more interrupts.
> 
> That's understandable -- one of the CPUs is likely more loaded than the
> other. However, I'd like to confirm whether or not you see what I see. With
> the 4430_init hack on a 4460, if I run:
> 
> # taskset 0x2 perf top
> 
> then I get no samples. If I do:
> 
> # taskset 0x1 perf top
> 
> then I *do* get samples and from *both* CPUs. So it smells more like an
> issue poking some configuration registers from CPU1 rather than the IRQ
> path being broken. As I said before, if I don't do the extra init hack
> then I don't get this problem (but event counters don't tick).

In both cases, I see interrupts on both CPUs. However, typically more on
the CPU that perf is running on (which is probably to be expected). And
I confirm that the only change I made was ...

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index f90d958..042881b 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -286,7 +286,7 @@ static int __init omap_init_pmu(void)
         * interrupts and so the CTI IRQs are used and this requires
additional
         * sub-systems to be enabled.
         */
-       if (cpu_is_omap443x())
+       if (cpu_is_omap44xx())
                r = omap4430_init_pmu();
        else


When you boot the kernel what 4460 rev does it show (very early in the
kernel boot log)? Mine shows ...

[    0.000000] OMAP4460 ES1.1

However, the A9 version has not changed between ES1.0 and ES1.1. Both
should be r2p10.

>> From a PMU programming standpoint, if we just use "perf top" are the
>> event counters not used/programmed?
> 
> Just using perf top should use the cycle counter as the event source.

Ok, so no event counters are used.

>> And when we use "perf top -e instructions" is it the "software
>> increment" event that the event counter(s) are monitoring? I am just
>> trying to understand how the counters are being programmed and then I
>> can ask the design folks an intelligent question :-)
> 
> It depends on the CPU. For Cortex-A9, `instructions' maps to event 0x68,
> which isn't a perfect match. If you want to specify a hex value for the
> event code, you can do:
> 
> # perf top -e rNN
> 
> where NN is the hex event number. On A9, r11 would give you cycles via
> an event counter.

Ok, thanks.

>> By the way, I don't suppose there is any debugfs entry to dump the PMU
>> registers?
> 
> 'fraid not, but there is some debug code in perf_event_v7.c that you
> could call if you wanted to (just #define DEBUG at the top of the file).

Thanks
Jon
