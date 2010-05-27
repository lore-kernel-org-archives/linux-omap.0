From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 6/6] omap: move generic omap3 features to generic
Date: Thu, 27 May 2010 16:54:12 +0530
Message-ID: <AANLkTinsrRAYX4dvB8A8wPayfRc7wkULQtUSiJ9RxbWh@mail.gmail.com>
References: <1274585799-16226-1-git-send-email-nm@ti.com>
	<1274585799-16226-2-git-send-email-nm@ti.com>
	<1274585799-16226-3-git-send-email-nm@ti.com>
	<1274585799-16226-4-git-send-email-nm@ti.com>
	<1274585799-16226-5-git-send-email-nm@ti.com>
	<1274585799-16226-6-git-send-email-nm@ti.com>
	<1274585799-16226-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59735 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0E0LYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 07:24:13 -0400
Received: by gwaa12 with SMTP id a12so1817505gwa.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 04:24:12 -0700 (PDT)
In-Reply-To: <1274585799-16226-7-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Senthilvadivu Gurusamy <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>

Nishanth Menon <nm@ti.com> wrote:
> sgx, iva, l2cache, sgx, neon, isp are generic features, make
> them generic features, current OMAP3 detection mechanism
> is still retained. 192Mhz is more specific OMAP3 feature
> so it is retained as is
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Angelo Arrifano <miknix@gmail.com>
> Cc: "Zebediah C. McClure" <zmc@lurian.net>
> Cc: Alistair Buxton <a.j.buxton@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
> Cc: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Vishwanath S <vishwa.s@ti.com>
> Cc: linux-omap@vger.kernel.org
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 20 +++++=
+++--------
> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 | =A0 =A03 ++
> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 39 +++++++++++++++++++=
-------------
> =A03 files changed, 36 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 809e13a..01555b6 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -161,7 +161,7 @@ static void __init omap24xx_check_revision(void)
> =A0#define OMAP3_CHECK_FEATURE(status,feat) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0if (((status & OMAP3_ ##feat## _MASK) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> OMAP3_ ##feat## _SHIFT) !=3D FEAT_ =
##feat## _NONE) { =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_ ##feat; =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP_HAS_ ##feat; =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0}

"CHECK" sounds like a querying API, whereas the macro populates data.
Maybe UPDATE or SET ?

> =A0static void __init omap3_check_features(void)
> @@ -310,20 +310,20 @@ static void __init omap3_cpuinfo(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * AM35xx devices
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap3_has_sgx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_has_sgx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OMAP=
3517_REV(rev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "AM35=
17");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Already set in omap=
3_check_revision() */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "AM35=
05");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 } else if (omap3_has_iva() && omap3_has_sgx()) {
> + =A0 =A0 =A0 } else if (omap_has_iva() && omap_has_sgx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* OMAP3430, OMAP3525, OMAP3515, OMAP3=
503 devices */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "OMAP3430/3530");
> - =A0 =A0 =A0 } else if (omap3_has_iva()) {
> + =A0 =A0 =A0 } else if (omap_has_iva()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OMAP3525_REV(rev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "OMAP3525");
> - =A0 =A0 =A0 } else if (omap3_has_sgx()) {
> + =A0 =A0 =A0 } else if (omap_has_sgx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OMAP3515_REV(rev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "OMAP3515");
> =A0 =A0 =A0 =A0} else {
> @@ -354,11 +354,11 @@ static void __init omap3_cpuinfo(void)
> =A0 =A0 =A0 =A0/* Print verbose information */
> =A0 =A0 =A0 =A0pr_info("%s ES%s (", cpu_name, cpu_rev);
>
> - =A0 =A0 =A0 OMAP_SHOW_FEATURE(3, l2cache);
> - =A0 =A0 =A0 OMAP_SHOW_FEATURE(3, iva);
> - =A0 =A0 =A0 OMAP_SHOW_FEATURE(3, sgx);
> - =A0 =A0 =A0 OMAP_SHOW_FEATURE(3, neon);
> - =A0 =A0 =A0 OMAP_SHOW_FEATURE(3, isp);
> + =A0 =A0 =A0 OMAP_SHOW_FEATURE(, l2cache);
> + =A0 =A0 =A0 OMAP_SHOW_FEATURE(, iva);
> + =A0 =A0 =A0 OMAP_SHOW_FEATURE(, sgx);
> + =A0 =A0 =A0 OMAP_SHOW_FEATURE(, neon);
> + =A0 =A0 =A0 OMAP_SHOW_FEATURE(, isp);
> =A0 =A0 =A0 =A0OMAP_SHOW_FEATURE(3, 192mhz_clk);
>
> =A0 =A0 =A0 =A0printk(")\n");
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.=
c
> index 459a45f..259adc7 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -81,6 +81,9 @@ const void *omap_get_var_config(u16 tag, size_t *le=
n)
> =A0}
> =A0EXPORT_SYMBOL(omap_get_var_config);
>
> +/* OMAP Generic features */
> +u32 omap_features;
> +
> =A0void __init omap_check_revision()
> =A0{
> =A0#ifdef CONFIG_ARCH_OMAP1
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-om=
ap/include/plat/cpu.h
> index f8ecbc4..3cc4947 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -331,14 +331,14 @@ IS_OMAP_TYPE(3517, 0x3517)
> =A0# undef cpu_is_omap3517
> =A0# define cpu_is_omap3430() =A0 =A0 =A0 =A0 =A0 =A0 is_omap3430()
> =A0# define cpu_is_omap3503() =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap343=
0() && =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap3_has_iva()) && =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap3_has_sgx()))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap_has_iva()) && =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap_has_sgx()))
> =A0# define cpu_is_omap3515() =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap343=
0() && =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap3_has_iva()) && =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (omap3_has_sgx()))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap_has_iva()) && =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (omap_has_sgx()))
> =A0# define cpu_is_omap3525() =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap343=
0() && =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap3_has_sgx()) && =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (omap3_has_iva()))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (!omap_has_sgx()) && =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (omap_has_iva()))
> =A0# define cpu_is_omap3530() =A0 =A0 =A0 =A0 =A0 =A0 (cpu_is_omap343=
0())
> =A0# define cpu_is_omap3505() =A0 =A0 =A0 =A0 =A0 =A0 is_omap3505()
> =A0# define cpu_is_omap3517() =A0 =A0 =A0 =A0 =A0 =A0 is_omap3517()
> @@ -457,22 +457,29 @@ static inline unsigned int omap##rev##_has_ ##f=
eat(void) =A0 =A0 =A0 =A0 =A0\
> =A0} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0\
>
> =A0/*
> + * Runtime detection of Generic OMAP features
> + */
> +extern u32 omap_features;
> +
> +#define OMAP_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> +#define OMAP_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> +#define OMAP_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
> +#define OMAP_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
> +#define OMAP_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
> +
> +OMAP_HAS_FEATURE(, l2cache, L2CACHE)
> +OMAP_HAS_FEATURE(, sgx, SGX)
> +OMAP_HAS_FEATURE(, iva, IVA)
> +OMAP_HAS_FEATURE(, neon, NEON)
> +OMAP_HAS_FEATURE(, isp, ISP)
> +
> +/*
> =A0* Runtime detection of OMAP3 features
> =A0*/
> =A0extern u32 omap3_features;
>
> -#define OMAP3_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
> -#define OMAP3_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
> -#define OMAP3_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
> -#define OMAP3_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
> -#define OMAP3_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
> =A0#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
>
> -OMAP_HAS_FEATURE(3, l2cache, L2CACHE)
> -OMAP_HAS_FEATURE(3, sgx, SGX)
> -OMAP_HAS_FEATURE(3, iva, IVA)
> -OMAP_HAS_FEATURE(3, neon, NEON)
> -OMAP_HAS_FEATURE(3, isp, ISP)
> =A0OMAP_HAS_FEATURE(3, 192mhz_clk, 192MHZ_CLK)
>
> =A0#endif
> --

What about feature detection for OMAP2 and OMAP4 (similar to
omap3_check_features) ?
At least a dummy implementation with warning messages would be good,
so that they are not used without initialization.

Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
