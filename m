From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2 2/2] OMAP3BEAGLE: Add support for mt9p031 sensor driver.
Date: Mon, 23 May 2011 09:25:01 +0200
Message-ID: <BANLkTi=sqZpAKFxeCbwqpU_7+WZABGa4=w@mail.gmail.com>
References: <1305899272-31839-1-git-send-email-javier.martin@vista-silicon.com>
	<1305899272-31839-2-git-send-email-javier.martin@vista-silicon.com>
	<4DD9146B.2050408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65337 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1EWHZC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2011 03:25:02 -0400
In-Reply-To: <4DD9146B.2050408@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-media@vger.kernel.org, beagleboard@googlegroups.com, carlighting@yahoo.co.nz, g.liakhovetski@gmx.de, linux-arm-kernel@lists.infradead.org, laurent.pinchart@ideasonboard.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 22 May 2011 15:49, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Javier,
>
>
> linux-omap should be CC'ed - added.
>
> In addition to Koen's comments, some comments below.
>
>
> On 05/20/11 16:47, Javier Martin wrote:
>
>> isp.h file has to be included as a temporal measure
>> since clocks of the isp are not exposed yet.
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0127 ++++++++++++++++=
++++++++++++++-
>> =A01 files changed, 123 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach=
-omap2/board-omap3beagle.c
>> index 33007fd..f52e6ae 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -24,15 +24,20 @@
>> =A0#include <linux/input.h>
>> =A0#include <linux/gpio_keys.h>
>> =A0#include <linux/opp.h>
>> +#include <linux/i2c.h>
>> +#include <linux/mm.h>
>> +#include <linux/videodev2.h>
>>
>> =A0#include <linux/mtd/mtd.h>
>> =A0#include <linux/mtd/partitions.h>
>> =A0#include <linux/mtd/nand.h>
>> =A0#include <linux/mmc/host.h>
>> -
>> +#include <linux/gpio.h>
>
> Why include this for second time?

Good catch, I'll fix it.

[snip]
>> @@ -309,6 +357,15 @@ static int beagle_twl_gpio_setup(struct device =
*dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to co=
nfigure EHCI_nOC\n", __func__);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Power on camera interface - only on p=
re-production, not
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* needed on production boards
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_request(gpio + 2, "CAM_EN");
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(gpio + 2, 1);
>
> Why not gpio_request_one()?

Just to follow the same approach as in the rest of the code.
Maybe a further patch could change all "gpio_request()" uses to
"gpio_request_one()".

>
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* TWL4030_GPIO_MAX + 0 =3D=3D ledA, EHCI nEN_USB_PWR =
(out, XM active
>> =A0 =A0 =A0 =A0* high / others active low)
>> @@ -451,6 +508,8 @@ static struct twl4030_platform_data beagle_twlda=
ta =3D {
>> =A0 =A0 =A0 .vsim =A0 =A0 =A0 =A0 =A0 =3D &beagle_vsim,
>> =A0 =A0 =A0 .vdac =A0 =A0 =A0 =A0 =A0 =3D &beagle_vdac,
>> =A0 =A0 =A0 .vpll2 =A0 =A0 =A0 =A0 =A0=3D &beagle_vpll2,
>> + =A0 =A0 .vaux3 =A0 =A0 =A0 =A0 =A0=3D &beagle_vaux3,
>> + =A0 =A0 .vaux4 =A0 =A0 =A0 =A0 =A0=3D &beagle_vaux4,
>> =A0};
>>
>> =A0static struct i2c_board_info __initdata beagle_i2c_boardinfo[] =3D=
 {
>> @@ -463,15 +522,16 @@ static struct i2c_board_info __initdata beagle=
_i2c_boardinfo[] =3D {
>> =A0};
>>
>> =A0static struct i2c_board_info __initdata beagle_i2c_eeprom[] =3D {
>> - =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_BOARD_INFO("eeprom", 0x50),
>> - =A0 =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 I2C_BOARD_INFO("eeprom", 0x50),
>> + =A0 =A0 },
>> =A0};
>
> This part of the hunk is not related to the patch
> and should be in a separate (cleanup) patch.
>

Sure, I'll fix it.

>>
>> =A0static int __init omap3_beagle_i2c_init(void)
>> =A0{
>> =A0 =A0 =A0 omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(beagle_i2c_bo=
ardinfo));
>> + =A0 =A0 omap_register_i2c_bus(2, 100, NULL, 0); /* Enable I2C2 for=
 camera */
>> =A0 =A0 =A0 /* Bus 3 is attached to the DVI port where devices like =
the pico DLP
>> =A0 =A0 =A0 =A0* projector don't work reliably with 400kHz */
>> =A0 =A0 =A0 omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_S=
IZE(beagle_i2c_eeprom));
>> @@ -654,6 +714,60 @@ static void __init beagle_opp_init(void)
>> =A0 =A0 =A0 return;
>> =A0}
>>
>> +static int beagle_cam_set_xclk(struct v4l2_subdev *subdev, int hz)
>> +{
>> + =A0 =A0 struct isp_device *isp =3D v4l2_dev_to_isp_device(subdev->=
v4l2_dev);
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D isp->platform_cb.set_xclk(isp, hz, MT9P031_XCLK);
>> + =A0 =A0 return 0;
>> +}
>
> Why do you need ret variable here, if you always return zero?
>

You are right, it's not needed any longer.


>> +
>> +static int beagle_cam_reset(struct v4l2_subdev *subdev, int active)
>> +{
>> + =A0 =A0 /* Set RESET_BAR to !active */
>> + =A0 =A0 gpio_set_value(MT9P031_RESET_GPIO, !active);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct mt9p031_platform_data beagle_mt9p031_platform_data =3D=
 {
>> + =A0 =A0 .set_xclk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D beagle_cam_set_x=
clk,
>> + =A0 =A0 .reset =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D beagle_cam_r=
eset,
>> +};
>> +
>> +static struct i2c_board_info mt9p031_camera_i2c_device =3D {
>> + =A0 =A0 I2C_BOARD_INFO("mt9p031", 0x48),
>> + =A0 =A0 .platform_data =3D &beagle_mt9p031_platform_data,
>> +};
>> +
>> +static struct isp_subdev_i2c_board_info mt9p031_camera_subdevs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .board_info =3D &mt9p031_camera_i2c_device=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .i2c_adapter_id =3D 2,
>> + =A0 =A0 },
>> + =A0 =A0 { NULL, 0, },
>> +};
>> +
>> +static struct isp_v4l2_subdevs_group beagle_camera_subdevs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .subdevs =3D mt9p031_camera_subdevs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .interface =3D ISP_INTERFACE_PARALLEL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .bus =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .parallel =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data_lane=
_shift =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clk_pol =3D=
 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bridge =3D=
 ISPCTRL_PAR_BRIDGE_DISABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 { },
>> +};
>> +
>> +static struct isp_platform_data beagle_isp_platform_data =3D {
>> + =A0 =A0 .subdevs =3D beagle_camera_subdevs,
>> +};
>> +
>> =A0static void __init omap3_beagle_init(void)
>> =A0{
>> =A0 =A0 =A0 omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>> @@ -679,6 +793,11 @@ static void __init omap3_beagle_init(void)
>>
>> =A0 =A0 =A0 beagle_display_init();
>> =A0 =A0 =A0 beagle_opp_init();
>> +
>> + =A0 =A0 /* Enable camera */
>> + =A0 =A0 gpio_request(MT9P031_RESET_GPIO, "cam_rst");
>> + =A0 =A0 gpio_direction_output(MT9P031_RESET_GPIO, 0);
>
> gpio_request_one()?

ditto

>> + =A0 =A0 omap3_init_camera(&beagle_isp_platform_data);
>> =A0}
>>
>> =A0MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
>
>
>
> --
> Regards,
> Igor.
>
>



--=20
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
