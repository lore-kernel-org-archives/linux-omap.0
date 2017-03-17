From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Fri, 17 Mar 2017 09:24:58 +0000
Message-ID: <20170317092458.GJ23750@n2100.armlinux.org.uk>
References: <20170313205231.1593-1-tony@atomide.com>
 <0bade322-5bee-412f-ef21-972c99846e84@ti.com>
 <20170314151725.GC20572@atomide.com>
 <d0fe191f-66f8-b72d-0a2a-00815e663a8d@ti.com>
 <20170314164106.GE20572@atomide.com>
 <ea09d676-29f6-7100-4c68-88920deaeb7c@ti.com>
 <20170314181425.GF20572@atomide.com>
 <20170315172200.GM20572@atomide.com>
 <20170316152925.GO20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170316152925.GO20572@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 16, 2017 at 08:29:25AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170315 10:24]:
> > * Tony Lindgren <tony@atomide.com> [170314 11:16]:
> > > * Andrew F. Davis <afd@ti.com> [170314 10:59]:
> > > Then onto the other related patches..
> > > 
> > > > We re-park cpu1 in bootROM in U-Boot already, in the U-Boot tree:
> > > > arch/arm/mach-omap2/omap5/sec_entry_cpu1.S
> > > 
> > > OK good to hear.
> > > 
> > > > omap_smc_sec_cpu1() wakes up cpu1 into the function cpu1_entry(), this
> > > > makes an SMC call to setup the core, then re-parks itself back in bootROM.
> > > > Relevant code to run on cpu1:
> > > > 
> > > > > #define AUX_CORE_BOOT_0		0x48281800
> > > > > #define AUX_CORE_BOOT_1		0x48281804
> > > > > /* DRA7xx ROM code function "startup_BootSlave". This function is where CPU1
> > > > >  * waits on WFE, polling on AUX_CORE_BOOT_x registers.
> > > > >  * This address is same for J6 and J6 Eco.
> > > > >  */
> > > > > #define ROM_FXN_STARTUP_BOOTSLAVE     0x00038a64
> > > > >
> > > > > ldr	r4, =AUX_CORE_BOOT_0
> > > > > mov	r5, #0x0
> > > > > str	r5, [r4]
> > > > > ldr	r4, =ROM_FXN_STARTUP_BOOTSLAVE
> > > > > bx	r4	@ Jump back to ROM
> > > > 
> > > > We would have to do this in kernel. The issue I'm thinking we are going
> > > > to hit is that the parking function in bootROM expects the MMU to be
> > > > off. Although we don't really need to turn it off as long as we can
> > > > identity map the bootROM area, the AUX_CORE_BOOT_0/1 space, and wherever
> > > > we plan to exit the parking loop.
> > > 
> > > Would be good to hear what Russell thinks we should do here to park
> > > CPU1.
> > 
> > How about we introduce smp_park_secondary()?
> > 
> > Then soft_restart() can call it between setup_mm_for_reboot()
> > and cpu_proc_fin()?
> 
> Hmm that probably won't help as we'd have to still have a 1:1
> mapping in cpu_die() to put CPU1 into WFI and release it in
> smp_park_secondary() to the bootrom.
> 
> Anyways, I think in your use case it's the suspend/resume that needs
> the state preserved for CPU1. Do you need kexec working in your use
> case?

I think you're trying way too hard and making this too complicated.  I
put forward my comments on it via email on Monday - is there a reason
why you can't follow my recommendations (which are exactly what Linux
expects) of the to-be-unplugged CPU?

Why do you need the CPU to spin in the kernel when you hot-unplug it?

Why can't you reset the CPU when it's died, possibly releasing the
reset again to get it into the boot rom (which is where it'll be at
boot time.)

To detect older kernels, you could write a magic identifier into the
boot address registers from a new kernel when taking the CPU offline.
(eg, the value it has at normal system boot.)  When you attempt to
bring CPUs online, check the value, if it isn't set correctly, assume
that the CPU has gone awol, and reset it as you're doing now.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
