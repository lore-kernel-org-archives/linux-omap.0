From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 07/12] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
Date: Thu, 14 Jun 2012 02:59:16 -0700
Message-ID: <20120614095916.GH12766@atomide.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004611.20034.60143.stgit@dusk>
 <20120611062905.GS12766@atomide.com>
 <alpine.DEB.2.00.1206140344500.30212@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41573 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab2FNJ7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 05:59:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206140344500.30212@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

* Paul Walmsley <paul@pwsan.com> [120614 02:53]:
> Hi
>=20
> (revised patch below)
>=20
> On Sun, 10 Jun 2012, Tony Lindgren wrote:
>=20
> > * Paul Walmsley <paul@pwsan.com> [120610 17:56]:
> >=20
> > > --- /dev/null
> > > +++ b/include/linux/platform_data/aess.h
> >=20
> > This should be include/linux/platform_data/omap-aess.h or similar a=
s
> > there are other aess controllers too.
>=20
> Hmm, I guess there could be other SoCs that include this IP block;=20
> probably there is nothing OMAP-specific about it.  So I moved this fi=
le to=20
> include/sound/aess.h.  What do you think?

Sounds good to me.
=20
> > > +/*
> > > + * AESS_AUTO_GATING_ENABLE_OFFSET: offset in bytes of the AESS I=
P
> > > + *     block's AESS_AUTO_GATING_ENABLE__1 register from the IP b=
lock's
> > > + *     base address
> > > + */
> > > +#define AESS_AUTO_GATING_ENABLE_OFFSET			0x07c
> > > +
> > > +/* Register bitfields in the AESS_AUTO_GATING_ENABLE__1 register=
 */
> > > +#define AESS_AUTO_GATING_ENABLE_SHIFT			0
> >=20
> > Also these should be OMAP_AESS_AUTOGATING etc, or even better,
> > XYZ_AESS_AUTOGATING where XYZ is the type of the AESS controller.
>=20
> Hmm, do you think this is really needed?  The other files in include/=
sound=20
> don't have SOUND_ or AUDIO_ prefixe.

No you're right, those parts should follow what the driver is doing.
=20
> > This should be static inline function as it's in the header, and ag=
ain
> > something like omap_aess_enable_autogating.
>=20
> I made it static inline, but didn't rename this one by the same ratio=
nale=20
> above.

OK
=20
> > > +/**
> > > + * hwmod_aess_preprogram - enable AESS internal autogating (call=
ed by hwmod)
> > > + * @oh: struct omap_hwmod *
> > > + *
> > > + * The AESS will not IdleAck to the PRCM until its internal auto=
gating
> > > + * is enabled.  Since internal autogating is disabled by default=
 after
> > > + * AESS reset, we must enable autogating after the hwmod code re=
sets
> > > + * the AESS.  Returns 0.
> > > + */
> > > +static int __maybe_unused hwmod_aess_preprogram(struct omap_hwmo=
d *oh)
> > > +{
> > > +	void __iomem *va;
> > > +
> > > +	va =3D omap_hwmod_get_mpu_rt_va(oh);
> > > +	if (!va)
> > > +		return -EINVAL;
> > > +
> > > +	aess_enable_autogating(va);
> > > +
> > > +	return 0;
> > > +}
> >=20
> > Then this function should not be in this header, instead it should =
be a
> > static function somewhere in the omap hwmod code in some .c file. T=
hat's
> > because this header should only have omap aess specific driver code=
, no
> > hwmod code should be needed here.
>=20
> Moved this to arch/arm/mach-omap2/omap_hwmod_reset.c and prefixed it =
with=20
> "omap_".
>=20
> Are you okay with this approach?

Yup looks good to me, thanks! We should probably get an ack from the
ASoC people for the header changes.

Regards,

Tony
=20
=20
> - Paul
>=20
> From: Paul Walmsley <paul@pwsan.com>
> Date: Thu, 14 Jun 2012 03:35:13 -0600
> Subject: [PATCH] ARM: OMAP4+: AESS: enable internal auto-gating durin=
g
>  initial setup
>=20
> Enable the AESS auto-gating control bit during AESS hwmod setup.  Thi=
s
> fixes the following boot warning on OMAP4:
>=20
> omap_hwmod: aess: _wait_target_disable failed
>=20
> Without this patch, the AESS IP block does not indicate to the PRCM
> that it is idle after it is reset.  This prevents some types of SoC
> power management until something sets the auto-gating control bit.
>=20
> This second version of this patch moves the control functions to
> include/linux/platform_data/aess.h at Tony's request:
>=20
>     http://www.spinics.net/lists/arm-kernel/msg178329.html
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile                 |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    1 +
>  arch/arm/mach-omap2/omap_hwmod_reset.c       |   52 ++++++++++++++++=
+++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 +++
>  include/sound/aess.h                         |   53 ++++++++++++++++=
++++++++++
>  5 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c
>  create mode 100644 include/sound/aess.h
>=20
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index fa742f3..4381e04 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -7,7 +7,7 @@ obj-y :=3D id.o io.o control.o mux.o devices.o serial=
=2Eo gpmc.o timer.o pm.o \
>  	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o
> =20
>  omap-2-3-common				=3D irq.o sdrc.o
> -hwmod-common				=3D omap_hwmod.o \
> +hwmod-common				=3D omap_hwmod.o omap_hwmod_reset.o \
>  					  omap_hwmod_common_data.o
>  clock-common				=3D clock.o clock_common_data.o \
>  					  clkt_dpll.o clkt_clksel.o
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 6b0aedc..d1c4f3c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -313,6 +313,7 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_aess_sysc =3D {
>  static struct omap_hwmod_class omap44xx_aess_hwmod_class =3D {
>  	.name	=3D "aess",
>  	.sysc	=3D &omap44xx_aess_sysc,
> +	.setup_preprogram =3D omap_hwmod_aess_preprogram,
>  };
> =20
>  /* aess */
> diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-o=
map2/omap_hwmod_reset.c
> new file mode 100644
> index 0000000..f810ba3
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
> @@ -0,0 +1,52 @@
> +/*
> + * OMAP IP block custom reset and preprogramming stubs
> + *
> + * Copyright (C) 2012 Texas Instruments, Inc.
> + * Paul Walmsley
> + *
> + * A small number of IP blocks need custom reset and preprogramming
> + * functions.  The stubs in this file provide a standard way for the
> + * hwmod code to call these functions, which are to be located under
> + * drivers/.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + */
> +#include <linux/kernel.h>
> +
> +#include <plat/omap_hwmod.h>
> +
> +#include <sound/aess.h>
> +
> +/**
> + * omap_hwmod_aess_preprogram - enable AESS internal autogating
> + * @oh: struct omap_hwmod *
> + *
> + * The AESS will not IdleAck to the PRCM until its internal autogati=
ng
> + * is enabled.  Since internal autogating is disabled by default aft=
er
> + * AESS reset, we must enable autogating after the hwmod code resets
> + * the AESS.  Returns 0.
> + */
> +int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
> +{
> +	void __iomem *va;
> +
> +	va =3D omap_hwmod_get_mpu_rt_va(oh);
> +	if (!va)
> +		return -EINVAL;
> +
> +	aess_enable_autogating(va);
> +
> +	return 0;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index b5f3efc..76fea1f 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -662,6 +662,11 @@ extern int omap2430_hwmod_init(void);
>  extern int omap3xxx_hwmod_init(void);
>  extern int omap44xx_hwmod_init(void);
> =20
> +/* Custom reset & preprogram stub prototypes - from omap_hwmod_reset=
=2Ec */
> +
> +extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
> +
> +
>  extern int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if=
 **ois);
> =20
>  #endif
> diff --git a/include/sound/aess.h b/include/sound/aess.h
> new file mode 100644
> index 0000000..cee0d09
> --- /dev/null
> +++ b/include/sound/aess.h
> @@ -0,0 +1,53 @@
> +/*
> + * AESS IP block reset
> + *
> + * Copyright (C) 2012 Texas Instruments, Inc.
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + */
> +#ifndef __SOUND_AESS_H__
> +#define __SOUND_AESS_H__
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +
> +/*
> + * AESS_AUTO_GATING_ENABLE_OFFSET: offset in bytes of the AESS IP
> + *     block's AESS_AUTO_GATING_ENABLE__1 register from the IP block=
's
> + *     base address
> + */
> +#define AESS_AUTO_GATING_ENABLE_OFFSET			0x07c
> +
> +/* Register bitfields in the AESS_AUTO_GATING_ENABLE__1 register */
> +#define AESS_AUTO_GATING_ENABLE_SHIFT			0
> +
> +/**
> + * aess_enable_autogating - enable AESS internal autogating
> + * @oh: struct omap_hwmod *
> + *
> + * Enable internal autogating on the AESS.  This allows the AESS to
> + * indicate that it is idle to the OMAP PRCM.  Returns 0.
> + */
> +static inline void aess_enable_autogating(void __iomem *base)
> +{
> +	u32 v;
> +
> +	/* Set AESS_AUTO_GATING_ENABLE__1.ENABLE to allow idle entry */
> +	v =3D 1 << AESS_AUTO_GATING_ENABLE_SHIFT;
> +	writel(v, base + AESS_AUTO_GATING_ENABLE_OFFSET);
> +}
> +
> +#endif /* __SOUND_AESS_H__ */
> --=20
> 1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
