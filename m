From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] OMAP3: PRCM interrupt: only check for enabled PRCM IRQs
Date: Tue, 27 Apr 2010 11:52:21 -0500
Message-ID: <4BD71645.8070804@ti.com>
References: <1272320584-14244-1-git-send-email-khilman@deeprootsystems.com>	<4BD631D3.4000800@ti.com> <878w89rl6w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48868 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab0D0Qw0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 12:52:26 -0400
In-Reply-To: <878w89rl6w.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman wrote:
> commit cfabe8a950e252d26cdeb4a9bb11e2cabb2a50c6
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Mon Apr 26 14:59:09 2010 -0700
> 
>     OMAP3: PRCM interrupt: only check and clear enabled PRCM IRQs
>     
>     While handling PRCM IRQs, mask out interrupts that are not enabled in
>     PRM_IRQENABLE_MPU.  If these are not masked out, non-enabled
>     interrupts are caught, a WARN() is printed due to no 'handler' and the
>     events are cleared.  In addition to being noisy, this can also
>     interfere with independent polling of this register by SR/VP code.
>     
>     This was noticed using SmartReflex transitions which cause the VPx_*
>     interrupts to be handled since they are set in PRM_IRQSTATUS_MPU even
>     but not enabled in PRM_IRQENABLE_MPU.
>     
>     Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

ACK.

Mike

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index fee2efb..c38016b 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -266,13 +266,16 @@ static int _prcm_int_handle_wakeup(void)
>   */
>  static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  {
> -	u32 irqstatus_mpu;
> +	u32 irqenable_mpu, irqstatus_mpu;
>  	int c = 0;
>  
> -	do {
> -		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
> -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
> +					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> +	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
> +					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +	irqstatus_mpu &= irqenable_mpu;
>  
> +	do {
>  		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
>  			c = _prcm_int_handle_wakeup();
>  
> @@ -291,7 +294,11 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
>  					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>  
> -	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
> +		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
> +					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +		irqstatus_mpu &= irqenable_mpu;
> +
> +	} while (irqstatus_mpu);
>  
>  	return IRQ_HANDLED;
>  }

