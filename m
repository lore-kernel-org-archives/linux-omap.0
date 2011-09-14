From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Pointers to __devexit should be __devexit_p
Date: Wed, 14 Sep 2011 09:10:05 +0200
Message-ID: <CAFULf_xOY74c5Osg0s_sc6SCC8e8_KNpOWOSAL6Lr68gfmNbCQ@mail.gmail.com>
References: <CAFULf_wXK_2XkjUaDuZc+Ap8YiaesrdmHjErNvwyzV5CizLYYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34345 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab1INHPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 03:15:18 -0400
Received: by qyk7 with SMTP id 7so1350658qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 00:15:17 -0700 (PDT)
In-Reply-To: <CAFULf_wXK_2XkjUaDuZc+Ap8YiaesrdmHjErNvwyzV5CizLYYQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

I can't see this one queued up anywhere.  Did it just slip through the
cracks, or are there any problems with it?

BR,

Bjarne Steinsbo

On Tue, Aug 16, 2011 at 4:33 PM, Bjarne Steinsbo <bsteinsbo@gmail.com> =
wrote:
> Pointers to functions that are annotated as __devexit should be
> protected by the __devexit_p() macro.
>
> This fixes a build failure for OMAP when defined(CONFIG_SMP_ON_UP) &&
> !defined(CONFIG_DEBUG_SPINLOCK)
>
> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
> ---
> =A0arch/arm/mach-omap2/smartreflex.c | =A0 =A02 +-
> =A0arch/arm/plat-omap/dma.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A02 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c
> b/arch/arm/mach-omap2/smartreflex.c
> index 34c01a7..67bc6ce 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -1002,7 +1002,7 @@ static int __devexit omap_sr_remove(struct
> platform_device *pdev)
> =A0}
>
> =A0static struct platform_driver smartreflex_driver =3D {
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_sr_remove,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap_sr_remove)=
,
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "smartreflex",
> =A0 =A0 =A0 =A0},
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index c22217c..f7150ba 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2105,7 +2105,7 @@ static int __devexit
> omap_system_dma_remove(struct platform_device *pdev)
>
> =A0static struct platform_driver omap_system_dma_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D omap_system_dma_probe,
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_system_dma_remove,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap_system_dma=
_remove),
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "omap_dma_system"
> =A0 =A0 =A0 =A0},
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
