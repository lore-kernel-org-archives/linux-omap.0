From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH V4] OMAP3+: SR Layer Cleanup
Date: Fri, 20 May 2011 08:23:02 -0500
Message-ID: <BANLkTi=sLwrdaOanRNDM+NsnBGjxn5G6nQ@mail.gmail.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53208 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754355Ab1ETNXX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 09:23:23 -0400
Received: by mail-ww0-f47.google.com with SMTP id 4so3709678wwk.28
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 06:23:22 -0700 (PDT)
In-Reply-To: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Fri, May 13, 2011 at 01:27, Shweta Gulati <shweta.gulati@ti.com> wro=
te:
[...]
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_3xxx_data.c
> index 3cd91ac..b1b11de 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -29,6 +29,7 @@
>
> =A0#include "omap_hwmod_common_data.h"
>
> +#include "smartreflex.h"
> =A0#include "prm-regbits-34xx.h"
> =A0#include "cm-regbits-34xx.h"
> =A0#include "wd_timer.h"
> @@ -2904,6 +2905,10 @@ static struct omap_hwmod_class omap36xx_smartr=
eflex_hwmod_class =3D {
> =A0};
>
> =A0/* SR1 */
> +static struct omap_smartreflex_dev_attr sr1_dev_attr =3D {
> + =A0 =A0 =A0 .sensor_voltdm_name =A0 =3D "mpu_iva",
> +};

[...]
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/=
smartreflex.h
> index 5f35b9e..aeeec5f 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -197,6 +197,16 @@ struct omap_sr_nvalue_table {
> =A0};
>
> =A0/**
> + * struct omap_smartreflex_dev_attr - Smartreflex Device attribute.
> + *
> + * @sensor_voltdm_name: =A0 =A0 =A0 Name of voltdomain of SR instanc=
e
> + */
> +
> +struct omap_smartreflex_dev_attr {
> + =A0 =A0 =A0 const char =A0 =A0 =A0*sensor_voltdm_name;
> +};
> +

This structure is in #ifdef CONFIG_SMART_REFLEX and breaks
hwmod_data.c when built without SR.
please move it out of the #ifdef in your next rev.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
