From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/12] PRCM context save/restore
Date: Wed, 10 Sep 2008 09:31:10 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809100925090.20446@utopia.booyaka.com>
References: <61169.192.168.10.89.1220276406.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44552 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbYIJPbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 11:31:12 -0400
In-Reply-To: <61169.192.168.10.89.1220276406.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 1 Sep 2008, Rajendra Nayak wrote:

> This patch adds the context save restore functions for PRCM module

This patch reads and writes from the INTCPS MIR registers, but is in
prcm.c.  prcm.c should call INTCPS functions in mach-omap2/irq.c to do
this.  I suggest something similar to the following:

1. In arch/arm/plat-omap/include/mach/irqs.h, add:

#define INTCPS_NR_MIR_REGS          3

/**
 * struct intcps_mir_ctx - INTCPS interrupt mask context
 * @mir: contents of the INTPCS MIR registers
 *
 * Contents of the INTCPS MIR (interrupt mask) registers -
 * used by omap_intcps_{save,restore}_mir() during PRCM context
 * save/restore (*not* INTCPS).
 */
struct intcps_mir_ctx {
    u32 mir[INTCPS_NR_MIR_REGS];
}


2. In the same file, in the #ifndef __ASSEMBLY__ section, add:

void omap_intcps_save_mir(struct intc_mir_ctx *c);
void omap_intcps_restore_mir(struct intc_mir_ctx *c);

- In mach-omap2/irq.c in the register offsets section, add the three
  INTC_MIR registers.

- Add this code to mach-omap2/irq.c:

void omap_intcps_save_mir(struct intc_mir_ctx *c)
{
        for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
                c->mir[i] = intc_bank_read_reg(&irq_banks[0], INTC_MIR0 + (0x20 * i));
}


void omap_intcps_restore_mir(struct intc_mir_ctx *c)
{
        for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
                intc_bank_write_reg(c->mir[i], &irq_banks[0], INTC_MIR0 + (0x20 * i));
}


> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/prcm.c                |  291 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prm.h                 |    2
>  arch/arm/plat-omap/include/mach/control.h |    2
>  arch/arm/plat-omap/include/mach/prcm.h    |   92 +++++++++
>  4 files changed, 387 insertions(+)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/prcm.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/prcm.c	2008-09-01
> 18:11:28.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/prcm.c	2008-09-01 18:11:53.000000000 +0530
> @@ -22,6 +22,7 @@
>  #include <mach/prcm.h>
> 
>  #include "clock.h"
> +#include "cm.h"
>  #include "prm.h"
>  #include "prm-regbits-24xx.h"
> 
> @@ -125,3 +126,293 @@ void __init omap2_set_globals_prcm(struc
>  	prm_base = omap2_globals->prm;
>  	cm_base = omap2_globals->cm;
>  }
> +
> +#ifdef CONFIG_ARCH_OMAP3
> +#include "clock34xx.h"
> +struct prcm_context_regs prcm_context;

The above should be static.  Please move the #include to the top of the 
file.

Add a "static struct intcps_mir_ctx mir_ctx;" here.

> +void omap3_save_prcm_ctx(void)
> +{
> +	prcm_context.intc_mir_0 = omap_readl(INTC_MIR_0);
> +	prcm_context.intc_mir_1 = omap_readl(INTC_MIR_1);
> +	prcm_context.intc_mir_2 = omap_readl(INTC_MIR_2);

Replace these with a call to omap_intcps_save_mir(&mir_ctx);

> +	prcm_context.control_padconf_sys_nirq =
> +			 omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
> +	prcm_context.iva2_cm_clksel2 =
> +			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
> +	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
> +	prcm_context.sgx_cm_clksel =
> +			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
> +	prcm_context.wkup_cm_clksel = cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
> +	prcm_context.dss_cm_clksel =
> +			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
> +	prcm_context.cam_cm_clksel =
> +			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSEL);
> +	prcm_context.per_cm_clksel =
> +			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
> +	prcm_context.emu_cm_clksel =
> +			 cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
> +	prcm_context.emu_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSTCTRL);
> +	prcm_context.pll_cm_autoidle2 =
> +			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
> +	prcm_context.pll_cm_clksel5 =
> +			 cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
> +	prcm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
> +	prcm_context.iva2_cm_fclken =
> +			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
> +	prcm_context.core_cm_fclken1 =
> +			 cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
> +	prcm_context.core_cm_fclken3 =
> +			 cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
> +	prcm_context.sgx_cm_fclken =
> +			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
> +	prcm_context.wkup_cm_fclken =
> +			 cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
> +	prcm_context.dss_cm_fclken =
> +			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN);
> +	prcm_context.cam_cm_fclken =
> +			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN);
> +	prcm_context.per_cm_fclken =
> +			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
> +	prcm_context.usbhost_cm_fclken =
> +			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
> +	prcm_context.core_cm_iclken1 =
> +			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
> +	prcm_context.core_cm_iclken2 =
> +			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
> +	prcm_context.core_cm_iclken3 =
> +			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
> +	prcm_context.sgx_cm_iclken =
> +			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
> +	prcm_context.wkup_cm_iclken =
> +			 cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
> +	prcm_context.dss_cm_iclken =
> +			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_ICLKEN);
> +	prcm_context.cam_cm_iclken =
> +			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_ICLKEN);
> +	prcm_context.per_cm_iclken =
> +			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
> +	prcm_context.usbhost_cm_iclken =
> +			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
> +	prcm_context.iva2_cm_autiidle2 =
> +			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
> +	prcm_context.mpu_cm_autoidle2 =
> +			 cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
> +	prcm_context.pll_cm_autoidle =
> +			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
> +	prcm_context.iva2_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
> +	prcm_context.mpu_cm_clkstctrl =
> +			 cm_read_mod_reg(MPU_MOD, CM_CLKSTCTRL);
> +	prcm_context.core_cm_clkstctrl =
> +			 cm_read_mod_reg(CORE_MOD, CM_CLKSTCTRL);
> +	prcm_context.sgx_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSTCTRL);
> +	prcm_context.dss_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSTCTRL);
> +	prcm_context.cam_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSTCTRL);
> +	prcm_context.per_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSTCTRL);
> +	prcm_context.neon_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430_NEON_MOD, CM_CLKSTCTRL);
> +	prcm_context.usbhost_cm_clkstctrl =
> +			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
> +	prcm_context.core_cm_autoidle1 =
> +			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
> +	prcm_context.core_cm_autoidle2 =
> +			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
> +	prcm_context.core_cm_autoidle3 =
> +			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
> +	prcm_context.wkup_cm_autoidle =
> +			 cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
> +	prcm_context.dss_cm_autoidle =
> +			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_AUTOIDLE);
> +	prcm_context.cam_cm_autoidle =
> +			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_AUTOIDLE);
> +	prcm_context.per_cm_autoidle =
> +			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
> +	prcm_context.usbhost_cm_autoidle =
> +			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
> +	prcm_context.sgx_cm_sleepdep =
> +		 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP3430_CM_SLEEPDEP);
> +	prcm_context.dss_cm_sleepdep =
> +		 cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP3430_CM_SLEEPDEP);
> +	prcm_context.cam_cm_sleepdep =
> +		 cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP3430_CM_SLEEPDEP);
> +	prcm_context.per_cm_sleepdep =
> +		 cm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_CM_SLEEPDEP);
> +	prcm_context.usbhost_cm_sleepdep =
> +		 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
> +	prcm_context.cm_clkout_ctrl = __raw_readl(OMAP3430_CM_CLKOUT_CTRL);
> +	prcm_context.prm_clkout_ctrl = __raw_readl(OMAP3430_PRM_CLKOUT_CTRL);
> +	prcm_context.sgx_pm_wkdep =
> +		 prm_read_mod_reg(OMAP3430ES2_SGX_MOD, PM_WKDEP);
> +	prcm_context.dss_pm_wkdep =
> +		 prm_read_mod_reg(OMAP3430_DSS_MOD, PM_WKDEP);
> +	prcm_context.cam_pm_wkdep =
> +		 prm_read_mod_reg(OMAP3430_CAM_MOD, PM_WKDEP);
> +	prcm_context.per_pm_wkdep =
> +		 prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKDEP);
> +	prcm_context.neon_pm_wkdep =
> +		 prm_read_mod_reg(OMAP3430_NEON_MOD, PM_WKDEP);
> +	prcm_context.usbhost_pm_wkdep =
> +		 prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
> +	prcm_context.core_pm_mpugrpsel1 =
> +		 prm_read_mod_reg(CORE_MOD, OMAP3430_PM_MPUGRPSEL1);
> +	prcm_context.iva2_pm_ivagrpsel1 =
> +		 prm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_PM_IVAGRPSEL1);
> +	prcm_context.core_pm_mpugrpsel3 =
> +		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_MPUGRPSEL3);
> +	prcm_context.core_pm_ivagrpsel3 =
> +		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
> +	prcm_context.wkup_pm_mpugrpsel =
> +		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
> +	prcm_context.wkup_pm_ivagrpsel =
> +		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
> +	prcm_context.per_pm_mpugrpsel =
> +		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
> +	prcm_context.per_pm_ivagrpsel =
> +		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
> +	prcm_context.wkup_pm_wken = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> +	return;
> +}
> +
> +void omap3_restore_prcm_ctx(void)
> +{

Replace these with a call to omap_intcps_restore_mir(&mir_ctx);

> +	omap_writel(prcm_context.intc_mir_0, INTC_MIR_0);
> +	omap_writel(prcm_context.intc_mir_1, INTC_MIR_1);
> +	omap_writel(prcm_context.intc_mir_2, INTC_MIR_2);
> +	omap_ctrl_writel(prcm_context.control_padconf_sys_nirq,
> +					 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
> +	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
> +					 CM_CLKSEL2);
> +	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
> +	cm_write_mod_reg(prcm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
> +					 CM_CLKSEL);
> +	cm_write_mod_reg(prcm_context.wkup_cm_clksel, WKUP_MOD, CM_CLKSEL);
> +	cm_write_mod_reg(prcm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
> +					 CM_CLKSEL);
> +	cm_write_mod_reg(prcm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
> +					 CM_CLKSEL);
> +	cm_write_mod_reg(prcm_context.per_cm_clksel, OMAP3430_PER_MOD,
> +					 CM_CLKSEL);
> +	cm_write_mod_reg(prcm_context.emu_cm_clksel, OMAP3430_EMU_MOD,
> +					 CM_CLKSEL1);
> +	cm_write_mod_reg(prcm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
> +					 CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.pll_cm_autoidle2, PLL_MOD,
> +					 CM_AUTOIDLE2);
> +	cm_write_mod_reg(prcm_context.pll_cm_clksel5, PLL_MOD,
> +					 OMAP3430ES2_CM_CLKSEL5);
> +	__raw_writel(prcm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
> +	cm_write_mod_reg(prcm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
> +					 CM_FCLKEN);
> +	cm_write_mod_reg(prcm_context.core_cm_fclken1, CORE_MOD, CM_FCLKEN1);
> +	cm_write_mod_reg(prcm_context.core_cm_fclken3, CORE_MOD,
> +					 OMAP3430ES2_CM_FCLKEN3);
> +	cm_write_mod_reg(prcm_context.sgx_cm_fclken, OMAP3430ES2_SGX_MOD,
> +					 CM_FCLKEN);
> +	cm_write_mod_reg(prcm_context.wkup_cm_fclken, WKUP_MOD, CM_FCLKEN);
> +	cm_write_mod_reg(prcm_context.dss_cm_fclken, OMAP3430_DSS_MOD,
> +					 CM_FCLKEN);
> +	cm_write_mod_reg(prcm_context.cam_cm_fclken, OMAP3430_CAM_MOD,
> +					 CM_FCLKEN);
> +	cm_write_mod_reg(prcm_context.per_cm_fclken, OMAP3430_PER_MOD,
> +					 CM_FCLKEN);
> +	cm_write_mod_reg(prcm_context.usbhost_cm_fclken,
> +					 OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
> +	cm_write_mod_reg(prcm_context.core_cm_iclken1, CORE_MOD, CM_ICLKEN1);
> +	cm_write_mod_reg(prcm_context.core_cm_iclken2, CORE_MOD, CM_ICLKEN2);
> +	cm_write_mod_reg(prcm_context.core_cm_iclken3, CORE_MOD, CM_ICLKEN3);
> +	cm_write_mod_reg(prcm_context.sgx_cm_iclken, OMAP3430ES2_SGX_MOD,
> +					CM_ICLKEN);
> +	cm_write_mod_reg(prcm_context.wkup_cm_iclken, WKUP_MOD, CM_ICLKEN);
> +	cm_write_mod_reg(prcm_context.dss_cm_iclken, OMAP3430_DSS_MOD,
> +					CM_ICLKEN);
> +	cm_write_mod_reg(prcm_context.cam_cm_iclken, OMAP3430_CAM_MOD,
> +					CM_ICLKEN);
> +	cm_write_mod_reg(prcm_context.per_cm_iclken, OMAP3430_PER_MOD,
> +					CM_ICLKEN);
> +	cm_write_mod_reg(prcm_context.usbhost_cm_iclken,
> +					OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
> +	cm_write_mod_reg(prcm_context.iva2_cm_autiidle2, OMAP3430_IVA2_MOD,
> +					CM_AUTOIDLE2);
> +	cm_write_mod_reg(prcm_context.mpu_cm_autoidle2, MPU_MOD, CM_AUTOIDLE2);
> +	cm_write_mod_reg(prcm_context.pll_cm_autoidle, PLL_MOD, CM_AUTOIDLE);
> +	cm_write_mod_reg(prcm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
> +					CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.mpu_cm_clkstctrl, MPU_MOD, CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.core_cm_clkstctrl, CORE_MOD,
> +					CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.sgx_cm_clkstctrl, OMAP3430ES2_SGX_MOD,
> +					CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.dss_cm_clkstctrl, OMAP3430_DSS_MOD,
> +					CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.cam_cm_clkstctrl, OMAP3430_CAM_MOD,
> +					CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.per_cm_clkstctrl, OMAP3430_PER_MOD,
> +					CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.neon_cm_clkstctrl, OMAP3430_NEON_MOD,
> +					CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.usbhost_cm_clkstctrl,
> +					OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
> +	cm_write_mod_reg(prcm_context.core_cm_autoidle1, CORE_MOD,
> +					CM_AUTOIDLE1);
> +	cm_write_mod_reg(prcm_context.core_cm_autoidle2, CORE_MOD,
> +					CM_AUTOIDLE2);
> +	cm_write_mod_reg(prcm_context.core_cm_autoidle3, CORE_MOD,
> +					CM_AUTOIDLE3);
> +	cm_write_mod_reg(prcm_context.wkup_cm_autoidle, WKUP_MOD, CM_AUTOIDLE);
> +	cm_write_mod_reg(prcm_context.dss_cm_autoidle, OMAP3430_DSS_MOD,
> +					CM_AUTOIDLE);
> +	cm_write_mod_reg(prcm_context.cam_cm_autoidle, OMAP3430_CAM_MOD,
> +					CM_AUTOIDLE);
> +	cm_write_mod_reg(prcm_context.per_cm_autoidle, OMAP3430_PER_MOD,
> +					CM_AUTOIDLE);
> +	cm_write_mod_reg(prcm_context.usbhost_cm_autoidle,
> +					OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
> +	cm_write_mod_reg(prcm_context.sgx_cm_sleepdep, OMAP3430ES2_SGX_MOD,
> +					OMAP3430_CM_SLEEPDEP);
> +	cm_write_mod_reg(prcm_context.dss_cm_sleepdep, OMAP3430_DSS_MOD,
> +					OMAP3430_CM_SLEEPDEP);
> +	cm_write_mod_reg(prcm_context.cam_cm_sleepdep, OMAP3430_CAM_MOD,
> +					OMAP3430_CM_SLEEPDEP);
> +	cm_write_mod_reg(prcm_context.per_cm_sleepdep, OMAP3430_PER_MOD,
> +					OMAP3430_CM_SLEEPDEP);
> +	cm_write_mod_reg(prcm_context.usbhost_cm_sleepdep,
> +				 OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
> +	__raw_writel(prcm_context.cm_clkout_ctrl, OMAP3430_CM_CLKOUT_CTRL);
> +	__raw_writel(prcm_context.prm_clkout_ctrl, OMAP3430_PRM_CLKOUT_CTRL);
> +	prm_write_mod_reg(prcm_context.sgx_pm_wkdep, OMAP3430ES2_SGX_MOD,
> +					PM_WKDEP);
> +	prm_write_mod_reg(prcm_context.dss_pm_wkdep, OMAP3430_DSS_MOD,
> +					PM_WKDEP);
> +	prm_write_mod_reg(prcm_context.cam_pm_wkdep, OMAP3430_CAM_MOD,
> +					PM_WKDEP);
> +	prm_write_mod_reg(prcm_context.per_pm_wkdep, OMAP3430_PER_MOD,
> +					PM_WKDEP);
> +	prm_write_mod_reg(prcm_context.neon_pm_wkdep, OMAP3430_NEON_MOD,
> +					PM_WKDEP);
> +	prm_write_mod_reg(prcm_context.usbhost_pm_wkdep,
> +					OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
> +	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel1, CORE_MOD,
> +					OMAP3430_PM_MPUGRPSEL1);
> +	prm_write_mod_reg(prcm_context.iva2_pm_ivagrpsel1, OMAP3430_IVA2_MOD,
> +					OMAP3430_PM_IVAGRPSEL1);
> +	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel3, CORE_MOD,
> +					OMAP3430ES2_PM_MPUGRPSEL3);
> +	prm_write_mod_reg(prcm_context.core_pm_ivagrpsel3, CORE_MOD,
> +					OMAP3430ES2_PM_IVAGRPSEL3);
> +	prm_write_mod_reg(prcm_context.wkup_pm_mpugrpsel, WKUP_MOD,
> +					OMAP3430_PM_MPUGRPSEL);
> +	prm_write_mod_reg(prcm_context.wkup_pm_ivagrpsel, WKUP_MOD,
> +					OMAP3430_PM_IVAGRPSEL);
> +	prm_write_mod_reg(prcm_context.per_pm_mpugrpsel, OMAP3430_PER_MOD,
> +					OMAP3430_PM_MPUGRPSEL);
> +	prm_write_mod_reg(prcm_context.per_pm_ivagrpsel, OMAP3430_PER_MOD,
> +					 OMAP3430_PM_IVAGRPSEL);
> +	prm_write_mod_reg(prcm_context.wkup_pm_wken, WKUP_MOD, PM_WKEN);
> +	return;
> +}
> +#endif
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/prcm.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/prcm.h	2008-09-01
> 18:11:28.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/prcm.h	2008-09-01
> 18:11:53.000000000 +0530
> @@ -30,6 +30,98 @@ void cm_write_mod_reg(u32 val, s16 modul
>  u32 cm_read_mod_reg(s16 module, u16 idx);
>  u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
> 
> +#ifdef CONFIG_ARCH_OMAP3
> +
> +#define START_PADCONF_SAVE 0x2
> +#define PADCONF_SAVE_DONE  0x1
> +
> +/* Interrupt Controller registers */
> +#define INTC_MIR_0      0x48200084
> +#define INTC_MIR_1      0x482000A4
> +#define INTC_MIR_2      0x482000C4

Please erase the above three defines - they are absolute addresses and 
should be handled in a relative manner like the other INTC regs.

> +struct prcm_context_regs {
> +	u32 intc_mir_0;
> +	u32 intc_mir_1;
> +	u32 intc_mir_2;
> +	u32 control_padconf_sys_nirq;
> +	u32 iva2_cm_clksel2;
> +	u32 cm_sysconfig;
> +	u32 sgx_cm_clksel;
> +	u32 wkup_cm_clksel;
> +	u32 dss_cm_clksel;
> +	u32 cam_cm_clksel;
> +	u32 per_cm_clksel;
> +	u32 emu_cm_clksel;
> +	u32 emu_cm_clkstctrl;
> +	u32 pll_cm_autoidle2;
> +	u32 pll_cm_clksel5;
> +	u32 cm_polctrl;
> +	u32 iva2_cm_fclken;
> +	u32 core_cm_fclken1;
> +	u32 core_cm_fclken3;
> +	u32 sgx_cm_fclken;
> +	u32 wkup_cm_fclken;
> +	u32 dss_cm_fclken;
> +	u32 cam_cm_fclken;
> +	u32 per_cm_fclken;
> +	u32 usbhost_cm_fclken;
> +	u32 core_cm_iclken1;
> +	u32 core_cm_iclken2;
> +	u32 core_cm_iclken3;
> +	u32 sgx_cm_iclken;
> +	u32 wkup_cm_iclken;
> +	u32 dss_cm_iclken;
> +	u32 cam_cm_iclken;
> +	u32 per_cm_iclken;
> +	u32 usbhost_cm_iclken;
> +	u32 iva2_cm_autiidle2;
> +	u32 mpu_cm_autoidle2;
> +	u32 pll_cm_autoidle;
> +	u32 iva2_cm_clkstctrl;
> +	u32 mpu_cm_clkstctrl;
> +	u32 core_cm_clkstctrl;
> +	u32 sgx_cm_clkstctrl;
> +	u32 dss_cm_clkstctrl;
> +	u32 cam_cm_clkstctrl;
> +	u32 per_cm_clkstctrl;
> +	u32 neon_cm_clkstctrl;
> +	u32 usbhost_cm_clkstctrl;
> +	u32 core_cm_autoidle1;
> +	u32 core_cm_autoidle2;
> +	u32 core_cm_autoidle3;
> +	u32 wkup_cm_autoidle;
> +	u32 dss_cm_autoidle;
> +	u32 cam_cm_autoidle;
> +	u32 per_cm_autoidle;
> +	u32 usbhost_cm_autoidle;
> +	u32 sgx_cm_sleepdep;
> +	u32 dss_cm_sleepdep;
> +	u32 cam_cm_sleepdep;
> +	u32 per_cm_sleepdep;
> +	u32 usbhost_cm_sleepdep;
> +	u32 cm_clkout_ctrl;
> +	u32 prm_clkout_ctrl;
> +	u32 sgx_pm_wkdep;
> +	u32 dss_pm_wkdep;
> +	u32 cam_pm_wkdep;
> +	u32 per_pm_wkdep;
> +	u32 neon_pm_wkdep;
> +	u32 usbhost_pm_wkdep;
> +	u32 core_pm_mpugrpsel1;
> +	u32 iva2_pm_ivagrpsel1;
> +	u32 core_pm_mpugrpsel3;
> +	u32 core_pm_ivagrpsel3;
> +	u32 wkup_pm_mpugrpsel;
> +	u32 wkup_pm_ivagrpsel;
> +	u32 per_pm_mpugrpsel;
> +	u32 per_pm_ivagrpsel;
> +	u32 wkup_pm_wken;
> +};
> +
> +void omap3_save_prcm_ctx(void);
> +void omap3_restore_prcm_ctx(void);
> +#endif
>  #endif
> 
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/prm.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/prm.h	2008-09-01 18:11:28.000000000
> +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/prm.h	2008-09-01 18:11:53.000000000 +0530
> @@ -137,9 +137,11 @@
> 
>  #define OMAP3430_PM_MPUGRPSEL				0x00a4
>  #define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
> +#define OMAP3430ES2_PM_MPUGRPSEL3                       0x00f8

Please check the whitespace on this define - it should use tabs.


> 
>  #define OMAP3430_PM_IVAGRPSEL				0x00a8
>  #define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
> +#define OMAP3430ES2_PM_IVAGRPSEL3                       0x00f4

Please check the whitespace on this define - it should use tabs.

> 
>  #define OMAP3430_PM_PREPWSTST				0x00e8
> 
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/control.h	2008-09-01
> 18:11:34.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h	2008-09-01
> 18:11:53.000000000 +0530
> @@ -108,6 +108,8 @@
>  #define OMAP24XX_CONTROL_TEST_KEY_8	(OMAP2_CONTROL_GENERAL + 0x00e0)
>  #define OMAP24XX_CONTROL_TEST_KEY_9	(OMAP2_CONTROL_GENERAL + 0x00e4)
> 
> +#define OMAP343X_CONTROL_PADCONF_SYSNIRQ (OMAP2_CONTROL_INTERFACE + 0x01b0)
> +
>  /* 34xx-only CONTROL_GENERAL register offsets */
>  #define OMAP343X_CONTROL_PADCONF_OFF	(OMAP2_CONTROL_GENERAL + 0x0000)
>  #define OMAP343X_CONTROL_MEM_DFTRW0	(OMAP2_CONTROL_GENERAL + 0x0008)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
