From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 2/6] omap: introduce OMAP3 remoteproc module
Date: Tue, 27 Jul 2010 20:53:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2225@dbde02.ent.ti.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
 <1278022994-28476-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab0G0PXb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 11:23:31 -0400
In-Reply-To: <1278022994-28476-3-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ben-cohen, Ohad" <ohadb@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohen
> Sent: Friday, July 02, 2010 3:53 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ben-cohen, Ohad
> Subject: [RFC 2/6] omap: introduce OMAP3 remoteproc module
> 
> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> Introduce OMAP3 remoteproc module which takes care of
> machine-specific code required to start and stop
> the DSP remote processor.
> 
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/remoteproc3xxx.c |  226 
> ++++++++++++++++++++++++++++++++++
>  1 files changed, 226 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/remoteproc3xxx.c
> 
> diff --git a/arch/arm/mach-omap2/remoteproc3xxx.c 
> b/arch/arm/mach-omap2/remoteproc3xxx.c
> new file mode 100644
> index 0000000..f86a333
> --- /dev/null
> +++ b/arch/arm/mach-omap2/remoteproc3xxx.c
> @@ -0,0 +1,226 @@
> +/*
> + * Remote Processor machine-specific module for OMAP3
> + *
> + * Copyright (C) 2010 Texas Instruments Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be 
> useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +/* this is needed for multi-omap support */
> +#ifdef CONFIG_ARCH_OMAP3

[sp] If ARCH_OMAP3 is not defined this file shouldn't be compiled.
     I do see that we are achieving the multi-omap support - a
     concern I had in my comment on another patch in the series -
     but this appears to be a hack.

> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <plat/remoteproc.h>
> +#include <mach/irqs.h>
> +#include <plat/omap_device.h>
> +#include <plat/control.h>
> +#include <plat/common.h>
> +#include <plat/powerdomain.h>
> +#include <plat/clockdomain.h>
> +#include <asm/uaccess.h>
> +
> +#include "cm-regbits-34xx.h"
> +#include "prm-regbits-34xx.h"
> +
> +#define OMAP3_IVA2_BOOTADDR_MASK	0xFFFFFC00
> +
> +#define PRCM_PM_PWSTCTRL_IVA2_POWER_STATE_MASK		(u32)(3)
> +#define PRCM_PM_PWSTCTRL_IVA2_POWER_STATE_OFFSET	(u32)(0)

[sp] We should either use the definitions in prm-regbits-34xx.h/prm.h
     or make sure appropriate headers are updated with these definitions.

     The naming conventions here seem to be very differen from the ones
     used in prm-regbits-34xx.h and prm.h

> +
> +#define PRCM_PM_PWSTST_IVA2_InTransition_MASK		
> (u32)(0x100000)
> +#define PRCM_PM_PWSTST_IVA2_InTransition_OFFSET		
> (u32)(20)

[sp] Is "InTransition" delibrately put in CamelCase?

> +
> +#define CM_CLKSTCTRL_IVA2_OFFSET	(0)
> +#define CM_CLKSTCTRL_IVA2_MASK		(3)

[sp] Same somment as before. See corresponding definition(s) in
     cm-regbits-34xx.h for existing definitions, instead of
     defining new ones.

> +
> +#define DSP_SYSC_DIRECTBOOT		(0)
> +#define DSP_SYSC_IDLEBOOT		(1)
> +#define DSP_SYSC_SELFLOOPBOOT		(2)
> +#define DSP_SYSC_USRBOOTSTRAP		(3)
> +#define DSP_SYSC_DEFAULTRESTORE		(4)
> +
> +#ifdef CONFIG_BRIDGE_DEBUG
> +static void omap3_rproc_dump_regs(struct device *dev)
> +{
> +	u32 temp;
> +
> +	temp = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
> +	dev_info(dev, "CM_FCLKEN_IVA2 = 0x%x \n", temp);

[sp] Shouldn't we be using dev_dbg() here?
     Also, same information is available in debugfs in base linux.
     Is this function really needed here?

> +	temp = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_ICLKEN1);
> +	dev_info(dev, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
> +	temp = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_IDLEST);
> +	dev_info(dev, "CM_IDLEST_IVA2 = 0x%x \n", temp);
> +	temp = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
> +	dev_info(dev, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
> +	temp = cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST);
> +	dev_info(dev, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
> +	temp = prm_read_mod_reg(OMAP3430_IVA2_MOD, RM_RSTCTRL);
> +	dev_info(dev, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
> +	temp = prm_read_mod_reg(OMAP3430_IVA2_MOD, RM_RSTST);
> +	dev_info(dev, "RM_RSTST_IVA2 = 0x%x \n", temp);
> +	temp = prm_read_mod_reg(OMAP3430_IVA2_MOD, PM_PWSTCTRL);
> +	dev_info(dev, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
> +	temp = prm_read_mod_reg(OMAP3430_IVA2_MOD, PM_PWSTST);
> +	dev_info(dev, "PM_PWSTST_IVA2 = 0x%x \n", temp);
> +	temp = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
> +	dev_info(dev, "CM_ICLKEN1_CORE = 0x%x \n", temp);
> +}
> +#else
> +static void omap3_rproc_dump_regs(struct device *dev) { }
> +#endif
> +
> +static int omap3_rproc_get_state(struct device *dev)
> +{
> +	u32 dsp_pwr_state;
> +
> +	dsp_pwr_state = prm_read_mod_reg(OMAP3430_IVA2_MOD, PM_PWSTST);
> +
> +	return dsp_pwr_state & OMAP_POWERSTATEST_MASK;
> +}
> +
> +static int omap3_rproc_start(struct device *dev, u32 start_addr)
> +{
> +	dev_info(dev, "%s: set boot mode, addr: 0x%x\n", 
> __func__, start_addr);
> +
> +	omap3_rproc_dump_regs(dev);
> +
> +	if (PWRDM_POWER_ON != omap3_rproc_get_state(dev)) {
> +		/* IVA2 is not in ON state */
> +		/* Read and set PM_PWSTCTRL_IVA2 to ON */
> +		prm_rmw_mod_reg_bits(OMAP_POWERSTATEST_MASK, 
> PWRDM_POWER_ON,
> +				OMAP3430_IVA2_MOD, PM_PWSTCTRL);
> +
> +		/* Set the SW supervised state transition */
> +		cm_write_mod_reg(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP,
> +					OMAP3430_IVA2_MOD, 
> CM_CLKSTCTRL);
> +
> +		/* Wait until the state has moved to ON */
> +		while (prm_read_mod_reg(OMAP3430_IVA2_MOD, PM_PWSTST)
> +						& OMAP_INTRANSITION)
> +			;
> +
> +		/* Disable Automatic transition */
> +		cm_write_mod_reg(OMAP34XX_CLKSTCTRL_DISABLE_AUTO,
> +					OMAP3430_IVA2_MOD, 
> CM_CLKSTCTRL);
> +	}
> +
> +	/* Assert RST1 i.e only the RST only for DSP megacell */
> +	prm_rmw_mod_reg_bits(OMAP3430_RST1_IVA2, OMAP3430_RST1_IVA2,
> +					OMAP3430_IVA2_MOD, RM_RSTCTRL);
> +	/* Mask address with 1K for compatibility */
> +	omap_ctrl_writel(start_addr & OMAP3_IVA2_BOOTADDR_MASK,
> +					OMAP343X_CONTROL_IVA2_BOOTADDR);
> +	/* Set bootmode to self loop if dsp_debug flag is true */
> +	omap_ctrl_writel(DSP_SYSC_DIRECTBOOT, 
> OMAP343X_CONTROL_IVA2_BOOTMOD);
> +
> +	/*Set Autoidle Mode for IVA2 PLL */
> +	cm_write_mod_reg(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
> +				OMAP3430_IVA2_MOD, 
> OMAP3430_CM_AUTOIDLE_PLL);
> +
> +	/* select GPT5 and GPT6 as IVA2 wake-up modules */
> +	prm_rmw_mod_reg_bits(0x3F, 0xC0, OMAP3430_PER_MOD,
> +							
> OMAP3430_PM_IVAGRPSEL);
> +
> +	/* make sure GPT5 and GPT6 are not selected as MPU 
> wake-up modules */
> +	prm_rmw_mod_reg_bits(0xC0, 0, OMAP3430_PER_MOD, 
> OMAP3430_PM_MPUGRPSEL);
> +
> +	/* PER domain sleep dependency with IVA2 domain is enabled */
> +	cm_rmw_mod_reg_bits(4, 4, OMAP3430_PER_MOD, 
> OMAP3430_CM_SLEEPDEP);
> +
> +	/* Allow automatic transitions */
> +	cm_write_mod_reg(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, 
> OMAP3430_IVA2_MOD,
> +								
> CM_CLKSTCTRL);
> +
> +	/* Let DSP go */
> +	dev_dbg(dev, "%s Unreset DSP\n", __func__);
> +
> +	/* release the RST1, DSP starts executing now .. */
> +	prm_rmw_mod_reg_bits(OMAP3430_RST1_IVA2, 0, OMAP3430_IVA2_MOD,
> +								
> RM_RSTCTRL);
> +
> +	omap3_rproc_dump_regs(dev);
> +
> +	return 0;
> +}
> +
> +static int omap3_rproc_stop(struct device *dev)
> +{
> +	dev_info(dev, "%s\n", __func__);
> +
> +	omap3_rproc_dump_regs(dev);
> +
> +	/* Set PM_PWSTCTRL_IVA2 to OFF */
> +	prm_rmw_mod_reg_bits(OMAP_POWERSTATEST_MASK,
> +			PWRDM_POWER_OFF, OMAP3430_IVA2_MOD, 
> PM_PWSTCTRL);
> +
> +	/* Set the SW supervised state transition for Sleep */
> +	cm_write_mod_reg(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, 
> OMAP3430_IVA2_MOD,
> +								
> CM_CLKSTCTRL);
> +
> +	/* Reset RST1 + RST3 */
> +	prm_rmw_mod_reg_bits(OMAP3430_RST1_IVA2 | OMAP3430_RST3_IVA2,
> +				OMAP3430_RST1_IVA2 | OMAP3430_RST3_IVA2,
> +				OMAP3430_IVA2_MOD, RM_RSTCTRL);
> +
> +	udelay(10);
> +
> +	return 0;
> +}
> +
> +static struct omap_rproc_ops omap3_rproc_ops = {
> +	.start		= omap3_rproc_start,
> +	.stop		= omap3_rproc_stop,
> +	.get_state	= omap3_rproc_get_state,
> +};
> +
> +static struct omap_rproc_platform_data omap3_rproc_data[] = {
> +	{
> +		.name = "dsp",
> +		.ops = &omap3_rproc_ops,
> +		.oh_name = "iva2_hwmod",
> +	},
> +};
> +
> +struct omap_rproc_platform_data *omap3_get_rproc_data(void)
> +{
> +       return omap3_rproc_data;
> +}
> +
> +int omap3_get_rproc_data_size(void)
> +{
> +       return ARRAY_SIZE(omap3_rproc_data);
> +}
> +#else
> +struct omap_rproc_platform_data *omap3_get_rproc_data(void)
> +{
> +       return NULL;
> +}
> +
> +int omap3_get_rproc_data_size(void)
> +{
> +       return 0;
> +}
> +#endif
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("OMAP3 Remote Processor module");
> +MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
> +MODULE_AUTHOR("Hari Kanigeri <h-kanigeri2@ti.com>");
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 