From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
 control detection
Date: Thu, 6 Oct 2011 12:42:52 -0700
Message-ID: <CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46100 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab1JFTmx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 15:42:53 -0400
Received: by vws1 with SMTP id 1so2553348vws.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 12:42:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, dhylands@gmail.com

On Thu, Oct 6, 2011 at 12:11 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The way that we detect which OMAP3 chips support I/O wakeup and
> software I/O chain clock control is broken.
>
> Currently, I/O wakeup is marked as present for all OMAP3 SoCs other
> than the AM3505/3517. =A0The TI81xx family of SoCs are at present
> considered to be OMAP3 SoCs, but don't support I/O wakeup. =A0To reso=
lve
> this, convert the existing blacklist approach to an explicit,
> whitelist support, in which only SoCs which are known to support I/O
> wakeup are listed. =A0(At present, this only includes OMAP34xx,
> OMAP3503, OMAP3515, OMAP3525, OMAP3530, and OMAP36xx.)
>
> Also, the current code incorrectly detects the presence of a
> software-controllable I/O chain clock on several chips that don't
> support it. =A0This results in writes to reserved bitfields, unnecess=
ary
> delays, and console messages on kernels running on those chips:
>
> =A0 =A0http://www.spinics.net/lists/linux-omap/msg58735.html
>
> Convert this test to a feature test with a chip-by-chip whitelist.
>
> Thanks to Dave Hylands <dhylands@gmail.com> for reporting this proble=
m
> and doing some testing to help isolate the cause.

Thanks for doing this patch so quickly!

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Dave Hylands <dhylands@gmail.com>
> Cc: Steve Sakoman <sakoman@gmail.com>
> ---
> =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++=
-
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0| =A0 44 +++++++++=
++++++++---------------
> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 17 +++++++++---
> =A03 files changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 37efb86..eb1b8e4 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -201,8 +201,12 @@ static void __init omap3_check_features(void)
> =A0 =A0 =A0 =A0OMAP3_CHECK_FEATURE(status, ISP);
> =A0 =A0 =A0 =A0if (cpu_is_omap3630())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_features |=3D OMAP3_HAS_192MHZ_CL=
K;
> - =A0 =A0 =A0 if (!cpu_is_omap3505() && !cpu_is_omap3517())
> + =A0 =A0 =A0 if (cpu_is_omap3430() || cpu_is_omap3630())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_features |=3D OMAP3_HAS_IO_WAKEUP=
;
> + =A0 =A0 =A0 if ((omap_rev() =3D=3D OMAP3430_REV_ES3_1 &&
> + =A0 =A0 =A0 =A0 =A0 =A0omap_rev() =3D=3D OMAP3430_REV_ES3_1_2) ||

Perhaps I'm confused but shouldn't it be an || instead of &&?

We're testing for ES3.1 *or* ES3.12?

Otherwise looks good.  I'll test on my old Overo COMs.

Steve

> + =A0 =A0 =A0 =A0 =A0 cpu_is_omap3630())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP3_HAS_IO_CHAIN_C=
TRL;
>
> =A0 =A0 =A0 =A0omap_features |=3D OMAP3_HAS_SDRC;
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 7255d9b..a6156bd 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -99,31 +99,28 @@ static void omap3_enable_io_chain(void)
> =A0{
> =A0 =A0 =A0 =A0int timeout =3D 0;
>
> - =A0 =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES3_1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3430_EN_=
IO_CHAIN_MASK, WKUP_MOD,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0PM_WKEN);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do a readback to assure write has be=
en done */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_read_mod_reg(WKUP_MOD, PM_WKE=
N);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap2_prm_read_mod_reg(WKUP_MO=
D, PM_WKEN) &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3430_ST_IO_CHAIN=
_MASK)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout > 1000) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR "Wake up daisy chain "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"activation failed.\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_set_mod_reg_b=
its(OMAP3430_ST_IO_CHAIN_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0WKUP_MOD, PM_WKEN);
> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, W=
KUP_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
PM_WKEN);
> + =A0 =A0 =A0 /* Do a readback to assure write has been done */
> + =A0 =A0 =A0 omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> +
> + =A0 =A0 =A0 while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3430_ST_IO_CHAIN_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout > 1000) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Wake u=
p daisy chain "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"activat=
ion failed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3430_ST_=
IO_CHAIN_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0WKUP_MOD, PM_WKEN);
> =A0 =A0 =A0 =A0}
> =A0}
>
> =A0static void omap3_disable_io_chain(void)
> =A0{
> - =A0 =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES3_1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_clear_mod_reg_bits(OMAP3430_E=
N_IO_CHAIN_MASK, WKUP_MOD,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PM_WKEN);
> + =A0 =A0 =A0 omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK,=
 WKUP_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0PM_WKEN);
> =A0}
>
> =A0static void omap3_core_save_context(void)
> @@ -376,7 +373,8 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0(per_next_state < PWRDM_POWER_ON ||
> =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_ON)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_prm_set_mod_reg_bits(OMAP3430_EN=
_IO_MASK, WKUP_MOD, PM_WKEN);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_enable_io_chain();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap3_has_io_chain_ctrl())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_enable_io_chain()=
;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Block console output in case it is on one of the OM=
AP UARTs */
> @@ -475,7 +473,8 @@ console_still_active:
> =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_ON)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_prm_clear_mod_reg_bits(OMAP3430_=
EN_IO_MASK, WKUP_MOD,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 PM_WKEN);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_disable_io_chain();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap3_has_io_chain_ctrl())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_disable_io_chain(=
);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pwrdm_post_transition();
> @@ -870,6 +869,9 @@ static int __init omap3_pm_init(void)
> =A0 =A0 =A0 =A0if (!cpu_is_omap34xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> + =A0 =A0 =A0 if (!omap3_has_io_chain_ctrl())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("PM: no software I/O chain c=
ontrol; some wakeups may be lost\n");
> +
> =A0 =A0 =A0 =A0pm_errata_configure();
>
> =A0 =A0 =A0 =A0/* XXX prcm_setup_regs needs to be before enabling hw
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-om=
ap/include/plat/cpu.h
> index 67b3d75..3a280aa 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -477,6 +477,13 @@ void omap2_check_revision(void);
>
> =A0/*
> =A0* Runtime detection of OMAP3 features
> + *
> + * OMAP3_HAS_IO_CHAIN_CTRL: Some later members of the OMAP3 chip
> + * =A0 =A0family have OS-level control over the I/O chain clock. =A0=
This is
> + * =A0 =A0to avoid a window during which wakeups could potentially b=
e lost
> + * =A0 =A0during powerdomain transitions. =A0If this bit is set, it
> + * =A0 =A0indicates that the chip does support OS-level control of t=
his
> + * =A0 =A0feature.
> =A0*/
> =A0extern u32 omap_features;
>
> @@ -488,9 +495,10 @@ extern u32 omap_features;
> =A0#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
> =A0#define OMAP3_HAS_IO_WAKEUP =A0 =A0 =A0 =A0 =A0 =A0BIT(6)
> =A0#define OMAP3_HAS_SDRC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(7)
> -#define OMAP4_HAS_MPU_1GHZ =A0 =A0 =A0 =A0 =A0 =A0 BIT(8)
> -#define OMAP4_HAS_MPU_1_2GHZ =A0 =A0 =A0 =A0 =A0 BIT(9)
> -#define OMAP4_HAS_MPU_1_5GHZ =A0 =A0 =A0 =A0 =A0 BIT(10)
> +#define OMAP3_HAS_IO_CHAIN_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(8=
)
> +#define OMAP4_HAS_MPU_1GHZ =A0 =A0 =A0 =A0 =A0 =A0 BIT(9)
> +#define OMAP4_HAS_MPU_1_2GHZ =A0 =A0 =A0 =A0 =A0 BIT(10)
> +#define OMAP4_HAS_MPU_1_5GHZ =A0 =A0 =A0 =A0 =A0 BIT(11)
>
>
> =A0#define OMAP3_HAS_FEATURE(feat,flag) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 \
> @@ -507,12 +515,11 @@ OMAP3_HAS_FEATURE(isp, ISP)
> =A0OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> =A0OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
> =A0OMAP3_HAS_FEATURE(sdrc, SDRC)
> +OMAP3_HAS_FEATURE(io_chain_ctrl, IO_CHAIN_CTRL)
>
> =A0/*
> =A0* Runtime detection of OMAP4 features
> =A0*/
> -extern u32 omap_features;
> -
> =A0#define OMAP4_HAS_FEATURE(feat, flag) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0\
> =A0static inline unsigned int omap4_has_ ##feat(void) =A0 =A0 \
> =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> --
> 1.7.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
