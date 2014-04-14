From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 02/11] ARM: OMAP3: Fix idle mode signaling for sys_clkreq
 and sys_off_mode
Date: Tue, 15 Apr 2014 01:51:27 +0300
Message-ID: <CANOLnOO=O8xkTV9LiH+JTtmEXd9ihu0+ZYoHtrQK2QsFWOWVbg@mail.gmail.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
	<1397173639-29587-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:41406 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbaDNWv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2014 18:51:28 -0400
Received: by mail-ob0-f177.google.com with SMTP id vb8so1558042obc.36
        for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2014 15:51:27 -0700 (PDT)
In-Reply-To: <1397173639-29587-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

On Fri, Apr 11, 2014 at 2:47 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> While debugging legacy mode vs device tree booted PM regressions,
> I noticed that omap3 is not toggling sys_clkreq and sys_off_mode
> pins like it should.
>
> The sys_clkreq and sys_off_mode pins are not toggling because of
> the following issues:
>
> 1. The default polarity for the sys_off_mode pin is wrong.
>    OFFMODE_POL needs to be cleared for sys_off_mode to go down when
>    hitting off-idle, while CLKREQ_POL needs to be set so sys_clkreq
>    goes down when hitting retention.
>
> 2. The values for voltctrl register need to be updated dynamically.
>    We need to set either the retention idle bits, or off idle bits
>    in the voltctrl register depending the idle mode we're targeting
>    to hit.
>
> Let's fix these two issues as otherwise the system will just
> hang if any twl4030 PMIC idle scripts are loaded. The only case
> where the system does not hang is if only retention idle over I2C4
> is configured by the bootloader.
>
> Note that even without the twl4030 PMIC scripts, these fixes will
> do the proper signaling of sys_clkreq and sys_off_mode pins, so
> the fixes are needed to fix monitoring of PM states with LEDs or
> an oscilloscope.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c           |  2 +
>  arch/arm/mach-omap2/prm-regbits-34xx.h | 11 ++++-
>  arch/arm/mach-omap2/vc.c               | 75 ++++++++++++++++++++++++=
+++++++++-
>  arch/arm/mach-omap2/vc.h               |  2 +
>  4 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 87099bb..3119ec2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -50,6 +50,7 @@
>  #include "sdrc.h"
>  #include "sram.h"
>  #include "control.h"
> +#include "vc.h"
>
>  /* pm34xx errata defined in pm.h */
>  u16 pm34xx_errata;
> @@ -282,6 +283,7 @@ void omap_sram_idle(void)
>
>         /* CORE */
>         if (core_next_state < PWRDM_POWER_ON) {
> +               omap3_vc_set_pmic_signaling(core_next_state);

I wonder how is it going to affect latencies, adding stuff to suspend
path hurts things like NAND transfers, which consist of lots of small
blocks with an interrupt after each..

>                 if (core_next_state =3D=3D PWRDM_POWER_OFF) {
>                         omap3_core_save_context();
>                         omap3_cm_save_context();
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-o=
map2/prm-regbits-34xx.h
> index cebad56..106132d 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -123,8 +123,15 @@
>  #define OMAP3430_GLOBAL_SW_RST_SHIFT                   1
>  #define OMAP3430_GLOBAL_COLD_RST_SHIFT                 0
>  #define OMAP3430_GLOBAL_COLD_RST_MASK                  (1 << 0)
> -#define OMAP3430_SEL_OFF_MASK                          (1 << 3)
> -#define OMAP3430_AUTO_OFF_MASK                         (1 << 2)
> +#define OMAP3430_PRM_VOLTCTRL_SEL_VMODE                        (1 <<=
 4)
> +#define OMAP3430_PRM_VOLTCTRL_SEL_OFF                  (1 << 3)
> +#define OMAP3430_PRM_VOLTCTRL_AUTO_OFF                 (1 << 2)
> +#define OMAP3430_PRM_VOLTCTRL_AUTO_RET                 (1 << 1)
> +#define OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP               (1 << 0)
>  #define OMAP3430_SETUP_TIME2_MASK                      (0xffff << 16=
)
>  #define OMAP3430_SETUP_TIME1_MASK                      (0xffff << 0)
> +#define OMAP3430_PRM_POLCTRL_OFFMODE_POL               (1 << 3)
> +#define OMAP3430_PRM_POLCTRL_CLKOUT_POL                        (1 <<=
 2)
> +#define OMAP3430_PRM_POLCTRL_CLKREQ_POL                        (1 <<=
 1)
> +#define OMAP3430_PRM_POLCTRL_EXTVOL_POL                        (1 <<=
 0)
>  #endif
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 49ac797..3d5ba5d 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -220,6 +220,78 @@ static inline u32 omap_usec_to_32k(u32 usec)
>         return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
>  }
>
> +void omap3_vc_set_pmic_signaling(int core_next_state)
> +{
> +       u32 voltctrl;
> +
> +       voltctrl =3D omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
> +                                         OMAP3_PRM_VOLTCTRL_OFFSET);
> +       switch (core_next_state) {
> +       case PWRDM_POWER_OFF:
> +               voltctrl &=3D ~(OMAP3430_PRM_VOLTCTRL_AUTO_RET |
> +                             OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
> +               voltctrl |=3D OMAP3430_PRM_VOLTCTRL_AUTO_OFF;
> +               break;
> +       case PWRDM_POWER_RET:
> +               voltctrl &=3D ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
> +                             OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
> +               voltctrl |=3D OMAP3430_PRM_VOLTCTRL_AUTO_RET;
> +               break;
> +       default:
> +               voltctrl &=3D ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
> +                             OMAP3430_PRM_VOLTCTRL_AUTO_RET);
> +               voltctrl |=3D OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP;
> +               break;
> +       }
> +       omap2_prm_write_mod_reg(voltctrl, OMAP3430_GR_MOD,
> +                               OMAP3_PRM_VOLTCTRL_OFFSET);

Could it only write if the value changed? Caching register value would
be great too to avoid slow register accesses.

> +}
> +
> +/*
> + * Configure signal polarity for sys_clkreq and sys_off_mode pins
> + * as the default values are wrong and can cause the system to hang
> + * if any twl4030 sccripts are loaded.

s/sccripts/scripts

> + */
> +static void __init omap3_vc_init_pmic_signaling(void)
> +{
> +       u32 val, old;
> +
> +       val =3D omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
> +                                    OMAP3_PRM_POLCTRL_OFFSET);
> +       old =3D val;
> +
> +       if (old & OMAP3430_PRM_POLCTRL_CLKREQ_POL)
> +               val |=3D OMAP3430_PRM_POLCTRL_CLKREQ_POL;

Are these 2 lines actually doing anything?

> +       if (old & OMAP3430_PRM_POLCTRL_OFFMODE_POL)
> +               val &=3D ~OMAP3430_PRM_POLCTRL_OFFMODE_POL;

Why not just clear the bit unconditionally?

> +
> +       if (val !=3D old) {
> +               pr_debug("PM: fixing sys_clkreq and sys_off_mode pola=
rity 0x%x -> 0x%x\n",
> +                        old, val);
> +       }
> +       omap2_prm_write_mod_reg(val, OMAP3430_GR_MOD,
> +                               OMAP3_PRM_POLCTRL_OFFSET);

Maybe move this write inside the block just above it?


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
