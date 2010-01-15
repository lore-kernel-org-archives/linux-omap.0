From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Fri, 15 Jan 2010 16:25:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB7F9@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D798A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43107 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab0AOKzP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 05:55:15 -0500
In-Reply-To: <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Paul

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, January 13, 2010 11:30 PM
> To: Reddy, Teerth
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Kevin Hilman
> Subject: Re: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR
> stall in SDRC after a Warm-reset
> 
> Some more comments.
> 
> On Wed, 13 Jan 2010, Reddy, Teerth wrote:
> 
> > From: Teerth Reddy <teerth@ti.com>
> >
> > This patch has the workaround for errata 1.176.
> > In some cases, user is not able to access DDR memory after
> > warm-reset.This situation occurs while the warm-reset
> > happens during a read access to DDR memory. In that
> > particular conditions, DDR memory does not respond to a
> > corrupted read command due to the warm reset occurence but
> > SDRC is waiting for read completion.SDRC is not sensitive to
> > the warm reset, but the interconect is reset on the fly,
> > thus causing a misalignment between SDRC logic, interconect
> > logic and DDR memory state.
> >
> > Root cause description: A corrupted read transaction is
> > issued to a closed row: (address0, bank0) instead of the
> > expected read access, violating protocol.
> >
> > Failure signature: Once the failure occurs and system has
> > restarted, memory content is not accessible.SDRC registers
> > can be accessed successfully, until 1st access to memory
> > location is performed. After 1st access to memory is done,
> > SDRC is stuck.
> >
> > WORKAROUND
> > Steps to perform before a SW reset is trigged, if user needs
> > to generate a SW reset and keep DDR memory content:
> > 1. Enable self-refresh on idle request
> > 2. Put SDRC in idle
> > 3. Wait until SDRC goes to idle
> > 4. Generate SW reset
> >
> > Steps to perform after warm reset occurs:
> > If HW warm reset is the source, apply below steps before
> > any accesses to SDRAM:
> > 1. Reset SMS and SDRC
> > 2. Re-initialize SMS, SDRC and memory
> >
> > This would need the u-boot/x-loader workaround changes
> > as well for the reboot to work correctly.
> >
> > Signed-off-by: Teerth Reddy <teerth@ti.com>
> > ---
> >  arch/arm/mach-omap2/prcm.c             |    9 +++--
> >  arch/arm/mach-omap2/sram34xx.S         |   50
> ++++++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/sram.h |    7 ++++
> >  arch/arm/plat-omap/sram.c              |   19 ++++++++++++
> >  4 files changed, 81 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> > index 3ea8177..d66711e 100644
> > --- a/arch/arm/mach-omap2/prcm.c
> > +++ b/arch/arm/mach-omap2/prcm.c
> > @@ -26,6 +26,7 @@
> >  #include <plat/prcm.h>
> >  #include <plat/irqs.h>
> >  #include <plat/control.h>
> > +#include <plat/sram.h>
> >
> >  #include "clock.h"
> >  #include "cm.h"
> > @@ -134,9 +135,10 @@ void omap_prcm_arch_reset(char mode)
> >  	s16 prcm_offs;
> >  	omap2_clk_prepare_for_reboot();
> >
> > -	if (cpu_is_omap24xx())
> > +	if (cpu_is_omap24xx()) {
> >  		prcm_offs = WKUP_MOD;
> > -	else if (cpu_is_omap34xx()) {
> > +		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
> > +	} else if (cpu_is_omap34xx()) {
> >  		u32 l;
> >
> >  		prcm_offs = OMAP3430_GR_MOD;
> > @@ -147,10 +149,9 @@ void omap_prcm_arch_reset(char mode)
> >  		 * cf. OMAP34xx TRM, Initialization / Software Booting
> >  		 * Configuration. */
> >  		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
> > +		omap3_warmreset();
> 
> Please add a comment to indicate that this function does not return.
 Ok..


> >  	} else
> >  		WARN_ON(1);
> > -
> > -	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
> >  }
> >
> >  static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16
> reg)
> > diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-
> omap2/sram34xx.S
> > index de99ba2..6a425ca 100644
> > --- a/arch/arm/mach-omap2/sram34xx.S
> > +++ b/arch/arm/mach-omap2/sram34xx.S
> > @@ -33,6 +33,8 @@
> >
> >  #include "sdrc.h"
> >  #include "cm.h"
> > +#include "prcm-common.h"
> > +#include "prm.h"
> >
> >  	.text
> >
> > @@ -68,6 +70,9 @@
> >  /* CM_CLKSEL1_PLL bit settings */
> >  #define CORE_DPLL_CLKOUT_DIV_SHIFT	0x1b
> >
> > +/* PRM_RSTCTRL bit setting */
> > +#define EN_DPLL3_RESET                  0x4
> > +
> >  /*
> >   * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
> >   *
> > @@ -313,3 +318,48 @@ core_m2_mask_val:
> >  ENTRY(omap3_sram_configure_core_dpll_sz)
> >  	.word	. - omap3_sram_configure_core_dpll
> >
> > +
> > +/* omap3_sram_warmreset -
> > + *
> > + * Enable SDRC self refresh on idle request, put SDRC in idle,
> > + * wait until SDRC goes to idle
> > + * Enable DPLL3 reset bit in RM_RSTCTRL
> > + */
> 
> This multi-line comment needs to be fixed to conform with CodingStyle as
> mentioned in my previous comments.
 I think the issue is with my mailer here. I had fixed this.

> 
> 
> > +
> > +ENTRY(omap3_sram_warmreset)
> > +sdram_in_selfrefresh1:
> > +	ldr	r11, omap3_sdrc_power1  @ read the SDRC_POWER register
> > +	ldr	r12, [r11]              @ read the contents of SDRC_POWER
> > +	mov	r9, r12                 @ keep a copy of SDRC_POWER bits
> > +	orr	r12, r12, #SRFRONIDLEREQ_MASK   @ enable self refresh on idle
> > +	str	r12, [r11]              @ write back to SDRC_POWER register
> > +	ldr	r12, [r11]              @ posted-write barrier for SDRC
> > +	ldr	r11, omap3_cm_iclken1_core1     @ read the CM_ICLKEN1_CORE reg
> > +	ldr	r12, [r11]
> > +	bic	r12, r12, #EN_SDRC_MASK         @ disable iclk bit for SDRC
> > +	str	r12, [r11]
> > +wait_sdrc_idle2:
> > +	ldr	r11, omap3_cm_idlest1_core1
> > +	ldr	r12, [r11]
> > +	and	r12, r12, #ST_SDRC_MASK         @ check for SDRC idle
> > +	cmp	r12, #ST_SDRC_MASK
> > +	bne	wait_sdrc_idle2
> > +osw_warm_reset:
> > +	ldr	r11, omap3_reset_cntrl
> > +	ldr	r12, [r11]
> > +	orr	r12, r12, #EN_DPLL3_RESET       @ Enable DPLL3 reset bit
> > +	str	r12, [r11]
> > +osw_loop:
> > +	b	osw_loop
> > +
> > +omap3_reset_cntrl:
> > +	.word OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, RM_RSTCTRL)
> > +omap3_sdrc_power1:
> > +	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> > +omap3_cm_idlest1_core1:
> > +	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
> > +omap3_cm_iclken1_core1:
> > +	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
> > +
> > +ENTRY(omap3_sram_warmreset_sz)
> > +	.word   . - omap3_sram_warmreset
> > diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-
> omap/include/plat/sram.h
> > index 16a1b45..2393cbe 100644
> > --- a/arch/arm/plat-omap/include/plat/sram.h
> > +++ b/arch/arm/plat-omap/include/plat/sram.h
> > @@ -27,6 +27,9 @@ extern u32 omap3_configure_core_dpll(
> >  			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
> >  			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
> >  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
> > +
> > +extern u32 omap3_warmreset(void);
> 
> This should be named 'omap3_sram_warmreset' to conform with the naming
> style used by the rest of the file.
There are 2 functions 
omap3_warmreset(void) and
omap3_sram_warmreset(void) which is declared below...

> 
> > +
> >  extern void omap3_sram_restore_context(void);
> >
> >  /* Do not use these */
> > @@ -69,6 +72,10 @@ extern u32 omap3_sram_configure_core_dpll(
> >  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
> >  extern unsigned long omap3_sram_configure_core_dpll_sz;
> >
> > +extern u32 omap3_sram_warmreset(void);
> > +
> > +extern unsigned long omap3_sram_warmreset_sz;
> > +
> >  #ifdef CONFIG_PM
> >  extern void omap_push_sram_idle(void);
> >  #else
> > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > index d8d5094..722154b 100644
> > --- a/arch/arm/plat-omap/sram.c
> > +++ b/arch/arm/plat-omap/sram.c
> > @@ -410,6 +410,16 @@ u32 omap3_configure_core_dpll(u32 m2, u32
> unlock_dll, u32 f, u32 inc,
> >  			sdrc_actim_ctrl_b_1, sdrc_mr_1);
> >  }
> >
> > +/* Function for SDRC config for warm reset */
> > +static u32 (*_omap3_sram_warmreset)(void);
> > +
> > +u32 omap3_warmreset()
> 
> See above re: naming style.
Same as above

> 
> > +{
> > +	WARN_ON(!_omap3_sram_warmreset);
> > +
> > +	return _omap3_sram_warmreset();
> > +}
> 
> What value is this function supposed to return?  Again from my previous
> comments, this function has no return value.  In fact it never returns at
> all.  So this should not be marked as returning u32.
Will make both the functions as void.

> 
> > +
> >  #ifdef CONFIG_PM
> >  void omap3_sram_restore_context(void)
> >  {
> > @@ -418,6 +428,10 @@ void omap3_sram_restore_context(void)
> >  	_omap3_sram_configure_core_dpll =
> >  		omap_sram_push(omap3_sram_configure_core_dpll,
> >  			       omap3_sram_configure_core_dpll_sz);
> > +	_omap3_sram_warmreset =
> > +	omap_sram_push(omap3_sram_warmreset,
> > +		       omap3_sram_warmreset_sz);
> 
> Please fix the indent level on the above lines to ensure they are indented
> past the start of the LHS of the expression.
Will fix this.
> > +
> >  	omap_push_sram_idle();
> >  }
> >  #endif /* CONFIG_PM */
> > @@ -427,6 +441,11 @@ int __init omap34xx_sram_init(void)
> >  	_omap3_sram_configure_core_dpll =
> >  		omap_sram_push(omap3_sram_configure_core_dpll,
> >  			       omap3_sram_configure_core_dpll_sz);
> > +
> > +	_omap3_sram_warmreset =
> > +	omap_sram_push(omap3_sram_warmreset,
> > +		       omap3_sram_warmreset_sz);
> 
> Please fix the indent level on the above lines to ensure they are indented
> past the start of the LHS of the expression.
Will fix this.
> 
> > +
> >  	omap_push_sram_idle();
> >  	return 0;
> >  }
> >
> 
> 
> - Paul

Will send the updated patch.

Thanks
Teerth
