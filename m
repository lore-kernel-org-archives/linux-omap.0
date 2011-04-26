From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 15/15] OMAP: GPIO: cleanup show revision, remove cpu_is
 checks, display only once
Date: Tue, 26 Apr 2011 17:18:47 +0530
Message-ID: <BANLkTimwFezON_qX+wr3Gj+A3EOEbD81YQ@mail.gmail.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com> <1303513327-14532-16-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33129 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932Ab1DZLt2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 07:49:28 -0400
Received: by mail-iy0-f176.google.com with SMTP id 1so530732iym.7
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 04:49:27 -0700 (PDT)
In-Reply-To: <1303513327-14532-16-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Remove cpu_is_* checks from gpio_show_revision() by passing in the
> revision address offset from platform data. =A0SoCs with no revision
> register (15xx, 7xx, and all MPUIOs) use -1 to signify no register.
>
> While here, all GPIO banks are assumed to be the same revision, so fi=
x
> show_revision() to only show the revision for the first bank it finds=
=2E
> This removes duplicate GPIO revision prints during boot.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap1/gpio15xx.c =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A0arch/arm/mach-omap1/gpio7xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A0arch/arm/plat-omap/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 ++++=
++--------
> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A01 +
> =A06 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpi=
o15xx.c
> index 9175624..6f77c36 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -35,6 +35,7 @@ static struct __initdata resource omap15xx_mpu_gpio=
_resources[] =3D {
> =A0};
>
> =A0static struct omap_gpio_reg_offs omap15xx_mpuio_regs =3D {
> + =A0 =A0 =A0 .revision =A0 =A0 =A0 =3D -1,

Assigning -1 to u16 type. Instead you may want to use 0xffff?

> =A0 =A0 =A0 =A0.direction =A0 =A0 =A0=3D OMAP_MPUIO_IO_CNTL,
> =A0 =A0 =A0 =A0.datain =A0 =A0 =A0 =A0 =3D OMAP_MPUIO_INPUT_LATCH,
> =A0 =A0 =A0 =A0.dataout =A0 =A0 =A0 =A0=3D OMAP_MPUIO_OUTPUT,
> @@ -75,6 +76,7 @@ static struct __initdata resource omap15xx_gpio_res=
ources[] =3D {
> =A0};

<<snip>>

> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-o=
map/include/plat/gpio.h
> index 7a3f067..91e8de3 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -175,6 +175,7 @@ struct omap_gpio_dev_attr {
> =A0};
>
> =A0struct omap_gpio_reg_offs {
> + =A0 =A0 =A0 u16 revision;
> =A0 =A0 =A0 =A0u16 direction;
> =A0 =A0 =A0 =A0u16 datain;
> =A0 =A0 =A0 =A0u16 dataout;

-V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
