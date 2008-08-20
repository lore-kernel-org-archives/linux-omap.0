From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/16] ARM: OMAP2: Split sleep.S into sleep242x.S and
	sleep243x.S
Date: Wed, 20 Aug 2008 10:36:18 +0300
Message-ID: <20080820073617.GC28862@atomide.com>
References: <1212804762-18413-1-git-send-email-tony@atomide.com> <20080819170311.GB17034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65197 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbYHTHg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 03:36:27 -0400
Content-Disposition: inline
In-Reply-To: <20080819170311.GB17034@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080819 20:03]:
> On Fri, Jun 06, 2008 at 07:12:28PM -0700, Tony Lindgren wrote:
> > Some register offsets are different for 242x and 243x. This
> > will allow compiling sleep code for both chips into the same
> > kernel.
> > 
> > Note that some PM patches are still missing. The PM patches will
> > be added later on once the base files are in sync with linux-omap
> > tree.
> 
> Please use git diff -M, since it makes the changes across renames more
> obvious.

OK

> > +ENTRY(omap242x_idle_loop_suspend)
> > +	stmfd	sp!, {r0, lr}		@ save registers on stack
> > +	mov	r0, #0x0		@ clear for mrc call
> > +	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
> > +	ldmfd	sp!, {r0, pc}		@ restore regs and return
> 
> What's been lost because of the lack of git diff -M here is the real
> change:
> 
> -ENTRY(omap24xx_idle_loop_suspend)
> +ENTRY(omap242x_idle_loop_suspend)
>  	stmfd	sp!, {r0, lr}		@ save registers on stack
> -	mov	r0, #0			@ clear for mcr setup
> +	mov	r0, #0x0		@ clear for mrc call
>  	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
>  	ldmfd	sp!, {r0, pc}		@ restore regs and return
> 
> which makes the problem stand out.  That change of the 'mov' line
> along with the comment is completely bogus.  In fact, the change to
> the comment is clearly wrong.  The same applies to sleep243x.S

Will remove.

> Realistically, the only real difference between the two files are
> these lines:
> 
>  omap2_ocs_sdrc_power:
> -       .word OMAP242X_SDRC_REGADDR(SDRC_POWER)
> +       .word OMAP243X_SDRC_REGADDR(SDRC_POWER)
>  A_SDRC0:
>         .word A_SDRC0_V
>  omap2_ocs_sdrc_dlla_ctrl:
> -       .word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> +       .word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
> 
> so is doubling the size of this code really justified?

Yes duplication is a problem. We had code that was dynamically
rewriting the addresses but it was not very easy to follow and
hard to debug. This code is only compiled in twice if both 242x
and 243x are both selected though.

> Looking harder at this code:
> 
> ENTRY(omap242x_cpu_suspend)
>         stmfd   sp!, {r0 - r12, lr}     @ save registers on stack
> ...
>         mov     r5, #0x2000             @ set delay (DPLL relock + DLL relock)
> ...
>         nop
>         mcr     p15, 0, r2, c7, c0, 4   @ wait for interrupt
>         nop
> loop:
>         subs    r5, r5, #0x1            @ awake, wait just a bit
>         bne     loop
> 
>         ldmfd   sp!, {r0 - r12, pc}     @ restore regs and return
> 
> it's clear that registers are preserved across the wait-for-interrupt
> instruction, so I'm not sure why saving all the registers is really
> necessary, but that's only a side point to my main point, which is...
> 
> ... that you could pass the addresses of these registers into the
> function, either directly:
> 
> void omap24xx_cpu_suspend(u32 dll_ctrl, u32 cpu_revision,
> 			  void __iomem *sdrc_pwr,
> 			  void __iomem *sdrc_dlla_ctrl);
> 
> or via a structure, and thereby avoid this duplication.

The structure would have to be also in SRAM then. I guess in this case
there are only two addresses, so passing them via into the function
should be enough. It's unlikely that this code changes any further
to need more addresses.

Will repost.

Tony
