From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 05/11] scratchpad contents
Date: Wed, 02 Jul 2008 15:14:31 +0300
Message-ID: <87fxqssct4.fsf@trdhcp146196.ntc.nokia.com>
References: <004201c8db85$06f5bb40$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32428 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbYGBMOq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 08:14:46 -0400
In-Reply-To: <004201c8db85$06f5bb40$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Tue, 1 Jul 2008 19:46:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> This patch populates the scratchpad
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> ---
>  arch/arm/mach-omap2/pm.h        |    7 +
>  arch/arm/mach-omap2/pm34xx.c    |  170 +++++++++++++++++++++++++++++=
++++++++++-
>  arch/arm/mach-omap2/sleep34xx.S |    8 -
>  include/asm-arm/arch-omap/pm.h  |    4=20
>  4 files changed, 182 insertions(+), 7 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-07-01 17:21:12.=
738682737 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-07-01 17:21:12.78368=
1306 +0530
> @@ -20,6 +20,13 @@ extern unsigned short enable_dyn_sleep;
>  extern unsigned short clocks_off_while_idle;
>  extern atomic_t sleep_block;
> =20
> +#define SCRATCHPAD_ROM  		0x48002860
> +#define SCRATCHPAD      		0x48002910
> +#define SCRATHPAD_ROM_OFFSET    	0x19C
> +#define TABLE_ADDRESS_OFFSET    	0x31
> +#define TABLE_VALUE_OFFSET      	0x30
> +#define CONTROL_REG_VALUE_OFFSET	0x32
> +
>  #ifdef CONFIG_PM_DEBUG
>  extern void omap2_pm_dump(int mode, int resume, unsigned int us);
>  extern int omap2_pm_debug;
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-07-01 17:21=
:12.761682006 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-07-01 17:22:24.1=
20412909 +0530
> @@ -30,6 +30,9 @@
>  #include <asm/arch/clockdomain.h>
>  #include <asm/arch/powerdomain.h>
>  #include <asm/arch/common.h>
> +#include <asm/arch/sdrc.h>
> +#include <asm/tlbflush.h>
> +#include "sdrc.h"
> =20
>  #include "cm.h"
>  #include "cm-regbits-34xx.h"
> @@ -38,6 +41,12 @@
>  #include "prm.h"
>  #include "pm.h"
>  #include "smartreflex.h"
> +#include "clock34xx.h"
> +
> +#define OMAP3430_PRM_RSTST      \
> +	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
> +
> +u32 context_mem[128];
> =20
>  struct power_state {
>  	struct powerdomain *pwrdm;
> @@ -46,6 +55,9 @@ struct power_state {
>  	struct list_head node;
>  };
> =20
> +u32 *scratchpad_restore_addr;
> +u32 restore_pointer_address;
> +
>  static LIST_HEAD(pwrst_list);
> =20
>  void (*_omap_sram_idle)(u32 *addr, int save_state, int disable_clock=
s);
> @@ -176,6 +188,35 @@ static irqreturn_t prcm_interrupt_handle
>  	return IRQ_HANDLED;
>  }
> =20
> +static void restore_control_register(u32 val)
> +{
> +	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
> +}
> +
> +/* Function to restore the table entry that was modified for enablin=
g MMU*/
> +static void restore_table_entry(void)
> +{
> +	u32 *scratchpad_address;
> +	u32 previous_value, control_reg_value;
> +	u32 *address;
> +	/* Get virtual address of SCRATCHPAD */
> +	scratchpad_address =3D (u32 *) io_p2v(SCRATCHPAD);
> +	/* Get address of entry that was modified */
> +	address =3D (u32 *) *(scratchpad_address + TABLE_ADDRESS_OFFSET);
> +	/* Get the previous value which needs to be restored */
> +	previous_value =3D *(scratchpad_address + TABLE_VALUE_OFFSET);
> +	/* Convert address to virtual address */
> +	address =3D __va(address);
> +	/* Restore table entry */
> +	*address =3D previous_value;
> +	/* Flush TLB */
> +	flush_tlb_all();
> +	control_reg_value =3D *(scratchpad_address + CONTROL_REG_VALUE_OFFS=
ET);
> +	/* Restore control register*/
> +	/* This will enable caches and prediction */
> +	restore_control_register(control_reg_value);
> +}
> +
>  void omap_sram_idle(void)
>  {
>  	/* Variable to tell what needs to be saved and restored
> @@ -196,13 +237,19 @@ void omap_sram_idle(void)
>  		/* No need to save context */
>  		save_state =3D 0;
>  		break;
> +	case PWRDM_POWER_OFF:
> +		save_state =3D 3;
> +		break;
>  	default:
>  		/* Invalid state */
>  		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
>  		return;
>  	}
> =20
> -	_omap_sram_idle(NULL, save_state, clocks_off_while_idle);
> +	_omap_sram_idle(context_mem, save_state, clocks_off_while_idle);
> +	/* Restore table entry modified during MMU restoration */
> +	if (pwrdm_read_prev_pwrst(mpu_pwrdm) =3D=3D 0x0)
> +		restore_table_entry();
>  }
> =20
>  static int omap3_fclks_active(void)
> @@ -593,7 +640,10 @@ static int __init pwrdms_setup(struct po
>  	if (!pwrst)
>  		return -ENOMEM;
>  	pwrst->pwrdm =3D pwrdm;
> -	pwrst->next_state =3D PWRDM_POWER_RET;
> +	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm"))
> +		pwrst->next_state =3D PWRDM_POWER_RET;
> +	else
> +		pwrst->next_state =3D PWRDM_POWER_OFF;

I think writing these states here should be behind #ifdef
CONFIG_CPU_IDLE at least what comest to mpu, neon and core. Then as we
have srf in l-o tree, rest of the pwrdm states should be written in
that code. This is basically for traditional pm_idle loop. Anyway
until srf is in tree you could write other than mpu, neon and core
states here.

>  	list_add(&pwrst->node, &pwrst_list);
> =20
>  	if (pwrdm_has_hdwr_sar(pwrdm))
> @@ -659,5 +709,121 @@ err2:
>  		list_del(&pwrst->node);
>  		kfree(pwrst);
>  	}
> +
>  	return ret;
>  }
> +
> +/* Clears the scratchpad contents in case of cold boot- called durin=
g bootup*/
> +void clear_scratchpad_contents(void)
> +{
> +	u32 max_offset =3D SCRATHPAD_ROM_OFFSET;
> +	u32 offset =3D 0;
> +	u32 v;
> +	u32 v_addr =3D io_p2v(SCRATCHPAD_ROM);
> +	if (__raw_readl(OMAP3430_PRM_RSTST) & 0x1) {
> +		for ( ; offset <=3D max_offset; offset +=3D 0x4)
> +			__raw_writel(0x0, (v_addr + offset));
> +		v =3D __raw_readl(OMAP3430_PRM_RSTST);
> +		v |=3D 0x1;
> +		__raw_writel(v, OMAP3430_PRM_RSTST);
> +	}
> +}
> +
> +/* Populate the scratchpad structure with restore structure */
> +void save_scratchpad_contents(void)
> +{
> +	u32 *scratchpad_address;
> +	u32 *restore_address;
> +	u32 *sdram_context_address;
> +
> +	/* Get virtual address of SCRATCHPAD */
> +	scratchpad_address =3D (u32 *) io_p2v(SCRATCHPAD);
> +	/* Get Restore pointer to jump to while waking up from OFF */
> +	restore_address =3D get_restore_pointer();
> +	/* Convert it to physical address */
> +	restore_address =3D (u32 *) io_v2p(restore_address);
> +	/* Get address where registers are saved in SDRAM */
> +	sdram_context_address =3D (u32 *) io_v2p(context_mem);
> +	/* Booting configuration pointer*/
> +	*(scratchpad_address++) =3D 0x0;
> +	/* Public restore pointer */
> +	/* On ES 2.0, if scrathpad is populated with valid
> +	* pointer, warm reset does not work
> +	* So populate scrathpad restore address only in
> +	* cpuidle and suspend calls
> +	*/
> +	scratchpad_restore_addr =3D scratchpad_address;
> +	restore_pointer_address =3D (u32) restore_address;
> +	*(scratchpad_address++) =3D 0x0;
> +	/* Secure ram restore pointer */
> +	*(scratchpad_address++) =3D 0x0;
> +	/* SDRC Module semaphore */
> +	*(scratchpad_address++) =3D 0x0;
> +	/* PRCM Block Offset */
> +	*(scratchpad_address++) =3D 0x2C;
> +	/* SDRC Block Offset */
> +	*(scratchpad_address++) =3D 0x64;
> +	/* Empty */
> +	/* Offset 0x8*/
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D 0x0;
> +	/* Offset 0xC*/
> +	*(scratchpad_address++) =3D 0x0;
> +	/* Offset 0x10*/
> +	*(scratchpad_address++) =3D 0x0;
> +	/* Offset 0x14*/
> +	*(scratchpad_address++) =3D 0x0;
> +	/* Offset 0x18*/
> +	/* PRCM Block */
> +	*(scratchpad_address++) =3D __raw_readl(OMAP3430_PRM_CLKSRC_CTRL);
> +	*(scratchpad_address++) =3D __raw_readl(OMAP3430_PRM_CLKSEL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
> +					OMAP3430_CM_CLKEN_PLL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
> +					OMAP3430_CM_AUTOIDLE_PLL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
> +					OMAP3430_CM_CLKSEL1_PLL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
> +					OMAP3430_CM_CLKSEL2_PLL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
> +					OMAP3430_CM_CLKSEL3);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(MPU_MOD,
> +					OMAP3430_CM_CLKEN_PLL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(MPU_MOD,
> +					OMAP3430_CM_AUTOIDLE_PLL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(MPU_MOD,
> +					OMAP3430_CM_CLKSEL1_PLL);
> +	*(scratchpad_address++) =3D cm_read_mod_reg(MPU_MOD,
> +					OMAP3430_CM_CLKSEL2_PLL);
> +	*(scratchpad_address++) =3D 0x0;
> +	/* SDRC Block */
> +	*(scratchpad_address++) =3D (((sdrc_read_reg(SDRC_CS_CFG) & 0xFFFF)=
 << 16)
> +				 | (sdrc_read_reg(SDRC_SYSCONFIG) & 0xFFFF));
> +	*(scratchpad_address++) =3D (((sdrc_read_reg(SDRC_ERR_TYPE)
> +				 & 0xFFFF) << 16)
> +				 | (sdrc_read_reg(SDRC_SHARING) & 0xFFFF));
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_DLLA_CTRL);
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_POWER);
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_MCFG_0);
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_MR_0) & 0xFFFF;
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_ACTIM_CTRL_A_0);
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_ACTIM_CTRL_B_0);
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_RFR_CTRL_0);
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_MCFG_1);
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_MR_1) & 0xFFFF;
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++)	=3D sdrc_read_reg(SDRC_ACTIM_CTRL_A_1);
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_ACTIM_CTRL_B_1);
> +	*(scratchpad_address++) =3D sdrc_read_reg(SDRC_RFR_CTRL_1);
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D 0x0;
> +	*(scratchpad_address++) =3D (u32) sdram_context_address;
> +}
> +
> Index: linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/sleep34xx.S	2008-07-01 17=
:21:09.043800223 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S	2008-07-01 17:22:0=
4.018052152 +0530
> @@ -37,12 +37,10 @@
>  				OMAP3430_PM_PREPWSTST)
>  #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
>  				OMAP3430_PM_PREPWSTST)
> -#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
> +#define PM_PWSTCTRL_MPU_P	0x483069E0
>  #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
>  				       * available */
> -#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
> -				OMAP343X_CONTROL_MEM_WKUP +\
> -				SCRATCHPAD_MEM_OFFS)
> +#define SCRATCHPAD_BASE_P	0x48002910
>  #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> =20
>  	.text
> @@ -97,7 +95,7 @@ loop:
> =20
>  	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
>  restore:
> -	/* b restore*/ 	@ Enable to debug restore code
> +	/* b restore*/  @ Enable to debug restore code
>          /* Check what was the reason for mpu reset and store the rea=
son in r9*/
>          /* 1 - Only L1 and logic lost */
>          /* 2 - Only L2 lost - In this case, we wont be here */
> Index: linux-omap-2.6/include/asm-arm/arch-omap/pm.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/pm.h	2008-07-01 17:=
21:09.043800223 +0530
> +++ linux-omap-2.6/include/asm-arm/arch-omap/pm.h	2008-07-01 17:21:12=
=2E785681242 +0530
> @@ -153,6 +153,10 @@ extern void omap1510_idle_loop_suspend(v
>  extern void omap1610_idle_loop_suspend(void);
>  extern void omap242x_idle_loop_suspend(void);
>  extern void omap243x_idle_loop_suspend(void);
> +extern void save_scratchpad_contents(void);
> +extern void clear_scratchpad_contents(void);
> +extern u32 *get_restore_pointer(void);
> +extern void vfp_enable(void);
> =20
>  extern unsigned int omap730_cpu_suspend_sz;
>  extern unsigned int omap1510_cpu_suspend_sz;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
