From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Add support for the IGEP v2 board (rev B)
Date: Fri, 9 Oct 2009 20:46:10 -0500
Message-ID: <4ACFE762.1020708@ti.com>
References: <70c9a9110910090859h9b1d50fh928e34909f2b1e46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43523 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933898AbZJJBqs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 21:46:48 -0400
In-Reply-To: <70c9a9110910090859h9b1d50fh928e34909f2b1e46@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?RW5yaWMgQmFsbGV0YsOyIGkgU2VycmE=?= <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
Thanks for the patch.. a few minor comments follow from a read through.=
=2E

Enric Balletb=C3=B2 i Serra had written, on 10/09/2009 10:59 AM, the fo=
llowing:
>   This patch adds minimal IGEP v2 support.

could you add more details on where do we get more data on this platfor=
m?

>=20
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> ---
>  arch/arm/configs/igep0020_defconfig  | 1443 ++++++++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap2/Kconfig          |    4 +
>  arch/arm/mach-omap2/Makefile         |    2 +
>  arch/arm/mach-omap2/board-igep0020.c |  239 ++++++
>  4 files changed, 1688 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/igep0020_defconfig
>  create mode 100644 arch/arm/mach-omap2/board-igep0020.c
[...]
>=20
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -0,0 +1,239 @@
> +/*
[..]

> +static inline void __init igep2_init_smsc911x(void)
> +{
> +       unsigned long cs_mem_base;
> +
> +       if (gpmc_cs_request(IGEP2_SMSC911X_CS, SZ_16M, &cs_mem_base) =
< 0) {
> +               printk(KERN_ERR "Failed request for GPMC mem for smsc=
911x\n");
> +               return;
> +       }
> +
> +       igep2_smsc911x_resources[0].start =3D cs_mem_base + 0x0;
> +       igep2_smsc911x_resources[0].end   =3D cs_mem_base + 0xff;
> +
> +       if ((gpio_request(IGEP2_SMSC911X_GPIO, "SMSC911X IRQ") =3D=3D=
 0) &&
> +           (gpio_direction_input(IGEP2_SMSC911X_GPIO) =3D=3D 0)) {
> +               gpio_export(IGEP2_SMSC911X_GPIO, 0);
> +       } else {
could you run scripts/checkpatch --strict ../patchName after generating=
=20
the patch with git format-patch -s -M -o .. -1 ? one liners dont usuall=
y=20
need a {} also there are few warning inducing code below..
> +               printk(KERN_ERR "could not obtain gpio for SMSC911X I=
RQ\n");
probably dumb question: should'nt we be moving to pr_err and family=20
instead of printks?

further, if this does not work.. are'nt you supposed to release the cs?=
=20
gpmc_cs_free perhaps?

> +               return;
> +       }
> +
> +       igep2_smsc911x_resources[1].start =3D OMAP_GPIO_IRQ(IGEP2_SMS=
C911X_GPIO);
> +       igep2_smsc911x_resources[1].end   =3D 0;
> +
> +       platform_device_register(&igep2_smsc911x_device);
> +}
> +
> +#else
> +
> +static inline void __init igep2_init_smsc911x(void) { }
> +
> +#endif
> +
[..]
> +               .flags          =3D I2C_CLIENT_WAKE,
> +               .irq            =3D INT_34XX_SYS_NIRQ,
> +               .platform_data  =3D &igep2_twldata,
> +       },
> +};
> +
> +static int __init igep2_i2c_init(void)
> +{
> +       omap_register_i2c_bus(1, 2600, igep2_i2c_boardinfo,
> +                       ARRAY_SIZE(igep2_i2c_boardinfo));
you may want to step down to 2400=20
http://marc.info/?l=3Dlinux-omap&m=3D125510664919890&w=3D2 if you are u=
sing=20
26Mhz.. if you are using twl5030..
> +       omap_register_i2c_bus(3, 400, NULL, 0);
> +       return 0;
> +}
> +
> +static void __init igep2_init(void)
> +{
> +       igep2_i2c_init();
> +       omap_serial_init();
> +       usb_musb_init();
> +
> +       igep2_init_smsc911x();
> +
> +       /* GPIO userspace leds */
> +       if ((gpio_request(IGEP2_GPIO_LED_0_RED, "GPIO_LED_0_RED") =3D=
=3D 0) &&
> (gpio_direction_output(IGEP2_GPIO_LED_0_RED, 1) =3D=3D 0)) {
> +               gpio_export(IGEP2_GPIO_LED_0_RED, 1);
> +       } else {
> +               printk(KERN_ERR "could not obtain gpio for " "GPIO_LE=
D_0_RED\n");
do you really want to flag a an error for a led glow?
> +       }
> +       if ((gpio_request(IGEP2_GPIO_LED_0_GREEN, "GPIO_LED_0_GREEN")=
 =3D=3D 0)
> && (gpio_direction_output(IGEP2_GPIO_LED_0_GREEN, 1) =3D=3D 0)) {
> +               gpio_export(IGEP2_GPIO_LED_0_GREEN, 1);
> +       } else {
> +               printk(KERN_ERR "could not obtain gpio for " "GPIO_LE=
D_0_GREEN\n");
> +       }
> +       if ((gpio_request(IGEP2_GPIO_LED_1_RED, "GPIO_LED_1_RED") =3D=
=3D 0) &&
> (gpio_direction_output(IGEP2_GPIO_LED_1_RED, 1) =3D=3D 0)) {
here is a an long line?
[...]
--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
