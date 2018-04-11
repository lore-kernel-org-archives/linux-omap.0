From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Wed, 11 Apr 2018 14:10:12 +0100
Message-ID: <20180411131011.GG10990@n2100.armlinux.org.uk>
References: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
 <20180410134149.GQ5700@atomide.com>
 <685f80e3-30b3-8806-b81c-8de456507001@ti.com>
 <20180411125210.GF10990@n2100.armlinux.org.uk>
 <5985b6df-d19c-c30e-1044-466ee388e74e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5985b6df-d19c-c30e-1044-466ee388e74e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 11, 2018 at 06:29:21PM +0530, Keerthy wrote:
> On Wednesday 11 April 2018 06:22 PM, Russell King - ARM Linux wrote:
> > That will also go for the other locations in this patch too, as they
> > are all callable on _any_ platform.
> > 
> > It sounds like we need to abstract this so that platforms where "wfi"
> > is complex can handle the "spin on this CPU forever" appropriately.
> > 
> > While we could use dsb, we're asking a CPU to indefinitely spin in a
> > tight loop, which isn't going to be good for power consumption - what
> > if we have three CPUs doing that, could it push a SoC over the thermal
> > limits?  I don't think that's a question we can confidently answer
> > except for specific SoCs.
> 
> Yes. If the ondemand governor detects that CPU was busy greater than
> 80% of the time it bumps to the highest OPP and can lead to higher
> temperatures though CPU might not be doing anything useful.

That probably wouldn't happen - all these paths are concerned with
stopping CPUs doing something as a result of either a panic, a crash
or a failed attempt to reset the system.

We'd enter them in whatever operating state the system was in at the
time, which is indeterminant.  What we can be relatively sure about
is that no further operating state transitions will occur.

For example, in the case of a crash with kexec and a crashdump kernel
loaded, the non-crashing CPUs end up in machine_crash_nonpanic_core().
Should kexec fail, then the system stops leaving all but one CPU
spinning in that function in whatever operating state they were in,
which could be the highest OPP.

This means that, for example, in the case of a four CPU system, three
CPUs will be spinning hard on whatever instructions we have there,
while one CPU is trying to perform cache operations to prepare to boot
the crashdump kernel.

For a panic, it's very similar - the CPUs which didn't call panic()
are directed to ipi_cpu_stop() where they spin.  By default, a panic()
halts the panicing CPU and nothing further happens, so the other CPUs
will endlessly spin in the same way as above.  The panicing CPU may
be waiting for the panic timeout to expire before trying to reboot the
system.

The OMAP reset case is slightly different, because that's a case of
failure-to-reboot - combine that with a panic timeout, and you can end
up with _all_ CPUs in the system indefinitely spinning hard in a tight
loop.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
