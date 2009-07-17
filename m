From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Prevent hang in prcm_interrupt handler
Date: Fri, 17 Jul 2009 16:34:12 -0700
Message-ID: <87bpniubnv.fsf@deeprootsystems.com>
References: <1247870687-27149-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:21928 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbZGQXeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jul 2009 19:34:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so418087qwh.37
        for <linux-omap@vger.kernel.org>; Fri, 17 Jul 2009 16:34:15 -0700 (PDT)
In-Reply-To: <1247870687-27149-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Fri\, 17 Jul 2009 17\:44\:47 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com

Vikram Pandita <vikram.pandita@ti.com> writes:

> There are two scenarios where a race condition could result in a hang in the
> prcm_interrupt handler:
>
> 1) Waiting for PRM_IRQSTATUS_MPU register to clear.
> Bit 0 of the PRM_IRQSTATUS_MPU register indicates that a wake-up event is
> pending for the MPU. This bit can only be cleared if the all the wake-up events
> latched in the various PM_WKST_x registers have been cleared. If a wake-up event
> occurred during the processing of the prcm interrupt handler, after the
> corresponding PM_WKST_x register was checked but before the PRM_IRQSTATUS_MPU
> was cleared, then the CPU would be stuck forever waiting for bit 0 in
> PRM_IRQSTATUS_MPU to be cleared.
>
> 2) Waiting for the PM_WKST_x register to clear.
> Some power domains have more than one wake-up source. The PM_WKST_x registers
> indicate the source of a wake-up event and need to be cleared after a wake-up
> event occurs. When the PM_WKST_x registers are read and before they are cleared,
> it is possible that another wake-up event could occur causing another bit to be
> set in one of the PM_WKST_x registers. If this did occur after reading a
> PM_WKST_x register then the CPU would miss this event and get stuck forever in
> a loop waiting for that PM_WKST_x register to clear.
>
> This patch address the above race conditions that would result in a hang.
>
> Adapted from a version posted by Jon Hunter:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg13786.html

I much prefer Jon's version, which also added some additional needed
cleanup and removed lots of code duplication, but may need some
additional tweaking to support the special-case raised in your USBHOST
patch.

Kevin

> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> cc: Hunter, Jon <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 4cbeff1..ce34ac1 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -200,6 +200,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  	u32 wkst, irqstatus_mpu;
>  	u32 fclk, iclk;
>  
> +restart:
> +	fclk = 0;
> +	iclk = 0;
> +
>  	/* WKUP */
>  	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
>  	if (wkst) {
> @@ -285,8 +289,11 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  	prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
>  			  OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>  
> -	while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET))
> -		cpu_relax();
> +	/* In case another wakep happend while in this handler,
> +	 * restart the clearing process
> +	 */
> +	if (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET))
> +		goto restart;
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 1.6.3.3.334.g916e1
