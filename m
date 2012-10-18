From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 3/5] ARM: OMAP2+: powerdomain/PRM: move the low-level
 powerdomain functions into PRM
Date: Thu, 18 Oct 2012 04:21:28 -0700
Message-ID: <CA+Bv8XY_My412nxMU=FqJTPeDACYQO3KyRg=nM05VgzHVRo9wg@mail.gmail.com>
References: <20121015224455.18306.89030.stgit@dusk.lan>
	<20121015230542.18306.88940.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48541 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab2JRLVa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 07:21:30 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1963080wib.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 04:21:28 -0700 (PDT)
In-Reply-To: <20121015230542.18306.88940.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Mon, Oct 15, 2012 at 4:05 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Move the low-level SoC-specific powerdomain control functions into
> prm*.c.  For example, OMAP2xxx low-level powerdomain functions go int=
o
> prm2xxx.c.  Then remove the unnecessary powerdomain*xxx*.c files.
>
> The objective is to centralize low-level PRM register accesses into
> the prm*.[ch] files, and then to export an OMAP SoC-independent API t=
o
> higher-level OMAP power management code.

Looks good
Reviewed-by: Russ.Dill@ti.com

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile               |    1
>  arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |  242 ------------------=
------
>  arch/arm/mach-omap2/powerdomain33xx.c      |  229 ------------------=
----
>  arch/arm/mach-omap2/powerdomain44xx.c      |  285 ------------------=
----------
>  arch/arm/mach-omap2/prm2xxx.c              |   40 ++++
>  arch/arm/mach-omap2/prm2xxx_3xxx.c         |  112 +++++++++++
>  arch/arm/mach-omap2/prm2xxx_3xxx.h         |   13 +
>  arch/arm/mach-omap2/prm33xx.c              |  202 ++++++++++++++++++=
++
>  arch/arm/mach-omap2/prm3xxx.c              |  106 ++++++++++
>  arch/arm/mach-omap2/prm44xx.c              |  264 ++++++++++++++++++=
++++++++
>  10 files changed, 736 insertions(+), 758 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
>  delete mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
>  delete mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
>  create mode 100644 arch/arm/mach-omap2/prm2xxx.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 20849604..7404e3d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -95,6 +95,7 @@ endif
>  # PRCM
>  obj-y                                  +=3D prcm.o prm_common.o
>  obj-$(CONFIG_ARCH_OMAP2)               +=3D cm2xxx_3xxx.o prm2xxx_3x=
xx.o
> +obj-$(CONFIG_ARCH_OMAP2)               +=3D prm2xxx.o
>  obj-$(CONFIG_ARCH_OMAP3)               +=3D cm2xxx_3xxx.o prm2xxx_3x=
xx.o
>  obj-$(CONFIG_ARCH_OMAP3)               +=3D prm3xxx.o
>  obj-$(CONFIG_ARCH_OMAP3)               +=3D vc3xxx_data.o vp3xxx_dat=
a.o
> diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/ma=
ch-omap2/powerdomain2xxx_3xxx.c
> deleted file mode 100644
> index 3950ccf..0000000
> --- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
> +++ /dev/null
> @@ -1,242 +0,0 @@
> -/*
> - * OMAP2 and OMAP3 powerdomain control
> - *
> - * Copyright (C) 2009-2011 Texas Instruments, Inc.
> - * Copyright (C) 2007-2009 Nokia Corporation
> - *
> - * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
> - * Rajendra Nayak <rnayak@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/io.h>
> -#include <linux/errno.h>
> -#include <linux/delay.h>
> -#include <linux/bug.h>
> -
> -#include <plat/prcm.h>
> -
> -#include "powerdomain.h"
> -#include "prm.h"
> -#include "prm-regbits-24xx.h"
> -#include "prm-regbits-34xx.h"
> -
> -
> -/* Common functions across OMAP2 and OMAP3 */
> -static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 =
pwrst)
> -{
> -       omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> -                               (pwrst << OMAP_POWERSTATE_SHIFT),
> -                               pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
> -       return 0;
> -}
> -
> -static int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
> -{
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                                            OMAP2_PM_PWSTCTRL,
> -                                            OMAP_POWERSTATE_MASK);
> -}
> -
> -static int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> -{
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                                            OMAP2_PM_PWSTST,
> -                                            OMAP_POWERSTATEST_MASK);
> -}
> -
> -static int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 ba=
nk,
> -                                                               u8 pw=
rst)
> -{
> -       u32 m;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_onstate_mask(bank);
> -
> -       omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prc=
m_offs,
> -                                  OMAP2_PM_PWSTCTRL);
> -
> -       return 0;
> -}
> -
> -static int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 b=
ank,
> -                                                               u8 pw=
rst)
> -{
> -       u32 m;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> -
> -       omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prc=
m_offs,
> -                                  OMAP2_PM_PWSTCTRL);
> -
> -       return 0;
> -}
> -
> -static int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 =
bank)
> -{
> -       u32 m;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_stst_mask(bank);
> -
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_=
PM_PWSTST,
> -                                            m);
> -}
> -
> -static int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 =
bank)
> -{
> -       u32 m;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> -
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                                            OMAP2_PM_PWSTCTRL, m);
> -}
> -
> -static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8=
 pwrst)
> -{
> -       u32 v;
> -
> -       v =3D pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
> -       omap2_prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK=
, v,
> -                                  pwrdm->prcm_offs, OMAP2_PM_PWSTCTR=
L);
> -
> -       return 0;
> -}
> -
> -static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
> -{
> -       u32 c =3D 0;
> -
> -       /*
> -        * REVISIT: pwrdm_wait_transition() may be better implemented
> -        * via a callback and a periodic timer check -- how long do w=
e expect
> -        * powerdomain transitions to take?
> -        */
> -
> -       /* XXX Is this udelay() value meaningful? */
> -       while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWS=
TST) &
> -               OMAP_INTRANSITION_MASK) &&
> -               (c++ < PWRDM_TRANSITION_BAILOUT))
> -                       udelay(1);
> -
> -       if (c > PWRDM_TRANSITION_BAILOUT) {
> -               pr_err("powerdomain: %s: waited too long to complete =
transition\n",
> -                      pwrdm->name);
> -               return -EAGAIN;
> -       }
> -
> -       pr_debug("powerdomain: completed transition in %d loops\n", c=
);
> -
> -       return 0;
> -}
> -
> -/* Applicable only for OMAP3. Not supported on OMAP2 */
> -static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
> -{
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                                            OMAP3430_PM_PREPWSTST,
> -                                            OMAP3430_LASTPOWERSTATEE=
NTERED_MASK);
> -}
> -
> -static int omap3_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> -{
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                                            OMAP2_PM_PWSTST,
> -                                            OMAP3430_LOGICSTATEST_MA=
SK);
> -}
> -
> -static int omap3_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> -{
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                                            OMAP2_PM_PWSTCTRL,
> -                                            OMAP3430_LOGICSTATEST_MA=
SK);
> -}
> -
> -static int omap3_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwr=
dm)
> -{
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                                            OMAP3430_PM_PREPWSTST,
> -                                            OMAP3430_LASTLOGICSTATEE=
NTERED_MASK);
> -}
> -
> -static int omap3_get_mem_bank_lastmemst_mask(u8 bank)
> -{
> -       switch (bank) {
> -       case 0:
> -               return OMAP3430_LASTMEM1STATEENTERED_MASK;
> -       case 1:
> -               return OMAP3430_LASTMEM2STATEENTERED_MASK;
> -       case 2:
> -               return OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MAS=
K;
> -       case 3:
> -               return OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;
> -       default:
> -               WARN_ON(1); /* should never happen */
> -               return -EEXIST;
> -       }
> -       return 0;
> -}
> -
> -static int omap3_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm=
, u8 bank)
> -{
> -       u32 m;
> -
> -       m =3D omap3_get_mem_bank_lastmemst_mask(bank);
> -
> -       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -                               OMAP3430_PM_PREPWSTST, m);
> -}
> -
> -static int omap3_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrd=
m)
> -{
> -       omap2_prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREP=
WSTST);
> -       return 0;
> -}
> -
> -static int omap3_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
> -{
> -       return omap2_prm_rmw_mod_reg_bits(0,
> -                                         1 << OMAP3430ES2_SAVEANDRES=
TORE_SHIFT,
> -                                         pwrdm->prcm_offs, OMAP2_PM_=
PWSTCTRL);
> -}
> -
> -static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
> -{
> -       return omap2_prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRES=
TORE_SHIFT,
> -                                         0, pwrdm->prcm_offs,
> -                                         OMAP2_PM_PWSTCTRL);
> -}
> -
> -struct pwrdm_ops omap2_pwrdm_operations =3D {
> -       .pwrdm_set_next_pwrst   =3D omap2_pwrdm_set_next_pwrst,
> -       .pwrdm_read_next_pwrst  =3D omap2_pwrdm_read_next_pwrst,
> -       .pwrdm_read_pwrst       =3D omap2_pwrdm_read_pwrst,
> -       .pwrdm_set_logic_retst  =3D omap2_pwrdm_set_logic_retst,
> -       .pwrdm_set_mem_onst     =3D omap2_pwrdm_set_mem_onst,
> -       .pwrdm_set_mem_retst    =3D omap2_pwrdm_set_mem_retst,
> -       .pwrdm_read_mem_pwrst   =3D omap2_pwrdm_read_mem_pwrst,
> -       .pwrdm_read_mem_retst   =3D omap2_pwrdm_read_mem_retst,
> -       .pwrdm_wait_transition  =3D omap2_pwrdm_wait_transition,
> -};
> -
> -struct pwrdm_ops omap3_pwrdm_operations =3D {
> -       .pwrdm_set_next_pwrst   =3D omap2_pwrdm_set_next_pwrst,
> -       .pwrdm_read_next_pwrst  =3D omap2_pwrdm_read_next_pwrst,
> -       .pwrdm_read_pwrst       =3D omap2_pwrdm_read_pwrst,
> -       .pwrdm_read_prev_pwrst  =3D omap3_pwrdm_read_prev_pwrst,
> -       .pwrdm_set_logic_retst  =3D omap2_pwrdm_set_logic_retst,
> -       .pwrdm_read_logic_pwrst =3D omap3_pwrdm_read_logic_pwrst,
> -       .pwrdm_read_logic_retst =3D omap3_pwrdm_read_logic_retst,
> -       .pwrdm_read_prev_logic_pwrst    =3D omap3_pwrdm_read_prev_log=
ic_pwrst,
> -       .pwrdm_set_mem_onst     =3D omap2_pwrdm_set_mem_onst,
> -       .pwrdm_set_mem_retst    =3D omap2_pwrdm_set_mem_retst,
> -       .pwrdm_read_mem_pwrst   =3D omap2_pwrdm_read_mem_pwrst,
> -       .pwrdm_read_mem_retst   =3D omap2_pwrdm_read_mem_retst,
> -       .pwrdm_read_prev_mem_pwrst      =3D omap3_pwrdm_read_prev_mem=
_pwrst,
> -       .pwrdm_clear_all_prev_pwrst     =3D omap3_pwrdm_clear_all_pre=
v_pwrst,
> -       .pwrdm_enable_hdwr_sar  =3D omap3_pwrdm_enable_hdwr_sar,
> -       .pwrdm_disable_hdwr_sar =3D omap3_pwrdm_disable_hdwr_sar,
> -       .pwrdm_wait_transition  =3D omap2_pwrdm_wait_transition,
> -};
> diff --git a/arch/arm/mach-omap2/powerdomain33xx.c b/arch/arm/mach-om=
ap2/powerdomain33xx.c
> deleted file mode 100644
> index 67c5663..0000000
> --- a/arch/arm/mach-omap2/powerdomain33xx.c
> +++ /dev/null
> @@ -1,229 +0,0 @@
> -/*
> - * AM33XX Powerdomain control
> - *
> - * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://w=
ww.ti.com/
> - *
> - * Derived from mach-omap2/powerdomain44xx.c written by Rajendra Nay=
ak
> - * <rnayak@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warran=
ty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#include <linux/io.h>
> -#include <linux/errno.h>
> -#include <linux/delay.h>
> -
> -#include <plat/prcm.h>
> -
> -#include "powerdomain.h"
> -#include "prm33xx.h"
> -#include "prm-regbits-33xx.h"
> -
> -
> -static int am33xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8=
 pwrst)
> -{
> -       am33xx_prm_rmw_reg_bits(OMAP_POWERSTATE_MASK,
> -                               (pwrst << OMAP_POWERSTATE_SHIFT),
> -                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> -       return 0;
> -}
> -
> -static int am33xx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs,  pwrdm->pwrstctrl=
_offs);
> -       v &=3D OMAP_POWERSTATE_MASK;
> -       v >>=3D OMAP_POWERSTATE_SHIFT;
> -
> -       return v;
> -}
> -
> -static int am33xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> -       v &=3D OMAP_POWERSTATEST_MASK;
> -       v >>=3D OMAP_POWERSTATEST_SHIFT;
> -
> -       return v;
> -}
> -
> -static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> -       v &=3D AM33XX_LASTPOWERSTATEENTERED_MASK;
> -       v >>=3D AM33XX_LASTPOWERSTATEENTERED_SHIFT;
> -
> -       return v;
> -}
> -
> -static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm=
)
> -{
> -       am33xx_prm_rmw_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
> -                               (1 << AM33XX_LOWPOWERSTATECHANGE_SHIF=
T),
> -                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> -       return 0;
> -}
> -
> -static int am33xx_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwr=
dm)
> -{
> -       am33xx_prm_rmw_reg_bits(AM33XX_LASTPOWERSTATEENTERED_MASK,
> -                               AM33XX_LASTPOWERSTATEENTERED_MASK,
> -                               pwrdm->prcm_offs, pwrdm->pwrstst_offs=
);
> -       return 0;
> -}
> -
> -static int am33xx_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u=
8 pwrst)
> -{
> -       u32 m;
> -
> -       m =3D pwrdm->logicretstate_mask;
> -       if (!m)
> -               return -EINVAL;
> -
> -       am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
> -                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> -
> -       return 0;
> -}
> -
> -static int am33xx_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> -       v &=3D AM33XX_LOGICSTATEST_MASK;
> -       v >>=3D AM33XX_LOGICSTATEST_SHIFT;
> -
> -       return v;
> -}
> -
> -static int am33xx_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> -{
> -       u32 v, m;
> -
> -       m =3D pwrdm->logicretstate_mask;
> -       if (!m)
> -               return -EINVAL;
> -
> -       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_=
offs);
> -       v &=3D m;
> -       v >>=3D __ffs(m);
> -
> -       return v;
> -}
> -
> -static int am33xx_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 b=
ank,
> -               u8 pwrst)
> -{
> -       u32 m;
> -
> -       m =3D pwrdm->mem_on_mask[bank];
> -       if (!m)
> -               return -EINVAL;
> -
> -       am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
> -                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> -
> -       return 0;
> -}
> -
> -static int am33xx_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 =
bank,
> -                                       u8 pwrst)
> -{
> -       u32 m;
> -
> -       m =3D pwrdm->mem_ret_mask[bank];
> -       if (!m)
> -               return -EINVAL;
> -
> -       am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
> -                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> -
> -       return 0;
> -}
> -
> -static int am33xx_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8=
 bank)
> -{
> -       u32 m, v;
> -
> -       m =3D pwrdm->mem_pwrst_mask[bank];
> -       if (!m)
> -               return -EINVAL;
> -
> -       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> -       v &=3D m;
> -       v >>=3D __ffs(m);
> -
> -       return v;
> -}
> -
> -static int am33xx_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8=
 bank)
> -{
> -       u32 m, v;
> -
> -       m =3D pwrdm->mem_retst_mask[bank];
> -       if (!m)
> -               return -EINVAL;
> -
> -       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_=
offs);
> -       v &=3D m;
> -       v >>=3D __ffs(m);
> -
> -       return v;
> -}
> -
> -static int am33xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
> -{
> -       u32 c =3D 0;
> -
> -       /*
> -        * REVISIT: pwrdm_wait_transition() may be better implemented
> -        * via a callback and a periodic timer check -- how long do w=
e expect
> -        * powerdomain transitions to take?
> -        */
> -
> -       /* XXX Is this udelay() value meaningful? */
> -       while ((am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_=
offs)
> -                       & OMAP_INTRANSITION_MASK) &&
> -                       (c++ < PWRDM_TRANSITION_BAILOUT))
> -               udelay(1);
> -
> -       if (c > PWRDM_TRANSITION_BAILOUT) {
> -               pr_err("powerdomain: %s: waited too long to complete =
transition\n",
> -                      pwrdm->name);
> -               return -EAGAIN;
> -       }
> -
> -       pr_debug("powerdomain: completed transition in %d loops\n", c=
);
> -
> -       return 0;
> -}
> -
> -struct pwrdm_ops am33xx_pwrdm_operations =3D {
> -       .pwrdm_set_next_pwrst           =3D am33xx_pwrdm_set_next_pwr=
st,
> -       .pwrdm_read_next_pwrst          =3D am33xx_pwrdm_read_next_pw=
rst,
> -       .pwrdm_read_pwrst               =3D am33xx_pwrdm_read_pwrst,
> -       .pwrdm_read_prev_pwrst          =3D am33xx_pwrdm_read_prev_pw=
rst,
> -       .pwrdm_set_logic_retst          =3D am33xx_pwrdm_set_logic_re=
tst,
> -       .pwrdm_read_logic_pwrst         =3D am33xx_pwrdm_read_logic_p=
wrst,
> -       .pwrdm_read_logic_retst         =3D am33xx_pwrdm_read_logic_r=
etst,
> -       .pwrdm_clear_all_prev_pwrst     =3D am33xx_pwrdm_clear_all_pr=
ev_pwrst,
> -       .pwrdm_set_lowpwrstchange       =3D am33xx_pwrdm_set_lowpwrst=
change,
> -       .pwrdm_read_mem_pwrst           =3D am33xx_pwrdm_read_mem_pwr=
st,
> -       .pwrdm_read_mem_retst           =3D am33xx_pwrdm_read_mem_ret=
st,
> -       .pwrdm_set_mem_onst             =3D am33xx_pwrdm_set_mem_onst=
,
> -       .pwrdm_set_mem_retst            =3D am33xx_pwrdm_set_mem_rets=
t,
> -       .pwrdm_wait_transition          =3D am33xx_pwrdm_wait_transit=
ion,
> -};
> diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-om=
ap2/powerdomain44xx.c
> deleted file mode 100644
> index aceb4f4..0000000
> --- a/arch/arm/mach-omap2/powerdomain44xx.c
> +++ /dev/null
> @@ -1,285 +0,0 @@
> -/*
> - * OMAP4 powerdomain control
> - *
> - * Copyright (C) 2009-2010, 2012 Texas Instruments, Inc.
> - * Copyright (C) 2007-2009 Nokia Corporation
> - *
> - * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
> - * Rajendra Nayak <rnayak@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/io.h>
> -#include <linux/errno.h>
> -#include <linux/delay.h>
> -#include <linux/bug.h>
> -
> -#include "powerdomain.h"
> -#include <plat/prcm.h>
> -#include "prm2xxx_3xxx.h"
> -#include "prm44xx.h"
> -#include "prminst44xx.h"
> -#include "prm-regbits-44xx.h"
> -
> -static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 =
pwrst)
> -{
> -       omap4_prminst_rmw_inst_reg_bits(OMAP_POWERSTATE_MASK,
> -                                       (pwrst << OMAP_POWERSTATE_SHI=
=46T),
> -                                       pwrdm->prcm_partition,
> -                                       pwrdm->prcm_offs, OMAP4_PM_PW=
STCTRL);
> -       return 0;
> -}
> -
> -static int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> -                                       OMAP4_PM_PWSTCTRL);
> -       v &=3D OMAP_POWERSTATE_MASK;
> -       v >>=3D OMAP_POWERSTATE_SHIFT;
> -
> -       return v;
> -}
> -
> -static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> -                                       OMAP4_PM_PWSTST);
> -       v &=3D OMAP_POWERSTATEST_MASK;
> -       v >>=3D OMAP_POWERSTATEST_SHIFT;
> -
> -       return v;
> -}
> -
> -static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> -                                       OMAP4_PM_PWSTST);
> -       v &=3D OMAP4430_LASTPOWERSTATEENTERED_MASK;
> -       v >>=3D OMAP4430_LASTPOWERSTATEENTERED_SHIFT;
> -
> -       return v;
> -}
> -
> -static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
> -{
> -       omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_=
MASK,
> -                                       (1 << OMAP4430_LOWPOWERSTATEC=
HANGE_SHIFT),
> -                                       pwrdm->prcm_partition,
> -                                       pwrdm->prcm_offs, OMAP4_PM_PW=
STCTRL);
> -       return 0;
> -}
> -
> -static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrd=
m)
> -{
> -       omap4_prminst_rmw_inst_reg_bits(OMAP4430_LASTPOWERSTATEENTERE=
D_MASK,
> -                                       OMAP4430_LASTPOWERSTATEENTERE=
D_MASK,
> -                                       pwrdm->prcm_partition,
> -                                       pwrdm->prcm_offs, OMAP4_PM_PW=
STST);
> -       return 0;
> -}
> -
> -static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8=
 pwrst)
> -{
> -       u32 v;
> -
> -       v =3D pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
> -       omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOGICRETSTATE_MASK, =
v,
> -                                       pwrdm->prcm_partition, pwrdm-=
>prcm_offs,
> -                                       OMAP4_PM_PWSTCTRL);
> -
> -       return 0;
> -}
> -
> -static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 ba=
nk,
> -                                   u8 pwrst)
> -{
> -       u32 m;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_onstate_mask(bank);
> -
> -       omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
> -                                       pwrdm->prcm_partition, pwrdm-=
>prcm_offs,
> -                                       OMAP4_PM_PWSTCTRL);
> -
> -       return 0;
> -}
> -
> -static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 b=
ank,
> -                                    u8 pwrst)
> -{
> -       u32 m;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> -
> -       omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
> -                                       pwrdm->prcm_partition, pwrdm-=
>prcm_offs,
> -                                       OMAP4_PM_PWSTCTRL);
> -
> -       return 0;
> -}
> -
> -static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> -                                       OMAP4_PM_PWSTST);
> -       v &=3D OMAP4430_LOGICSTATEST_MASK;
> -       v >>=3D OMAP4430_LOGICSTATEST_SHIFT;
> -
> -       return v;
> -}
> -
> -static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> -{
> -       u32 v;
> -
> -       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> -                                       OMAP4_PM_PWSTCTRL);
> -       v &=3D OMAP4430_LOGICRETSTATE_MASK;
> -       v >>=3D OMAP4430_LOGICRETSTATE_SHIFT;
> -
> -       return v;
> -}
> -
> -/**
> - * omap4_pwrdm_read_prev_logic_pwrst - read the previous logic power=
state
> - * @pwrdm: struct powerdomain * to read the state for
> - *
> - * Reads the previous logic powerstate for a powerdomain. This
> - * function must determine the previous logic powerstate by first
> - * checking the previous powerstate for the domain. If that was OFF,
> - * then logic has been lost. If previous state was RETENTION, the
> - * function reads the setting for the next retention logic state to
> - * see the actual value.  In every other case, the logic is
> - * retained. Returns either PWRDM_POWER_OFF or PWRDM_POWER_RET
> - * depending whether the logic was retained or not.
> - */
> -static int omap4_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwr=
dm)
> -{
> -       int state;
> -
> -       state =3D omap4_pwrdm_read_prev_pwrst(pwrdm);
> -
> -       if (state =3D=3D PWRDM_POWER_OFF)
> -               return PWRDM_POWER_OFF;
> -
> -       if (state !=3D PWRDM_POWER_RET)
> -               return PWRDM_POWER_RET;
> -
> -       return omap4_pwrdm_read_logic_retst(pwrdm);
> -}
> -
> -static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 =
bank)
> -{
> -       u32 m, v;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_stst_mask(bank);
> -
> -       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> -                                       OMAP4_PM_PWSTST);
> -       v &=3D m;
> -       v >>=3D __ffs(m);
> -
> -       return v;
> -}
> -
> -static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 =
bank)
> -{
> -       u32 m, v;
> -
> -       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> -
> -       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> -                                       OMAP4_PM_PWSTCTRL);
> -       v &=3D m;
> -       v >>=3D __ffs(m);
> -
> -       return v;
> -}
> -
> -/**
> - * omap4_pwrdm_read_prev_mem_pwrst - reads the previous memory power=
state
> - * @pwrdm: struct powerdomain * to read mem powerstate for
> - * @bank: memory bank index
> - *
> - * Reads the previous memory powerstate for a powerdomain. This
> - * function must determine the previous memory powerstate by first
> - * checking the previous powerstate for the domain. If that was OFF,
> - * then logic has been lost. If previous state was RETENTION, the
> - * function reads the setting for the next memory retention state to
> - * see the actual value.  In every other case, the logic is
> - * retained. Returns either PWRDM_POWER_OFF or PWRDM_POWER_RET
> - * depending whether logic was retained or not.
> - */
> -static int omap4_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm=
, u8 bank)
> -{
> -       int state;
> -
> -       state =3D omap4_pwrdm_read_prev_pwrst(pwrdm);
> -
> -       if (state =3D=3D PWRDM_POWER_OFF)
> -               return PWRDM_POWER_OFF;
> -
> -       if (state !=3D PWRDM_POWER_RET)
> -               return PWRDM_POWER_RET;
> -
> -       return omap4_pwrdm_read_mem_retst(pwrdm, bank);
> -}
> -
> -static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
> -{
> -       u32 c =3D 0;
> -
> -       /*
> -        * REVISIT: pwrdm_wait_transition() may be better implemented
> -        * via a callback and a periodic timer check -- how long do w=
e expect
> -        * powerdomain transitions to take?
> -        */
> -
> -       /* XXX Is this udelay() value meaningful? */
> -       while ((omap4_prminst_read_inst_reg(pwrdm->prcm_partition,
> -                                           pwrdm->prcm_offs,
> -                                           OMAP4_PM_PWSTST) &
> -               OMAP_INTRANSITION_MASK) &&
> -              (c++ < PWRDM_TRANSITION_BAILOUT))
> -               udelay(1);
> -
> -       if (c > PWRDM_TRANSITION_BAILOUT) {
> -               pr_err("powerdomain: %s: waited too long to complete =
transition\n",
> -                      pwrdm->name);
> -               return -EAGAIN;
> -       }
> -
> -       pr_debug("powerdomain: completed transition in %d loops\n", c=
);
> -
> -       return 0;
> -}
> -
> -struct pwrdm_ops omap4_pwrdm_operations =3D {
> -       .pwrdm_set_next_pwrst   =3D omap4_pwrdm_set_next_pwrst,
> -       .pwrdm_read_next_pwrst  =3D omap4_pwrdm_read_next_pwrst,
> -       .pwrdm_read_pwrst       =3D omap4_pwrdm_read_pwrst,
> -       .pwrdm_read_prev_pwrst  =3D omap4_pwrdm_read_prev_pwrst,
> -       .pwrdm_set_lowpwrstchange       =3D omap4_pwrdm_set_lowpwrstc=
hange,
> -       .pwrdm_clear_all_prev_pwrst     =3D omap4_pwrdm_clear_all_pre=
v_pwrst,
> -       .pwrdm_set_logic_retst  =3D omap4_pwrdm_set_logic_retst,
> -       .pwrdm_read_logic_pwrst =3D omap4_pwrdm_read_logic_pwrst,
> -       .pwrdm_read_prev_logic_pwrst    =3D omap4_pwrdm_read_prev_log=
ic_pwrst,
> -       .pwrdm_read_logic_retst =3D omap4_pwrdm_read_logic_retst,
> -       .pwrdm_read_mem_pwrst   =3D omap4_pwrdm_read_mem_pwrst,
> -       .pwrdm_read_mem_retst   =3D omap4_pwrdm_read_mem_retst,
> -       .pwrdm_read_prev_mem_pwrst      =3D omap4_pwrdm_read_prev_mem=
_pwrst,
> -       .pwrdm_set_mem_onst     =3D omap4_pwrdm_set_mem_onst,
> -       .pwrdm_set_mem_retst    =3D omap4_pwrdm_set_mem_retst,
> -       .pwrdm_wait_transition  =3D omap4_pwrdm_wait_transition,
> -};
> diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2=
xxx.c
> new file mode 100644
> index 0000000..14940c4
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prm2xxx.c
> @@ -0,0 +1,40 @@
> +/*
> + * OMAP2xxx PRM module functions
> + *
> + * Copyright (C) 2010-2012 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + * Beno=C3=AEt Cousson
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +
> +#include "common.h"
> +#include <plat/cpu.h>
> +#include <plat/prcm.h>
> +
> +#include "vp.h"
> +#include "powerdomain.h"
> +#include "prm2xxx.h"
> +#include "cm2xxx_3xxx.h"
> +#include "prm-regbits-24xx.h"
> +
> +struct pwrdm_ops omap2_pwrdm_operations =3D {
> +       .pwrdm_set_next_pwrst   =3D omap2_pwrdm_set_next_pwrst,
> +       .pwrdm_read_next_pwrst  =3D omap2_pwrdm_read_next_pwrst,
> +       .pwrdm_read_pwrst       =3D omap2_pwrdm_read_pwrst,
> +       .pwrdm_set_logic_retst  =3D omap2_pwrdm_set_logic_retst,
> +       .pwrdm_set_mem_onst     =3D omap2_pwrdm_set_mem_onst,
> +       .pwrdm_set_mem_retst    =3D omap2_pwrdm_set_mem_retst,
> +       .pwrdm_read_mem_pwrst   =3D omap2_pwrdm_read_mem_pwrst,
> +       .pwrdm_read_mem_retst   =3D omap2_pwrdm_read_mem_retst,
> +       .pwrdm_wait_transition  =3D omap2_pwrdm_wait_transition,
> +};
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2=
/prm2xxx_3xxx.c
> index 0d6cc54..bdddf5c 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -17,7 +17,7 @@
>  #include <linux/io.h>
>
>  #include "common.h"
> -
> +#include "powerdomain.h"
>  #include "prm2xxx_3xxx.h"
>  #include "prm-regbits-24xx.h"
>
> @@ -98,3 +98,113 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 =
rst_shift, u8 st_shift)
>         return (c =3D=3D MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
>  }
>
> +
> +/* Powerdomain low-level functions */
> +
> +/* Common functions across OMAP2 and OMAP3 */
> +int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
> +{
> +       omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> +                                  (pwrst << OMAP_POWERSTATE_SHIFT),
> +                                  pwrdm->prcm_offs, OMAP2_PM_PWSTCTR=
L);
> +       return 0;
> +}
> +
> +int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
> +{
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                                            OMAP2_PM_PWSTCTRL,
> +                                            OMAP_POWERSTATE_MASK);
> +}
> +
> +int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> +{
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                                            OMAP2_PM_PWSTST,
> +                                            OMAP_POWERSTATEST_MASK);
> +}
> +
> +int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
> +                                                               u8 pw=
rst)
> +{
> +       u32 m;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_onstate_mask(bank);
> +
> +       omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prc=
m_offs,
> +                                  OMAP2_PM_PWSTCTRL);
> +
> +       return 0;
> +}
> +
> +int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
> +                                                               u8 pw=
rst)
> +{
> +       u32 m;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> +
> +       omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prc=
m_offs,
> +                                  OMAP2_PM_PWSTCTRL);
> +
> +       return 0;
> +}
> +
> +int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
> +{
> +       u32 m;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_stst_mask(bank);
> +
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_=
PM_PWSTST,
> +                                            m);
> +}
> +
> +int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
> +{
> +       u32 m;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> +
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                                            OMAP2_PM_PWSTCTRL, m);
> +}
> +
> +int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
> +{
> +       u32 v;
> +
> +       v =3D pwrst << __ffs(OMAP_LOGICRETSTATE_MASK);
> +       omap2_prm_rmw_mod_reg_bits(OMAP_LOGICRETSTATE_MASK, v, pwrdm-=
>prcm_offs,
> +                                  OMAP2_PM_PWSTCTRL);
> +
> +       return 0;
> +}
> +
> +int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
> +{
> +       u32 c =3D 0;
> +
> +       /*
> +        * REVISIT: pwrdm_wait_transition() may be better implemented
> +        * via a callback and a periodic timer check -- how long do w=
e expect
> +        * powerdomain transitions to take?
> +        */
> +
> +       /* XXX Is this udelay() value meaningful? */
> +       while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWS=
TST) &
> +               OMAP_INTRANSITION_MASK) &&
> +               (c++ < PWRDM_TRANSITION_BAILOUT))
> +                       udelay(1);
> +
> +       if (c > PWRDM_TRANSITION_BAILOUT) {
> +               pr_err("powerdomain: %s: waited too long to complete =
transition\n",
> +                      pwrdm->name);
> +               return -EAGAIN;
> +       }
> +
> +       pr_debug("powerdomain: completed transition in %d loops\n", c=
);
> +
> +       return 0;
> +}
> +
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2=
/prm2xxx_3xxx.h
> index 8d09a1a..706b026 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> @@ -50,6 +50,7 @@
>  #ifndef __ASSEMBLER__
>
>  #include <linux/io.h>
> +#include "powerdomain.h"
>
>  /* Power/reset management domain register get/set */
>  static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
> @@ -103,6 +104,18 @@ extern int omap2_prm_is_hardreset_asserted(s16 p=
rm_mod, u8 shift);
>  extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
>  extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u=
8 st_shift);
>
> +extern int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 =
pwrst);
> +extern int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
> +extern int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm);
> +extern int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 ba=
nk,
> +                                   u8 pwrst);
> +extern int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 b=
ank,
> +                                    u8 pwrst);
> +extern int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 =
bank);
> +extern int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 =
bank);
> +extern int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8=
 pwrst);
> +extern int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm);
> +
>  #endif /* __ASSEMBLER */
>
>  /*
> diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm3=
3xx.c
> index e7dbb6c..3417dd3 100644
> --- a/arch/arm/mach-omap2/prm33xx.c
> +++ b/arch/arm/mach-omap2/prm33xx.c
> @@ -22,6 +22,7 @@
>  #include <plat/common.h>
>
>  #include "common.h"
> +#include "powerdomain.h"
>  #include "prm33xx.h"
>  #include "prm-regbits-33xx.h"
>
> @@ -133,3 +134,204 @@ int am33xx_prm_deassert_hardreset(u8 shift, s16=
 inst,
>
>         return (c =3D=3D MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
>  }
> +
> +static int am33xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8=
 pwrst)
> +{
> +       am33xx_prm_rmw_reg_bits(OMAP_POWERSTATE_MASK,
> +                               (pwrst << OMAP_POWERSTATE_SHIFT),
> +                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> +       return 0;
> +}
> +
> +static int am33xx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs,  pwrdm->pwrstctrl=
_offs);
> +       v &=3D OMAP_POWERSTATE_MASK;
> +       v >>=3D OMAP_POWERSTATE_SHIFT;
> +
> +       return v;
> +}
> +
> +static int am33xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> +       v &=3D OMAP_POWERSTATEST_MASK;
> +       v >>=3D OMAP_POWERSTATEST_SHIFT;
> +
> +       return v;
> +}
> +
> +static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> +       v &=3D AM33XX_LASTPOWERSTATEENTERED_MASK;
> +       v >>=3D AM33XX_LASTPOWERSTATEENTERED_SHIFT;
> +
> +       return v;
> +}
> +
> +static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm=
)
> +{
> +       am33xx_prm_rmw_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
> +                               (1 << AM33XX_LOWPOWERSTATECHANGE_SHIF=
T),
> +                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> +       return 0;
> +}
> +
> +static int am33xx_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwr=
dm)
> +{
> +       am33xx_prm_rmw_reg_bits(AM33XX_LASTPOWERSTATEENTERED_MASK,
> +                               AM33XX_LASTPOWERSTATEENTERED_MASK,
> +                               pwrdm->prcm_offs, pwrdm->pwrstst_offs=
);
> +       return 0;
> +}
> +
> +static int am33xx_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u=
8 pwrst)
> +{
> +       u32 m;
> +
> +       m =3D pwrdm->logicretstate_mask;
> +       if (!m)
> +               return -EINVAL;
> +
> +       am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
> +                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> +
> +       return 0;
> +}
> +
> +static int am33xx_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> +       v &=3D AM33XX_LOGICSTATEST_MASK;
> +       v >>=3D AM33XX_LOGICSTATEST_SHIFT;
> +
> +       return v;
> +}
> +
> +static int am33xx_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> +{
> +       u32 v, m;
> +
> +       m =3D pwrdm->logicretstate_mask;
> +       if (!m)
> +               return -EINVAL;
> +
> +       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_=
offs);
> +       v &=3D m;
> +       v >>=3D __ffs(m);
> +
> +       return v;
> +}
> +
> +static int am33xx_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 b=
ank,
> +               u8 pwrst)
> +{
> +       u32 m;
> +
> +       m =3D pwrdm->mem_on_mask[bank];
> +       if (!m)
> +               return -EINVAL;
> +
> +       am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
> +                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> +
> +       return 0;
> +}
> +
> +static int am33xx_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 =
bank,
> +                                       u8 pwrst)
> +{
> +       u32 m;
> +
> +       m =3D pwrdm->mem_ret_mask[bank];
> +       if (!m)
> +               return -EINVAL;
> +
> +       am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
> +                               pwrdm->prcm_offs, pwrdm->pwrstctrl_of=
fs);
> +
> +       return 0;
> +}
> +
> +static int am33xx_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8=
 bank)
> +{
> +       u32 m, v;
> +
> +       m =3D pwrdm->mem_pwrst_mask[bank];
> +       if (!m)
> +               return -EINVAL;
> +
> +       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_of=
fs);
> +       v &=3D m;
> +       v >>=3D __ffs(m);
> +
> +       return v;
> +}
> +
> +static int am33xx_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8=
 bank)
> +{
> +       u32 m, v;
> +
> +       m =3D pwrdm->mem_retst_mask[bank];
> +       if (!m)
> +               return -EINVAL;
> +
> +       v =3D am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_=
offs);
> +       v &=3D m;
> +       v >>=3D __ffs(m);
> +
> +       return v;
> +}
> +
> +static int am33xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
> +{
> +       u32 c =3D 0;
> +
> +       /*
> +        * REVISIT: pwrdm_wait_transition() may be better implemented
> +        * via a callback and a periodic timer check -- how long do w=
e expect
> +        * powerdomain transitions to take?
> +        */
> +
> +       /* XXX Is this udelay() value meaningful? */
> +       while ((am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_=
offs)
> +                       & OMAP_INTRANSITION_MASK) &&
> +                       (c++ < PWRDM_TRANSITION_BAILOUT))
> +               udelay(1);
> +
> +       if (c > PWRDM_TRANSITION_BAILOUT) {
> +               pr_err("powerdomain: %s: waited too long to complete =
transition\n",
> +                      pwrdm->name);
> +               return -EAGAIN;
> +       }
> +
> +       pr_debug("powerdomain: completed transition in %d loops\n", c=
);
> +
> +       return 0;
> +}
> +
> +struct pwrdm_ops am33xx_pwrdm_operations =3D {
> +       .pwrdm_set_next_pwrst           =3D am33xx_pwrdm_set_next_pwr=
st,
> +       .pwrdm_read_next_pwrst          =3D am33xx_pwrdm_read_next_pw=
rst,
> +       .pwrdm_read_pwrst               =3D am33xx_pwrdm_read_pwrst,
> +       .pwrdm_read_prev_pwrst          =3D am33xx_pwrdm_read_prev_pw=
rst,
> +       .pwrdm_set_logic_retst          =3D am33xx_pwrdm_set_logic_re=
tst,
> +       .pwrdm_read_logic_pwrst         =3D am33xx_pwrdm_read_logic_p=
wrst,
> +       .pwrdm_read_logic_retst         =3D am33xx_pwrdm_read_logic_r=
etst,
> +       .pwrdm_clear_all_prev_pwrst     =3D am33xx_pwrdm_clear_all_pr=
ev_pwrst,
> +       .pwrdm_set_lowpwrstchange       =3D am33xx_pwrdm_set_lowpwrst=
change,
> +       .pwrdm_read_mem_pwrst           =3D am33xx_pwrdm_read_mem_pwr=
st,
> +       .pwrdm_read_mem_retst           =3D am33xx_pwrdm_read_mem_ret=
st,
> +       .pwrdm_set_mem_onst             =3D am33xx_pwrdm_set_mem_onst=
,
> +       .pwrdm_set_mem_retst            =3D am33xx_pwrdm_set_mem_rets=
t,
> +       .pwrdm_wait_transition          =3D am33xx_pwrdm_wait_transit=
ion,
> +};
> diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3=
xxx.c
> index 88f7d8d..b2c5fd9 100644
> --- a/arch/arm/mach-omap2/prm3xxx.c
> +++ b/arch/arm/mach-omap2/prm3xxx.c
> @@ -22,8 +22,9 @@
>  #include <plat/prcm.h>
>
>  #include "vp.h"
> -
> +#include "powerdomain.h"
>  #include "prm3xxx.h"
> +#include "prm2xxx_3xxx.h"
>  #include "cm2xxx_3xxx.h"
>  #include "prm-regbits-34xx.h"
>
> @@ -215,6 +216,109 @@ static void __init omap3xxx_prm_enable_io_wakeu=
p(void)
>                                            PM_WKEN);
>  }
>
> +/* Powerdomain low-level functions */
> +
> +/* Applicable only for OMAP3. Not supported on OMAP2 */
> +static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
> +{
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                                            OMAP3430_PM_PREPWSTST,
> +                                            OMAP3430_LASTPOWERSTATEE=
NTERED_MASK);
> +}
> +
> +static int omap3_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> +{
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                                            OMAP2_PM_PWSTST,
> +                                            OMAP3430_LOGICSTATEST_MA=
SK);
> +}
> +
> +static int omap3_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> +{
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                                            OMAP2_PM_PWSTCTRL,
> +                                            OMAP3430_LOGICSTATEST_MA=
SK);
> +}
> +
> +static int omap3_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwr=
dm)
> +{
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                                            OMAP3430_PM_PREPWSTST,
> +                                            OMAP3430_LASTLOGICSTATEE=
NTERED_MASK);
> +}
> +
> +static int omap3_get_mem_bank_lastmemst_mask(u8 bank)
> +{
> +       switch (bank) {
> +       case 0:
> +               return OMAP3430_LASTMEM1STATEENTERED_MASK;
> +       case 1:
> +               return OMAP3430_LASTMEM2STATEENTERED_MASK;
> +       case 2:
> +               return OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MAS=
K;
> +       case 3:
> +               return OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;
> +       default:
> +               WARN_ON(1); /* should never happen */
> +               return -EEXIST;
> +       }
> +       return 0;
> +}
> +
> +static int omap3_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm=
, u8 bank)
> +{
> +       u32 m;
> +
> +       m =3D omap3_get_mem_bank_lastmemst_mask(bank);
> +
> +       return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +                               OMAP3430_PM_PREPWSTST, m);
> +}
> +
> +static int omap3_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrd=
m)
> +{
> +       omap2_prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREP=
WSTST);
> +       return 0;
> +}
> +
> +static int omap3_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
> +{
> +       return omap2_prm_rmw_mod_reg_bits(0,
> +                                         1 << OMAP3430ES2_SAVEANDRES=
TORE_SHIFT,
> +                                         pwrdm->prcm_offs, OMAP2_PM_=
PWSTCTRL);
> +}
> +
> +static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
> +{
> +       return omap2_prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRES=
TORE_SHIFT,
> +                                         0, pwrdm->prcm_offs,
> +                                         OMAP2_PM_PWSTCTRL);
> +}
> +
> +struct pwrdm_ops omap3_pwrdm_operations =3D {
> +       .pwrdm_set_next_pwrst   =3D omap2_pwrdm_set_next_pwrst,
> +       .pwrdm_read_next_pwrst  =3D omap2_pwrdm_read_next_pwrst,
> +       .pwrdm_read_pwrst       =3D omap2_pwrdm_read_pwrst,
> +       .pwrdm_read_prev_pwrst  =3D omap3_pwrdm_read_prev_pwrst,
> +       .pwrdm_set_logic_retst  =3D omap2_pwrdm_set_logic_retst,
> +       .pwrdm_read_logic_pwrst =3D omap3_pwrdm_read_logic_pwrst,
> +       .pwrdm_read_logic_retst =3D omap3_pwrdm_read_logic_retst,
> +       .pwrdm_read_prev_logic_pwrst    =3D omap3_pwrdm_read_prev_log=
ic_pwrst,
> +       .pwrdm_set_mem_onst     =3D omap2_pwrdm_set_mem_onst,
> +       .pwrdm_set_mem_retst    =3D omap2_pwrdm_set_mem_retst,
> +       .pwrdm_read_mem_pwrst   =3D omap2_pwrdm_read_mem_pwrst,
> +       .pwrdm_read_mem_retst   =3D omap2_pwrdm_read_mem_retst,
> +       .pwrdm_read_prev_mem_pwrst      =3D omap3_pwrdm_read_prev_mem=
_pwrst,
> +       .pwrdm_clear_all_prev_pwrst     =3D omap3_pwrdm_clear_all_pre=
v_pwrst,
> +       .pwrdm_enable_hdwr_sar  =3D omap3_pwrdm_enable_hdwr_sar,
> +       .pwrdm_disable_hdwr_sar =3D omap3_pwrdm_disable_hdwr_sar,
> +       .pwrdm_wait_transition  =3D omap2_pwrdm_wait_transition,
> +};
> +
> +/*
> + *
> + */
> +
>  static int __init omap3xxx_prm_init(void)
>  {
>         int ret;
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm4=
4xx.c
> index 06bb679..9231fe5 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -27,6 +27,7 @@
>  #include "prm-regbits-44xx.h"
>  #include "prcm44xx.h"
>  #include "prminst44xx.h"
> +#include "powerdomain.h"
>
>  static const struct omap_prcm_irq omap4_prcm_irqs[] =3D {
>         OMAP_PRCM_IRQ("wkup",   0,      0),
> @@ -291,6 +292,269 @@ static void __init omap44xx_prm_enable_io_wakeu=
p(void)
>                                     OMAP4_PRM_IO_PMCTRL_OFFSET);
>  }
>
> +/* Powerdomain low-level functions */
> +
> +static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 =
pwrst)
> +{
> +       omap4_prminst_rmw_inst_reg_bits(OMAP_POWERSTATE_MASK,
> +                                       (pwrst << OMAP_POWERSTATE_SHI=
=46T),
> +                                       pwrdm->prcm_partition,
> +                                       pwrdm->prcm_offs, OMAP4_PM_PW=
STCTRL);
> +       return 0;
> +}
> +
> +static int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> +                                       OMAP4_PM_PWSTCTRL);
> +       v &=3D OMAP_POWERSTATE_MASK;
> +       v >>=3D OMAP_POWERSTATE_SHIFT;
> +
> +       return v;
> +}
> +
> +static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> +                                       OMAP4_PM_PWSTST);
> +       v &=3D OMAP_POWERSTATEST_MASK;
> +       v >>=3D OMAP_POWERSTATEST_SHIFT;
> +
> +       return v;
> +}
> +
> +static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> +                                       OMAP4_PM_PWSTST);
> +       v &=3D OMAP4430_LASTPOWERSTATEENTERED_MASK;
> +       v >>=3D OMAP4430_LASTPOWERSTATEENTERED_SHIFT;
> +
> +       return v;
> +}
> +
> +static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
> +{
> +       omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_=
MASK,
> +                                       (1 << OMAP4430_LOWPOWERSTATEC=
HANGE_SHIFT),
> +                                       pwrdm->prcm_partition,
> +                                       pwrdm->prcm_offs, OMAP4_PM_PW=
STCTRL);
> +       return 0;
> +}
> +
> +static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrd=
m)
> +{
> +       omap4_prminst_rmw_inst_reg_bits(OMAP4430_LASTPOWERSTATEENTERE=
D_MASK,
> +                                       OMAP4430_LASTPOWERSTATEENTERE=
D_MASK,
> +                                       pwrdm->prcm_partition,
> +                                       pwrdm->prcm_offs, OMAP4_PM_PW=
STST);
> +       return 0;
> +}
> +
> +static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8=
 pwrst)
> +{
> +       u32 v;
> +
> +       v =3D pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
> +       omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOGICRETSTATE_MASK, =
v,
> +                                       pwrdm->prcm_partition, pwrdm-=
>prcm_offs,
> +                                       OMAP4_PM_PWSTCTRL);
> +
> +       return 0;
> +}
> +
> +static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 ba=
nk,
> +                                   u8 pwrst)
> +{
> +       u32 m;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_onstate_mask(bank);
> +
> +       omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
> +                                       pwrdm->prcm_partition, pwrdm-=
>prcm_offs,
> +                                       OMAP4_PM_PWSTCTRL);
> +
> +       return 0;
> +}
> +
> +static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 b=
ank,
> +                                    u8 pwrst)
> +{
> +       u32 m;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> +
> +       omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
> +                                       pwrdm->prcm_partition, pwrdm-=
>prcm_offs,
> +                                       OMAP4_PM_PWSTCTRL);
> +
> +       return 0;
> +}
> +
> +static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> +                                       OMAP4_PM_PWSTST);
> +       v &=3D OMAP4430_LOGICSTATEST_MASK;
> +       v >>=3D OMAP4430_LOGICSTATEST_SHIFT;
> +
> +       return v;
> +}
> +
> +static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> +{
> +       u32 v;
> +
> +       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> +                                       OMAP4_PM_PWSTCTRL);
> +       v &=3D OMAP4430_LOGICRETSTATE_MASK;
> +       v >>=3D OMAP4430_LOGICRETSTATE_SHIFT;
> +
> +       return v;
> +}
> +
> +/**
> + * omap4_pwrdm_read_prev_logic_pwrst - read the previous logic power=
state
> + * @pwrdm: struct powerdomain * to read the state for
> + *
> + * Reads the previous logic powerstate for a powerdomain. This
> + * function must determine the previous logic powerstate by first
> + * checking the previous powerstate for the domain. If that was OFF,
> + * then logic has been lost. If previous state was RETENTION, the
> + * function reads the setting for the next retention logic state to
> + * see the actual value.  In every other case, the logic is
> + * retained. Returns either PWRDM_POWER_OFF or PWRDM_POWER_RET
> + * depending whether the logic was retained or not.
> + */
> +static int omap4_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwr=
dm)
> +{
> +       int state;
> +
> +       state =3D omap4_pwrdm_read_prev_pwrst(pwrdm);
> +
> +       if (state =3D=3D PWRDM_POWER_OFF)
> +               return PWRDM_POWER_OFF;
> +
> +       if (state !=3D PWRDM_POWER_RET)
> +               return PWRDM_POWER_RET;
> +
> +       return omap4_pwrdm_read_logic_retst(pwrdm);
> +}
> +
> +static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 =
bank)
> +{
> +       u32 m, v;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_stst_mask(bank);
> +
> +       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> +                                       OMAP4_PM_PWSTST);
> +       v &=3D m;
> +       v >>=3D __ffs(m);
> +
> +       return v;
> +}
> +
> +static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 =
bank)
> +{
> +       u32 m, v;
> +
> +       m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
> +
> +       v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrd=
m->prcm_offs,
> +                                       OMAP4_PM_PWSTCTRL);
> +       v &=3D m;
> +       v >>=3D __ffs(m);
> +
> +       return v;
> +}
> +
> +/**
> + * omap4_pwrdm_read_prev_mem_pwrst - reads the previous memory power=
state
> + * @pwrdm: struct powerdomain * to read mem powerstate for
> + * @bank: memory bank index
> + *
> + * Reads the previous memory powerstate for a powerdomain. This
> + * function must determine the previous memory powerstate by first
> + * checking the previous powerstate for the domain. If that was OFF,
> + * then logic has been lost. If previous state was RETENTION, the
> + * function reads the setting for the next memory retention state to
> + * see the actual value.  In every other case, the logic is
> + * retained. Returns either PWRDM_POWER_OFF or PWRDM_POWER_RET
> + * depending whether logic was retained or not.
> + */
> +static int omap4_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm=
, u8 bank)
> +{
> +       int state;
> +
> +       state =3D omap4_pwrdm_read_prev_pwrst(pwrdm);
> +
> +       if (state =3D=3D PWRDM_POWER_OFF)
> +               return PWRDM_POWER_OFF;
> +
> +       if (state !=3D PWRDM_POWER_RET)
> +               return PWRDM_POWER_RET;
> +
> +       return omap4_pwrdm_read_mem_retst(pwrdm, bank);
> +}
> +
> +static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
> +{
> +       u32 c =3D 0;
> +
> +       /*
> +        * REVISIT: pwrdm_wait_transition() may be better implemented
> +        * via a callback and a periodic timer check -- how long do w=
e expect
> +        * powerdomain transitions to take?
> +        */
> +
> +       /* XXX Is this udelay() value meaningful? */
> +       while ((omap4_prminst_read_inst_reg(pwrdm->prcm_partition,
> +                                           pwrdm->prcm_offs,
> +                                           OMAP4_PM_PWSTST) &
> +               OMAP_INTRANSITION_MASK) &&
> +              (c++ < PWRDM_TRANSITION_BAILOUT))
> +               udelay(1);
> +
> +       if (c > PWRDM_TRANSITION_BAILOUT) {
> +               pr_err("powerdomain: %s: waited too long to complete =
transition\n",
> +                      pwrdm->name);
> +               return -EAGAIN;
> +       }
> +
> +       pr_debug("powerdomain: completed transition in %d loops\n", c=
);
> +
> +       return 0;
> +}
> +
> +struct pwrdm_ops omap4_pwrdm_operations =3D {
> +       .pwrdm_set_next_pwrst   =3D omap4_pwrdm_set_next_pwrst,
> +       .pwrdm_read_next_pwrst  =3D omap4_pwrdm_read_next_pwrst,
> +       .pwrdm_read_pwrst       =3D omap4_pwrdm_read_pwrst,
> +       .pwrdm_read_prev_pwrst  =3D omap4_pwrdm_read_prev_pwrst,
> +       .pwrdm_set_lowpwrstchange       =3D omap4_pwrdm_set_lowpwrstc=
hange,
> +       .pwrdm_clear_all_prev_pwrst     =3D omap4_pwrdm_clear_all_pre=
v_pwrst,
> +       .pwrdm_set_logic_retst  =3D omap4_pwrdm_set_logic_retst,
> +       .pwrdm_read_logic_pwrst =3D omap4_pwrdm_read_logic_pwrst,
> +       .pwrdm_read_prev_logic_pwrst    =3D omap4_pwrdm_read_prev_log=
ic_pwrst,
> +       .pwrdm_read_logic_retst =3D omap4_pwrdm_read_logic_retst,
> +       .pwrdm_read_mem_pwrst   =3D omap4_pwrdm_read_mem_pwrst,
> +       .pwrdm_read_mem_retst   =3D omap4_pwrdm_read_mem_retst,
> +       .pwrdm_read_prev_mem_pwrst      =3D omap4_pwrdm_read_prev_mem=
_pwrst,
> +       .pwrdm_set_mem_onst     =3D omap4_pwrdm_set_mem_onst,
> +       .pwrdm_set_mem_retst    =3D omap4_pwrdm_set_mem_retst,
> +       .pwrdm_wait_transition  =3D omap4_pwrdm_wait_transition,
> +};
> +
> +
>  static int __init omap4xxx_prm_init(void)
>  {
>         if (!cpu_is_omap44xx())
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
