From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Sun, 15 Apr 2018 15:08:34 +0100
Message-ID: <20180415140833.GH10990@n2100.armlinux.org.uk>
References: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
 <20180410134149.GQ5700@atomide.com>
 <685f80e3-30b3-8806-b81c-8de456507001@ti.com>
 <20180411125210.GF10990@n2100.armlinux.org.uk>
 <20180411141139.GU5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180411141139.GU5700@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 11, 2018 at 07:11:39AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180411 12:53]:
> > On Tue, Apr 10, 2018 at 05:12:37PM +0300, Tero Kristo wrote:
> > > On 10/04/18 16:41, Tony Lindgren wrote:
> > > >* Russell King <rmk+kernel@armlinux.org.uk> [180410 10:43]:
> > > >>diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> > > >>index 021b5a8b9c0a..d4ddc78b2a0b 100644
> > > >>--- a/arch/arm/mach-omap2/prm_common.c
> > > >>+++ b/arch/arm/mach-omap2/prm_common.c
> > > >>@@ -523,7 +523,7 @@ void omap_prm_reset_system(void)
> > > >>  	prm_ll_data->reset_system();
> > > >>  	while (1)
> > > >>-		cpu_relax();
> > > >>+		cpu_do_idle();
> > > >>  }
> > > >
> > > >Hmm we need to check so the added WFI here does not cause an
> > > >undesired change to a low power state. Adding Tero to Cc also.
> > > 
> > > Generally it is a bad idea to call arbitrary WFI within OMAP architecture,
> > > as this triggers a PRCM power transition and will most likely cause a hang
> > > if not controlled properly.
> > > 
> > > Has this patch been tested on any platform that supports proper power
> > > management?
> > 
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
> We already have code in the kernel (and in the bootrom) to "park" a
> cpu after starting. But using it without resetting the cpu would require
> 1-1 memory mapping or modifying the code. That is if we wanted to use
> the same code also for parking the cpus for kexec without resetting
> them.

In which case, how about using:

	while (1) {
		cpu_relax();
		wfe();
	}

instead - that appears to also have the desired effect, allowing kdump
to work on the SDP4430.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
