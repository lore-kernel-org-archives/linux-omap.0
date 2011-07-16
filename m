From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] TI816X: clock: Add clockdomains and powerdomains
 data
Date: Sat, 16 Jul 2011 01:54:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107160154080.25013@utopia.booyaka.com>
References: <1301070022-8405-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60435 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1GPHy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jul 2011 03:54:58 -0400
In-Reply-To: <1301070022-8405-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Fri, 25 Mar 2011, Hemant Pedanekar wrote:

> This patch adds data for various clock domains and power domains in TI816X.
> 
> Note that at present this is not exhaustive and need to add missing domains.
> 
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomains816x.h |  167 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomains816x.h |   74 ++++++++++++++
>  2 files changed, 241 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clockdomains816x.h
>  create mode 100644 arch/arm/mach-omap2/powerdomains816x.h

Static data shouldn't be declared in .h files; it should be declared in 
*domains81*_data.c files, as is the practice with the rest of the 
powerdomains/clockdomains data here.



> 
> diff --git a/arch/arm/mach-omap2/clockdomains816x.h b/arch/arm/mach-omap2/clockdomains816x.h
> new file mode 100644
> index 0000000..1938abc
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clockdomains816x.h
> @@ -0,0 +1,167 @@
> +/*
> + * TI816X Clock Domain data.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS816X_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS816X_H
> +
> +#include "cm.h"
> +#include "cm816x.h"
> +#include "cm-regbits-816x.h"
> +
> +#ifdef CONFIG_SOC_OMAPTI816X
> +
> +static struct clockdomain alwon_mpu_816x_clkdm = {
> +	.name		= "alwon_mpu_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI816X_CM_ALWON_MOD,
> +	.clkdm_offs	= TI816X_CM_ALWON_MPU_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain alwon_l3_slow_816x_clkdm = {
> +	.name		= "alwon_l3_slow_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI816X_CM_ALWON_MOD,
> +	.clkdm_offs	= TI816X_CM_ALWON_L3_SLOW_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain alwon_ethernet_816x_clkdm = {
> +	.name		= "alwon_ethernet_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI816X_CM_ALWON_MOD,
> +	.clkdm_offs	= TI816X_CM_ETHERNET_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain mmu_816x_clkdm = {
> +	.name		= "mmu_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI816X_CM_ALWON_MOD,
> +	.clkdm_offs	= TI816X_CM_MMU_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain mmu_cfg_816x_clkdm = {
> +	.name		= "mmu_cfg_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI816X_CM_ALWON_MOD,
> +	.clkdm_offs	= TI816X_CM_MMUCFG_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain active_gem_816x_clkdm = {
> +	.name		= "active_gem_clkdm",
> +	.pwrdm		= { .name = "active_pwrdm" },
> +	.cm_inst	= TI816X_CM_ACTIVE_MOD,
> +	.clkdm_offs	= TI816X_CM_ACTIVE_GEM_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain hdvicp0_816x_clkdm = {
> +	.name		= "hdvicp0_clkdm",
> +	.pwrdm		= { .name = "hdvicp0_pwrdm" },
> +	.cm_inst	= TI816X_CM_IVAHD0_MOD,
> +	.clkdm_offs	= TI816X_CM_IVAHD0_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain hdvicp1_816x_clkdm = {
> +	.name		= "hdvicp1_clkdm",
> +	.pwrdm		= { .name = "hdvicp1_pwrdm" },
> +	.cm_inst	= TI816X_CM_IVAHD1_MOD,
> +	.clkdm_offs	= TI816X_CM_IVAHD1_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain hdvicp2_816x_clkdm = {
> +	.name		= "hdvicp2_clkdm",
> +	.pwrdm		= { .name = "hdvicp2_pwrdm" },
> +	.cm_inst	= TI816X_CM_IVAHD2_MOD,
> +	.clkdm_offs	= TI816X_CM_IVAHD2_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain sgx_816x_clkdm = {
> +	.name		= "sgx_clkdm",
> +	.pwrdm		= { .name = "sgx_pwrdm" },
> +	.cm_inst	= TI816X_CM_SGX_MOD,
> +	.clkdm_offs	= TI816X_CM_SGX_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain default_l3_med_816x_clkdm = {
> +	.name		= "default_l3_med_clkdm",
> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_L3_MED_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain default_ducati_816x_clkdm = {
> +	.name		= "default_ducati_clkdm",
> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_DUCATI_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain default_pcie_816x_clkdm = {
> +	.name		= "default_pcie_clkdm",
> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_PCI_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct clockdomain default_usb_816x_clkdm = {
> +	.name		= "default_usb_clkdm",
> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_L3_SLOW_CLKDM,
> +	.clktrctrl_mask	= TI816X_CLKTRCTRL_MASK,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +#endif
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/powerdomains816x.h b/arch/arm/mach-omap2/powerdomains816x.h
> new file mode 100644
> index 0000000..491b439
> --- /dev/null
> +++ b/arch/arm/mach-omap2/powerdomains816x.h
> @@ -0,0 +1,74 @@
> +/*
> + * TI816X Power Domain data.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAINS816X_H
> +#define __ARCH_ARM_MACH_OMAP2_POWERDOMAINS816X_H
> +
> +#include "prcm-common.h"
> +#include "prm2xxx_3xxx.h"
> +
> +#ifdef CONFIG_SOC_OMAPTI816X
> +
> +static struct powerdomain alwon_816x_pwrdm = {
> +	.name		  = "alwon_pwrdm",
> +	.prcm_offs	  = TI816X_PRM_ALWON_MOD,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +};
> +
> +static struct powerdomain active_816x_pwrdm = {
> +	.name		  = "active_pwrdm",
> +	.prcm_offs	  = TI816X_PRM_ACTIVE_MOD,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +	.pwrsts		  = PWRSTS_OFF_ON,
> +};
> +
> +static struct powerdomain default_816x_pwrdm = {
> +	.name		  = "default_pwrdm",
> +	.prcm_offs	  = TI816X_PRM_DEFAULT_MOD,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +	.pwrsts		  = PWRSTS_OFF_ON,
> +};
> +
> +static struct powerdomain hdvicp0_816x_pwrdm = {
> +	.name		  = "hdvicp0_pwrdm",
> +	.prcm_offs	  = TI816X_PRM_IVAHD0_MOD,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +	.pwrsts		  = PWRSTS_OFF_ON,
> +};
> +
> +static struct powerdomain hdvicp1_816x_pwrdm = {
> +	.name		  = "hdvicp1_pwrdm",
> +	.prcm_offs	  = TI816X_PRM_IVAHD1_MOD,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +	.pwrsts		  = PWRSTS_OFF_ON,
> +};
> +
> +static struct powerdomain hdvicp2_816x_pwrdm = {
> +	.name		  = "hdvicp2_pwrdm",
> +	.prcm_offs	  = TI816X_PRM_IVAHD2_MOD,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +	.pwrsts		  = PWRSTS_OFF_ON,
> +};
> +
> +static struct powerdomain sgx_816x_pwrdm = {
> +	.name		  = "sgx_pwrdm",
> +	.prcm_offs	  = TI816X_PRM_SGX_MOD,
> +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_TI816X),
> +	.pwrsts		  = PWRSTS_OFF_ON,
> +};
> +
> +#endif
> +
> +#endif
> -- 
> 1.7.3.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
