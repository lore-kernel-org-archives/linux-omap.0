From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: how to force IVA2 powerdomain OFF on boot
Date: Tue, 25 Nov 2008 09:06:13 +0200 (EET)
Message-ID: <20081125.090613.186857123.Hiroshi.DOYU@nokia.com>
References: <8763mcr248.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58780 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbYKYHG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 02:06:57 -0500
In-Reply-To: <8763mcr248.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Hi Kevin,

From: "ext Kevin Hilman" <khilman@deeprootsystems.com>
Subject: how to force IVA2 powerdomain OFF on boot
Date: Mon, 24 Nov 2008 18:05:59 -0800

> Hello,
> 
> For some strange reason, some bootloaders (like u-boot on Beagle) seem
> to power up the DSP/IVA2 during boot.  This of course will prevent
> full-chip retention until the IVA is put into retention.
> 
> On several boards I've tested the PM branch, after kernel boot the
> unused domains (like SGX, DSS, CAM, IVA2) are all in RET since the
> init code sets next states to retention.  This is working except if
> the bootloader has powered up the IVA2.
> 
> I'm trying to figure out why the IVA2 isn't going into RET, even when
> iva2_fck is disabled during boot as part of the 'reset unused clocks'
> feature.
> 
> I'm now trying to force the IVA2 into RET/OFF during boot by following
> 'Figure 14-46: IVA2 Power Down' in the TRM (see patch[1] below), but
> that is not working.  IVA2 still stays ON.
> 
> Any ideas?

I think that, this is because there's no 'Figure 14-45' steps, which
goes into 'IVA2 ready to go to off mode', before the following code?

The explanation in 'Figure 14-45' says:

 The user must also ensure that no other instruction is executed
 parallel to the IDLE instruction. When IVA2 is ready to go to off
 mode, there are two ways to completely shut down IVA2 subsystem (see
 Figure 14-46):

So I guess that 'Figure 14-45' should be done in DSP side for 'Figure
14-46' in advance?

	Hiroshi DOYU

> 
> Kevin
> 
> 
> [1] This is an attempt to implement Figure 14-46, and then
> the 'reset unused clocks' will disable iva2_fck an finish the procedure.
> 
> khilman@vence:~/work/kernel/omap/dev$ git diff
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 804b3ac..5ef7cf8 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -591,6 +591,24 @@ int __init omap3_pm_init(void)
>  
>  	(void) clkdm_for_each(clkdms_setup, NULL);
>  
> +	{
> +		struct powerdomain *iva2_pwrdm;
> +		struct clockdomain *iva2_clkdm;
> +
> +		iva2_pwrdm = pwrdm_lookup("iva2_pwrdm");
> +		iva2_clkdm = clkdm_lookup("iva2_clkdm");
> +
> +		if (iva2_pwrdm && iva2_clkdm) {
> +			u32 pwrst;
> +
> +			pwrdm_set_next_pwrst(iva2_pwrdm, PWRDM_POWER_OFF);
> +			cm_write_mod_reg(0x1, OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
> +			prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
> +			omap2_clkdm_sleep(iva2_clkdm);
> +		} else 
> +			printk(KERN_ERR "KJH: Cannot reset IVA2\n");
> +	}
> +
>  	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>  	if (mpu_pwrdm == NULL) {
>  		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
