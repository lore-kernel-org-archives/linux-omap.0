From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Thu, 28 May 2015 17:17:30 +0100
Message-ID: <20150528161730.GE3657@e103592.cambridge.arm.com>
References: <20150527215545.GA30984@atomide.com>
 <7h7frtmzoh.fsf@deeprootsystems.com>
 <20150527225553.GC30984@atomide.com>
 <CANOLnOMYBFAr_t_tOs8ifo=ngtCrpyogtf_7hBDc4rmbC_-BQQ@mail.gmail.com>
 <20150528142125.GE30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:62657 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbbE1QRk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2015 12:17:40 -0400
In-Reply-To: <20150528142125.GE30984@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, tyler.baker@linaro.org, Stephen Boyd <sboyd@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 28, 2015 at 07:21:25AM -0700, Tony Lindgren wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [150528 04:45]:
> > On Thu, May 28, 2015 at 1:55 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > 8 <----------------------
> > > From: Tony Lindgren <tony@atomide.com>
> > > Date: Wed, 27 May 2015 15:33:57 -0700
> > > Subject: [PATCH] ARM: OMAP3: Fix booting with thumb2 kernel
> > >
> > > We get a NULL pointer dereference on omap3 for thumb2 compiled kernels:
> > >
> > > Internal error: Oops: 80000005 [#1] SMP THUMB2
> > > ...
> > > [<c046497b>] (_raw_spin_unlock_irqrestore) from [<c0024375>]
> > > (omap3_enter_idle_bm+0xc5/0x178)
> > > [<c0024375>] (omap3_enter_idle_bm) from [<c0374e63>]
> > > (cpuidle_enter_state+0x77/0x27c)
> > > [<c0374e63>] (cpuidle_enter_state) from [<c00627f1>]
> > > (cpu_startup_entry+0x155/0x23c)
> > > [<c00627f1>] (cpu_startup_entry) from [<c06b9a47>]
> > > (start_kernel+0x32f/0x338)
> > > [<c06b9a47>] (start_kernel) from [<8000807f>] (0x8000807f)
> > >
> > > The power management related assembly on moaps needs to interact with
> > 
> > moaps -> omaps
> 
> Thanks, fixed now. I also added a link for why ENDPROC is needed to the
> description. I'll apply the patch below into fixes today.
> 
> Regards,
> 
> Tony
> 
> 8< ----------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 27 May 2015 15:33:57 -0700
> Subject: [PATCH] ARM: OMAP3: Fix booting with thumb2 kernel
> 
> We get a NULL pointer dereference on omap3 for thumb2 compiled kernels:
> 
> Internal error: Oops: 80000005 [#1] SMP THUMB2
> ...
> [<c046497b>] (_raw_spin_unlock_irqrestore) from [<c0024375>]
> (omap3_enter_idle_bm+0xc5/0x178)
> [<c0024375>] (omap3_enter_idle_bm) from [<c0374e63>]
> (cpuidle_enter_state+0x77/0x27c)
> [<c0374e63>] (cpuidle_enter_state) from [<c00627f1>]
> (cpu_startup_entry+0x155/0x23c)
> [<c00627f1>] (cpu_startup_entry) from [<c06b9a47>]
> (start_kernel+0x32f/0x338)
> [<c06b9a47>] (start_kernel) from [<8000807f>] (0x8000807f)
> 
> The power management related assembly on omaps needs to interact with
> ARM mode bootrom code, so we need to keep most of the related assembly
> in ARM mode.
> 
> Turns out this error is because of missing ENDPROC for assembly code
> as suggested by Stephen Boyd <sboyd@codeaurora.org>. Let's add the
> missing ENDPROC in two places to sleep34xx.S, and also remove the
> earlier mystery code that was probably also caused by missing ENDPROC
> for earlier kernels.
> 
> The reason why ENDPROC makes a difference is it sets .type and then
> the compiler knows what to do with the thumb bit as explained at:
> 
> https://wiki.ubuntu.com/ARM/Thumb2PortingHowto
> 
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -203,23 +203,8 @@ save_context_wfi:
>  	 */
>  	ldr	r1, kernel_flush
>  	blx	r1
> -	/*
> -	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
> -	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
> -	 * This sequence switches back to ARM.  Note that .align may insert a
> -	 * nop: bx pc needs to be word-aligned in order to work.
> -	 */
> - THUMB(	.thumb		)
> - THUMB(	.align		)
> - THUMB(	bx	pc	)
> - THUMB(	nop		)
> -	.arm
> -

^ This looks unrelated to the issue?  This code is simply unnecessary
after Russell introduced the "ret" macro in commit 6ebbf2ce43.  That
made v7_flush_dcache_all do a proper interworking return.

It should probably be in a separate commit, or at least mentioned
explicitly in the commit log.


>  	b	omap3_do_wfi
> -
> -/*
> - * Local variables
> - */

^ Likewise this is just tidyup, not bug fixing.


> +ENDPROC(omap34xx_cpu_suspend)
>  omap3_do_wfi_sram_addr:
>  	.word omap3_do_wfi_sram
>  kernel_flush:
> @@ -364,10 +349,7 @@ exit_nonoff_modes:
>   * ===================================
>   */
>  	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
> -
> -/*
> - * Local variables
> - */
> +ENDPROC(omap3_do_wfi)

The ENDPROC()s look appropriate here.

[...]

Cheers
---Dave

