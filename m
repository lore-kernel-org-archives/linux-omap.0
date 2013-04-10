From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: OMAP: instantiate omap-cpufreq as a platform_driver
Date: Wed, 10 Apr 2013 14:20:26 +0200
Message-ID: <7179834.vhxUWUzCyV@vostro.rjw.lan>
References: <1365549721-15620-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55416 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935572Ab3DJMMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 08:12:41 -0400
In-Reply-To: <1365549721-15620-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On Tuesday, April 09, 2013 04:22:01 PM Kevin Hilman wrote:
> From: Nishanth Menon <nm@ti.com>
>=20
> As multi-platform build is being adopted by more and more ARM platfor=
ms,
> initcall function should be used very carefully.  For example, when
> CONFIG_ARM_OMAP2PLUS_CPUFREQ is built in the kernel, omap_cpufreq_ini=
t()
> will be called on all the platforms to initialize omap-cpufreq driver=
=2E
>=20
> Further, on OMAP, we now use Soc generic cpufreq-cpu0 driver using de=
vice
> tree entries.  To allow cpufreq-cpu0 and omap-cpufreq drivers to co-e=
xist
> for OMAP in a single image, we need to ensure the following:
> 1. With device tree boot, we use cpufreq-cpu0
> 2. With non device tree boot, we use omap-cpufreq
>=20
> In the case of (1), we will have cpu OPPs and regulator registered
> as part of the device tree nodes, to ensure that omap-cpufreq
> and cpufreq-cpu0 don't conflict in managing the frequency of the
> same CPU, we should not permit omap-cpufreq to be probed.
>=20
> In the case of (2), we will not have the cpufreq-cpu0 device, hence
> only omap-cpufreq will be active.
>=20
> To eliminate this undesired these effects, we change omap-cpufreq
> driver to have it instantiated as a platform_driver and register
> "omap-cpufreq" device only when booted without device tree nodes on
> OMAP platforms.
>=20
> This allows the following:
> a) Will only run on platforms that create the platform_device
>    "omap-cpufreq".
> b) Since the platform_device is registered only when device tree node=
s
>    are *not* populated, omap-cpufreq driver does not conflict with
>    the usage of cpufreq-cpu0 driver which is used on OMAP platforms w=
hen
>    device tree nodes are present.
>=20
> Inspired by commit 5553f9e26f6f49a93ba732fd222eac6973a4cf35
> (cpufreq: instantiate cpufreq-cpu0 as a platform_driver)
>=20
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> [robherring2@gmail.com: reported conflict of omap-cpufreq vs other
> driver in an non-device tree supported boot]
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> Rafael, can you add this one for v3.10?  It applies on top the
> rest of your cpufreq changes and I've verified that the OMAP
> changes are OK and don't conflict with anything else we have
> queued for v3.10 on OMAP.
>=20
> This patch was previously part of a 2-patch series, but the=20
> other part is still in discussion, and this part can be merged
> independently.

Applied to my bleeding-edge branch and will go to linux-next after buil=
d testing.

Thanks,
Rafael


>  arch/arm/mach-omap2/pm.c       |  9 +++++++++
>  drivers/cpufreq/omap-cpufreq.c | 19 ++++++++++++++-----
>  2 files changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 673a4c1..8d15f9a 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -265,6 +265,12 @@ static void __init omap4_init_voltages(void)
>  	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", "iva");
>  }
> =20
> +static inline void omap_init_cpufreq(void)
> +{
> +	struct platform_device_info devinfo =3D { .name =3D "omap-cpufreq",=
 };
> +	platform_device_register_full(&devinfo);
> +}
> +
>  static int __init omap2_common_pm_init(void)
>  {
>  	if (!of_have_populated_dt())
> @@ -294,6 +300,9 @@ int __init omap2_common_pm_late_init(void)
> =20
>  		/* Smartreflex device init */
>  		omap_devinit_smartreflex();
> +
> +		/* cpufreq dummy device instantiation */
> +		omap_init_cpufreq();
>  	}
> =20
>  #ifdef CONFIG_SUSPEND
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cp=
ufreq.c
> index 9128c07..d4f84b8 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -25,6 +25,7 @@
>  #include <linux/opp.h>
>  #include <linux/cpu.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> =20
>  #include <asm/smp_plat.h>
> @@ -252,7 +253,7 @@ static struct cpufreq_driver omap_driver =3D {
>  	.attr		=3D omap_cpufreq_attr,
>  };
> =20
> -static int __init omap_cpufreq_init(void)
> +static int omap_cpufreq_probe(struct platform_device *pdev)
>  {
>  	mpu_dev =3D get_cpu_device(0);
>  	if (!mpu_dev) {
> @@ -280,12 +281,20 @@ static int __init omap_cpufreq_init(void)
>  	return cpufreq_register_driver(&omap_driver);
>  }
> =20
> -static void __exit omap_cpufreq_exit(void)
> +static int omap_cpufreq_remove(struct platform_device *pdev)
>  {
> -	cpufreq_unregister_driver(&omap_driver);
> +	return cpufreq_unregister_driver(&omap_driver);
>  }
> =20
> +static struct platform_driver omap_cpufreq_platdrv =3D {
> +	.driver =3D {
> +		.name	=3D "omap-cpufreq",
> +		.owner	=3D THIS_MODULE,
> +	},
> +	.probe		=3D omap_cpufreq_probe,
> +	.remove		=3D omap_cpufreq_remove,
> +};
> +module_platform_driver(omap_cpufreq_platdrv);
> +
>  MODULE_DESCRIPTION("cpufreq driver for OMAP SoCs");
>  MODULE_LICENSE("GPL");
> -module_init(omap_cpufreq_init);
> -module_exit(omap_cpufreq_exit);
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
