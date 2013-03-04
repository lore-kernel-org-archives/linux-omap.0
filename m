From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 05/15] ARM: OMAP5: PM: Enables ES2 PM mode by default
Date: Mon, 4 Mar 2013 12:29:21 -0600
Message-ID: <20130304182921.GC14860@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-6-git-send-email-santosh.shilimkar@ti.com>
 <20130301193745.GA22626@kahuna>
 <51319273.5090703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51359 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126Ab3CDS32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 13:29:28 -0500
Content-Disposition: inline
In-Reply-To: <51319273.5090703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 11:17-20130302, Santosh Shilimkar wrote:
> On Saturday 02 March 2013 01:07 AM, Nishanth Menon wrote:
> > On 17:40-20130301, Santosh Shilimkar wrote:
> >> Enables MPUSS ES2 power management mode using ES2_PM_MODE in
> >> AMBA_IF_MODE register.
> >>
> >> 0x0: ES1 behavior, CPU cores would enter and exit OFF mode together. Broken
> >> 0x1: ES2 behavior, CPU cores are allowed to enter/exit OFF mode independently.
> >>
> >> This is one time settings thanks to always ON domain.
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/omap-secure.h    |    2 ++
> >>  arch/arm/mach-omap2/omap-wakeupgen.c |   14 ++++++++++++++
> >>  arch/arm/mach-omap2/omap-wakeupgen.h |    1 +
> >>  3 files changed, 17 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
> >> index 0e72917..82b3c4c 100644
> >> --- a/arch/arm/mach-omap2/omap-secure.h
> >> +++ b/arch/arm/mach-omap2/omap-secure.h
> >> @@ -42,6 +42,8 @@
> >>  #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
> >>  #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
> >>  
> >> +#define OMAP5_MON_AMBA_IF_INDEX		0x108
> >> +
> >>  /* Secure PPA(Primary Protected Application) APIs */
> >>  #define OMAP4_PPA_L2_POR_INDEX		0x23
> >>  #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
> >> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> >> index 5d3b4f4..a7350dd 100644
> >> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> >> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> >> @@ -403,6 +403,7 @@ int __init omap_wakeupgen_init(void)
> >>  {
> >>  	int i;
> >>  	unsigned int boot_cpu = smp_processor_id();
> >> +	u32 val;
> >>  
> >>  	/* Not supported on OMAP4 ES1.0 silicon */
> >>  	if (omap_rev() == OMAP4430_REV_ES1_0) {
> >> @@ -444,6 +445,19 @@ int __init omap_wakeupgen_init(void)
> >>  	for (i = 0; i < max_irqs; i++)
> >>  		irq_target_cpu[i] = boot_cpu;
> >>  
> >> +	/*
> >> +	 * Enables OMAP5 ES2 PM Mode using ES2_PM_MODE in AMBA_IF_MODE
> >> +	 * 0x0:	ES1 behavior, CPU cores would enter and exit OFF mode together.
> >> +	 * 0x1:	ES2 behavior, CPU cores are allowed to enter/exit OFF mode
> >> +	 * independently.
> >> +	 * This needs to be set one time thanks to always ON domain.
> >> +	 */
> >> +	if (soc_is_omap54xx()) {
> >> +		val = __raw_readl(wakeupgen_base + OMAP_AMBA_IF_MODE);
> >> +		val |= BIT(5);
> > BIT(5) is ES2_PM_MODE for es2.0 only - we dont have a OMAP5 revision check atm.
> > maybe 
OK on ES1.0 bit from previous discussion. I still suggest having a macro for
BIT(5) instead of having to review TRM to ensure this is right.
> >> +		omap_smc1(OMAP5_MON_AMBA_IF_INDEX, val);
> >> +	}
> >> +
> >>  	irq_hotplug_init();
> >>  	irq_pm_init();
> >>  
> >> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.h b/arch/arm/mach-omap2/omap-wakeupgen.h
> >> index b0fd16f..b3c8ecc 100644
> >> --- a/arch/arm/mach-omap2/omap-wakeupgen.h
> >> +++ b/arch/arm/mach-omap2/omap-wakeupgen.h
> >> @@ -27,6 +27,7 @@
> >>  #define OMAP_WKG_ENB_E_1			0x420
> >>  #define OMAP_AUX_CORE_BOOT_0			0x800
> >>  #define OMAP_AUX_CORE_BOOT_1			0x804
> >> +#define OMAP_AMBA_IF_MODE			0x80c
> >>  #define OMAP_PTMSYNCREQ_MASK			0xc00
> >>  #define OMAP_PTMSYNCREQ_EN			0xc04
> >>  #define OMAP_TIMESTAMPCYCLELO			0xc08
> > 
> > Curious, I see OMAP5_AMBA_IF_MODE_OFFSET in
> > arch/arm/mach-omap2/omap4-sar-layout.h
> > if we dont save new modified contents there, Wont restore logic just
> > reset it back to 0?
> > 
> It is already restored in the wakeup-gen restore code.
I apologize, I do not see it in:
https://github.com/SantoshShilimkar/linux/blob/testing/3.10/omap5-int-rebuild/arch/arm/mach-omap2/omap-wakeupgen.c
I might have expected an save of val to sar offset to ensure this is
done, but since you indicate this is in wakeupgen restore logic, which I
presume is done by ROM, we might expect an write to sar_base +
OMAP5_AMBA_IF_MODE_OFFSET with the val for it to function?

-- 
Regards,
Nishanth Menon
