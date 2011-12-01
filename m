From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 10/11] arm: omap4panda: Add support for omap4iss camera
Date: Thu, 1 Dec 2011 07:34:04 -0600
Message-ID: <CAKnK67QR4jqvnDg3qR=Er1TdPq__EYYdRzoF-81-xUmzjF3ViA@mail.gmail.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com>
 <1322698500-29924-11-git-send-email-saaguirre@ti.com> <79CD15C6BA57404B839C016229A409A8046F94@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:58545 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753938Ab1LANe2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 08:34:28 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8046F94@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>

Hi Vaibhav,

Thanks for the comments.

On Thu, Dec 1, 2011 at 12:24 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
>> Sent: Thursday, December 01, 2011 5:45 AM
>> To: linux-media@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org; laurent.pinchart@ideasonboard.com;
>> sakari.ailus@iki.fi; Aguirre, Sergio
>> Subject: [PATCH v2 10/11] arm: omap4panda: Add support for omap4iss =
camera
>>
>> This adds support for camera interface with the support for
>> following sensors:
>>
>> - OV5640
>> - OV5650
>>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 27 ++++
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +
>> =A0arch/arm/mach-omap2/board-omap4panda-camera.c | =A0198
>> +++++++++++++++++++++++++
>> =A03 files changed, 226 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/board-omap4panda-camera.c
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconf=
ig
>> index f883abb..0fc5ce9 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -358,6 +358,33 @@ config MACH_OMAP4_PANDA
>> =A0 =A0 =A0 select OMAP_PACKAGE_CBS
>> =A0 =A0 =A0 select REGULATOR_FIXED_VOLTAGE
>>
>> +config MACH_OMAP4_PANDA_CAMERA_SUPPORT
>> + =A0 =A0 bool "OMAP4 Panda Board Camera support"
>> + =A0 =A0 depends on MACH_OMAP4_PANDA
>> + =A0 =A0 select MEDIA_SUPPORT
>> + =A0 =A0 select MEDIA_CONTROLLER
>> + =A0 =A0 select VIDEO_DEV
>> + =A0 =A0 select VIDEO_V4L2_SUBDEV_API
>> + =A0 =A0 select VIDEO_OMAP4
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Enable Camera HW support for PandaBoard.
>> + =A0 =A0 =A0 This is for using the OMAP4 ISS CSI2A Camera sensor
>> + =A0 =A0 =A0 interface.
>> +
>> +choice
>> + =A0 =A0 prompt "Camera sensor to use"
>> + =A0 =A0 depends on MACH_OMAP4_PANDA_CAMERA_SUPPORT
>> + =A0 =A0 default MACH_OMAP4_PANDA_CAM_OV5650
>> +
>> + =A0 =A0 config MACH_OMAP4_PANDA_CAM_OV5640
>> + =A0 =A0 =A0 =A0 =A0 =A0 bool "Use OmniVision OV5640 Camera"
>> + =A0 =A0 =A0 =A0 =A0 =A0 select VIDEO_OV5640
>> +
>> + =A0 =A0 config MACH_OMAP4_PANDA_CAM_OV5650
>> + =A0 =A0 =A0 =A0 =A0 =A0 bool "Use OmniVision OV5650 Camera"
>> + =A0 =A0 =A0 =A0 =A0 =A0 select VIDEO_OV5650
>> +endchoice
>> +
>> =A0config OMAP3_EMU
>> =A0 =A0 =A0 bool "OMAP3 debugging peripherals"
>> =A0 =A0 =A0 depends on ARCH_OMAP3
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 8bc446a..e80724d 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -236,6 +236,7 @@ obj-$(CONFIG_MACH_TI8168EVM) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0+=3D board-
>> ti8168evm.o
>> =A0# Platform specific device init code
>>
>> =A0obj-$(CONFIG_MACH_OMAP_4430SDP_CAMERA_SUPPORT) =A0 =A0 =A0 +=3D b=
oard-4430sdp-camera.o
>> +obj-$(CONFIG_MACH_OMAP4_PANDA_CAMERA_SUPPORT) =A0 =A0 =A0 =A0+=3D b=
oard-omap4panda-
>> camera.o
>>
> Can't this be merged into single file? Do we really need separate fil=
e for every board here?
>
> I am sure you would have thought about this.

:)

Well, not really, to be honest.

I could have a single file, but wouldn't that make it more complex?

I mean, every board has it's own HW connection specs, like sensor MCLK =
source,
and different power up sequences. How would you probe for all, without =
messing
with an invalid GPIO on that board?

Have you resolved a similar case for other OMAP/Davinci boards?

>
>> =A0omap-flash-$(CONFIG_MTD_NAND_OMAP2) =A0:=3D board-flash.o
>> =A0omap-flash-$(CONFIG_MTD_ONENAND_OMAP2) =A0 =A0 =A0 :=3D board-fla=
sh.o
>> diff --git a/arch/arm/mach-omap2/board-omap4panda-camera.c
>> b/arch/arm/mach-omap2/board-omap4panda-camera.c
>> new file mode 100644
>> index 0000000..02ef36e
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-omap4panda-camera.c
>> @@ -0,0 +1,198 @@
>> +#include <linux/gpio.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +
>> +#include <plat/i2c.h>
>> +#include <plat/omap-pm.h>
>> +
>> +#include <asm/mach-types.h>
>> +
>> +#include <media/ov5640.h>
>> +#include <media/ov5650.h>
>> +
>> +#include "devices.h"
>> +#include "../../../drivers/media/video/omap4iss/iss.h"
>> +
> I believe this is not good practice to include files directly from dr=
ivers folder. You should divide the header file such that, driver speci=
fic information stays in driver/... and platform specific goes into inc=
lude/...

Right. Will fix.

>
>> +#include "control.h"
>> +#include "mux.h"
>> +
>> +#define PANDA_GPIO_CAM_PWRDN =A0 =A0 =A0 =A0 45
>> +#define PANDA_GPIO_CAM_RESET =A0 =A0 =A0 =A0 83
>> +
>> +static struct clk *panda_cam_aux_clk;
>> +
>> +static int panda_ov5640_power(struct v4l2_subdev *subdev, int on)
>> +{
>> + =A0 =A0 struct iss_device *iss =3D v4l2_dev_to_iss_device(subdev->=
v4l2_dev);
>> + =A0 =A0 int ret =3D 0;
> You are not using this variable at all, you can get rid of this.

Right. Will fix.

>
>> + =A0 =A0 struct iss_csiphy_dphy_cfg dphy;
>> + =A0 =A0 struct iss_csiphy_lanes_cfg lanes;
>> + =A0 =A0 unsigned int ddr_freq =3D 480; /* FIXME: Do an actual quer=
y for this
>> */
>> +
>> + =A0 =A0 memset(&lanes, 0, sizeof(lanes));
>> + =A0 =A0 memset(&dphy, 0, sizeof(dphy));
>> +
>> + =A0 =A0 lanes.clk.pos =3D 1;
>> + =A0 =A0 lanes.clk.pol =3D 0;
>> + =A0 =A0 lanes.data[0].pos =3D 2;
>> + =A0 =A0 lanes.data[0].pol =3D 0;
>> + =A0 =A0 lanes.data[1].pos =3D 3;
>> + =A0 =A0 lanes.data[1].pol =3D 0;
>> +
>> + =A0 =A0 dphy.ths_term =3D ((((12500 * ddr_freq + 1000000) / 100000=
0) - 1) &
>> 0xFF);
>> + =A0 =A0 dphy.ths_settle =3D ((((90000 * ddr_freq + 1000000) / 1000=
000) + 3) &
>> 0xFF);
>> + =A0 =A0 dphy.tclk_term =3D 0;
>> + =A0 =A0 dphy.tclk_miss =3D 1;
>> + =A0 =A0 dphy.tclk_settle =3D 14;
>> +
>> + =A0 =A0 if (on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(PANDA_GPIO_CAM_PWRDN, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(panda_cam_aux_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mdelay(2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss->platform_cb.csiphy_config(&iss->csiph=
y1, &dphy, &lanes);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(panda_cam_aux_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(PANDA_GPIO_CAM_PWRDN, 1);
>> + =A0 =A0 }
> You may want to check return values for above API's.

Ok. Will fix.

>
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +#define OV5640_I2C_ADDRESS =A0 (0x3C)
>> +#define OV5650_I2C_ADDRESS =A0 (0x36)
>> +
>> +#ifdef CONFIG_MACH_OMAP4_PANDA_CAM_OV5650
>> +static struct ov5650_platform_data ov_platform_data =3D {
>> +#elif defined(CONFIG_MACH_OMAP4_PANDA_CAM_OV5640)
>> +static struct ov5640_platform_data ov_platform_data =3D {
>> +#endif
>> + =A0 =A0 =A0.s_power =3D panda_ov5640_power,
>> +};
>> +
>> +static struct i2c_board_info ov_camera_i2c_device =3D {
>> +#ifdef CONFIG_MACH_OMAP4_PANDA_CAM_OV5650
>> + =A0 =A0 I2C_BOARD_INFO("ov5650", OV5650_I2C_ADDRESS),
>> +#elif defined(CONFIG_MACH_OMAP4_PANDA_CAM_OV5640)
>> + =A0 =A0 I2C_BOARD_INFO("ov5640", OV5640_I2C_ADDRESS),
>> +#endif
>> + =A0 =A0 .platform_data =3D &ov_platform_data,
>> +};
>> +
> I may be wrong, but don't you think, we can clean all this #ifdefs he=
re.
> The drivers will get connected cleanly without any issues based on pr=
obing and ID (i2c_device_id defined in driver).

Will think about it.

Thanks again!

Regards,
Sergio

>
> Thanks,
> Vaibhav
>
>> +static struct iss_subdev_i2c_board_info ov_camera_subdevs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .board_info =3D &ov_camera_i2c_device,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .i2c_adapter_id =3D 3,
>> + =A0 =A0 },
>> + =A0 =A0 { NULL, 0, },
>> +};
>> +
>> +static struct iss_v4l2_subdevs_group panda_camera_subdevs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .subdevs =3D ov_camera_subdevs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .interface =3D ISS_INTERFACE_CSI2A_PHY1,
>> + =A0 =A0 },
>> + =A0 =A0 { },
>> +};
>> +
>> +static void panda_omap4iss_set_constraints(struct iss_device *iss, =
bool
>> enable)
>> +{
>> + =A0 =A0 if (!iss)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /* FIXME: Look for something more precise as a good throug=
htput
>> limit */
>> + =A0 =A0 omap_pm_set_min_bus_tput(iss->dev, OCP_INITIATOR_AGENT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable =
? 800000 : -1);
>> +}
>> +
>> +static struct iss_platform_data panda_iss_platform_data =3D {
>> + =A0 =A0 .subdevs =3D panda_camera_subdevs,
>> + =A0 =A0 .set_constraints =3D panda_omap4iss_set_constraints,
>> +};
>> +
>> +
>> +static struct omap_device_pad omap4iss_pads[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "csi21_dx0.csi21_dx0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_MUX_MODE0 | OMAP_INPUT_EN=
,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "csi21_dy0.csi21_dy0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_MUX_MODE0 | OMAP_INPUT_EN=
,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "csi21_dx1.csi21_dx1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_MUX_MODE0 | OMAP_INPUT_EN=
,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "csi21_dy1.csi21_dy1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_MUX_MODE0 | OMAP_INPUT_EN=
,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "csi21_dx2.csi21_dx2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_MUX_MODE0 | OMAP_INPUT_EN=
,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "csi21_dy2.csi21_dy2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_MUX_MODE0 | OMAP_INPUT_EN=
,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_board_data omap4iss_data =3D {
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
>> + =A0 =A0 .pads =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D omap4iss_pad=
s,
>> + =A0 =A0 .pads_cnt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D ARRAY_SIZE(omap4=
iss_pads),
>> +};
>> +
>> +static int __init panda_camera_init(void)
>> +{
>> + =A0 =A0 if (!machine_is_omap4_panda())
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 panda_cam_aux_clk =3D clk_get(NULL, "auxclk1_ck");
>> + =A0 =A0 if (IS_ERR(panda_cam_aux_clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to get auxclk1_ck\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (clk_set_rate(panda_cam_aux_clk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_round_rate(panda_cam_a=
ux_clk, 24000000)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* CSI2 1(A):
>> + =A0 =A0 =A0* =A0 LANEENABLE[4:0] =3D 00111(0x7) - Lanes 0, 1 & 2 e=
nabled
>> + =A0 =A0 =A0* =A0 CTRLCLKEN =3D 1 - Active high enable for CTRLCLK
>> + =A0 =A0 =A0* =A0 CAMMODE =3D 0 - DPHY mode
>> + =A0 =A0 =A0*/
>> + =A0 =A0 omap4_ctrl_pad_writel((omap4_ctrl_pad_readl(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_CTRL=
_MODULE_PAD_CORE_CONTROL_CAMERA_RX) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(OMAP4_CAMERARX_CSI21=
_LANEENABLE_MASK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_CAMERARX_CSI=
21_CAMMODE_MASK)) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7 << OMAP4_CAMERARX_=
CSI21_LANEENABLE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_CAMERARX_CSI21_CT=
RLCLKEN_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_CTRL_MODULE_PAD_C=
ORE_CONTROL_CAMERA_RX);
>> +
>> + =A0 =A0 /* Select GPIO 45 */
>> + =A0 =A0 omap_mux_init_gpio(PANDA_GPIO_CAM_PWRDN, OMAP_PIN_OUTPUT);
>> +
>> + =A0 =A0 /* Select GPIO 83 */
>> + =A0 =A0 omap_mux_init_gpio(PANDA_GPIO_CAM_RESET, OMAP_PIN_OUTPUT);
>> +
>> + =A0 =A0 /* Init FREF_CLK1_OUT */
>> + =A0 =A0 omap_mux_init_signal("fref_clk1_out", OMAP_PIN_OUTPUT);
>> +
>> + =A0 =A0 if (gpio_request_one(PANDA_GPIO_CAM_PWRDN, GPIOF_OUT_INIT_=
HIGH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"CAM_PWRDN"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "Cannot request GPIO %=
d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PANDA_GPIO_CAM_PWRDN);
>> +
>> + =A0 =A0 if (gpio_request_one(PANDA_GPIO_CAM_RESET, GPIOF_OUT_INIT_=
HIGH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"CAM_RESET"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "Cannot request GPIO %=
d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PANDA_GPIO_CAM_RESET);
>> +
>> + =A0 =A0 omap4_init_camera(&panda_iss_platform_data, &omap4iss_data=
);
>> + =A0 =A0 return 0;
>> +}
>> +late_initcall(panda_camera_init);
>> --
>> 1.7.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
