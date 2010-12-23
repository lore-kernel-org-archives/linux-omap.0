From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v1 02/10] OMAP: McBSP: Convert McBSP to platform device model
Date: Thu, 23 Dec 2010 14:59:43 +0530
Message-ID: <AANLkTikJnFbXaEmNb2O9PAbs-fAfL+bHC4LA9c8Ca5ut@mail.gmail.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com> <1292917231-13800-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48350 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094Ab0LWJdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 04:33:36 -0500
Received: by mail-iy0-f176.google.com with SMTP id 26so5908857iyb.7
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 01:33:35 -0800 (PST)
In-Reply-To: <1292917231-13800-2-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com

Kishon,

On Tue, Dec 21, 2010 at 13:10, Kishon Vijay Abraham I <kishon@ti.com> w=
rote:
> Implement McBSP as platform device and add support for
> registering through platform device layer using resource
> structures.
>
> Later in this patch series, OMAP2+ McBSP driver would be modified to
> use hwmod framework after populating the omap2+ hwmod database.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> =A0arch/arm/mach-omap1/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0383 +++++=
+++++++++---
> =A0arch/arm/mach-omap2/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0708 +++++=
++++++++++++++++++++------
> =A0arch/arm/plat-omap/devices.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 +-
> =A0arch/arm/plat-omap/include/plat/mcbsp.h | =A0 14 +-
> =A0arch/arm/plat-omap/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 60 +++=
-
> =A05 files changed, 969 insertions(+), 206 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.=
c
> index 372ea71..4324ba4 100644
> --- a/arch/arm/mach-omap1/mcbsp.c
> +++ b/arch/arm/mach-omap1/mcbsp.c
> @@ -10,6 +10,7 @@
> =A0*
> =A0* Multichannel mode not supported.
> =A0*/
> +#include <linux/ioport.h>
> =A0#include <linux/module.h>
> =A0#include <linux/init.h>
> =A0#include <linux/clk.h>
> @@ -78,114 +79,354 @@ static struct omap_mcbsp_ops omap1_mcbsp_ops =3D=
 {
> =A0};
>
> =A0#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> +struct resource omap7xx_mcbsp_res[][6] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0=3D "mpu",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D OMAP7XX_MCBS=
P1_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =3D OMAP7XX_MC=
BSP1_BASE + SZ_256,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_M=
EM,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0=3D "dma",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D OMAP7XX_MCBS=
P1_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =3D OMAP7XX_MC=
BSP1_BASE + SZ_256,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_M=
EM,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },

The above two resources looks similar except for the name. It would be
good to mention the reason for
providing two resource names for a single resource.

Same comment applicable to all McBSPs in other OMAPs too.

-V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
