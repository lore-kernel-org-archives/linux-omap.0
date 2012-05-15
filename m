From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5 3/8] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX gic control register change
Date: Tue, 15 May 2012 14:44:49 -0700
Message-ID: <87zk99ce5q.fsf@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
 <1336989796-26594-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1336989796-26594-4-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Mon, 14 May 2012 13:03:11 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Santosh,

Tero Kristo <t-kristo@ti.com> writes:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> GIC distributor control register has changed between CortexA9 r1pX and
> r2pX. The Control Register secure banked version is now composed of 2
> bits:
>      bit 0 == Secure Enable
>      bit 1 == Non-Secure Enable
> The Non-Secure banked register has not changed. 

For those without the r1pX TRM handy, please include what this look like
before (presumably 1 bit?)  The changelog and in-code comments should
both be enhanced.

> Since the ROM Code is based on the r1pX GIC, the CPU1 GIC restoration
> will cause a problem to CPU0 Non-Secure SW.

Please describe the problem, so we can better understand the specifics
of the workaround.

Also, is there an erratum number for this?

> The workaround must be:
>      1) Before doing the CPU1 wakeup, CPU0 must disable
>         the GIC distributor
>      2) CPU1 must re-enable the GIC distributor on
>         it's wakeup path.

Again, because the problem was not described, I am not entirely sure why
the workaround "must" be this, and how it fixes the problem.  Remember
to put yourself in the shoes of a reviewer who has not been deeply
involved in the code, so what seems obvious to you will not be obvious
to the reviewer without having to study the code and dig in to the TRMs.

> With this procedure, the GIC configuration done between the
> CPU0 wakeup and CPU1 wakeup will not be lost but during this
> short windows, the CPU0 will not receive interrupts

Hmm, so I guess this means that CPU0 always has to wakeup first, even on GP
devices? 

Also, the changelog doesn't describe what power states this affects, and
whether it's an idle problem or just a supend problem.  A quick glance
at the code suggests that only suspend is being addressed by this patch.
However, with the addition of coupled CPUidle (coming very soon now),
won't we have this same problem in idle?  IMO, this patch should address
both.

This workaround also assumes that you always want CPU1 to wakeup
immediately after CPU0.  I guess that will be the case for the coupled
states that would be affected by this bug, but the changelog should
describe that as well

Some minor comments below...

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/common.h              |    2 +
>  arch/arm/mach-omap2/omap-headsmp.S        |   36 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |    9 ++++++-
>  arch/arm/mach-omap2/omap-smp.c            |   28 +++++++++++++++++++++-
>  arch/arm/mach-omap2/omap4-common.c        |    8 +++++-
>  5 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 57da7f4..48d1ebe 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -199,6 +199,7 @@ static inline void __iomem *omap4_get_scu_base(void)
>  #endif
>  
>  extern void __init gic_init_irq(void);
> +extern void gic_dist_disable(void);
>  extern void omap_smc1(u32 fn, u32 arg);
>  extern void __iomem *omap4_get_sar_ram_base(void);
>  extern void omap_do_wfi(void);
> @@ -206,6 +207,7 @@ extern void omap_do_wfi(void);
>  #ifdef CONFIG_SMP
>  /* Needed for secondary core boot */
>  extern void omap_secondary_startup(void);
> +extern void omap_secondary_startup_4460(void);
>  extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
>  extern void omap_auxcoreboot_addr(u32 cpu_addr);
>  extern u32 omap_read_auxcoreboot0(void);
> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
> index 503ac77..d602555 100644
> --- a/arch/arm/mach-omap2/omap-headsmp.S
> +++ b/arch/arm/mach-omap2/omap-headsmp.S
> @@ -43,3 +43,39 @@ hold:	ldr	r12,=0x103
>  	b	secondary_startup
>  ENDPROC(omap_secondary_startup)
>  
> +ENTRY(omap_secondary_startup_4460)
> +hold_2:	ldr	r12,=0x103
> +	dsb
> +	smc	#0			@ read from AuxCoreBoot0
> +	mov	r0, r0, lsr #9
> +	mrc	p15, 0, r4, c0, c0, 5
> +	and	r4, r4, #0x0f
> +	cmp	r0, r4
> +	bne	hold_2
> +
> +	/*
> +	 * GIC distributor control register has changed between
> +	 * CortexA9 r1pX and r2pX. The Control Register secure
> +	 * banked version is now composed of 2 bits:
> +	 * bit 0 == Secure Enable
> +	 * bit 1 == Non-Secure Enable
> +	 * The Non-Secure banked register has not changed
> +	 * Because the ROM Code is based on the r1pX GIC, the CPU1
> +	 * GIC restoration will cause a problem to CPU0 Non-Secure SW.
> +	 * The workaround must be:
> +	 * 1) Before doing the CPU1 wakeup, CPU0 must disable
> +	 * the GIC distributor
> +	 * 2) CPU1 must re-enable the GIC distributor on
> +	 * it's wakeup path.
> +	 */
> +	ldr	r1, =0x48241000

Why not OMAP44XX_GIC_DIST_BASE for readability sake?

> +	ldr	r0, [r1]
> +	orr	r0, #1
> +	str	r0, [r1]
> +
> +	/*
> +	 * we've been released from the wait loop,secondary_stack
> +	 * should now contain the SVC stack for this core
> +	 */
> +	b	secondary_startup
> +ENDPROC(omap_secondary_startup_4460)
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index 13670aa..e02c082 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -68,6 +68,7 @@ struct omap4_cpu_pm_info {
>  	void __iomem *scu_sar_addr;
>  	void __iomem *wkup_sar_addr;
>  	void __iomem *l2x0_sar_addr;
> +	void (*secondary_startup)(void);
>  };
>  
>  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
> @@ -300,6 +301,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>  int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>  {
>  	unsigned int cpu_state = 0;
> +	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
>  
>  	if (omap_rev() == OMAP4430_REV_ES1_0)
>  		return -ENXIO;
> @@ -309,7 +311,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>  
>  	clear_cpu_prev_pwrst(cpu);
>  	set_cpu_next_pwrst(cpu, power_state);
> -	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_secondary_startup));
> +	set_cpu_wakeup_addr(cpu, virt_to_phys(pm_info->secondary_startup));
>  	scu_pwrst_prepare(cpu, power_state);
>  
>  	/*
> @@ -360,6 +362,11 @@ int __init omap4_mpuss_init(void)
>  	pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
>  	pm_info->wkup_sar_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
>  	pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
> +	if (cpu_is_omap446x())
> +		pm_info->secondary_startup = omap_secondary_startup_4460;
> +	else
> +		pm_info->secondary_startup = omap_secondary_startup;

Does this exist on 4470 too?

Using a PM erratum check here instead of cpu_is* would make this more
scalable.  

Same comment for the cpu_is* check in wakeup_secondary()

Then, where the erratum is defined, it should state clearly why this
affects 446x and not before (presumably because 4430 has r1pX and 4460
has r2pX.)

>  	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
>  	if (!pm_info->pwrdm) {
>  		pr_err("Lookup failed for CPU1 pwrdm\n");
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index deffbf1..c3eb9e8 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -33,6 +33,7 @@
>  
>  /* SCU base address */
>  static void __iomem *scu_base;
> +bool omap4_smp_romcode_errata;

static?

Kevin
