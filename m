From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Thu, 14 Feb 2013 07:18:43 -0300
Message-ID: <20130214101841.GA2429@localhost>
References: <510BF3D3.3000304@mimc.co.uk>
 <510BF766.5090608@ti.com>
 <510C19FC.8090906@mimc.co.uk>
 <5111304C.7090706@mimc.co.uk>
 <511134C8.8000008@ti.com>
 <511137CF.1090706@mimc.co.uk>
 <51113C74.4070607@ti.com>
 <51137923.4070301@mimc.co.uk>
 <511C007A.7080103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54298 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180Ab3BNKTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 05:19:23 -0500
Content-Disposition: inline
In-Reply-To: <511C007A.7080103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

Hi Jon,

I'm working on a similar memory controller for plat-orion.
I have a few questions about your approach.

On Wed, Feb 13, 2013 at 03:07:06PM -0600, Jon Hunter wrote:
>=20
> On 02/07/2013 03:51 AM, Mark Jackson wrote:
> > Okay ... I have made some progress, but it's not ideal.
> >=20
> > Currently I've hacked the GPMC DT driver (gpmc_probe_dt(), etc) so =
it now handles setting up the
> > chip selects and timings for NOR devices, e.g.
> >=20
> > 		gpmc: gpmc@50000000 {
> > 			status =3D "okay";
> > 			ranges =3D <0 0 0x08000000 0x08000000>;	/* CS0: NOR 16M */
>=20
> Is that really 16M? Looks more like 128M :-)
>=20
> > 			nor@0,0 {
> > 				compatible =3D "spansion,s29gl064n90t", "cfi-flash";
> > 				reg =3D <0 0 0>;
>=20
> I think that cfi-flash is expecting a length here. Here is
> what I have ...
>=20
> +&gpmc {
> +       ranges =3D <0 0 0x08000000 0x04000000>;
> +
> +       nor@0,0 {
> +               compatible =3D "cfi-flash";
> +               linux,mtd-name=3D "intel,ge28f256l18b85";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               reg =3D <0 0 0x04000000>;
> +               bank-width =3D <2>;
> +
> +               partition@0 {
> +                       label =3D "bootloader";
> +                       reg =3D <0 0x20000>;
> +               };
> +               partition@0x20000 {
> +                       label =3D "params";
> +                       reg =3D <0x20000 0x20000>;
> +               };
> +               partition@0x40000 {
> +                       label =3D "kernel";
> +                       reg =3D <0x40000 0x200000>;
> +               };
> +               partition@0x240000 {
> +                       label =3D "file-system";
> +                       reg =3D <0x240000 0x3dc0000>;
> +               };
> +       };
>=20
> > 	nor-flash@08000000 {
> > 		compatible =3D "spansion,s29gl064n90t", "cfi-flash";
> > 		reg =3D <0x08000000 0x00800000>;
> > 		bank-width =3D <2>;
> > 	};
>=20
> You don't need this extra entry if you add "simple-bus" to
> the gpmc node compatible string.
>=20

That would be nice. However, I wonder what happens if cfi-flash probing
fails: will the gpmc cs request by undone? See below...

> +               gpmc: gpmc@6800a000 {
> +                       compatible =3D "ti,omap2420-gpmc", "simple-bu=
s";
> +                       ti,hwmods =3D "gpmc";
> +                       reg =3D <0x6800a000 0x1000>;
> +                       interrupts =3D <20>;
> +
> +                       gpmc,num-cs =3D <8>;
> +                       gpmc,num-waitpins =3D <4>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <1>;
> +               };
>=20
> Currently I have the following and this is working for me.=20
> Please note that on my board the bootloader is configuring
> the timings for me and so this is missing from the below
> implementation and still needs to be added.
>=20
> Cheers
> Jon
>=20
> From c0ede833fad704ab452b116154177e3a59166c7e Mon Sep 17 00:00:00 200=
1
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Fri, 8 Feb 2013 16:46:13 -0600
> Subject: [PATCH] ARM: OMAP2+: Add device-tree support for NOR flash
>=20
> ---
>  arch/arm/mach-omap2/gpmc.c |   69 ++++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index bc90155..421320b 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -26,6 +26,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_mtd.h>
>  #include <linux/of_device.h>
>  #include <linux/mtd/nand.h>
> @@ -517,6 +518,26 @@ static int gpmc_cs_delete_mem(int cs)
>  	return r;
>  }
> =20
> +static int gpmc_cs_remap(int cs, u32 base)
> +{
> +	int r;
> +	u32 old_base, size;
> +
> +	gpmc_cs_get_memconf(cs, &old_base, &size);
> +	if (base =3D=3D old_base)
> +		return 0;
> +	gpmc_cs_disable_mem(cs);
> +	r =3D gpmc_cs_delete_mem(cs);
> +	if (IS_ERR_VALUE(r))
> +		return r;
> +	r =3D gpmc_cs_insert_mem(cs, base, size);
> +	if (IS_ERR_VALUE(r))
> +		return r;
> +	gpmc_cs_enable_mem(cs, base, size);
> +
> +	return 0;
> +}
> +
>  int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
>  {
>  	struct resource *res =3D &gpmc_cs_mem[cs];
> @@ -1305,6 +1326,45 @@ static int gpmc_probe_onenand_child(struct pla=
tform_device *pdev,
>  }
>  #endif
> =20
> +static int gpmc_probe_nor_child(struct platform_device *pdev,
> +				struct device_node *child)
> +{
> +	struct resource res;
> +	unsigned long base;
> +	int rc, cs;
> +
> +	if (of_property_read_u32(child, "reg", &cs) < 0) {
> +		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	if (of_address_to_resource(child, 0, &res)) {
> +		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	rc =3D gpmc_cs_request(cs, res.end - res.start, &base);
> +	if (rc < 0)
> +		pr_err("%s: cannot request GPMC CS %d\n", __func__, cs);

gpmc_cs_request will request a memory region from the resource allocato=
r
using allocate_resource().
How will this be released in case cfi-flash probe fails?

IMHO, this works fine currently for NAND and OneNAND because we registe=
r
the platform device explicitly and, thus, know if that fails.

> +
> +	/*
> +	 * gpmc_cs_request() will map the CS to an arbitary location
> +	 * in the gpmc address space. When booting with device-tree we
> +	 * want the NOR flash to be mapped to the location specified
> +	 * in the device-tree blob. So remap the CS to this location.
> +	 */
> +	rc =3D gpmc_cs_remap(cs, res.start);
> +	if (rc < 0) {
> +		pr_err("%s: cannot remap GPMC CS %d to 0x%x\n",
> +		       __func__, cs, res.start);
> +		gpmc_cs_free(cs);
> +	}
> +
> +	return rc;
> +}
> +
>  static int gpmc_probe_dt(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -1330,6 +1390,15 @@ static int gpmc_probe_dt(struct platform_devic=
e *pdev)
>  			return ret;
>  		}
>  	}
> +
> +	for_each_node_by_name(child, "nor") {
> +		ret =3D gpmc_probe_nor_child(pdev, child);
> +		if (ret < 0) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  #else
> --=20


Thanks,

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
