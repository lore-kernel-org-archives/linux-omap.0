From: John Sarman <johnsarman@gmail.com>
Subject: Re: MMC3 Overo
Date: Thu, 30 Jul 2009 15:23:50 -0400
Message-ID: <bb2708720907301223h616eb215gb4aea1df8e1d578e@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f183.google.com ([209.85.211.183]:58206 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZG3TXu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 15:23:50 -0400
Received: by ywh13 with SMTP id 13so996374ywh.15
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2009 12:23:50 -0700 (PDT)
In-Reply-To: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On Thu, Jul 30, 2009 at 11:49 AM, John Sarman<johnsarman@gmail.com> wro=
te:
> I am trying to use mmc3 on the Overo Gumstix board with no luck. =A0I
> have patched the kernel with the latest changes and have yet to see a
> clk pulse, both before and after the patches.
After adding some debugging printks, I have determined the mmc3 fails
getting IRQ
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
REQUEST IRQ =3D 83 HOST =3D -812068416
mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
REQUEST IRQ =3D 86 HOST =3D -812067392
mmci-omap-hs mmci-omap-hs.2: Failed to get debounce clock
REQUEST IRQ =3D 83 HOST =3D -812066368
mmci-omap-hs mmci-omap-hs.2: Unable to grab HSMMC IRQ
mmci-omap-hs mmci-omap-hs.2: Probe Failed
mmci-omap-hs: probe of mmci-omap-hs.2 failed with error -16

=46or some reason mmc1 and mmc3 ask for the same interrupt 83 ???

Why would this be assigned the same value?

> So far I have reconfigured the pins with uboot to GPIO and tested eac=
h
> pin to verify that the signals are connected properly. =A0That test
> passed.
> Then I reconfigured them back to MODE 2(mmc modes) for each pin. =A0I=
 am
> confident that the level transceiver(TXS0108ERGYR) is operating
> properly. This transceiver is automatic so no external controls are
> necessary.
>
>
> <u-boot_snip>
> =A0MUX_VAL(CP(ETK_CLK_ES2), =A0 =A0 =A0 (IDIS | PTU | EN =A0| M2)) /*=
MMC3_CLK*/\
> =A0MUX_VAL(CP(ETK_CTL_ES2), =A0 =A0 =A0 (IEN =A0| PTU | EN =A0| M2)) =
/*MMC3_CMD*/\
> =A0MUX_VAL(CP(ETK_D3_ES2), =A0 =A0 =A0 =A0(IEN =A0| PTU | EN =A0| M2)=
) /*MMC3_DAT3*/\
> =A0MUX_VAL(CP(ETK_D4_ES2), =A0 =A0 =A0 =A0(IEN =A0| PTU | EN =A0| M2)=
) /*MMC3_DAT0*/\
> =A0MUX_VAL(CP(ETK_D5_ES2), =A0 =A0 =A0 =A0(IEN =A0| PTU | EN =A0| M2)=
) /*MMC3_DAT1*/\
> =A0MUX_VAL(CP(ETK_D6_ES2), =A0 =A0 =A0 =A0(IEN =A0| PTU | EN =A0| M2)=
) /*MMC3_DAT2*/\
> </u-boot_snip>
>
> <mmc_params>
> // I Switched mmc 2 and 3 in a feeble attempt. =A0Also I removed 2 in=
 an
> earlier attempt and the kernel would not boot ???????
> // Also I have tested working gpio connected to CD and WP but not
> attempting to tackle that yet.
> static struct twl4030_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.wires =A0 =A0 =A0 =A0 =A0=3D 4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 3,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.wires =A0 =A0 =A0 =A0 =A0=3D 4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.wires =A0 =A0 =A0 =A0 =A0=3D 4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.transceiver =A0 =A0=3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ocr_mask =A0 =A0 =A0 =3D 0x00100000, =
=A0 /* 3.3V */
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> };
> </mmc_params>
>
> <twl_setup>
>
> static int overo_twl_gpio_setup(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned gpio, unsigned ngpio)
> {
> =A0 =A0 =A0 =A0twl4030_mmc_init(mmc); =A0 =A0 =A0 =A0<-- mmc params =A0=
 =A0passed to init
>
> =A0 =A0 =A0 =A0overo_vmmc1_supply.dev =3D mmc[0].dev;
>
> =A0 =A0 =A0 =A0return 0;
> }
> static struct twl4030_gpio_platform_data overo_gpio_data =3D {
> =A0 =A0 =A0 =A0.gpio_base =A0 =A0 =A0=3D OMAP_MAX_GPIO_LINES,
> =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_GPIO_IRQ_BASE,
> =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_GPIO_IRQ_END,
> =A0 =A0 =A0 =A0.setup =A0 =A0 =A0 =A0 =A0=3D overo_twl_gpio_setup,
> <----- =A0 =A0setup passed into the twl4030 gpio platform data
> };
>
> static struct twl4030_platform_data overo_twldata =3D {
> =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
> =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
> =A0 =A0 =A0 =A0.gpio =A0 =A0 =A0 =A0 =A0 =3D &overo_gpio_data,
> <--- gpio data passed into twl4030 plat data
> =A0 =A0 =A0 =A0.usb =A0 =A0 =A0 =A0 =A0 =A0=3D &overo_usb_data,
> =A0 =A0 =A0 =A0.power =A0 =A0 =A0 =A0 =A0=3D GENERIC3430_T2SCRIPTS_DA=
TA,
> =A0 =A0 =A0 =A0.vmmc1 =A0 =A0 =A0 =A0 =A0=3D &overo_vmmc1,
> };
>
> static struct i2c_board_info __initdata overo_i2c_boardinfo[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C_BOARD_INFO("tps65950", 0x48),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D I2C_CLIENT_WAKE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =3D INT_34XX_SYS_NIRQ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =3D &overo_twldata,
> =A0 =A0 =A0 =A0},
> };
>
> static int __init overo_i2c_init(void)
> {
> =A0 =A0 =A0 =A0omap_register_i2c_bus(1, 2600, overo_i2c_boardinfo,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(overo_i2c_b=
oardinfo));
> =A0 =A0 =A0 =A0/* i2c2 pins are used for gpio */
> =A0 =A0 =A0 =A0omap_register_i2c_bus(3, 400, NULL, 0);
> =A0 =A0 =A0 =A0return 0;
> }
>
> // i2c_init called first in init.
> static void __init overo_init(void)
> {
> =A0 =A0 =A0 =A0overo_i2c_init();
> =A0.....
> =A0</twl_setup>
>
>
> So the way I see it working is i2c is initialized, which sets up the
> twl4030. =A0When the twl4030 configures gpio it initializes the mmc.
> mmc0 comes up fine (I have a root File System), but I never get a clk
> on mmc3.
>
> Any help would be greatly appreciated.
>
> Thanks
> John Sarman
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
