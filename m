From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/16] ARM: OMAP2: Split sleep.S into sleep242x.S and
	sleep243x.S
Date: Tue, 19 Aug 2008 18:03:12 +0100
Message-ID: <20080819170311.GB17034@flint.arm.linux.org.uk>
References: <1212804762-18413-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <1212804762-18413-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 07:12:28PM -0700, Tony Lindgren wrote:
> Some register offsets are different for 242x and 243x. This
> will allow compiling sleep code for both chips into the same
> kernel.
> 
> Note that some PM patches are still missing. The PM patches will
> be added later on once the base files are in sync with linux-omap
> tree.

Please use git diff -M, since it makes the changes across renames more
obvious.

> +ENTRY(omap242x_idle_loop_suspend)
> +	stmfd	sp!, {r0, lr}		@ save registers on stack
> +	mov	r0, #0x0		@ clear for mrc call
> +	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
> +	ldmfd	sp!, {r0, pc}		@ restore regs and return

What's been lost because of the lack of git diff -M here is the real
change:

-ENTRY(omap24xx_idle_loop_suspend)
+ENTRY(omap242x_idle_loop_suspend)
 	stmfd	sp!, {r0, lr}		@ save registers on stack
-	mov	r0, #0			@ clear for mcr setup
+	mov	r0, #0x0		@ clear for mrc call
 	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
 	ldmfd	sp!, {r0, pc}		@ restore regs and return

which makes the problem stand out.  That change of the 'mov' line
along with the comment is completely bogus.  In fact, the change to
the comment is clearly wrong.  The same applies to sleep243x.S

Realistically, the only real difference between the two files are
these lines:

 omap2_ocs_sdrc_power:
-       .word OMAP242X_SDRC_REGADDR(SDRC_POWER)
+       .word OMAP243X_SDRC_REGADDR(SDRC_POWER)
 A_SDRC0:
        .word A_SDRC0_V
 omap2_ocs_sdrc_dlla_ctrl:
-       .word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+       .word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)

so is doubling the size of this code really justified?

Looking harder at this code:

ENTRY(omap242x_cpu_suspend)
        stmfd   sp!, {r0 - r12, lr}     @ save registers on stack
...
        mov     r5, #0x2000             @ set delay (DPLL relock + DLL relock)
...
        nop
        mcr     p15, 0, r2, c7, c0, 4   @ wait for interrupt
        nop
loop:
        subs    r5, r5, #0x1            @ awake, wait just a bit
        bne     loop

        ldmfd   sp!, {r0 - r12, pc}     @ restore regs and return

it's clear that registers are preserved across the wait-for-interrupt
instruction, so I'm not sure why saving all the registers is really
necessary, but that's only a side point to my main point, which is...

... that you could pass the addresses of these registers into the
function, either directly:

void omap24xx_cpu_suspend(u32 dll_ctrl, u32 cpu_revision,
			  void __iomem *sdrc_pwr,
			  void __iomem *sdrc_dlla_ctrl);

or via a structure, and thereby avoid this duplication.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
