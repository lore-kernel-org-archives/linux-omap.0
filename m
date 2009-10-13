From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: Add support for the IGEP v2 board (rev B)
Date: Tue, 13 Oct 2009 13:20:31 +0200
Message-ID: <70c9a9110910130420q236867faj7bc0576871ca2c00@mail.gmail.com>
References: <70c9a9110910090859h9b1d50fh928e34909f2b1e46@mail.gmail.com>
	 <4ACFE762.1020708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:58413 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759500AbZJMLVJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 07:21:09 -0400
Received: by fxm27 with SMTP id 27so10046855fxm.17
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 04:20:32 -0700 (PDT)
In-Reply-To: <4ACFE762.1020708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Nishanth,

    Thanks for your feedback, I'll forward the patch correcting some th=
ings

2009/10/10 Nishanth Menon <nm@ti.com>:

> could you add more details on where do we get more data on this platf=
orm?

More details will be in new patch and you can get more information here=
:

       www.igep-platform.com

Regards,

   Enric

2009/10/10 Nishanth Menon <nm@ti.com>:
> Hi,
> Thanks for the patch.. a few minor comments follow from a read throug=
h..
>
> Enric Balletb=C3=B2 i Serra had written, on 10/09/2009 10:59 AM, the =
following:
>>
>> =C2=A0This patch adds minimal IGEP v2 support.
>
> could you add more details on where do we get more data on this platf=
orm?
>
>>
>> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>> ---
>> =C2=A0arch/arm/configs/igep0020_defconfig =C2=A0| 1443
>> ++++++++++++++++++++++++++++++++++
>> =C2=A0arch/arm/mach-omap2/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A04 +
>> =C2=A0arch/arm/mach-omap2/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A02 +
>> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0239 ++++++
>> =C2=A04 files changed, 1688 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 arch/arm/configs/igep0020_defconfig
>> =C2=A0create mode 100644 arch/arm/mach-omap2/board-igep0020.c
>
> [...]
>>
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-igep0020.c
>> @@ -0,0 +1,239 @@
>> +/*
>
> [..]
>
>> +static inline void __init igep2_init_smsc911x(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long cs_mem_base;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (gpmc_cs_request(IGEP2_SMSC911X_CS, SZ_16M=
, &cs_mem_base) < 0)
>> {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "=
=46ailed request for GPMC mem for
>> smsc911x\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 igep2_smsc911x_resources[0].start =3D cs_mem_=
base + 0x0;
>> + =C2=A0 =C2=A0 =C2=A0 igep2_smsc911x_resources[0].end =C2=A0 =3D cs=
_mem_base + 0xff;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if ((gpio_request(IGEP2_SMSC911X_GPIO, "SMSC9=
11X IRQ") =3D=3D 0) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_input(IGEP2_SMS=
C911X_GPIO) =3D=3D 0)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_export(IGEP2=
_SMSC911X_GPIO, 0);
>> + =C2=A0 =C2=A0 =C2=A0 } else {
>
> could you run scripts/checkpatch --strict ../patchName after generati=
ng the
> patch with git format-patch -s -M -o .. -1 ? one liners dont usually =
need a
> {} also there are few warning inducing code below..
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "=
could not obtain gpio for SMSC911X
>> IRQ\n");
>
> probably dumb question: should'nt we be moving to pr_err and family i=
nstead
> of printks?
>
> further, if this does not work.. are'nt you supposed to release the c=
s?
> gpmc_cs_free perhaps?
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 igep2_smsc911x_resources[1].start =3D
>> OMAP_GPIO_IRQ(IGEP2_SMSC911X_GPIO);
>> + =C2=A0 =C2=A0 =C2=A0 igep2_smsc911x_resources[1].end =C2=A0 =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 platform_device_register(&igep2_smsc911x_devi=
ce);
>> +}
>> +
>> +#else
>> +
>> +static inline void __init igep2_init_smsc911x(void) { }
>> +
>> +#endif
>> +
>
> [..]
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D I2C_CLIENT_WAKE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D INT_34XX_SYS_NIRQ,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=
=A0=3D &igep2_twldata,
>> + =C2=A0 =C2=A0 =C2=A0 },
>> +};
>> +
>> +static int __init igep2_i2c_init(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 omap_register_i2c_bus(1, 2600, igep2_i2c_boar=
dinfo,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ARRAY_SIZE(igep2_i2c_boardinfo));
>
> you may want to step down to 2400
> http://marc.info/?l=3Dlinux-omap&m=3D125510664919890&w=3D2 if you are=
 using
> 26Mhz.. if you are using twl5030..
>>
>> + =C2=A0 =C2=A0 =C2=A0 omap_register_i2c_bus(3, 400, NULL, 0);
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static void __init igep2_init(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 igep2_i2c_init();
>> + =C2=A0 =C2=A0 =C2=A0 omap_serial_init();
>> + =C2=A0 =C2=A0 =C2=A0 usb_musb_init();
>> +
>> + =C2=A0 =C2=A0 =C2=A0 igep2_init_smsc911x();
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* GPIO userspace leds */
>> + =C2=A0 =C2=A0 =C2=A0 if ((gpio_request(IGEP2_GPIO_LED_0_RED, "GPIO=
_LED_0_RED") =3D=3D 0) &&
>> (gpio_direction_output(IGEP2_GPIO_LED_0_RED, 1) =3D=3D 0)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_export(IGEP2=
_GPIO_LED_0_RED, 1);
>> + =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "=
could not obtain gpio for "
>> "GPIO_LED_0_RED\n");
>
> do you really want to flag a an error for a led glow?
>>
>> + =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 if ((gpio_request(IGEP2_GPIO_LED_0_GREEN, "GP=
IO_LED_0_GREEN") =3D=3D
>> 0)
>> && (gpio_direction_output(IGEP2_GPIO_LED_0_GREEN, 1) =3D=3D 0)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_export(IGEP2=
_GPIO_LED_0_GREEN, 1);
>> + =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "=
could not obtain gpio for "
>> "GPIO_LED_0_GREEN\n");
>> + =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 if ((gpio_request(IGEP2_GPIO_LED_1_RED, "GPIO=
_LED_1_RED") =3D=3D 0) &&
>> (gpio_direction_output(IGEP2_GPIO_LED_1_RED, 1) =3D=3D 0)) {
>
> here is a an long line?
> [...]
> --
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
