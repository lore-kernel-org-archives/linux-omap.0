From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 2/3]NAND: OMAP: Fixing omap nand driver, compiled as
 module
Date: Tue, 03 Nov 2009 10:28:17 +0200
Message-ID: <1257236897.21596.57.camel@localhost>
References: <ce9ab5790910292321y1e7239b7pbffe9a5891d66448@mail.gmail.com>
	 <ce9ab5790910300142kf12e31cpd6249d4c7383553f@mail.gmail.com>
	 <ce9ab5790910300227r41d42673webad0ee48e3444d1@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38169 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbZKCI21 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 03:28:27 -0500
In-Reply-To: <ce9ab5790910300227r41d42673webad0ee48e3444d1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

On Fri, 2009-10-30 at 14:57 +0530, Vimal Singh wrote:
> Last time I forgot to 'git add' for 'arch/arm/mach-omap2/gpmc.c'... M=
y bad.
> Correct patch is below.
>=20
> -vimal
>=20
>=20
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Fri, 30 Oct 2009 14:54:29 +0530
> Subject: [PATCH] NAND: OMAP: Fixing omap nand driver, compiled as mod=
ule
>=20
> Removing OMAP NAND driver, when loaded as a module, gives error and
> does not get success. This fixes this and makes driver loadable and
> removable run time.
>=20
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |    2 ++
>  drivers/mtd/nand/omap2.c   |    5 ++++-
>  2 files changed, 6 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 1587682..1d10b7b 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -88,6 +88,7 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
>  	reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
>  	__raw_writel(val, reg_addr);
>  }
> +EXPORT_SYMBOL(gpmc_cs_write_reg);
>=20
>  u32 gpmc_cs_read_reg(int cs, int idx)
>  {
> @@ -96,6 +97,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
>  	reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
>  	return __raw_readl(reg_addr);
>  }
> +EXPORT_SYMBOL(gpmc_cs_read_reg);

Why do you export these?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
