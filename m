From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and
 kick
Date: Wed, 17 Jun 2009 02:04:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com> <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59512 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbZFQIES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 04:04:18 -0400
In-Reply-To: <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Woodruff <r-woodruff2@ti.com>, Mike Chan <mikechan@google.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi,

a few questions for Mike and Richard:

On Mon, 15 Jun 2009, Kevin Hilman wrote:

> From: Richard Woodruff <r-woodruff2@ti.com>
> 
> I'm thinking DLL state is an exceptional condition which happens based
> on some wrong early programming when initially setting DLL up.  Some
> kind of race between idle features and lock happens early on.  This
> patch recognizes the issue and moves state machine into locked state.
> 
> Its my guess the kick case won't be executed that often.  As long as
> DLL is not on you can mess with idle state.  When its on to mess with
> DDR control you need to be in self-refresh and not making
> accesses... like in dvfs code.
> 
> Tested-by: Mike Chan <mikechan@google.com>

The last time I torture-tested CORE DVFS, which admittedly was some time 
ago, the boards tested were stable across the entire overnight run, doing 
nothing but CORE DVFS switching.  This was on a Beagle and a 3430SDP.

So, what is different about your setup?  The usual suite of questions:  

- What chip revisions/boards does this affect?

- Is this specific to certain bootloaders?  

- Has anyone else out there seen this problem?

Rather than working around an occasional DLL failure to lock, is it 
possible to reset the DLL earlier in the boot process, as Richard's commit 
message suggests?  That would be preferable to this approach.  A 
back-of-the-envelope assessment suggests that this patch could cause 
unpredictable, additional 1.5 millisecond latency spikes whenever the 
workaround triggers (since OCM RAM is marked uncacheable).


- Paul


> ---
>  arch/arm/mach-omap2/sleep34xx.S |   22 ++++++++++++++++++++--
>  1 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index aedcf94..c469bbe 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -595,20 +595,38 @@ wait_sdrc_ok:
>          ldr     r5, [r4]
>          bic     r5, r5, #0x40
>          str     r5, [r4]
> -wait_dll_lock:
> -        /* Is dll in lock mode? */
> +is_dll_in_lock_mode:
>          ldr     r4, sdrc_dlla_ctrl
>          ldr     r5, [r4]
>          tst     r5, #0x4
>          bxne    lr
>          /* wait till dll locks */
> +wait_dll_lock_timed:
>          ldr     r4, sdrc_dlla_status
> +        mov     r6, #0x2000
> +wait_dll_lock:
> +        subs    r6, r6, #0x1
> +        beq     kick_dll
>          ldr     r5, [r4]
>          and     r5, r5, #0x4
>          cmp     r5, #0x4
>          bne     wait_dll_lock
>          bx      lr
>  
> +        /* Kick DLL state machine if lock not started */
> +kick_dll:
> +	ldr     r4, sdrc_dlla_ctrl	/* get dlla addr */
> +	ldr     r5, [r4]		/* grab value */
> +	mov	r6, r5			/* save value */
> +	orr	r6, r6, #0x10		/* dllidle on */
> +	str	r6, [r4]
> +	dsb
> +	bic	r6, #0x10		/* dllidle off */
> +	str	r6, [r4]
> +	dsb
> +	str	r6, [r4]		/* restore old value */
> +	b wait_dll_lock_timed
> +
>  cm_idlest1_core:
>  	.word	CM_IDLEST1_CORE_V
>  sdrc_dlla_status:
> -- 
> 1.6.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
