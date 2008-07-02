From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 11/11] CORE context save/restore
Date: Wed, 02 Jul 2008 16:44:02 +0300
Message-ID: <87wsk4qu3h.fsf@trdhcp146196.ntc.nokia.com>
References: <004801c8db85$1457c990$68bf18ac@ent.ti.com>
	<877ic4sbtm.fsf@trdhcp146196.ntc.nokia.com>
	<000601c8dc46$8857dc60$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45369 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbYGBNog convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 09:44:36 -0400
In-Reply-To: <000601c8dc46$8857dc60$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Wed, 2 Jul 2008 18:51:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> =20
>
>> -----Original Message-----
>> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
>> Sent: Wednesday, July 02, 2008 6:06 PM
>> To: ext Rajendra Nayak
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 11/11] CORE context save/restore
>>=20
>> "ext Rajendra Nayak" <rnayak@ti.com> writes:
>>=20
>> > This patch adds the CORE context save/restore routines
>> > - save/restores the following
>> > 	1) PRCM registers
>> > 	2) INTC context
>> > 	3) System Control module context
>> > 	4) Padconf
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> >
>> > ---
>> >  arch/arm/mach-omap2/cpuidle34xx.c   |  546=20
>> +++++++++++++++++++++++++++++++-----
>> >  arch/arm/mach-omap2/cpuidle34xx.h   |   32 +-
>> >  arch/arm/mach-omap2/pm34xx.c        |   45 ++
>> >  arch/arm/mach-omap2/prm.h           |    2=20
>> >  arch/arm/mach-omap2/serial.c        |   19 -
>> >  arch/arm/mach-omap2/sleep34xx.S     |   12=20
>> >  arch/arm/plat-omap/sram.c           |   15=20
>> >  include/asm-arm/arch-omap/common.h  |    2=20
>> >  include/asm-arm/arch-omap/control.h |   22 +
>> >  include/asm-arm/arch-omap/prcm.h    |   58 +++
>> >  10 files changed, 646 insertions(+), 107 deletions(-)
>> >
>> > Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c=09
>> 2008-07-01 18:51:23.077236449 +0530
>> > +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c=09
>> 2008-07-01 19:15:49.844144072 +0530
>> > @@ -28,12 +28,22 @@
>> >  #include <asm/arch/powerdomain.h>
>> >  #include <asm/arch/clockdomain.h>
>> >  #include <asm/arch/gpio.h>
>> > +#include <asm/arch/gpmc.h>
>> > +#include <asm/arch/control.h>
>> > +#include <linux/sched.h>
>> >  #include "cpuidle34xx.h"
>> > +#include "cm.h"
>> > +#include "cm-regbits-34xx.h"
>> > +#include "prm-regbits-34xx.h"
>> > +#include "prm.h"
>> > +#include "pm.h"
>> > +#include "clock34xx.h"
>> > =20
>> >  #ifdef CONFIG_CPU_IDLE
>> > =20
>> >  struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
>> >  struct omap3_processor_cx current_cx_state;
>> > +static int padconf_saved;
>> > =20
>> >  static int omap3_idle_bm_check(void)
>> >  {
>> > @@ -42,6 +52,379 @@ static int omap3_idle_bm_check(void)
>> >  	return 0;
>> >  }
>> > =20
>> > +void omap3_save_prcm_ctx(void)
>> > +{
>> > +	prcm_sleep_save[1] =3D omap_readl(INTC_MIR_0);
>> > +	prcm_sleep_save[2] =3D omap_readl(INTC_MIR_1);
>> > +	prcm_sleep_save[3] =3D omap_readl(INTC_MIR_2);
>> > +	prcm_sleep_save[4] =3D omap_readl(CONTROL_PADCONF_SYS_NIRQ);
>> > +	prcm_sleep_save[5] =3D omap_readl(OMAP34XX_GPIO1_IRQENABLE1);
>> > +	prcm_sleep_save[6] =3D omap_readl(OMAP34XX_GPIO1_WAKEUPEN);
>> > +	prcm_sleep_save[7] =3D cm_read_mod_reg(OMAP3430_IVA2_MOD,=20
>> CM_CLKSEL2);
>> > +	prcm_sleep_save[8] =3D __raw_readl(OMAP3430_CM_SYSCONFIG);
>> > +	prcm_sleep_save[9] =3D=20
>> cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
>> > +	prcm_sleep_save[10] =3D cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
>> > +	prcm_sleep_save[11] =3D cm_read_mod_reg(OMAP3430_DSS_MOD,=20
>> CM_CLKSEL);
>> > +	prcm_sleep_save[12] =3D cm_read_mod_reg(OMAP3430_CAM_MOD,=20
>> CM_CLKSEL);
>> > +	prcm_sleep_save[13] =3D cm_read_mod_reg(OMAP3430_PER_MOD,=20
>> CM_CLKSEL);
>> > +	prcm_sleep_save[14] =3D cm_read_mod_reg(OMAP3430_EMU_MOD,=20
>> CM_CLKSEL1);
>> > +	prcm_sleep_save[15] =3D cm_read_mod_reg(OMAP3430_EMU_MOD,=20
>> CM_CLKSTCTRL);
>> > +	prcm_sleep_save[16] =3D cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
>> > +	prcm_sleep_save[17] =3D cm_read_mod_reg(PLL_MOD,=20
>> OMAP3430ES2_CM_CLKSEL5);
>> > +	prcm_sleep_save[18] =3D __raw_readl(OMAP3430_CM_POLCTRL);
>> > +	prcm_sleep_save[19] =3D=20
>> cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
>> > +	prcm_sleep_save[20] =3D cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
>> > +	prcm_sleep_save[21] =3D cm_read_mod_reg(CORE_MOD,=20
>> OMAP3430ES2_CM_FCLKEN3);
>> > +	prcm_sleep_save[22] =3D=20
>> cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
>> > +	prcm_sleep_save[23] =3D cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
>> > +	prcm_sleep_save[24] =3D cm_read_mod_reg(OMAP3430_DSS_MOD,=20
>> CM_FCLKEN);
>> > +	prcm_sleep_save[25] =3D cm_read_mod_reg(OMAP3430_CAM_MOD,=20
>> CM_FCLKEN);
>> > +	prcm_sleep_save[26] =3D cm_read_mod_reg(OMAP3430_PER_MOD,=20
>> CM_FCLKEN);
>> > +	prcm_sleep_save[27] =3D cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
>> > +							     =20
>> CM_FCLKEN);
>> > +	prcm_sleep_save[28] =3D cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
>> > +	prcm_sleep_save[29] =3D cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
>> > +	prcm_sleep_save[30] =3D cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
>> > +	prcm_sleep_save[31] =3D=20
>> cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
>> > +	prcm_sleep_save[32] =3D cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
>> > +	prcm_sleep_save[33] =3D cm_read_mod_reg(OMAP3430_DSS_MOD,=20
>> CM_ICLKEN);
>> > +	prcm_sleep_save[34] =3D cm_read_mod_reg(OMAP3430_CAM_MOD,=20
>> CM_ICLKEN);
>> > +	prcm_sleep_save[35] =3D cm_read_mod_reg(OMAP3430_PER_MOD,=20
>> CM_ICLKEN);
>> > +	prcm_sleep_save[36] =3D cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
>> > +							     =20
>> CM_ICLKEN);
>> > +	prcm_sleep_save[37] =3D=20
>> cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
>> > +	prcm_sleep_save[38] =3D cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
>> > +	prcm_sleep_save[39] =3D cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
>> > +	prcm_sleep_save[40] =3D=20
>> cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
>> > +	prcm_sleep_save[41] =3D cm_read_mod_reg(MPU_MOD, CM_CLKSTCTRL);
>> > +	prcm_sleep_save[42] =3D cm_read_mod_reg(CORE_MOD, CM_CLKSTCTRL);
>> > +	prcm_sleep_save[43] =3D cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
>> > +							     =20
>> CM_CLKSTCTRL);
>> > +	prcm_sleep_save[44] =3D cm_read_mod_reg(OMAP3430_DSS_MOD,=20
>> CM_CLKSTCTRL);
>> > +	prcm_sleep_save[45] =3D cm_read_mod_reg(OMAP3430_CAM_MOD,=20
>> CM_CLKSTCTRL);
>> > +	prcm_sleep_save[46] =3D cm_read_mod_reg(OMAP3430_PER_MOD,=20
>> CM_CLKSTCTRL);
>> > +	prcm_sleep_save[47] =3D=20
>> cm_read_mod_reg(OMAP3430_NEON_MOD, CM_CLKSTCTRL);
>> > +	prcm_sleep_save[48] =3D cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
>> > +							     =20
>> CM_CLKSTCTRL);
>> > +	prcm_sleep_save[49] =3D cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
>> > +	prcm_sleep_save[50] =3D cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
>> > +	prcm_sleep_save[51] =3D cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
>> > +	prcm_sleep_save[52] =3D cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
>> > +	prcm_sleep_save[53] =3D cm_read_mod_reg(OMAP3430_DSS_MOD,=20
>> CM_AUTOIDLE);
>> > +	prcm_sleep_save[54] =3D cm_read_mod_reg(OMAP3430_CAM_MOD,=20
>> CM_AUTOIDLE);
>> > +	prcm_sleep_save[55] =3D cm_read_mod_reg(OMAP3430_PER_MOD,=20
>> CM_AUTOIDLE);
>> > +	prcm_sleep_save[56] =3D cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
>> > +							     =20
>> CM_AUTOIDLE);
>> > +	prcm_sleep_save[57] =3D cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
>> > +						     =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	prcm_sleep_save[58] =3D cm_read_mod_reg(OMAP3430_DSS_MOD,
>> > +						     =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	prcm_sleep_save[59] =3D cm_read_mod_reg(OMAP3430_CAM_MOD,
>> > +						     =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	prcm_sleep_save[60] =3D cm_read_mod_reg(OMAP3430_PER_MOD,
>> > +						     =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	prcm_sleep_save[61] =3D cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
>> > +						     =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	prcm_sleep_save[62] =3D __raw_readl(OMAP3430_CM_CLKOUT_CTRL);
>> > +	prcm_sleep_save[63] =3D __raw_readl(OMAP3430_PRM_CLKOUT_CTRL);
>> > +	prcm_sleep_save[64] =3D=20
>> prm_read_mod_reg(OMAP3430ES2_SGX_MOD, PM_WKDEP);
>> > +	prcm_sleep_save[65] =3D=20
>> prm_read_mod_reg(OMAP3430_DSS_MOD, PM_WKDEP);
>> > +	prcm_sleep_save[66] =3D=20
>> prm_read_mod_reg(OMAP3430_CAM_MOD, PM_WKDEP);
>> > +	prcm_sleep_save[67] =3D=20
>> prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKDEP);
>> > +	prcm_sleep_save[68] =3D=20
>> prm_read_mod_reg(OMAP3430_NEON_MOD, PM_WKDEP);
>> > +	prcm_sleep_save[69] =3D prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD=
,
>> > +							      =20
>> PM_WKDEP);
>> > +	prcm_sleep_save[70] =3D prm_read_mod_reg(CORE_MOD,
>> > +					      OMAP3430_PM_MPUGRPSEL1);
>> > +	prcm_sleep_save[71] =3D prm_read_mod_reg(OMAP3430_IVA2_MOD,
>> > +					      OMAP3430_PM_IVAGRPSEL1);
>> > +	prcm_sleep_save[72] =3D prm_read_mod_reg(CORE_MOD,
>> > +					     =20
>> OMAP3430ES2_PM_MPUGRPSEL3);
>> > +	prcm_sleep_save[73] =3D prm_read_mod_reg(CORE_MOD,
>> > +					     =20
>> OMAP3430ES2_PM_IVAGRPSEL3);
>> > +	prcm_sleep_save[74] =3D prm_read_mod_reg(WKUP_MOD,=20
>> OMAP3430_PM_MPUGRPSEL);
>> > +	prcm_sleep_save[75] =3D prm_read_mod_reg(WKUP_MOD,
>> > +					      OMAP3430_PM_IVAGRPSEL);
>> > +	prcm_sleep_save[76] =3D prm_read_mod_reg(OMAP3430_PER_MOD,
>> > +					      OMAP3430_PM_MPUGRPSEL);
>> > +	prcm_sleep_save[77] =3D prm_read_mod_reg(OMAP3430_PER_MOD,
>> > +					      OMAP3430_PM_IVAGRPSEL);
>> > +	prcm_sleep_save[78] =3D prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>> > +	return;
>> > +}
>> > +
>> > +void omap3_restore_prcm_ctx(void)
>> > +{
>> > +	omap_writel(prcm_sleep_save[1], INTC_MIR_0);
>> > +	omap_writel(prcm_sleep_save[2], INTC_MIR_1);
>> > +	omap_writel(prcm_sleep_save[3], INTC_MIR_2);
>> > +	omap_writel(prcm_sleep_save[4], CONTROL_PADCONF_SYS_NIRQ);
>> > +	omap_writel(prcm_sleep_save[5], OMAP34XX_GPIO1_IRQENABLE1);
>> > +	omap_writel(prcm_sleep_save[6], OMAP34XX_GPIO1_WAKEUPEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[7], OMAP3430_IVA2_MOD,=20
>> CM_CLKSEL2);
>> > +	__raw_writel(prcm_sleep_save[8], OMAP3430_CM_SYSCONFIG);
>> > +	cm_write_mod_reg(prcm_sleep_save[9],=20
>> OMAP3430ES2_SGX_MOD, CM_CLKSEL);
>> > +	cm_write_mod_reg(prcm_sleep_save[10], WKUP_MOD, CM_CLKSEL);
>> > +	cm_write_mod_reg(prcm_sleep_save[11], OMAP3430_DSS_MOD,=20
>> CM_CLKSEL);
>> > +	cm_write_mod_reg(prcm_sleep_save[12], OMAP3430_CAM_MOD,=20
>> CM_CLKSEL);
>> > +	cm_write_mod_reg(prcm_sleep_save[13], OMAP3430_PER_MOD,=20
>> CM_CLKSEL);
>> > +	cm_write_mod_reg(prcm_sleep_save[14], OMAP3430_EMU_MOD,=20
>> CM_CLKSEL1);
>> > +	cm_write_mod_reg(prcm_sleep_save[15], OMAP3430_EMU_MOD,=20
>> CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[16], PLL_MOD, CM_AUTOIDLE2);
>> > +	cm_write_mod_reg(prcm_sleep_save[17], PLL_MOD,=20
>> OMAP3430ES2_CM_CLKSEL5);
>> > +	__raw_writel(prcm_sleep_save[18], OMAP3430_CM_POLCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[19],=20
>> OMAP3430_IVA2_MOD, CM_FCLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[20], CORE_MOD, CM_FCLKEN1);
>> > +	cm_write_mod_reg(prcm_sleep_save[21], CORE_MOD,=20
>> OMAP3430ES2_CM_FCLKEN3);
>> > +	cm_write_mod_reg(prcm_sleep_save[22],=20
>> OMAP3430ES2_SGX_MOD, CM_FCLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[23], WKUP_MOD, CM_FCLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[24], OMAP3430_DSS_MOD,=20
>> CM_FCLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[25], OMAP3430_CAM_MOD,=20
>> CM_FCLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[26], OMAP3430_PER_MOD,=20
>> CM_FCLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[27], OMAP3430ES2_USBHOST_MOD,
>> > +							      =20
>> CM_FCLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[28], CORE_MOD, CM_ICLKEN1);
>> > +	cm_write_mod_reg(prcm_sleep_save[29], CORE_MOD, CM_ICLKEN2);
>> > +	cm_write_mod_reg(prcm_sleep_save[30], CORE_MOD, CM_ICLKEN3);
>> > +	cm_write_mod_reg(prcm_sleep_save[31],=20
>> OMAP3430ES2_SGX_MOD, CM_ICLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[32], WKUP_MOD, CM_ICLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[33], OMAP3430_DSS_MOD,=20
>> CM_ICLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[34], OMAP3430_CAM_MOD,=20
>> CM_ICLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[35], OMAP3430_PER_MOD,=20
>> CM_ICLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[36], OMAP3430ES2_USBHOST_MOD,
>> > +							=09
>> CM_ICLKEN);
>> > +	cm_write_mod_reg(prcm_sleep_save[37],=20
>> OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
>> > +	cm_write_mod_reg(prcm_sleep_save[38], MPU_MOD, CM_AUTOIDLE2);
>> > +	cm_write_mod_reg(prcm_sleep_save[39], PLL_MOD, CM_AUTOIDLE);
>> > +	cm_write_mod_reg(prcm_sleep_save[40],=20
>> OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[41], MPU_MOD, CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[42], CORE_MOD, CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[43], OMAP3430ES2_SGX_MOD,
>> > +						       CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[44], OMAP3430_DSS_MOD,=20
>> CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[45], OMAP3430_CAM_MOD,=20
>> CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[46], OMAP3430_PER_MOD,=20
>> CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[47],=20
>> OMAP3430_NEON_MOD, CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[48], OMAP3430ES2_USBHOST_MOD,
>> > +							      =20
>> CM_CLKSTCTRL);
>> > +	cm_write_mod_reg(prcm_sleep_save[49], CORE_MOD, CM_AUTOIDLE1);
>> > +	cm_write_mod_reg(prcm_sleep_save[50], CORE_MOD, CM_AUTOIDLE2);
>> > +	cm_write_mod_reg(prcm_sleep_save[51], CORE_MOD, CM_AUTOIDLE3);
>> > +	cm_write_mod_reg(prcm_sleep_save[52], WKUP_MOD, CM_AUTOIDLE);
>> > +	cm_write_mod_reg(prcm_sleep_save[53], OMAP3430_DSS_MOD,=20
>> CM_AUTOIDLE);
>> > +	cm_write_mod_reg(prcm_sleep_save[54], OMAP3430_CAM_MOD,=20
>> CM_AUTOIDLE);
>> > +	cm_write_mod_reg(prcm_sleep_save[55], OMAP3430_PER_MOD,=20
>> CM_AUTOIDLE);
>> > +	cm_write_mod_reg(prcm_sleep_save[56], OMAP3430ES2_USBHOST_MOD,
>> > +							      =20
>> CM_AUTOIDLE);
>> > +	cm_write_mod_reg(prcm_sleep_save[57], OMAP3430ES2_SGX_MOD,
>> > +						      =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	cm_write_mod_reg(prcm_sleep_save[58], OMAP3430_DSS_MOD,
>> > +						      =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	cm_write_mod_reg(prcm_sleep_save[59], OMAP3430_CAM_MOD,
>> > +						      =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	cm_write_mod_reg(prcm_sleep_save[60], OMAP3430_PER_MOD,
>> > +						      =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	cm_write_mod_reg(prcm_sleep_save[61], OMAP3430ES2_USBHOST_MOD,
>> > +						      =20
>> OMAP3430_CM_SLEEPDEP);
>> > +	__raw_writel(prcm_sleep_save[62], OMAP3430_CM_CLKOUT_CTRL);
>> > +	__raw_writel(prcm_sleep_save[63], OMAP3430_PRM_CLKOUT_CTRL);
>> > +	prm_write_mod_reg(prcm_sleep_save[64],=20
>> OMAP3430ES2_SGX_MOD, PM_WKDEP);
>> > +	prm_write_mod_reg(prcm_sleep_save[65],=20
>> OMAP3430_DSS_MOD, PM_WKDEP);
>> > +	prm_write_mod_reg(prcm_sleep_save[66],=20
>> OMAP3430_CAM_MOD, PM_WKDEP);
>> > +	prm_write_mod_reg(prcm_sleep_save[67],=20
>> OMAP3430_PER_MOD, PM_WKDEP);
>> > +	prm_write_mod_reg(prcm_sleep_save[68],=20
>> OMAP3430_NEON_MOD, PM_WKDEP);
>> > +	prm_write_mod_reg(prcm_sleep_save[69], OMAP3430ES2_USBHOST_MOD,
>> > +							      =20
>> PM_WKDEP);
>> > +	prm_write_mod_reg(prcm_sleep_save[70], CORE_MOD,
>> > +					       OMAP3430_PM_MPUGRPSEL1);
>> > +	prm_write_mod_reg(prcm_sleep_save[71], OMAP3430_IVA2_MOD,
>> > +					       OMAP3430_PM_IVAGRPSEL1);
>> > +	prm_write_mod_reg(prcm_sleep_save[72], CORE_MOD,
>> > +					      =20
>> OMAP3430ES2_PM_MPUGRPSEL3);
>> > +	prm_write_mod_reg(prcm_sleep_save[73], CORE_MOD,
>> > +					      =20
>> OMAP3430ES2_PM_IVAGRPSEL3);
>> > +	prm_write_mod_reg(prcm_sleep_save[74], WKUP_MOD,
>> > +					       OMAP3430_PM_MPUGRPSEL);
>> > +	prm_write_mod_reg(prcm_sleep_save[75], WKUP_MOD,
>> > +					       OMAP3430_PM_IVAGRPSEL);
>> > +	prm_write_mod_reg(prcm_sleep_save[76], OMAP3430_PER_MOD,
>> > +					       OMAP3430_PM_MPUGRPSEL);
>> > +	prm_write_mod_reg(prcm_sleep_save[77], OMAP3430_PER_MOD,
>> > +					       OMAP3430_PM_IVAGRPSEL);
>> > +	prm_write_mod_reg(prcm_sleep_save[78], WKUP_MOD, PM_WKEN);
>> > +	return;
>> > +}
>> > +
>> > +static void omap_save_intc_ctx(void)
>> > +{
>> > +	int ind =3D 0;
>> > +	intc_context.sysconfig =3D omap_readl(INTCPS_SYSCONFIG);
>> > +	intc_context.protection =3D  omap_readl(INTCPS_PROTECTION);
>> > +	intc_context.idle =3D omap_readl(INTCPS_IDLE);
>> > +	intc_context.threshold =3D omap_readl(INTCPS_THRESHOLD);
>> > +	for (ind =3D 0; ind < 96; ind++)
>> > +	       intc_context.ilr[ind] =3D
>> > +		       omap_readl(INTC_BASE + (0x100 + 0x4*ind));
>> > +	/* MIRs are saved and restore with other PRCM registers */
>> > +}
>> > +
>> > +static void omap_restore_intc_ctx(void)
>> > +{
>> > +	int ind =3D 0;
>> > +	omap_writel(intc_context.sysconfig, INTCPS_SYSCONFIG);
>> > +	omap_writel(intc_context.protection, INTCPS_PROTECTION);
>> > +	omap_writel(intc_context.idle, INTCPS_IDLE);
>> > +	omap_writel(intc_context.threshold, INTCPS_THRESHOLD);
>> > +	for (ind =3D 0; ind < 96; ind++)
>> > +	       omap_writel(intc_context.ilr[ind],
>> > +		       INTC_BASE + (0x100 + 0x4*ind));
>> > +	/* MIRs are saved and restore with other PRCM registers */
>> > +}
>> > +
>> > +static void omap_save_control_ctx(void)
>> > +{
>> > +	control_ctx.sysconfig =3D=20
>> omap_ctrl_readl(OMAP2_CONTROL_SYSCONFIG);
>> > +	control_ctx.devconf0 =3D omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0)=
;
>> > +	control_ctx.mem_dftrw0 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW0);
>> > +	control_ctx.mem_dftrw1 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW1);
>> > +	control_ctx.msuspendmux_0 =3D
>> > +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_0);
>> > +	control_ctx.msuspendmux_1 =3D
>> > +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_1);
>> > +	control_ctx.msuspendmux_2 =3D
>> > +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_2);
>> > +	control_ctx.msuspendmux_3 =3D
>> > +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_3);
>> > +	control_ctx.msuspendmux_4 =3D
>> > +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_4);
>> > +	control_ctx.msuspendmux_5 =3D
>> > +		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_5);
>> > +	control_ctx.sec_ctrl =3D omap_ctrl_readl(OMAP2_CONTROL_SEC_CTRL)=
;
>> > +	control_ctx.devconf1 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
>> > +	control_ctx.csirxfe =3D omap_ctrl_readl(OMAP343X_CONTROL_CSIRXFE=
);
>> > +	control_ctx.iva2_bootaddr =3D
>> > +		       omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTADDR);
>> > +	control_ctx.iva2_bootmod =3D
>> > +		       omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTMOD);
>> > +	control_ctx.debobs_0 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_0);
>> > +	control_ctx.debobs_1 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_1);
>> > +	control_ctx.debobs_2 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_2);
>> > +	control_ctx.debobs_3 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_3);
>> > +	control_ctx.debobs_4 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_4);
>> > +	control_ctx.debobs_5 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_5);
>> > +	control_ctx.debobs_6 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_6);
>> > +	control_ctx.debobs_7 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_7);
>> > +	control_ctx.debobs_8 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_8);
>> > +	control_ctx.prog_io0 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO0);
>> > +	control_ctx.prog_io1 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
>> > +	control_ctx.dss_dpll_spreading =3D
>> > +	       omap_ctrl_readl(OMAP343X_CONTROL_DSS_DPLL_SPREADING);
>> > +	control_ctx.core_dpll_spreading =3D
>> > +	       omap_ctrl_readl(OMAP343X_CONTROL_CORE_DPLL_SPREADING);
>> > +	control_ctx.per_dpll_spreading =3D
>> > +	       omap_ctrl_readl(OMAP343X_CONTROL_PER_DPLL_SPREADING);
>> > +	control_ctx.usbhost_dpll_spreading =3D
>> > +	       omap_ctrl_readl(OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
>> > +	control_ctx.pbias_lite =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_PBIAS_LITE);
>> > +	control_ctx.temp_sensor =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_TEMP_SENSOR);
>> > +	control_ctx.sramldo4 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO4);
>> > +	control_ctx.sramldo5 =3D=20
>> omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO5);
>> > +	control_ctx.csi =3D omap_ctrl_readl(OMAP343X_CONTROL_CSI);
>> > +	return;
>> > +}
>> > +
>> > +static void omap_restore_control_ctx(void)
>> > +{
>> > +	omap_ctrl_writel(control_ctx.sysconfig,=20
>> OMAP2_CONTROL_SYSCONFIG);
>> > +	omap_ctrl_writel(control_ctx.devconf0, OMAP2_CONTROL_DEVCONF0);
>> > +	omap_ctrl_writel(control_ctx.mem_dftrw0,=20
>> OMAP343X_CONTROL_MEM_DFTRW0);
>> > +	omap_ctrl_writel(control_ctx.mem_dftrw1,=20
>> OMAP343X_CONTROL_MEM_DFTRW1);
>> > +	omap_ctrl_writel(control_ctx.msuspendmux_0,
>> > +					      =20
>> OMAP2_CONTROL_MSUSPENDMUX_0);
>> > +	omap_ctrl_writel(control_ctx.msuspendmux_1,
>> > +					      =20
>> OMAP2_CONTROL_MSUSPENDMUX_1);
>> > +	omap_ctrl_writel(control_ctx.msuspendmux_2,
>> > +					      =20
>> OMAP2_CONTROL_MSUSPENDMUX_2);
>> > +	omap_ctrl_writel(control_ctx.msuspendmux_3,
>> > +					      =20
>> OMAP2_CONTROL_MSUSPENDMUX_3);
>> > +	omap_ctrl_writel(control_ctx.msuspendmux_4,
>> > +					      =20
>> OMAP2_CONTROL_MSUSPENDMUX_4);
>> > +	omap_ctrl_writel(control_ctx.msuspendmux_5,
>> > +					      =20
>> OMAP2_CONTROL_MSUSPENDMUX_5);
>> > +	omap_ctrl_writel(control_ctx.sec_ctrl, OMAP2_CONTROL_SEC_CTRL);
>> > +	omap_ctrl_writel(control_ctx.devconf1,=20
>> OMAP343X_CONTROL_DEVCONF1);
>> > +	omap_ctrl_writel(control_ctx.csirxfe, OMAP343X_CONTROL_CSIRXFE);
>> > +	omap_ctrl_writel(control_ctx.iva2_bootaddr,
>> > +					      =20
>> OMAP343X_CONTROL_IVA2_BOOTADDR);
>> > +	omap_ctrl_writel(control_ctx.iva2_bootmod,
>> > +					      =20
>> OMAP343X_CONTROL_IVA2_BOOTMOD);
>> > +	omap_ctrl_writel(control_ctx.debobs_0,=20
>> OMAP343X_CONTROL_DEBOBS_0);
>> > +	omap_ctrl_writel(control_ctx.debobs_1,=20
>> OMAP343X_CONTROL_DEBOBS_1);
>> > +	omap_ctrl_writel(control_ctx.debobs_2,=20
>> OMAP343X_CONTROL_DEBOBS_2);
>> > +	omap_ctrl_writel(control_ctx.debobs_3,=20
>> OMAP343X_CONTROL_DEBOBS_3);
>> > +	omap_ctrl_writel(control_ctx.debobs_4,=20
>> OMAP343X_CONTROL_DEBOBS_4);
>> > +	omap_ctrl_writel(control_ctx.debobs_5,=20
>> OMAP343X_CONTROL_DEBOBS_5);
>> > +	omap_ctrl_writel(control_ctx.debobs_6,=20
>> OMAP343X_CONTROL_DEBOBS_6);
>> > +	omap_ctrl_writel(control_ctx.debobs_7,=20
>> OMAP343X_CONTROL_DEBOBS_7);
>> > +	omap_ctrl_writel(control_ctx.debobs_8,=20
>> OMAP343X_CONTROL_DEBOBS_8);
>> > +	omap_ctrl_writel(control_ctx.prog_io0,=20
>> OMAP343X_CONTROL_PROG_IO0);
>> > +	omap_ctrl_writel(control_ctx.prog_io1,=20
>> OMAP343X_CONTROL_PROG_IO1);
>> > +	omap_ctrl_writel(control_ctx.dss_dpll_spreading,
>> > +			       OMAP343X_CONTROL_DSS_DPLL_SPREADING);
>> > +	omap_ctrl_writel(control_ctx.core_dpll_spreading,
>> > +			       OMAP343X_CONTROL_CORE_DPLL_SPREADING);
>> > +	omap_ctrl_writel(control_ctx.per_dpll_spreading,
>> > +			       OMAP343X_CONTROL_PER_DPLL_SPREADING);
>> > +	omap_ctrl_writel(control_ctx.usbhost_dpll_spreading,
>> > +			       OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
>> > +	omap_ctrl_writel(control_ctx.pbias_lite,=20
>> OMAP343X_CONTROL_PBIAS_LITE);
>> > +	omap_ctrl_writel(control_ctx.temp_sensor,=20
>> OMAP343X_CONTROL_TEMP_SENSOR);
>> > +	omap_ctrl_writel(control_ctx.sramldo4,=20
>> OMAP343X_CONTROL_SRAMLDO4);
>> > +	omap_ctrl_writel(control_ctx.sramldo5,=20
>> OMAP343X_CONTROL_SRAMLDO5);
>> > +	omap_ctrl_writel(control_ctx.csi, OMAP343X_CONTROL_CSI);
>> > +	return;
>> > +}
>> > +
>> > +void omap3_save_core_ctx(void)
>> > +{
>> > +	u32 control_padconf_off;
>> > +
>> > +	if (!padconf_saved) {
>> > +	       /* Save the padconf registers */
>> > +	       control_padconf_off =3D omap_readl(CONTROL_PADCONF_OFF);
>> > +	       control_padconf_off |=3D 2;
>> > +	       omap_writel(control_padconf_off, CONTROL_PADCONF_OFF);
>> > +	       /* wait for the save to complete */
>> > +	       while=20
>> (!omap_readl(CONTROL_GENERAL_PURPOSE_STATUS) & 0x1);
>> > +	       padconf_saved =3D 1;
>> > +	}
>> > +	/* Save the Interrupt controller context */
>> > +	omap_save_intc_ctx();
>> > +	/* Save the GPMC context */
>> > +	omap_save_gpmc_ctx();
>> > +	/* Save the system control module context, padconf=20
>> already save above*/
>> > +	omap_save_control_ctx();
>> > +	omap_save_uart_ctx(0);
>>=20
>> This should be done in omap_serial_enable_clocks function.
>>=20
>> > +	omap_serial_enable_clocks(0, 0);
>>=20
>> Why this is here?=20
>>=20
>> > +	omap_save_uart_ctx(1);
>>=20
>> This should be done in omap_serial_enable_clocks function.
>>=20
>> > +	omap_serial_enable_clocks(0, 1);
>>=20
>> Why this is here?
>
> I did'nt understand these comments completely. Are you asking why spl=
itting of uarts? its=20
> because UART1/UART2 belong to CORE and UART3 is in PER.
> If you are saying that context save/restore functions could be moved =
within the
> enable_clocks functions, yes they can be.

It just looked weird to me that clock disable is done in save ctx
function. Is there own clock disable if RET is entered instead of OFF?

>
>>=20
>> > +}
>> > +
>> > +void omap3_restore_core_ctx(void)
>> > +{
>> > +	/* Restore the control module context, padconf restored=20
>> by h/w */
>> > +	omap_restore_control_ctx();
>> > +	/* Restore the GPMC context */
>> > +	omap_restore_gpmc_ctx();
>> > +	/* Restore the interrupt controller context */
>> > +	omap_restore_intc_ctx();
>> > +	omap_serial_enable_clocks(1, 0);
>> > +	omap_restore_uart_ctx(0);
>> > +	omap_serial_enable_clocks(1, 1);
>> > +	omap_restore_uart_ctx(1);
>>=20
>> Same comments as above. You could move these uart restores to
>> omap_serial_enable_clocks and restore always after enabling clock fo=
r
>> some specific uart. Then as we have that interface to ask wether
>> restore is needed then add if statement there.
>>=20
>> > +	padconf_saved =3D 0;
>> > +}
>> > +
>> >  /* omap3_enter_idle - Programs OMAP3 to enter the specified state=
=2E
>> >   * returns the total time during which the system was idle.
>> >   */
>> > @@ -60,9 +443,15 @@ static int omap3_enter_idle(struct cpuid
>> >  		return 0;
>> >  	}
>> > =20
>> > +	local_irq_disable();
>> > +	local_fiq_disable();
>> > +
>> >  	/* Used to keep track of the total time in idle */
>> >  	getnstimeofday(&ts_preidle);
>> > =20
>> > +	if (cx->type > OMAP3_STATE_C1)
>> > +		sched_clock_idle_sleep_event(); /* about to=20
>> enter deep idle */
>> > +
>> >  	mpu_pd =3D pwrdm_lookup("mpu_pwrdm");
>> >  	core_pd =3D pwrdm_lookup("core_pwrdm");
>> >  	per_pd =3D pwrdm_lookup("per_pwrdm");
>> > @@ -74,12 +463,13 @@ static int omap3_enter_idle(struct cpuid
>> >  	pwrdm_clear_all_prev_pwrst(core_pd);
>> >  	pwrdm_clear_all_prev_pwrst(per_pd);
>> > =20
>> > -	if (omap_irq_pending())
>> > -		return 0;
>> > -
>> >  	per_pwrst =3D pwrdm_read_pwrst(per_pd);
>> >  	neon_pwrst =3D pwrdm_read_pwrst(neon_pd);
>> > =20
>> > +	/* Do this before any changes to PRCM registers */
>> > +	if (cx->core_state =3D=3D PWRDM_POWER_OFF)
>> > +		omap3_save_prcm_ctx();
>> > +
>> >  	/* Program MPU to target state */
>> >  	if (cx->mpu_state < PWRDM_POWER_ON) {
>> >  		if (neon_pwrst =3D=3D PWRDM_POWER_ON) {
>> > @@ -96,15 +486,22 @@ static int omap3_enter_idle(struct cpuid
>> >  		if (per_pwrst =3D=3D PWRDM_POWER_ON) {
>> >  			omap2_gpio_prepare_for_retention();
>> >  			if (clocks_off_while_idle) {
>> > +				omap3_save_per_ctx();
>>=20
>> Gpio saving could be moved int per_gpio_clk_disable function.
>>=20
>> >  				per_gpio_clk_disable();
>> > -				omap_serial_enable_clocks(0);
>> > +				omap_save_uart_ctx(2);
>> > +				omap_serial_enable_clocks(0, 2);
>>=20
>> Same comment as for uarts in core domain.
>>=20
>> >  			}
>> >  		}
>> > +		if (cx->core_state =3D=3D PWRDM_POWER_OFF)
>> > +			omap3_save_core_ctx();
>> >  		pwrdm_set_next_pwrst(core_pd, cx->core_state);
>> >  	}
>> > =20
>> >  	*(scratchpad_restore_addr) =3D restore_pointer_address;
>> > =20
>> > +	if (omap_irq_pending())
>> > +		goto return_sleep_time;
>> > +
>> >  	/* Execute ARM wfi */
>> >  	omap_sram_idle();
>> > =20
>> > @@ -118,25 +515,41 @@ static int omap3_enter_idle(struct cpuid
>> >  	}
>> > =20
>> >  	if (cx->core_state < PWRDM_POWER_ON) {
>> > +		if ((cx->core_state =3D=3D PWRDM_POWER_OFF)
>> > +		&& (pwrdm_read_prev_pwrst(core_pd) =3D=3D=20
>> PWRDM_POWER_OFF)) {
>> > +			omap3_restore_core_ctx();
>> > +			omap3_restore_prcm_ctx();
>> > +			omap3_restore_sram_ctx();
>> > +		}
>> > +		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
>> >  		if (per_pwrst =3D=3D PWRDM_POWER_ON) {
>> >  			if (clocks_off_while_idle) {
>> > -				omap_serial_enable_clocks(1);
>> > +				omap_serial_enable_clocks(1, 2);
>> > +				omap_restore_uart_ctx(2);
>> >  				per_gpio_clk_enable();
>> > +				omap3_restore_per_ctx();
>>=20
>> And again these could be moved to the clock enable/disable functions=
=2E
>>=20
>> >  			}
>> >  			omap2_gpio_resume_after_retention();
>> >  		}
>> > -		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
>> >  	}
>> > =20
>> >  	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
>> > -			       pwrdm_read_prev_pwrst(mpu_pd),
>> > -			       pwrdm_read_prev_pwrst(neon_pd));
>> > +				pwrdm_read_prev_pwrst(mpu_pd),
>> > +				pwrdm_read_prev_pwrst(neon_pd));
>> >  	pr_debug("PER prev st:%x,CORE prev st:%x\n",
>> > -			       pwrdm_read_prev_pwrst(per_pd),
>> > -			       pwrdm_read_prev_pwrst(core_pd));
>> > +				pwrdm_read_prev_pwrst(per_pd),
>> > +				pwrdm_read_prev_pwrst(core_pd));
>> > =20
>> > +return_sleep_time:
>> >  	getnstimeofday(&ts_postidle);
>> >  	ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
>> > +
>> > +	if (cx->type > OMAP3_STATE_C1)
>> > +		sched_clock_idle_wakeup_event(timespec_to_ns(&ts_idle));
>> > +
>> > +	local_irq_enable();
>> > +	local_fiq_disable();
>> > +
>> >  	return (u32)timespec_to_ns(&ts_idle)/1000;
>> >  }
>> > =20
>> > @@ -187,79 +600,79 @@ DEFINE_PER_CPU(struct cpuidle_device, om
>> >  void omap_init_power_states(void)
>> >  {
>> >  	/* C0 . System executing code */
>> > -	omap3_power_states[0].valid =3D 1;
>> > -	omap3_power_states[0].type =3D OMAP3_STATE_C0;
>> > -	omap3_power_states[0].sleep_latency =3D 0;
>> > -	omap3_power_states[0].wakeup_latency =3D 0;
>> > -	omap3_power_states[0].threshold =3D 0;
>> > -	omap3_power_states[0].mpu_state =3D PWRDM_POWER_ON;
>> > -	omap3_power_states[0].core_state =3D PWRDM_POWER_ON;
>> > -	omap3_power_states[0].flags =3D CPUIDLE_FLAG_SHALLOW;
>> > +	omap3_power_states[OMAP3_STATE_C0].valid =3D 1;
>> > +	omap3_power_states[OMAP3_STATE_C0].type =3D OMAP3_STATE_C0;
>> > +	omap3_power_states[OMAP3_STATE_C0].sleep_latency =3D 0;
>> > +	omap3_power_states[OMAP3_STATE_C0].wakeup_latency =3D 0;
>> > +	omap3_power_states[OMAP3_STATE_C0].threshold =3D 0;
>> > +	omap3_power_states[OMAP3_STATE_C0].mpu_state =3D PWRDM_POWER_ON;
>> > +	omap3_power_states[OMAP3_STATE_C0].core_state =3D PWRDM_POWER_ON=
;
>> > +	omap3_power_states[OMAP3_STATE_C0].flags =3D CPUIDLE_FLAG_SHALLO=
W;
>> > =20
>> >  	/* C1 . MPU WFI + Core active */
>> > -	omap3_power_states[1].valid =3D 1;
>> > -	omap3_power_states[1].type =3D OMAP3_STATE_C1;
>> > -	omap3_power_states[1].sleep_latency =3D 10;
>> > -	omap3_power_states[1].wakeup_latency =3D 10;
>> > -	omap3_power_states[1].threshold =3D 30;
>> > -	omap3_power_states[1].mpu_state =3D PWRDM_POWER_ON;
>> > -	omap3_power_states[1].core_state =3D PWRDM_POWER_ON;
>> > -	omap3_power_states[1].flags =3D CPUIDLE_FLAG_TIME_VALID |
>> > +	omap3_power_states[OMAP3_STATE_C1].valid =3D 1;
>> > +	omap3_power_states[OMAP3_STATE_C1].type =3D OMAP3_STATE_C1;
>> > +	omap3_power_states[OMAP3_STATE_C1].sleep_latency =3D 10;
>> > +	omap3_power_states[OMAP3_STATE_C1].wakeup_latency =3D 10;
>> > +	omap3_power_states[OMAP3_STATE_C1].threshold =3D 30;
>> > +	omap3_power_states[OMAP3_STATE_C1].mpu_state =3D PWRDM_POWER_ON;
>> > +	omap3_power_states[OMAP3_STATE_C1].core_state =3D PWRDM_POWER_ON=
;
>> > +	omap3_power_states[OMAP3_STATE_C1].flags =3D=20
>> CPUIDLE_FLAG_TIME_VALID |
>> >  						CPUIDLE_FLAG_SHALLOW;
>> > =20
>> >  	/* C2 . MPU CSWR + Core active */
>> > -	omap3_power_states[2].valid =3D 1;
>> > -	omap3_power_states[2].type =3D OMAP3_STATE_C2;
>> > -	omap3_power_states[2].sleep_latency =3D 50;
>> > -	omap3_power_states[2].wakeup_latency =3D 50;
>> > -	omap3_power_states[2].threshold =3D 300;
>> > -	omap3_power_states[2].mpu_state =3D PWRDM_POWER_RET;
>> > -	omap3_power_states[2].core_state =3D PWRDM_POWER_ON;
>> > -	omap3_power_states[2].flags =3D CPUIDLE_FLAG_TIME_VALID |
>> > +	omap3_power_states[OMAP3_STATE_C2].valid =3D 1;
>> > +	omap3_power_states[OMAP3_STATE_C2].type =3D OMAP3_STATE_C2;
>> > +	omap3_power_states[OMAP3_STATE_C2].sleep_latency =3D 50;
>> > +	omap3_power_states[OMAP3_STATE_C2].wakeup_latency =3D 50;
>> > +	omap3_power_states[OMAP3_STATE_C2].threshold =3D 300;
>> > +	omap3_power_states[OMAP3_STATE_C2].mpu_state =3D PWRDM_POWER_RET=
;
>> > +	omap3_power_states[OMAP3_STATE_C2].core_state =3D PWRDM_POWER_ON=
;
>> > +	omap3_power_states[OMAP3_STATE_C2].flags =3D=20
>> CPUIDLE_FLAG_TIME_VALID |
>> >  						CPUIDLE_FLAG_BALANCED;
>> > =20
>> >  	/* C3 . MPU OFF + Core active */
>> > -	omap3_power_states[3].valid =3D 1;
>> > -	omap3_power_states[3].type =3D OMAP3_STATE_C3;
>> > -	omap3_power_states[3].sleep_latency =3D 1500;
>> > -	omap3_power_states[3].wakeup_latency =3D 1800;
>> > -	omap3_power_states[3].threshold =3D 4000;
>> > -	omap3_power_states[3].mpu_state =3D PWRDM_POWER_OFF;
>> > -	omap3_power_states[3].core_state =3D PWRDM_POWER_ON;
>> > -	omap3_power_states[3].flags =3D CPUIDLE_FLAG_TIME_VALID |
>> > +	omap3_power_states[OMAP3_STATE_C3].valid =3D 1;
>> > +	omap3_power_states[OMAP3_STATE_C3].type =3D OMAP3_STATE_C3;
>> > +	omap3_power_states[OMAP3_STATE_C3].sleep_latency =3D 1500;
>> > +	omap3_power_states[OMAP3_STATE_C3].wakeup_latency =3D 1800;
>> > +	omap3_power_states[OMAP3_STATE_C3].threshold =3D 4000;
>> > +	omap3_power_states[OMAP3_STATE_C3].mpu_state =3D PWRDM_POWER_OFF=
;
>> > +	omap3_power_states[OMAP3_STATE_C3].core_state =3D PWRDM_POWER_ON=
;
>> > +	omap3_power_states[OMAP3_STATE_C3].flags =3D=20
>> CPUIDLE_FLAG_TIME_VALID |
>> >  			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
>> > =20
>> >  	/* C4 . MPU CSWR + Core CSWR*/
>> > -	omap3_power_states[4].valid =3D 1;
>> > -	omap3_power_states[4].type =3D OMAP3_STATE_C4;
>> > -	omap3_power_states[4].sleep_latency =3D 2500;
>> > -	omap3_power_states[4].wakeup_latency =3D 7500;
>> > -	omap3_power_states[4].threshold =3D 12000;
>> > -	omap3_power_states[4].mpu_state =3D PWRDM_POWER_RET;
>> > -	omap3_power_states[4].core_state =3D PWRDM_POWER_RET;
>> > -	omap3_power_states[4].flags =3D CPUIDLE_FLAG_TIME_VALID |
>> > +	omap3_power_states[OMAP3_STATE_C4].valid =3D 1;
>> > +	omap3_power_states[OMAP3_STATE_C4].type =3D OMAP3_STATE_C4;
>> > +	omap3_power_states[OMAP3_STATE_C4].sleep_latency =3D 2500;
>> > +	omap3_power_states[OMAP3_STATE_C4].wakeup_latency =3D 7500;
>> > +	omap3_power_states[OMAP3_STATE_C4].threshold =3D 12000;
>> > +	omap3_power_states[OMAP3_STATE_C4].mpu_state =3D PWRDM_POWER_RET=
;
>> > +	omap3_power_states[OMAP3_STATE_C4].core_state =3D PWRDM_POWER_RE=
T;
>> > +	omap3_power_states[OMAP3_STATE_C4].flags =3D=20
>> CPUIDLE_FLAG_TIME_VALID |
>> >  			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
>> > =20
>> >  	/* C5 . MPU OFF + Core CSWR */
>> > -	omap3_power_states[5].valid =3D 1;
>> > -	omap3_power_states[5].type =3D OMAP3_STATE_C5;
>> > -	omap3_power_states[5].sleep_latency =3D 3000;
>> > -	omap3_power_states[5].wakeup_latency =3D 8500;
>> > -	omap3_power_states[5].threshold =3D 15000;
>> > -	omap3_power_states[5].mpu_state =3D PWRDM_POWER_OFF;
>> > -	omap3_power_states[5].core_state =3D PWRDM_POWER_RET;
>> > -	omap3_power_states[5].flags =3D CPUIDLE_FLAG_TIME_VALID |
>> > +	omap3_power_states[OMAP3_STATE_C5].valid =3D 1;
>> > +	omap3_power_states[OMAP3_STATE_C5].type =3D OMAP3_STATE_C5;
>> > +	omap3_power_states[OMAP3_STATE_C5].sleep_latency =3D 3000;
>> > +	omap3_power_states[OMAP3_STATE_C5].wakeup_latency =3D 8500;
>> > +	omap3_power_states[OMAP3_STATE_C5].threshold =3D 15000;
>> > +	omap3_power_states[OMAP3_STATE_C5].mpu_state =3D PWRDM_POWER_OFF=
;
>> > +	omap3_power_states[OMAP3_STATE_C5].core_state =3D PWRDM_POWER_RE=
T;
>> > +	omap3_power_states[OMAP3_STATE_C5].flags =3D=20
>> CPUIDLE_FLAG_TIME_VALID |
>> >  			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
>> > =20
>> >  	/* C6 . MPU OFF + Core OFF */
>> > -	omap3_power_states[6].valid =3D 0;
>> > -	omap3_power_states[6].type =3D OMAP3_STATE_C6;
>> > -	omap3_power_states[6].sleep_latency =3D 10000;
>> > -	omap3_power_states[6].wakeup_latency =3D 30000;
>> > -	omap3_power_states[6].threshold =3D 300000;
>> > -	omap3_power_states[6].mpu_state =3D PWRDM_POWER_OFF;
>> > -	omap3_power_states[6].core_state =3D PWRDM_POWER_OFF;
>> > -	omap3_power_states[6].flags =3D CPUIDLE_FLAG_TIME_VALID |
>> > +	omap3_power_states[OMAP3_STATE_C6].valid =3D 1;
>> > +	omap3_power_states[OMAP3_STATE_C6].type =3D OMAP3_STATE_C6;
>> > +	omap3_power_states[OMAP3_STATE_C6].sleep_latency =3D 10000;
>> > +	omap3_power_states[OMAP3_STATE_C6].wakeup_latency =3D 30000;
>> > +	omap3_power_states[OMAP3_STATE_C6].threshold =3D 300000;
>> > +	omap3_power_states[OMAP3_STATE_C6].mpu_state =3D PWRDM_POWER_OFF=
;
>> > +	omap3_power_states[OMAP3_STATE_C6].core_state =3D PWRDM_POWER_OF=
=46;
>> > +	omap3_power_states[OMAP3_STATE_C6].flags =3D=20
>> CPUIDLE_FLAG_TIME_VALID |
>> >  			CPUIDLE_FLAG_DEEP | CPUIDLE_FLAG_CHECK_BM;
>> >  }
>> > =20
>> > @@ -277,6 +690,7 @@ int omap3_idle_init(void)
>> >  	struct omap3_processor_cx *cx;
>> >  	struct cpuidle_state *state;
>> >  	struct cpuidle_device *dev;
>> > +	char clk_name[11];
>> > =20
>> >  	clear_scratchpad_contents();
>> >  	save_scratchpad_contents();
>> > Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.h=09
>> 2008-07-01 18:51:23.078236417 +0530
>> > +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h=09
>> 2008-07-01 18:51:25.189168688 +0530
>> > @@ -30,20 +30,41 @@
>> >  #define OMAP3_STATE_C5 5 /* C5 - MPU OFF + Core RET */
>> >  #define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core OFF */
>> > =20
>> > -/* Currently, we support only upto C2 */
>> > -#define MAX_SUPPORTED_STATES 3
>> > +/* Interrupt Controller registers */
>> > +#define INTC_BASE	0x48200000
>> > +#define INTC_MIR_0	0x48200084
>> > +#define INTC_MIR_1	0x482000A4
>> > +#define INTC_MIR_2	0x482000C4
>> > +#define INTCPS_SYSCONFIG	0x48200010
>> > +#define INTCPS_PROTECTION	0x4820004C
>> > +#define INTCPS_IDLE	0x48200050
>> > +#define INTCPS_THRESHOLD	0x48200068
>> > +
>> > +#define CONTROL_PADCONF_SYS_NIRQ	0x480021E0
>> > +#define CONTROL_PADCONF_OFF	0x48002270
>> > +#define CONTROL_GENERAL_PURPOSE_STATUS	0x480022F4
>> > +
>> > +#define OMAP34XX_GPIO1_IRQENABLE1	0x4831001c
>> > +#define OMAP34XX_GPIO1_WAKEUPEN	0x48310020
>> > +#define OMAP34XX_GPIO1_FALLINGDETECT	0x4831004c
>> > =20
>> >  extern unsigned short clocks_off_while_idle;
>> >  extern void omap_sram_idle(void);
>> >  extern int omap_irq_pending(void);
>> >  extern void per_gpio_clk_enable(void);
>> >  extern void per_gpio_clk_disable(void);
>> > -extern void omap_serial_enable_clocks(int enable);
>> > +extern void omap_serial_enable_clocks(int enable, int unum);
>> >  extern int omap3_can_sleep();
>> >  extern void clear_scratchpad_contents(void);
>> >  extern void save_scratchpad_contents(void);
>> >  extern u32 *scratchpad_restore_addr;
>> >  extern u32 restore_pointer_address;
>> > +extern void omap3_save_per_ctx();
>> > +extern void omap3_restore_per_ctx();
>> > +extern void omap_save_uart_ctx(int);
>> > +extern void omap_restore_uart_ctx(int);
>> > +extern void omap3_restore_sram_ctx();
>> > +extern int omap3_can_sleep();
>> > =20
>> >  struct omap3_processor_cx {
>> >  	u8 valid;
>> > @@ -59,5 +80,10 @@ struct omap3_processor_cx {
>> >  void omap_init_power_states(void);
>> >  int omap3_idle_init(void);
>> > =20
>> > +/* TODO fix the size:100 */
>> > +static unsigned int prcm_sleep_save[100];
>> > +static struct int_controller_context intc_context;
>> > +static struct control_module_context control_ctx;
>> > +
>> >  #endif /* ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX */
>> > =20
>> > Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c=09
>> 2008-07-01 18:51:22.662249764 +0530
>> > +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c=09
>> 2008-07-01 18:51:25.189168688 +0530
>> > @@ -154,7 +154,6 @@ static irqreturn_t prcm_interrupt_handle
>> >  		cm_write_mod_reg(iclk, OMAP3430_PER_MOD, CM_ICLKEN);
>> >  		cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
>> >  	}
>> > -
>> >  	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
>> >  		/* USBHOST */
>> >  		wkst =3D=20
>> prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
>> > @@ -361,7 +360,9 @@ static void omap3_pm_idle(void)
>> >  	omap2_gpio_prepare_for_retention();
>> > =20
>> >  	if (clocks_off_while_idle) {
>> > -		omap_serial_enable_clocks(0);
>> > +		omap_serial_enable_clocks(0, 0);
>> > +		omap_serial_enable_clocks(0, 1);
>> > +		omap_serial_enable_clocks(0, 2);
>> >  		/* XXX This is for gpio fclk hack. Will be removed as
>> >  		 * gpio driver * handles fcks correctly */
>> >  		per_gpio_clk_disable();
>> > @@ -370,7 +371,9 @@ static void omap3_pm_idle(void)
>> >  	omap_sram_idle();
>> > =20
>> >  	if (clocks_off_while_idle) {
>> > -		omap_serial_enable_clocks(1);
>> > +		omap_serial_enable_clocks(1, 0);
>> > +		omap_serial_enable_clocks(1, 1);
>> > +		omap_serial_enable_clocks(1, 2);
>> >  		/* XXX This is for gpio fclk hack. Will be removed as
>> >  		 * gpio driver * handles fcks correctly */
>> >  		per_gpio_clk_enable();
>> > @@ -412,7 +415,9 @@ static int omap3_pm_suspend(void)
>> >  	omap2_gpio_prepare_for_retention();
>> > =20
>> >  	if (clocks_off_while_idle) {
>> > -		omap_serial_enable_clocks(0);
>> > +		omap_serial_enable_clocks(0, 0);
>> > +		omap_serial_enable_clocks(0, 1);
>> > +		omap_serial_enable_clocks(0, 2);
>> >  		/* XXX This is for gpio fclk hack. Will be removed as
>> >  		 * gpio driver * handles fcks correctly */
>> >  		per_gpio_clk_disable();
>> > @@ -421,7 +426,9 @@ static int omap3_pm_suspend(void)
>> >  	omap_sram_idle();
>> > =20
>> >  	if (clocks_off_while_idle) {
>> > -		omap_serial_enable_clocks(1);
>> > +		omap_serial_enable_clocks(1, 0);
>> > +		omap_serial_enable_clocks(1, 1);
>> > +		omap_serial_enable_clocks(1, 2);
>> >  		/* XXX This is for gpio fclk hack. Will be removed as
>> >  		 * gpio driver * handles fcks correctly */
>> >  		per_gpio_clk_enable();
>> > @@ -629,6 +636,16 @@ static void __init prcm_setup_regs(void)
>> >  			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
>> >  }
>> > =20
>> > +void omap3_save_per_ctx(void)
>> > +{
>> > +	omap_gpio_save();
>> > +}
>> > +
>> > +void omap3_restore_per_ctx(void)
>> > +{
>> > +	omap_gpio_restore();
>> > +}
>> > +
>> >  static int __init pwrdms_setup(struct powerdomain *pwrdm)
>> >  {
>> >  	struct power_state *pwrst;
>> > @@ -652,6 +669,12 @@ static int __init pwrdms_setup(struct po
>> >  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>> >  }
>> > =20
>> > +void omap_push_sram_idle()
>> > +{
>> > +	_omap_sram_idle =3D omap_sram_push(omap34xx_cpu_suspend,
>> > +					omap34xx_cpu_suspend_sz);
>> > +}
>> > +
>> >  int __init omap3_pm_init(void)
>> >  {
>> >  	struct power_state *pwrst;
>> > @@ -663,6 +686,7 @@ int __init omap3_pm_init(void)
>> >  	/* XXX prcm_setup_regs needs to be before enabling hw
>> >  	 * supervised mode for powerdomains */
>> >  	prcm_setup_regs();
>> > +	save_scratchpad_contents();
>> > =20
>> >  	ret =3D request_irq(INT_34XX_PRCM_MPU_IRQ,
>> >  			  (irq_handler_t)prcm_interrupt_handler,
>> > @@ -685,9 +709,7 @@ int __init omap3_pm_init(void)
>> >  		goto err2;
>> >  	}
>> > =20
>> > -	_omap_sram_idle =3D omap_sram_push(omap34xx_cpu_suspend,
>> > -					omap34xx_cpu_suspend_sz);
>> > -
>> > +	omap_push_sram_idle();
>> >  	suspend_set_ops(&omap_pm_ops);
>> > =20
>> >  #ifndef CONFIG_CPU_IDLE
>> > @@ -779,10 +801,13 @@ void save_scratchpad_contents(void)
>> >  	*(scratchpad_address++) =3D __raw_readl(OMAP3430_PRM_CLKSEL);
>> >  	*(scratchpad_address++) =3D cm_read_mod_reg(CORE_MOD, CM_CLKSEL)=
;
>> >  	*(scratchpad_address++) =3D cm_read_mod_reg(WKUP_MOD, CM_CLKSEL)=
;
>> > +	/* TODO OMAP3430_CM_CLKEN_PLL is defined 0x4 */
>> > +	/**(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
>> > +					OMAP3430_CM_CLKEN_PLL);*/
>> >  	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
>> > -					OMAP3430_CM_CLKEN_PLL);
>> > +					0x0);
>> >  	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
>> > -					OMAP3430_CM_AUTOIDLE_PLL);
>> > +					CM_AUTOIDLE);
>> >  	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
>> >  					OMAP3430_CM_CLKSEL1_PLL);
>> >  	*(scratchpad_address++) =3D cm_read_mod_reg(PLL_MOD,
>> > Index: linux-omap-2.6/arch/arm/mach-omap2/prm.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/prm.h=09
>> 2008-07-01 18:48:04.946594134 +0530
>> > +++ linux-omap-2.6/arch/arm/mach-omap2/prm.h=09
>> 2008-07-01 18:51:25.190168656 +0530
>> > @@ -137,9 +137,11 @@
>> > =20
>> >  #define OMAP3430_PM_MPUGRPSEL				0x00a4
>> >  #define OMAP3430_PM_MPUGRPSEL1			=09
>> OMAP3430_PM_MPUGRPSEL
>> > +#define OMAP3430ES2_PM_MPUGRPSEL3			0x00f8
>> > =20
>> >  #define OMAP3430_PM_IVAGRPSEL				0x00a8
>> >  #define OMAP3430_PM_IVAGRPSEL1			=09
>> OMAP3430_PM_IVAGRPSEL
>> > +#define OMAP3430ES2_PM_IVAGRPSEL3			0x00f4
>> > =20
>> >  #define OMAP3430_PM_PREPWSTST				0x00e8
>> > =20
>> > Index: linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/sleep34xx.S=09
>> 2008-07-01 18:51:22.662249764 +0530
>> > +++ linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S=09
>> 2008-07-01 18:51:25.190168656 +0530
>> > @@ -457,10 +457,12 @@ loop2:
>> >  	mov     r9, r4
>> >  	/* create working copy of max way size*/
>> >  loop3:
>> > -	/* factor way and cache number into r11 */
>> > -	orr     r11, r10, r9, lsl r5
>> > -	/* factor index number into r11 */
>> > -	orr     r11, r11, r7, lsl r2
>> > + 	orr	r11, r10, r9, lsl r5	 @ factor way and cache=20
>> number into r11
>> > + 	orr	r11, r11, r7, lsl r2	 @ factor index number into r11
>> > + 	lsl	r6, r9, r5
>> > + 	orr	r11, r10, r6		 @ factor way and cache=20
>> number into r11
>> > + 	lsl	r6, r7, r2
>> > + 	orr	r11, r11, r6		 @ factor index number into r11
>> >  	/*clean & invalidate by set/way */
>> >  	mcr     p15, 0, r11, c7, c10, 2
>> >  	/* decrement the way*/
>> > @@ -475,7 +477,7 @@ skip:
>> >  	cmp     r3, r10
>> >  	bgt     loop1
>> >  finished:
>> > -	/*swith back to cache level 0 */
>> > +	/*switch back to cache level 0 */
>> >  	mov     r10, #0
>> >  	/* select current cache level in cssr */
>> >  	mcr     p15, 2, r10, c0, c0, 0
>> > Index: linux-omap-2.6/arch/arm/plat-omap/sram.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/arch/arm/plat-omap/sram.c=09
>> 2008-07-01 18:48:04.946594134 +0530
>> > +++ linux-omap-2.6/arch/arm/plat-omap/sram.c=09
>> 2008-07-01 18:51:25.191168624 +0530
>> > @@ -26,6 +26,7 @@
>> >  #include <asm/arch/board.h>
>> > =20
>> >  #include <asm/arch/control.h>
>> > +#include <asm/arch/pm.h>
>> > =20
>> >  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>> >  # include "../mach-omap2/prm.h"
>> > @@ -75,6 +76,8 @@ extern unsigned long omapfb_reserve_sram
>> >  					 unsigned long sram_size,
>> >  					 unsigned long pstart_avail,
>> >  					 unsigned long size_avail);
>> > +extern void (*_omap_sram_idle)(u32 *addr, int save_state);
>> > +extern void omap_push_sram_idle();
>> > =20
>> >  /*
>> >   * Depending on the target RAMFS firewall setup, the=20
>> public usable amount of
>> > @@ -108,6 +111,7 @@ static int is_sram_locked(void)
>> >  		return 1; /* assume locked with no PPA or=20
>> security driver */
>> >  }
>> > =20
>> > +
>> >  /*
>> >   * The amount of SRAM depends on the core type.
>> >   * Note that we cannot try to test for SRAM here because writes
>> > @@ -372,16 +376,15 @@ u32 omap2_sram_configure_core_dpll(u32 m
>> >  }
>> > =20
>> >  /* REVISIT: Should this be same as omap34xx_sram_init()=20
>> after off-idle? */
>> > -void restore_sram_functions(void)
>> > +void omap3_restore_sram_ctx(void)
>> >  {
>> >  	omap_sram_ceil =3D omap_sram_base + omap_sram_size;
>> > -
>> >  	_omap2_sram_reprogram_gpmc =3D=20
>> omap_sram_push(omap34xx_sram_reprogram_gpmc,
>> > -		omap34xx_sram_reprogram_gpmc_sz);
>> > -
>> > +				omap34xx_sram_reprogram_gpmc_sz);
>> >  	_omap2_sram_configure_core_dpll =3D
>> >  		=09
>> omap_sram_push(omap34xx_sram_configure_core_dpll,
>> > -				=09
>> omap34xx_sram_configure_core_dpll_sz);
>> > +			omap34xx_sram_configure_core_dpll_sz);
>> > +	omap_push_sram_idle();
>> >  }
>> > =20
>> >  int __init omap34xx_sram_init(void)
>> > @@ -401,6 +404,8 @@ int __init omap34xx_sram_init(void)
>> >  	_omap2_sram_configure_core_dpll =3D
>> >  			=09
>> omap_sram_push(omap34xx_sram_configure_core_dpll,
>> >  				=09
>> omap34xx_sram_configure_core_dpll_sz);
>> > +	_omap_sram_idle =3D omap_sram_push(omap34xx_cpu_suspend,
>> > +					omap34xx_cpu_suspend_sz);
>> > =20
>> >  	return 0;
>> >  }
>> > Index: linux-omap-2.6/include/asm-arm/arch-omap/prcm.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/include/asm-arm/arch-omap/prcm.h=09
>> 2008-07-01 18:48:04.947594102 +0530
>> > +++ linux-omap-2.6/include/asm-arm/arch-omap/prcm.h=09
>> 2008-07-01 18:51:25.192168592 +0530
>> > @@ -26,9 +26,57 @@
>> >  u32 omap_prcm_get_reset_sources(void);
>> >  void omap_prcm_arch_reset(char mode);
>> > =20
>> > -#endif
>> > -
>> > -
>> > -
>> > -
>> > +#ifdef CONFIG_ARCH_OMAP3
>> > +/* Structure to save interrupt controller context */
>> > +struct int_controller_context {
>> > +	u32 sysconfig;
>> > +	u32 protection;
>> > +	u32 idle;
>> > +	u32 threshold;
>> > +	u32 ilr[96];
>> > +	u32 mir_0;
>> > +	u32 mir_1;
>> > +	u32 mir_2;
>> > +};
>> > +
>> > +/* Structure to save control module context */
>> > +struct control_module_context {
>> > +	u32 sysconfig;
>> > +	u32 devconf0;
>> > +	u32 mem_dftrw0;
>> > +	u32 mem_dftrw1;
>> > +	u32 msuspendmux_0;
>> > +	u32 msuspendmux_1;
>> > +	u32 msuspendmux_2;
>> > +	u32 msuspendmux_3;
>> > +	u32 msuspendmux_4;
>> > +	u32 msuspendmux_5;
>> > +	u32 sec_ctrl;
>> > +	u32 devconf1;
>> > +	u32 csirxfe;
>> > +	u32 iva2_bootaddr;
>> > +	u32 iva2_bootmod;
>> > +	u32 debobs_0;
>> > +	u32 debobs_1;
>> > +	u32 debobs_2;
>> > +	u32 debobs_3;
>> > +	u32 debobs_4;
>> > +	u32 debobs_5;
>> > +	u32 debobs_6;
>> > +	u32 debobs_7;
>> > +	u32 debobs_8;
>> > +	u32 prog_io0;
>> > +	u32 prog_io1;
>> > +	u32 dss_dpll_spreading;
>> > +	u32 core_dpll_spreading;
>> > +	u32 per_dpll_spreading;
>> > +	u32 usbhost_dpll_spreading;
>> > +	u32 pbias_lite;
>> > +	u32 temp_sensor;
>> > +	u32 sramldo4;
>> > +	u32 sramldo5;
>> > +	u32 csi;
>> > +};
>> > =20
>> > +#endif /* CONFIG_ARCH_OMAP3 */
>> > +#endif /* __ASM_ARM_ARCH_OMAP_PRCM_H */
>> > Index: linux-omap-2.6/include/asm-arm/arch-omap/control.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/include/asm-arm/arch-omap/control.h=09
>> 2008-07-01 18:48:04.947594102 +0530
>> > +++ linux-omap-2.6/include/asm-arm/arch-omap/control.h=09
>> 2008-07-01 18:51:25.192168592 +0530
>> > @@ -149,7 +149,27 @@
>> >  #define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
>> >  #define OMAP343X_CONTROL_IVA2_BOOTADDR=09
>> (OMAP2_CONTROL_GENERAL + 0x0190)
>> >  #define OMAP343X_CONTROL_IVA2_BOOTMOD=09
>> (OMAP2_CONTROL_GENERAL + 0x0194)
>> > -#define OMAP343X_CONTROL_TEMP_SENSOR=09
>> (OMAP2_CONTROL_GENERAL + 0x02b4)
>> > +#define OMAP343X_CONTROL_DEBOBS_0	(OMAP2_CONTROL_GENERAL + 0x01B0=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_1	(OMAP2_CONTROL_GENERAL + 0x01B4=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_2	(OMAP2_CONTROL_GENERAL + 0x01B8=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_3	(OMAP2_CONTROL_GENERAL + 0x01BC=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_4	(OMAP2_CONTROL_GENERAL + 0x01C0=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_5	(OMAP2_CONTROL_GENERAL + 0x01C4=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_6	(OMAP2_CONTROL_GENERAL + 0x01C8=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_7	(OMAP2_CONTROL_GENERAL + 0x01CC=
)
>> > +#define OMAP343X_CONTROL_DEBOBS_8	(OMAP2_CONTROL_GENERAL + 0x01D0=
)
>> > +#define OMAP343X_CONTROL_PROG_IO0	(OMAP2_CONTROL_GENERAL + 0x01D4=
)
>> > +#define OMAP343X_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8=
)
>> > +#define OMAP343X_CONTROL_DSS_DPLL_SPREADING=09
>> (OMAP2_CONTROL_GENERAL + 0x01E0)
>> > +#define OMAP343X_CONTROL_CORE_DPLL_SPREADING=09
>> (OMAP2_CONTROL_GENERAL + 0x01E4)
>> > +#define OMAP343X_CONTROL_PER_DPLL_SPREADING=09
>> (OMAP2_CONTROL_GENERAL + 0x01E8)
>> > +#define OMAP343X_CONTROL_USBHOST_DPLL_SPREADING=20
>> (OMAP2_CONTROL_GENERAL + 0x01EC)
>> > +#define OMAP343X_CONTROL_PBIAS_LITE=09
>> (OMAP2_CONTROL_GENERAL + 0x02B0)
>> > +#define OMAP343X_CONTROL_TEMP_SENSOR=09
>> (OMAP2_CONTROL_GENERAL + 0x02B4)
>> > +#define OMAP343X_CONTROL_SRAMLDO4	(OMAP2_CONTROL_GENERAL + 0x02B8=
)
>> > +#define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0=
)
>> > +#define OMAP343X_CONTROL_CSI	=09
>> (OMAP2_CONTROL_GENERAL + 0x02b4)
>> > +
>> > =20
>> >  /*
>> >   * REVISIT: This list of registers is not comprehensive -=20
>> there are more
>> > Index: linux-omap-2.6/arch/arm/mach-omap2/serial.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/serial.c=09
>> 2008-07-01 18:51:23.908209787 +0530
>> > +++ linux-omap-2.6/arch/arm/mach-omap2/serial.c=09
>> 2008-07-01 18:51:25.192168592 +0530
>> > @@ -157,18 +157,15 @@ static void omap_serial_kick(void)
>> >  		NSEC_PER_SEC);
>> >  }
>> > =20
>> > -void omap_serial_enable_clocks(int enable)
>> > +void omap_serial_enable_clocks(int enable, int unum)
>> >  {
>> > -	int i;
>> > -	for (i =3D 0; i < OMAP_MAX_NR_PORTS; i++) {
>> > -		if (uart_ick[i] && uart_fck[i]) {
>> > -			if (enable) {
>> > -				clk_enable(uart_ick[i]);
>> > -				clk_enable(uart_fck[i]);
>> > -			} else {
>> > -				clk_disable(uart_ick[i]);
>> > -				clk_disable(uart_fck[i]);
>> > -			}
>> > +	if (uart_ick[unum] && uart_fck[unum]) {
>> > +		if (enable) {
>> > +			clk_enable(uart_ick[unum]);
>> > +			clk_enable(uart_fck[unum]);
>> > +		} else {
>> > +			clk_disable(uart_ick[unum]);
>> > +			clk_disable(uart_fck[unum]);
>>=20
>> If you do save and restore as I mentioned above then there is no nee=
d
>> to add new parameter to omap_serial_enable_clocks function. Just do
>> uart_ctx_save before calling clk_disable and restore after
>> clk_enable. Then as we have that interface to ask for need for resto=
re
>> add put restore under if statement.
>
> I don't understand how the second param could be avoided here. Its us=
ed=20
> to identify the UART and do the enable/disable only for the specified=
 UART,
> rather than doing it for all UART's.

Uarts whose clocks should be handled are identified originally using
enabled_uarts in ATAGS. After that uarts that needs to be controlled
are identified by checking the pointers. If you call this just using
omap_serial_enable_clocks(0) then those uart clocks are disabled. As
you pointed core and per are always entering sleep state together, it
is ok to disable/enable these clocks at same time.

>
>>=20
>> >  		}
>> >  	}
>> >  }
>> > Index: linux-omap-2.6/include/asm-arm/arch-omap/common.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-2.6.orig/include/asm-arm/arch-omap/common.h=09
>> 2008-07-01 18:51:24.326196376 +0530
>> > +++ linux-omap-2.6/include/asm-arm/arch-omap/common.h=09
>> 2008-07-01 18:51:25.193168559 +0530
>> > @@ -34,7 +34,7 @@ struct sys_timer;
>> >  extern void omap_map_common_io(void);
>> >  extern struct sys_timer omap_timer;
>> >  extern void omap_serial_init(void);
>> > -extern void omap_serial_enable_clocks(int enable);
>> > +extern void omap_serial_enable_clocks(int enable, int unum);
>> >  extern int omap_serial_can_sleep(void);
>> >  extern void omap_gpio_save(void);
>> >  extern void omap_gpio_restore(void);
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe=20
>> linux-omap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
>>=20
>> --=20
>> Jouni H=C3=B6gander
>>=20
>>=20
>
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
