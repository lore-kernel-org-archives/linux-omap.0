From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 3/8] OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE
	handling
Date: Wed, 18 Nov 2009 14:15:02 +0530
Message-ID: <ce9ab5790911180045sa35c96bgc5d49fddc83d5ffc@mail.gmail.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48603 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbZKRIpR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:45:17 -0500
Received: by bwz27 with SMTP id 27so829821bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 00:45:22 -0800 (PST)
In-Reply-To: <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Wed, Nov 18, 2009 at 6:35 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> From: Paul Walmsley <paul@pwsan.com>
>
> This patch fills in the OCP_SYSCONFIG.AUTOIDLE handling in the OMAP
> hwmod code.
>
> After this patch, the hwmod code will set the module AUTOIDLE bit (ge=
nerally
> <module>.OCP_SYSCONFIG.AUTOIDLE) to 1 by default upon enable, and 1 u=
pon
> disable.

You wanted to say:  "0 upon disable", isn't it?

-vimal

> If the hwmod flag HWMOD_NO_AUTOIDLE is set, AUTOIDLE will be
> set to 0 upon enable.
>
> Enabling module autoidle should save some power. =A0The only reason t=
o
> not set the OCP_SYSCONFIG.AUTOIDLE bit is if there is a bug in the
> module RTL, e.g., the MPUINTC block on OMAP3.
>
> Comments from Kevin Hilman <khilman@deeprootsystems.com> inspired thi=
s patch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 50 =
+++++++++++++++++++++++---
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A08 ++++-
> =A02 files changed, 52 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 7d7b3b8..25d9484 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -210,6 +210,29 @@ static int _set_softreset(struct omap_hwmod *oh,=
 u32 *v)
> =A0}
>
> =A0/**
> + * _set_module_autoidle: set the OCP_SYSCONFIG AUTOIDLE field in @v
> + * @oh: struct omap_hwmod *
> + * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
> + * @v: pointer to register contents to modify
> + *
> + * Update the module autoidle mode bit in @v to be @autoidle for the
> + * @oh hwmod. =A0Does not write to the hardware. =A0Returns -EINVAL =
upon
> + * error or 0 upon success.
> + */
> +static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 *v)
> +{
> + =A0 =A0 =A0 if (!oh->sysconfig ||
> + =A0 =A0 =A0 =A0 =A0 !(oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 *v &=3D ~SYSC_AUTOIDLE_MASK;
> + =A0 =A0 =A0 *v |=3D autoidle << SYSC_AUTOIDLE_SHIFT;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> =A0* _enable_wakeup: set OCP_SYSCONFIG.ENAWAKEUP bit in the hardware
> =A0* @oh: struct omap_hwmod *
> =A0*
> @@ -560,7 +583,13 @@ static void _sysc_enable(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_set_master_standbymode(oh, idlemode, =
&v);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* XXX OCP AUTOIDLE bit? */
> + =A0 =A0 =A0 if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idlemode =3D (oh->flags & HWMOD_NO_AUTO=
IDLE) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 : 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _set_module_autoidle(oh, idlemode, &v);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* XXX OCP ENAWAKEUP bit? */
>
> =A0 =A0 =A0 =A0if (oh->flags & HWMOD_SET_DEFAULT_CLOCKACT &&
> =A0 =A0 =A0 =A0 =A0 =A0oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTI=
VITY)
> @@ -625,7 +654,8 @@ static void _sysc_shutdown(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0if (oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_set_master_standbymode(oh, HWMOD_IDLE=
MODE_FORCE, &v);
>
> - =A0 =A0 =A0 /* XXX clear OCP AUTOIDLE bit? */
> + =A0 =A0 =A0 if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _set_module_autoidle(oh, 1, &v);
>
> =A0 =A0 =A0 =A0_write_sysconfig(v, oh);
> =A0}
> @@ -951,11 +981,21 @@ static int _setup(struct omap_hwmod *oh)
>
> =A0 =A0 =A0 =A0_enable(oh);
>
> - =A0 =A0 =A0 if (!(oh->flags & HWMOD_INIT_NO_RESET))
> + =A0 =A0 =A0 if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_reset(oh);
>
> - =A0 =A0 =A0 /* XXX OCP AUTOIDLE bit? */
> - =A0 =A0 =A0 /* XXX OCP ENAWAKEUP bit? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* XXX Do the OCP_SYSCONFIG bits need=
 to be
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* reprogrammed after a reset? =A0If =
not, then this can
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* be removed. =A0If it does, then pr=
obably the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* _enable() function should be split=
 to avoid the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* rewrite of the OCP_SYSCONFIG regis=
ter.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (oh->sysconfig) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _update_sysc_cache(oh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _sysc_enable(oh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (!(oh->flags & HWMOD_INIT_NO_IDLE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_idle(oh);
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index dbdd123..ec140b0 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -50,6 +50,8 @@ struct omap_device;
> =A0#define SYSC_ENAWAKEUP_MASK =A0 =A0 =A0 =A0 =A0 =A0(1 << SYSC_ENAW=
AKEUP_SHIFT)
> =A0#define SYSC_SOFTRESET_SHIFT =A0 =A0 =A0 =A0 =A0 1
> =A0#define SYSC_SOFTRESET_MASK =A0 =A0 =A0 =A0 =A0 =A0(1 << SYSC_SOFT=
RESET_SHIFT)
> +#define SYSC_AUTOIDLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A00
> +#define SYSC_AUTOIDLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 (1 << SYSC_AUTOID=
LE_SHIFT)
>
> =A0/* OCP SYSSTATUS bit shifts/masks */
> =A0#define SYSS_RESETDONE_SHIFT =A0 =A0 =A0 =A0 =A0 0
> @@ -294,13 +296,17 @@ struct omap_hwmod_omap4_prcm {
> =A0* =A0 =A0 SDRAM controller, etc.
> =A0* HWMOD_INIT_NO_IDLE: don't idle this module at boot - important f=
or SDRAM
> =A0* =A0 =A0 controller, etc.
> + * HWMOD_NO_AUTOIDLE: disable module autoidle (OCP_SYSCONFIG.AUTOIDL=
E)
> + * =A0 =A0 when module is enabled, rather than the default, which is=
 to
> + * =A0 =A0 enable autoidle
> =A0* HWMOD_SET_DEFAULT_CLOCKACT: program CLOCKACTIVITY bits at startu=
p
> =A0*/
> =A0#define HWMOD_SWSUP_SIDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 0)
> =A0#define HWMOD_SWSUP_MSTANDBY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
1 << 1)
> =A0#define HWMOD_INIT_NO_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 2)
> =A0#define HWMOD_INIT_NO_IDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 3)
> -#define HWMOD_SET_DEFAULT_CLOCKACT =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> +#define HWMOD_NO_AUTOIDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 4)
> +#define HWMOD_SET_DEFAULT_CLOCKACT =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5)
>
> =A0/*
> =A0* omap_hwmod._int_flags definitions
> --
> 1.6.5.1
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
