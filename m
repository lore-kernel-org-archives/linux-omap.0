From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH L23.I3 PM 2/2]: Setting Mpu registers properly when
 enable_off_mode is enabled
Date: Wed, 24 Mar 2010 20:42:50 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304700E2C@dbde02.ent.ti.com>
References: <1269438385-22579-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43958 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331Ab0CXPNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 11:13:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2OFCx7u017856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 10:13:02 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2OFCx5w027514
	for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 20:42:59 +0530 (IST)
In-Reply-To: <1269438385-22579-1-git-send-email-shweta.gulati@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Gulati, Shweta
> Sent: Wednesday, March 24, 2010 7:16 PM
> To: linux-omap@vger.kernel.org
> Cc: Gulati, Shweta; Sripathy, Vishwanath
> Subject: [PATCH L23.I3 PM 2/2]: Setting Mpu registers properly when
> enable_off_mode is enabled
Subject should be [PATCH 2/2] OMAP3 PM: Setting Mpu registers properly when
enable_off_mode is enabled. Do not put TI Internal release names.

> 
> From: Shweta Gulati <shweta.gulati@ti.com>
> 
> When enable_off_mode is enabled and ROM code issues WFI, the
> powerstate of all the powerdomains is set as OFF in PM_PWSTCTRL
> register and when it restores back the system to previous state
> it sets MPU as OFF and system hangs.
> 
> This Patch ensures that for MPU the state is ON after it comes out of
> Idle/Suspend till it renters Idle.
> 
> 
> Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
> Index: kernel-omap3-dev/arch/arm/mach-omap2/pm34xx.c
> =====================================================
> ==============
> --- kernel-omap3-dev.orig/arch/arm/mach-omap2/pm34xx.c
> +++ kernel-omap3-dev/arch/arm/mach-omap2/pm34xx.c
> @@ -573,8 +573,14 @@ void omap_sram_idle(void)
>  	_omap_sram_idle(omap3_arm_context, save_state);
>  	cpu_init();
> 
> +
>  	if (is_suspending())
>  		pm_dbg_regset_save(2);
> +	/* Ensure that Mpu state is restored back as ON
> +	 * after coming out of suspend/Idle.
> +	 */
> +	prm_rmw_mod_reg_bits(OMAP_POWERSTATEST_MASK, 0x3,
> +		MPU_MOD, PM_PWSTCTRL);
> 
>  	/* Restore normal SDRC POWER settings */
>  	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> @@ -1209,10 +1215,16 @@ void omap3_pm_off_mode_enable(int enable
>  	resource_unlock_opp(VDD1_OPP);
>  	resource_unlock_opp(VDD2_OPP);
>  #endif
> +	/* For Mpu only next state should be set as OFF, the
> +	 * powerstate bits of PM_PWSTCTRL_MPU should not be explicitily
> +	 * set as OFF
> +	 */
> +
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>  		if (strcmp("iva2_pwrdm", pwrst->pwrdm->name)) {
>  			pwrst->next_state = state;
> -			set_pwrdm_state(pwrst->pwrdm, state);
> +			if (strcmp("mpu_pwrdm", pwrst->pwrdm->name))
> +				set_pwrdm_state(pwrst->pwrdm, state);
>  		}
>  	}
>  }
