From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Tue, 15 May 2012 12:53:24 +0800
Message-ID: <CACVXFVOmLOm8qD5Mq8qJQGSCcD7kNhW9OOsQqzx6W77709CXEQ@mail.gmail.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51645 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2EOEx2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 00:53:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SU9lF-0007wO-Ue
	for linux-omap@vger.kernel.org; Tue, 15 May 2012 04:53:26 +0000
Received: by dady13 with SMTP id y13so6805134dad.19
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 21:53:24 -0700 (PDT)
In-Reply-To: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Thu, May 10, 2012 at 5:35 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> From: Jon Hunter <jon-hunter@ti.com>
>
> This patch is based upon Ming Lei's patch to add runtime PM support f=
or OMAP4
> [1]. In Ming's original patch the CTI interrupts were being enabled d=
uring
> runtime when the PMU was used but they were only configured once duri=
ng init.
> Therefore move the configuration of the CTI interrupts to the runtime=
 PM
> functions.

As Shilimkar pointed out, you need to give the reason why the change
is introduced
in the patch.

>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-Novemb=
er/074153.html
>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
> =A0arch/arm/mach-omap2/devices.c | =A0 50 ++++++++++++++++++++++-----=
-------------
> =A01 files changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index 636533d..b02aa81 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -18,6 +18,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/of.h>
> =A0#include <linux/platform_data/omap4-keypad.h>
> +#include <linux/pm_runtime.h>
>
> =A0#include <mach/hardware.h>
> =A0#include <mach/irqs.h>
> @@ -434,13 +435,22 @@ static struct omap_device_pm_latency omap_pmu_l=
atency[] =3D {
> =A0};
>
> =A0static struct cti omap4_cti[2];
> +static struct platform_device *pmu_dev;
>
> =A0static void omap4_enable_cti(int irq)
> =A0{
> - =A0 =A0 =A0 if (irq =3D=3D OMAP44XX_IRQ_CTI0)
> + =A0 =A0 =A0 pm_runtime_get_sync(&pmu_dev->dev);
> + =A0 =A0 =A0 if (irq =3D=3D OMAP44XX_IRQ_CTI0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure CTI0 for pmu irq routing *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cti_unlock(&omap4_cti[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cti_map_trigger(&omap4_cti[0], 1, 6, 2)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cti_enable(&omap4_cti[0]);
> - =A0 =A0 =A0 else if (irq =3D=3D OMAP44XX_IRQ_CTI1)
> + =A0 =A0 =A0 } else if (irq =3D=3D OMAP44XX_IRQ_CTI1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure CTI1 for pmu irq routing *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cti_unlock(&omap4_cti[1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cti_map_trigger(&omap4_cti[1], 1, 6, 2)=
;

The above line should be changed to below

                     cti_map_trigger(&omap4_cti[1], 1, 6, 3);

See below link for addressed irq flood issue.

http://permalink.gmane.org/gmane.linux.linaro.devel/10532

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cti_enable(&omap4_cti[1]);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static void omap4_disable_cti(int irq)
> @@ -449,6 +459,7 @@ static void omap4_disable_cti(int irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cti_disable(&omap4_cti[0]);
> =A0 =A0 =A0 =A0else if (irq =3D=3D OMAP44XX_IRQ_CTI1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cti_disable(&omap4_cti[1]);
> + =A0 =A0 =A0 pm_runtime_put(&pmu_dev->dev);
> =A0}
>
> =A0static irqreturn_t omap4_pmu_handler(int irq, void *dev, irq_handl=
er_t handler)
> @@ -461,27 +472,20 @@ static irqreturn_t omap4_pmu_handler(int irq, v=
oid *dev, irq_handler_t handler)
> =A0 =A0 =A0 =A0return handler(irq, dev);
> =A0}
>
> -static void __init omap4_configure_pmu_irq(void)
> +static int __init omap4_configure_pmu(void)
> =A0{
> - =A0 =A0 =A0 void __iomem *base0;
> - =A0 =A0 =A0 void __iomem *base1;
> + =A0 =A0 =A0 omap4_cti[0].base =3D ioremap(OMAP44XX_CTI0_BASE, SZ_4K=
);
> + =A0 =A0 =A0 omap4_cti[1].base =3D ioremap(OMAP44XX_CTI1_BASE, SZ_4K=
);
>
> - =A0 =A0 =A0 base0 =3D ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
> - =A0 =A0 =A0 base1 =3D ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
> - =A0 =A0 =A0 if (!base0 && !base1) {
> + =A0 =A0 =A0 if (!omap4_cti[0].base || !omap4_cti[1].base) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("ioremap for OMAP4 CTI failed\n=
");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /*configure CTI0 for pmu irq routing*/
> - =A0 =A0 =A0 cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
> - =A0 =A0 =A0 cti_unlock(&omap4_cti[0]);
> - =A0 =A0 =A0 cti_map_trigger(&omap4_cti[0], 1, 6, 2);
> + =A0 =A0 =A0 cti_init(&omap4_cti[0], omap4_cti[0].base, OMAP44XX_IRQ=
_CTI0, 6);
> + =A0 =A0 =A0 cti_init(&omap4_cti[1], omap4_cti[1].base, OMAP44XX_IRQ=
_CTI1, 6);
>
> - =A0 =A0 =A0 /*configure CTI1 for pmu irq routing*/
> - =A0 =A0 =A0 cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
> - =A0 =A0 =A0 cti_unlock(&omap4_cti[1]);
> - =A0 =A0 =A0 cti_map_trigger(&omap4_cti[1], 1, 6, 2);
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static struct platform_device* __init omap4_init_pmu(void)
> @@ -492,6 +496,9 @@ static struct platform_device* __init omap4_init_=
pmu(void)
> =A0 =A0 =A0 =A0struct omap_hwmod* oh[3];
> =A0 =A0 =A0 =A0char *dev_name =3D "arm-pmu";
>
> + =A0 =A0 =A0 if (omap4_configure_pmu())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> =A0 =A0 =A0 =A0hw =3D "l3_main_3";
> =A0 =A0 =A0 =A0oh[0] =3D omap_hwmod_lookup(hw);
> =A0 =A0 =A0 =A0if (!oh[0]) {
> @@ -530,14 +537,11 @@ static void __init omap_init_pmu(void)
> =A0 =A0 =A0 =A0} else if (cpu_is_omap34xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_pmu_device.resource =3D &omap3_pm=
u_resource;
> =A0 =A0 =A0 =A0} else if (cpu_is_omap44xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device *pd;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd =3D omap4_init_pmu();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmu_dev =3D omap4_init_pmu();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pmu_dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_enable(&od->pdev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_configure_pmu_irq();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pmu_dev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
