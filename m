From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 11/15] ARM: OMAP5: PM: Add L2 memory power down support
Date: Mon, 4 Mar 2013 12:41:52 -0600
Message-ID: <20130304184152.GC14958@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-12-git-send-email-santosh.shilimkar@ti.com>
 <20130301234355.GC23856@kahuna>
 <51319B32.3070106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52583 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139Ab3CDSl6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 13:41:58 -0500
Content-Disposition: inline
In-Reply-To: <51319B32.3070106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 11:54-20130302, Santosh Shilimkar wrote:
> On Saturday 02 March 2013 05:13 AM, Nishanth Menon wrote:
> > On 17:41-20130301, Santosh Shilimkar wrote:
> >> When the entire MPUSS cluster is powered down in device off state, L2 cache
> >> memory looses it's content and hence while targetting such a state,
> >> l2 cache needs to be flushed to main memory.
> >>
> >> Add the necessary low power code support for the same.
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/omap-secure.h     |    1 +
> >>  arch/arm/mach-omap2/sleep_omap4plus.S |   30 ++++++++++++++++++++++++++++++
> >>  2 files changed, 31 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
> >> index 1739468..a171a5a 100644
> >> --- a/arch/arm/mach-omap2/omap-secure.h
> >> +++ b/arch/arm/mach-omap2/omap-secure.h
> >> @@ -47,6 +47,7 @@
> >>  #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
> >>  #define OMAP5_MON_CACHES_CLEAN_INDEX	0x103
> >>  #define OMAP5_MON_AUX_CTRL_INDEX	0x107
> >> +#define OMAP5_MON_L2AUX_CTRL_INDEX	0x104
> >>  
> >>  #define OMAP5_MON_AMBA_IF_INDEX		0x108
> >>  
> >> diff --git a/arch/arm/mach-omap2/sleep_omap4plus.S b/arch/arm/mach-omap2/sleep_omap4plus.S
> >> index f4874e5..ea318be 100644
> >> --- a/arch/arm/mach-omap2/sleep_omap4plus.S
> >> +++ b/arch/arm/mach-omap2/sleep_omap4plus.S
> >> @@ -386,6 +386,27 @@ skip_secure_l1_clean_op:
> >>  	isb
> >>  	dsb
> >>  
> >> +	bl	omap4_get_sar_ram_base
> >> +	mov	r8, r0
> >> +	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
> >> +	ands	r5, r5, #0x0f
> >> +	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]	@ Retrieve L2 state
> >> +	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
> >> +	cmp	r0, #3
> > umm, we store l2x0_pwrst_prepare(cpu, save_state);
> > which in turn stores into L2X0_SAVE_OFFSET - I am with you so far
> > save_state in omap4_enter_lowpower is:
> > PWRDM_POWER_INACTIVE: 0
> > PWRDM_POWER_OFF: 1
> > or 2 in the case of OSWR
> > what is 3? ref:
> > https://github.com/SantoshShilimkar/linux/blob/testing/3.10/omap5-int-rebuild/arch/arm/mach-omap2/omap-mpuss-lowpower.c#L298
> This was obviosly for the case where L2 can be destroyed. As I said it can happen
> with MPU OSWR + L2 OFF setting or device OFF. 
Then please use macros for this.
> 
> >> +	bne	do_wfi
> >> +	bl	omap4_get_sar_ram_base
> >> +	ldr	r9, [r0, #OMAP_TYPE_OFFSET]
> >> +	cmp	r9, #0x1			@ Check for HS device
> > my 2c:
> > off topic: somewhere down the line, I think we need to clear up these
> > into macros so that as in this case, omap4_mpuss_init populated value
> > should be the same as here with usage of same macro without reviewer
> > needing to track down where it was set with what.
> >
> Patches welcome :)
Sure as long as we don't add even more "magic handshakes to the code" it
makes sense to cleanup older code.
> 
>  
> >> +	bne	skip_secure_l2_clean_op
> >> +	mov	r0, #1				@ Clean secure L2
> >> +	stmfd   r13!, {r4-r12, r14}
> >> +	ldr	r12, =OMAP5_MON_CACHES_CLEAN_INDEX
> >> +	DO_SMC
> >> +	ldmfd   r13!, {r4-r12, r14}
> >> +skip_secure_l2_clean_op:
> >> +	mov	r0, #2				@ Flush L2
> > v7_flush_dcache_all does not take parameters, right?
> >> +	bl	v7_flush_dcache_all
> >> +
> >>  do_wfi:
> >>  	bl	omap_do_wfi
> >>  
> >> @@ -427,6 +448,15 @@ ENTRY(omap5_cpu_resume)
> >>  	dsb
> >>  1:
> >>  #endif
> >> +	mrc	p15, 1, r0, c15, c0, 0		@ Read L2 ACTLR
> >> +	cmp	r0, #0x118			@ Check if it is already set
> > 
> >> 	beq	skip_sec_l2
> >> +	ldr	r0, =0x118			@ Setup L2 ACTLR = 0x118
> >> +	ldr	r12, =OMAP5_MON_L2AUX_CTRL_INDEX
> > I hope I am looking at the right place:
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0438g/BABIAICD.html
> It is correct.
> 
> > 
> > Is'nt it better to configure on boot, save it into SAR memory and restore it
> > from SAR using monitor call? I mean it is possible that we start boot
> > with L2 ACTLR != 0x118 and then hit off and come out of OFF mode with
> > 0x118.
> No need because it is more of re-initing the value rather than save/restore.
> I should have used macro instead of value though.
> 
> btw. I might drop this special setting based on some experiments am doing
> with benchmarks. Either case, if I keep the L2AUX code, I will use
> a macro.
Thanks. As long as it remains constant at boot and across OFF, it is
fine with me.

-- 
Regards,
Nishanth Menon
