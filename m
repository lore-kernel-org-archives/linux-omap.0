From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: HYP Kernel boot requirements [Was ...Re: [PATCH 2/2] ARM:
 OMAP5: Add HYP mode entry support for secondary CPUs]
Date: Mon, 25 Nov 2013 17:28:25 +0000
Message-ID: <20131125172825.GD8396@arm.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
 <1385251666-27532-3-git-send-email-santosh.shilimkar@ti.com>
 <CAMJs5B8XX-93YcRyTiQ1JRcKUB5oer8cV7FLtMPP6SeqeB3RwQ@mail.gmail.com>
 <52937AB4.1060901@ti.com>
 <CAMJs5B9nnpqjSmT7vi9cvC4e9Fx2Bft4rRGxmVKyLP7JbGMPAg@mail.gmail.com>
 <529381E4.3090405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:52277 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755228Ab3KYR3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 12:29:42 -0500
Content-Disposition: inline
In-Reply-To: <529381E4.3090405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Tony Lindgren <tony@atomide.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Nov 25, 2013 at 04:59:16PM +0000, Santosh Shilimkar wrote:
> On Monday 25 November 2013 11:33 AM, Christoffer Dall wrote:
> > On 25 November 2013 08:28, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> >> On Monday 25 November 2013 10:09 AM, Christoffer Dall wrote:
> >>> On 23 November 2013 16:07, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> >>>> Boot-CPU entry into the HYP mode is managed in boot-loader but
> >>>> the secondary CPUs directly jumps to kernel during boot. Same
> >>>> path is also used for CPU hotplug as well during suspend for
> >>>> secondary CPU.
> >>>>
> >>>> Hence patch the secondary CPU boot path for hyp mode etry.
> >>>>
> >>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> >>>> Cc: Tony Lindgren <tony@atomide.com>
> >>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>> ---
> >>>>  arch/arm/mach-omap2/omap-headsmp.S |    7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
> >>>> index 75e9295..4844dd8 100644
> >>>> --- a/arch/arm/mach-omap2/omap-headsmp.S
> >>>> +++ b/arch/arm/mach-omap2/omap-headsmp.S
> >>>> @@ -22,6 +22,7 @@
> >>>>
> >>>>  /* Physical address needed since MMU not enabled yet on secondary core */
> >>>>  #define AUX_CORE_BOOT0_PA                      0x48281800
> >>>> +#define API_HYP_ENTRY                          0x102
> >>>>
> >>>>  /*
> >>>>   * OMAP5 specific entry point for secondary CPU to jump from ROM
> >>>> @@ -38,6 +39,12 @@ wait:        ldr     r2, =AUX_CORE_BOOT0_PA  @ read from AuxCoreBoot0
> >>>>         and     r4, r4, #0x0f
> >>>>         cmp     r0, r4
> >>>>         bne     wait
> >>>> +#ifdef CONFIG_KVM_ARM_HOST
> >>>> +       ldr     r12, =API_HYP_ENTRY
> >>>> +       adr     r0, hyp_boot
> >>>> +       smc     #0
> >>>> +hyp_boot:
> >>>> +#endif
> >>>>         b       secondary_startup
> >>>>  END(omap5_secondary_startup)
> >>>>  /*
> >>>
> >>> hmm, this means that currently running this in a guest will fail to
> >>> bring-up SMP, right?
> >>>
> >> Nope. Because the code under 'KVM_ARM_HOST' macro. Guest build
> >> will not enable CONFIG_KVM_ARM_HOST and things should be fine then.
> >> Right ?
> >>
> > 
> > That really goes against the whole single binary on all platforms
> > thing. With multi-platform support you really shouldn't have to
> > compile your kernel any differently for running as a guest as when
> > you're running on a host.  Someone may even emulate an OMAP5 in QEMU
> > and you'd certainly want your kvm-enabled kernel to run as both guest
> > and host.  After all, this is not a paravirtualization solution.
> 
> Fair enough.
> 
> >>> Couldn't you create a little wrapper-pen in U-Boot instead, which
> >>> replicates the omap boot protocol and takes care of the hyp-mode
> >>> startup there instead, keeping this completely out of the kernel?
> >>>
> >> Its not just booting but CPU hotplug also follows the same path
> >> so we need the mechanism in kernel to switch mode.
> >>
> >> In general, I think its important to consider the aspect with
> >> CPU PM. CPUs are not going to go through the boot-loaders in
> >> those paths and hence need of HYP entry in the kernel will
> >> be must.
> >>
> > I agree, and PSCI is the obvious only correct answer to this.
> > 
> > We have discussed this a bit earlier (I think Will Deacon brought this
> > up - cc'ed), but I don't think anyone had any bright ideas.
> > 
> > However, we broadly agreed on the fact that for KVM/hyp support, you
> > need to boot your kernel in that mode, and this is definitely pulling
> > in the wrong direction.
> 
> What I am saying is the platforms like OMAP5 already support PM in
> mainline kernel and we can't break that for KVM. Boot-loaders
> would be thrashed after boot so you need something which runs
> in Kernel or along with Kernel to have equivalent of hyp
> switching.
> 
> Am not challenging the agreed direction but we need to solve the
> PM problem as well before making "all CPU runs boot-loader for
> HYP kernels" as a must have. At least its is a change in boot
> strategy from existing kernels.

Of course I recommend PSCI which covers both hotplug and suspend ;), but
I guess it's not the case for OMAP5. Since OMAP has its own secondary
booting protocol and CPU hotplug re-entry, can you not just use
different entry point when the primary CPU was initially started in Hyp
mode (e.g. omap5_hyp_secondary_startup)?

-- 
Catalin
