From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP2+: hwmod: remove OMAP_CHIP*
Date: Mon, 5 Sep 2011 14:27:08 +0300
Message-ID: <CANOLnOOkz2ZkhPSafTLxUUH2bSVoRrYA44-C1+yku8naYaRz3w@mail.gmail.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40437 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab1IEL1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 07:27:09 -0400
Received: by ywf7 with SMTP id 7so3293990ywf.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 04:27:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Sep 5, 2011 at 5:43 AM, Paul Walmsley <paul@pwsan.com> wrote:
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 84cc0bd..d7138070 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
<snip>

>
> =A0int __init omap3xxx_hwmod_init(void)
> =A0{
> - =A0 =A0 =A0 return omap_hwmod_register(omap3xxx_hwmods);
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 struct omap_hwmod **h =3D NULL;
> +
> + =A0 =A0 =A0 /* Register hwmods common to all OMAP3 */
> + =A0 =A0 =A0 r =3D omap_hwmod_register(omap3xxx_hwmods);
> + =A0 =A0 =A0 if (!r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Register hwmods common to individual OMAP3 familie=
s, all
> + =A0 =A0 =A0 =A0* silicon revisions (e.g., 34xx, or AM3505/3517, or =
36xx)
> + =A0 =A0 =A0 =A0* All possible revisions should be included in this =
conditional.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (omap_rev() =3D=3D OMAP3430_REV_ES1_0 ||
> + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES2_0 ||
> + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES2_1 ||
> + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES3_0 ||
> + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES3_1 ||
> + =A0 =A0 =A0 =A0 =A0 omap_rev() =3D=3D OMAP3430_REV_ES3_1_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =3D omap34xx_hwmods;
> + =A0 =A0 =A0 } else if (omap_rev() & OMAP3505_REV(0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =3D am35xx_hwmods;

This check will be always true I think?

Why not just use cpu_is_omap3xxx() for these tests, since it does same
omap_rev() call but only once per family?

> + =A0 =A0 =A0 } else if (omap_rev() =3D=3D OMAP3630_REV_ES1_0 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_rev() =3D=3D OMAP3630_REV_E=
S1_1 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_rev() =3D=3D OMAP3630_REV_E=
S1_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =3D omap36xx_hwmods;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP3 hwmod family init: unkno=
wn chip type\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 r =3D omap_hwmod_register(h);
> + =A0 =A0 =A0 if (!r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
> +
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
