From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/6] OMAP4: Fix cpu detection
Date: Wed, 9 Dec 2009 13:30:39 -0600
Message-ID: <782515bb0912091130r2fabec47v5c48057592edb070@mail.gmail.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:64397 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787AbZLITad convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 14:30:33 -0500
Received: by pxi27 with SMTP id 27so1529328pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 11:30:39 -0800 (PST)
In-Reply-To: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk

On Wed, Dec 9, 2009 at 12:29 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> This patch fixes the OMAP4430 cpu detection. Since the omap ID
> register is not fused in OMAP4430 ES1.0 silicon, identification is
> done using ARM CPUID register.

Am I reading the commit message wrong? the code seems to check on
TAPID instead of checking the arm CPUID...

>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 27 +++++=
+++++++++++++++++++++-
> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 =A03 ++-
> =A03 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index f48a4b2..52c6478 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -246,6 +246,31 @@ void __init omap3_check_revision(void)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +void __init omap4_check_revision(void)
> +{
> + =A0 =A0 =A0 u32 idcode;
> + =A0 =A0 =A0 u16 hawkeye;
> + =A0 =A0 =A0 u8 rev;
> + =A0 =A0 =A0 char *rev_name =3D "ES1.0";
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The IC rev detection is done with hawkeye and rev.
> + =A0 =A0 =A0 =A0* Note that rev does not map directly to defined pro=
cessor
> + =A0 =A0 =A0 =A0* revision numbers as ES1.0 uses value 0.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 idcode =3D read_tap_reg(OMAP_TAP_IDCODE);
> + =A0 =A0 =A0 hawkeye =3D (idcode >> 12) & 0xffff;
> + =A0 =A0 =A0 rev =3D (idcode >> 28) & 0xff;
> +
> + =A0 =A0 =A0 if ((hawkeye =3D=3D 0xb852) && (rev =3D=3D 0x0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP4430_REV_ES1_0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("OMAP%04x %s\n", omap_rev() >> =
16, rev_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 printk(KERN_ERR "Unknown OMAP CPU id\n");
a) Do you want to state unknown OMAP4 CPU id?
b) why not use pr_err?

> +}
> +
> =A0#define OMAP3_SHOW_FEATURE(feat) =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0if (omap3_has_ ##feat()) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(#feat" ");
> @@ -336,7 +361,7 @@ void __init omap2_check_revision(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_check_features();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_cpuinfo();
> =A0 =A0 =A0 =A0} else if (cpu_is_omap44xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "FIXME: CPU revision =3D=
 OMAP4430\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_check_revision();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("OMAP revision unknown, please =
fix!\n");
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.=
c
> index cc050b3..3473a80 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -280,7 +280,7 @@ void __init omap2_set_globals_343x(void)
> =A0#if defined(CONFIG_ARCH_OMAP4)
> =A0static struct omap_globals omap4_globals =3D {
> =A0 =A0 =A0 =A0.class =A0=3D OMAP443X_CLASS,
> - =A0 =A0 =A0 .tap =A0 =A0=3D OMAP2_L4_IO_ADDRESS(0x4830a000),
> + =A0 =A0 =A0 .tap =A0 =A0=3D OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),

What does this have to do with the subject of the patch? I agree it is
a good thing to have, but probably belongs elsewhere.

> =A0 =A0 =A0 =A0.ctrl =A0 =3D OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
> =A0 =A0 =A0 =A0.prm =A0 =A0=3D OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE)=
,
> =A0 =A0 =A0 =A0.cm =A0 =A0 =3D OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-om=
ap/include/plat/cpu.h
> index 2e17890..2a141ba 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -443,7 +443,8 @@ IS_OMAP_TYPE(3517, 0x3517)
> =A0#define OMAP3505_REV(v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP35XX_C=
LASS | (0x3505 << 16) | (v << 12))
> =A0#define OMAP3517_REV(v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP35XX_C=
LASS | (0x3517 << 16) | (v << 12))
>
> -#define OMAP443X_CLASS =A0 =A0 =A0 =A0 0x44300034
> +#define OMAP443X_CLASS =A0 =A0 =A0 =A0 0x44300044
> +#define OMAP4430_REV_ES1_0 =A0 =A0 0x44300044
Errr.. why? I suspect this might be to get the class and subclass right=
=2E.

Dont we need an cpu_is_omap_4430() to use it correctly? (unless I
missed a pending patch series as I am checking l-o kernel codebase)..
do we need the following?
IS_OMAP_CLASS(44xx, 0x44)
IS_OMAP_SUBCLASS(443x, 0x443)

then you will have is_omap_443x() and you can now:
#define cpu_is_omap4430 is_omap443x()

just my 2cents..
>
> =A0/*
> =A0* omap_chip bits

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
