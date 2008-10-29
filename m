From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/16] OMAP3: Populate scratchpad contents
Date: Wed, 29 Oct 2008 14:14:31 -0700
Message-ID: <87skqf6r48.fsf@deeprootsystems.com>
References: <01f901c91fd2$06570810$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.235]:20522 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYJ2VOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 17:14:37 -0400
Received: by qb-out-0506.google.com with SMTP id f11so108736qba.17
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 14:14:36 -0700 (PDT)
In-Reply-To: <01f901c91fd2$06570810$LocalHost@wipultra1382> (Rajendra Nayak's message of "Fri\, 26 Sep 2008 17\:48\:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra,

Could you comment on the problem I found below...

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch populates the scratchpad contents
> as expected by the bootROM code.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/control.c             |  204 ++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/control.h |   10 +
>  2 files changed, 214 insertions(+)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/control.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/control.c	2008-09-26 10:03:38.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/control.c	2008-09-26 13:45:57.000000000 +0530
> @@ -17,9 +17,82 @@
>  
>  #include <mach/common.h>
>  #include <mach/control.h>
> +#include <mach/sdrc.h>
> +#include "cm-regbits-34xx.h"
> +#include "prm-regbits-34xx.h"
> +#include "cm.h"
> +#include "prm.h"
> +#include "clock34xx.h"
> +#include "sdrc.h"
>  
>  static void __iomem *omap2_ctrl_base;
>  
> +struct omap3_scratchpad {
> +	u32 boot_config_ptr;
> +	u32 public_restore_ptr;
> +	u32 secure_ram_restore_ptr;
> +	u32 sdrc_module_semaphore;
> +	u32 prcm_block_offset;
> +	u32 sdrc_block_offset;
> +};
> +
> +struct omap3_scratchpad_prcm_block {
> +	u32 prm_clksrc_ctrl;
> +	u32 prm_clksel;
> +	u32 cm_clksel_core;
> +	u32 cm_clksel_wkup;
> +	u32 cm_clken_pll;
> +	u32 cm_autoidle_pll;
> +	u32 cm_clksel1_pll;
> +	u32 cm_clksel2_pll;
> +	u32 cm_clksel3_pll;
> +	u32 cm_clken_pll_mpu;
> +	u32 cm_autoidle_pll_mpu;
> +	u32 cm_clksel1_pll_mpu;
> +	u32 cm_clksel2_pll_mpu;
> +	u32 prcm_block_size;
> +};
> +
> +struct omap3_scratchpad_sdrc_block {
> +	u16 sysconfig;
> +	u16 cs_cfg;
> +	u16 sharing;
> +	u16 err_type;
> +	u32 dll_a_ctrl;
> +	u32 dll_b_ctrl;
> +	u32 power;
> +	u32 cs_0;
> +	u32 mcfg_0;
> +	u16 mr_0;
> +	u16 emr_1_0;
> +	u16 emr_2_0;
> +	u16 emr_3_0;
> +	u32 actim_ctrla_0;
> +	u32 actim_ctrlb_0;
> +	u32 rfr_ctrl_0;
> +	u32 cs_1;
> +	u32 mcfg_1;
> +	u16 mr_1;
> +	u16 emr_1_1;
> +	u16 emr_2_1;
> +	u16 emr_3_1;
> +	u32 actim_ctrla_1;
> +	u32 actim_ctrlb_1;
> +	u32 rfr_ctrl_1;
> +	u16 dcdl_1_ctrl;
> +	u16 dcdl_2_ctrl;
> +	u32 flags;
> +	u32 block_size;
> +};
> +
> +/*
> + * This is used to store ARM registers in SDRAM before attempting
> + * an MPU OFF. The save and restore happens from the SRAM sleep code.
> + * The address is stored in scratchpad, so that it can be used
> + * during the restore path.
> + */
> +u32 omap3_arm_context[128];
> +
>  #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
>  
>  void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
> @@ -62,3 +135,134 @@ void omap_ctrl_writel(u32 val, u16 offse
>  	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
>  }
>  
> +#ifdef CONFIG_ARCH_OMAP3
> +/*
> + * Clears the scratchpad contents in case of cold boot-
> + * called during bootup
> + */
> +void omap3_clear_scratchpad_contents(void)
> +{
> +	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
> +	u32 *v_addr;
> +	u32 offset = 0;
> +	v_addr = OMAP2_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
> +	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
> +		OMAP3430_GLOBAL_COLD_RST) {
> +		for ( ; offset <= max_offset; offset += 0x4)
> +			__raw_writel(0x0, (v_addr + offset));
> +		prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST, OMAP3430_GR_MOD,
> +			OMAP3_PRM_RSTST_OFFSET);
> +	}
> +}
> +
> +/* Populate the scratchpad structure with restore structure */
> +void omap3_save_scratchpad_contents(void)
> +{
> +	void * __iomem scratchpad_address;
> +	u32 arm_context_addr;
> +	struct omap3_scratchpad scratchpad_contents;
> +	struct omap3_scratchpad_prcm_block prcm_block_contents;
> +	struct omap3_scratchpad_sdrc_block sdrc_block_contents;
> +
> +	/* Populate the Scratchpad contents */
> +	scratchpad_contents.boot_config_ptr = 0x0;
> +	scratchpad_contents.public_restore_ptr =
> +			 virt_to_phys(get_restore_pointer());
> +	scratchpad_contents.secure_ram_restore_ptr = 0x0;
> +	scratchpad_contents.sdrc_module_semaphore = 0x0;
> +	scratchpad_contents.prcm_block_offset = 0x2C;
> +	scratchpad_contents.sdrc_block_offset = 0x64;
> +
> +	/* Populate the PRCM block contents */
> +	prcm_block_contents.prm_clksrc_ctrl = prm_read_mod_reg(OMAP3430_GR_MOD,
> +			OMAP3_PRM_CLKSRC_CTRL_OFFSET);
> +	prcm_block_contents.prm_clksel = prm_read_mod_reg(OMAP3430_CCR_MOD,
> +			OMAP3_PRM_CLKSEL_OFFSET);
> +	prcm_block_contents.cm_clksel_core =
> +			cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
> +	prcm_block_contents.cm_clksel_wkup =
> +			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
> +	prcm_block_contents.cm_clken_pll =
> +			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKEN_PLL);
> +	prcm_block_contents.cm_autoidle_pll =
> +			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
> +	prcm_block_contents.cm_clksel1_pll =
> +			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
> +	prcm_block_contents.cm_clksel2_pll =
> +			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL2_PLL);
> +	prcm_block_contents.cm_clksel3_pll =
> +			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL3);
> +	prcm_block_contents.cm_clken_pll_mpu =
> +			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKEN_PLL);
> +	prcm_block_contents.cm_autoidle_pll_mpu =
> +			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL);
> +	prcm_block_contents.cm_clksel1_pll_mpu =
> +			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL);
> +	prcm_block_contents.cm_clksel2_pll_mpu =
> +			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL);
> +	prcm_block_contents.prcm_block_size = 0x0;
> +
> +	/* Populate the SDRC block contents */
> +	sdrc_block_contents.sysconfig =
> +			(sdrc_read_reg(SDRC_SYSCONFIG) & 0xFFFF);
> +	sdrc_block_contents.cs_cfg =
> +			(sdrc_read_reg(SDRC_CS_CFG) & 0xFFFF);
> +	sdrc_block_contents.sharing =
> +			(sdrc_read_reg(SDRC_SHARING) & 0xFFFF);
> +	sdrc_block_contents.err_type =
> +			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
> +	sdrc_block_contents.dll_a_ctrl = sdrc_read_reg(SDRC_DLLA_CTRL);
> +	sdrc_block_contents.dll_b_ctrl = 0x0;
> +	sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
> +	sdrc_block_contents.cs_0 = 0x0;
> +	sdrc_block_contents.mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
> +	sdrc_block_contents.mr_0 = (sdrc_read_reg(SDRC_MR_0) & 0xFFFF);
> +	sdrc_block_contents.emr_1_0 = 0x0;
> +	sdrc_block_contents.emr_2_0 = 0x0;
> +	sdrc_block_contents.emr_3_0 = 0x0;
> +	sdrc_block_contents.actim_ctrla_0 =
> +			sdrc_read_reg(SDRC_ACTIM_CTRL_A_0);
> +	sdrc_block_contents.actim_ctrlb_0 =
> +			sdrc_read_reg(SDRC_ACTIM_CTRL_B_0);
> +	sdrc_block_contents.rfr_ctrl_0 =
> +			sdrc_read_reg(SDRC_RFR_CTRL_0);
> +	sdrc_block_contents.cs_1 = 0x0;
> +	sdrc_block_contents.mcfg_1 = sdrc_read_reg(SDRC_MCFG_1);
> +	sdrc_block_contents.mr_1 = sdrc_read_reg(SDRC_MR_1) & 0xFFFF;
> +	sdrc_block_contents.emr_1_1 = 0x0;
> +	sdrc_block_contents.emr_2_1 = 0x0;
> +	sdrc_block_contents.emr_3_1 = 0x0;
> +	sdrc_block_contents.actim_ctrla_1 =
> +			sdrc_read_reg(SDRC_ACTIM_CTRL_A_1);
> +	sdrc_block_contents.actim_ctrlb_1 =
> +			sdrc_read_reg(SDRC_ACTIM_CTRL_B_1);
> +	sdrc_block_contents.rfr_ctrl_1 =
> +			sdrc_read_reg(SDRC_RFR_CTRL_1);
> +	sdrc_block_contents.dcdl_1_ctrl = 0x0;
> +	sdrc_block_contents.dcdl_2_ctrl = 0x0;
> +	sdrc_block_contents.flags = 0x0;
> +	sdrc_block_contents.block_size = 0x0;
> +
> +	arm_context_addr = io_v2p(omap3_arm_context);

Here you are attempting to convert a virtual memory address into a
physical IO address.  This is clearly wrong, but what is even more
strange is how the code is still working.

This macro will simply add IO_OFFSET=0x01000000 to the memory address,
resulting in another arbitrary _virtual_ memory address.

I believe what is intented is for arm_context_addr to be a physical
memory address, right?  I've converted this to virt_to_phys().

Kevin


> +	/* Copy all the contents to the scratchpad location */
> +	scratchpad_address = OMAP2_IO_ADDRESS(OMAP343X_SCRATCHPAD);
> +	memcpy_toio(scratchpad_address, &scratchpad_contents,
> +		 sizeof(scratchpad_contents));
> +	/* Scratchpad contents being 32 bits, a divide by 4 done here */
> +	memcpy_toio(scratchpad_address +
> +		scratchpad_contents.prcm_block_offset,
> +		&prcm_block_contents, sizeof(prcm_block_contents));
> +	memcpy_toio(scratchpad_address +
> +		scratchpad_contents.sdrc_block_offset,
> +		&sdrc_block_contents, sizeof(sdrc_block_contents));
> +	/*
> +	 * Copies the address of the location in SDRAM where ARM
> +	 * registers get saved during a MPU OFF transition.
> +	 */
> +	memcpy_toio(scratchpad_address +
> +		scratchpad_contents.sdrc_block_offset +
> +		sizeof(sdrc_block_contents), &arm_context_addr, 4);
> +}
> +
> +#endif /* CONFIG_ARCH_OMAP3 */
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/control.h	2008-09-26 10:04:00.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h	2008-09-26 13:45:57.000000000 +0530
> @@ -193,6 +193,10 @@
>  #define OMAP343X_SR1_SENPENABLE_MASK	(0x3 << 0)
>  #define OMAP343X_SR1_SENPENABLE_SHIFT	0
>  
> +#define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
> +#define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
> +#define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
> +
>  #ifndef __ASSEMBLY__
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  extern void __iomem *omap_ctrl_base_get(void);
> @@ -202,6 +206,12 @@ extern u32 omap_ctrl_readl(u16 offset);
>  extern void omap_ctrl_writeb(u8 val, u16 offset);
>  extern void omap_ctrl_writew(u16 val, u16 offset);
>  extern void omap_ctrl_writel(u32 val, u16 offset);
> +
> +extern void omap3_save_scratchpad_contents(void);
> +extern void omap3_clear_scratchpad_contents(void);
> +extern u32 *get_restore_pointer(void);
> +extern u32 omap3_arm_context[128];
> +
>  #else
>  #define omap_ctrl_base_get()		0
>  #define omap_ctrl_readb(x)		0
