From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v3 05/10] v4l: Add support for ov5640 sensor
Date: Mon, 7 May 2012 09:34:05 -0500
Message-ID: <CAKnK67Q8d01toa83eB7AeyW4TSMvygHukeEbDEUMECuV+ycbag@mail.gmail.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
 <1335971749-21258-6-git-send-email-saaguirre@ti.com> <CAGGh5h1P0F2skcMTZa_RFnZhhVuER+wkiSw6iT6HwWyQGaPg=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56348 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756326Ab2EGOe1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 10:34:27 -0400
Received: by qcsd16 with SMTP id d16so3396768qcs.28
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 07:34:26 -0700 (PDT)
In-Reply-To: <CAGGh5h1P0F2skcMTZa_RFnZhhVuER+wkiSw6iT6HwWyQGaPg=A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org

Hi Jean-Philippe,

On Mon, May 7, 2012 at 2:27 AM, jean-philippe francois
<jp.francois@cynove.com> wrote:
> 2012/5/2 Sergio Aguirre <saaguirre@ti.com>:
>> This adds a very limited driver for ov5640, which
>> only supports:
>> =A0- 2592x1944 @ ~7.5 fps
>> =A0- 1920x1080 @ ~15 fps,
>> =A0- 1280x720 @ ~24 fps,
>> =A0- 640x480 @ ~24 fps,
>> =A0- 320x240 @ ~24 fps,
>>
>> All in YUV422i format, using 1 CSI2 datalane @ 333 MHz.
>>
>
> There is already a limited driver in mainline for ov5642.
> How does the 5642 differ from 5640 ?

Well, it has several differences, see:

- OV5640 product brief:
http://www.ovt.com/download_document.php?type=3Dsensor&sensorid=3D93
- OV5642 product brief:
http://www.ovt.com/download_document.php?type=3Dsensor&sensorid=3D65

Some of the most notable differences are:
- OV5642 has a MIPI input, for using OV ISP with an external sensor.
- OV5640 has JPEG compression, OV5642 apparently not...
- OV5640 supports anti-shake, OV5640 apparently not...

> Can a single driver handle both chip ?

Maybe, yeah..

Now, for the OV5640 differences above, I'm not enabling much nice
features so far,
so it might be worth a try to attempt the ov5642 driver on my OV5640
as-is, to see
if we can expand it to support both.

I'll also see if I can reach people at OmniVision to consult
feasibility of register settings
sharing.

Regards,
Sergio

>
>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> ---
>> =A0drivers/media/video/Kconfig =A0| =A0 =A06 +
>> =A0drivers/media/video/Makefile | =A0 =A01 +
>> =A0drivers/media/video/ov5640.c | =A0948 +++++++++++++++++++++++++++=
+++++++++++++++
>> =A0include/media/ov5640.h =A0 =A0 =A0 | =A0 10 +
>> =A04 files changed, 965 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/media/video/ov5640.c
>> =A0create mode 100644 include/media/ov5640.h
>>
>> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconf=
ig
>> index 4482ac4..cc76652 100644
>> --- a/drivers/media/video/Kconfig
>> +++ b/drivers/media/video/Kconfig
>> @@ -480,6 +480,12 @@ config VIDEO_OV7670
>> =A0 =A0 =A0 =A0 =A0OV7670 VGA camera. =A0It currently only works wit=
h the M88ALP01
>> =A0 =A0 =A0 =A0 =A0controller.
>>
>> +config VIDEO_OV5640
>> + =A0 =A0 =A0 tristate "OmniVision OV5640 sensor support"
>> + =A0 =A0 =A0 depends on I2C && VIDEO_V4L2
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This is a ov5640 camera driver
>> +
>> =A0config VIDEO_VS6624
>> =A0 =A0 =A0 =A0tristate "ST VS6624 sensor support"
>> =A0 =A0 =A0 =A0depends on VIDEO_V4L2 && I2C
>> diff --git a/drivers/media/video/Makefile b/drivers/media/video/Make=
file
>> index c95cc0d..da40ab3 100644
>> --- a/drivers/media/video/Makefile
>> +++ b/drivers/media/video/Makefile
>> @@ -68,6 +68,7 @@ obj-$(CONFIG_VIDEO_CX25840) +=3D cx25840/
>> =A0obj-$(CONFIG_VIDEO_UPD64031A) +=3D upd64031a.o
>> =A0obj-$(CONFIG_VIDEO_UPD64083) +=3D upd64083.o
>> =A0obj-$(CONFIG_VIDEO_OV7670) =A0 =A0 +=3D ov7670.o
>> +obj-$(CONFIG_VIDEO_OV5640) =A0 =A0 +=3D ov5640.o
>> =A0obj-$(CONFIG_VIDEO_TCM825X) +=3D tcm825x.o
>> =A0obj-$(CONFIG_VIDEO_TVEEPROM) +=3D tveeprom.o
>> =A0obj-$(CONFIG_VIDEO_MT9M032) +=3D mt9m032.o
>> diff --git a/drivers/media/video/ov5640.c b/drivers/media/video/ov56=
40.c
>> new file mode 100644
>> index 0000000..2a64d50
>> --- /dev/null
>> +++ b/drivers/media/video/ov5640.c
>> @@ -0,0 +1,948 @@
>> +/*
>> + * OmniVision OV5640 sensor driver
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.t=
i.com/
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warra=
nty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/videodev2.h>
>> +#include <linux/slab.h>
>> +#include <linux/i2c.h>
>> +#include <linux/log2.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-subdev.h>
>> +#include <media/v4l2-ctrls.h>
>> +
>> +#include <media/ov5640.h>
>> +
>> +/* OV5640 has only one fixed colorspace per pixelcode */
>> +struct ov5640_datafmt {
>> + =A0 =A0 =A0 enum v4l2_mbus_pixelcode =A0 =A0 =A0 =A0code;
>> + =A0 =A0 =A0 enum v4l2_colorspace =A0 =A0 =A0 =A0 =A0 =A0colorspace=
;
>> +};
>> +
>> +struct ov5640_timing_cfg {
>> + =A0 =A0 =A0 u16 x_addr_start;
>> + =A0 =A0 =A0 u16 y_addr_start;
>> + =A0 =A0 =A0 u16 x_addr_end;
>> + =A0 =A0 =A0 u16 y_addr_end;
>> + =A0 =A0 =A0 u16 h_output_size;
>> + =A0 =A0 =A0 u16 v_output_size;
>> + =A0 =A0 =A0 u16 h_total_size;
>> + =A0 =A0 =A0 u16 v_total_size;
>> + =A0 =A0 =A0 u16 isp_h_offset;
>> + =A0 =A0 =A0 u16 isp_v_offset;
>> + =A0 =A0 =A0 u8 h_odd_ss_inc;
>> + =A0 =A0 =A0 u8 h_even_ss_inc;
>> + =A0 =A0 =A0 u8 v_odd_ss_inc;
>> + =A0 =A0 =A0 u8 v_even_ss_inc;
>> +};
>> +
>> +enum ov5640_size {
>> + =A0 =A0 =A0 OV5640_SIZE_QVGA,
>> + =A0 =A0 =A0 OV5640_SIZE_VGA,
>> + =A0 =A0 =A0 OV5640_SIZE_720P,
>> + =A0 =A0 =A0 OV5640_SIZE_1080P,
>> + =A0 =A0 =A0 OV5640_SIZE_5MP,
>> + =A0 =A0 =A0 OV5640_SIZE_LAST,
>> +};
>> +
>> +static const struct v4l2_frmsize_discrete ov5640_frmsizes[OV5640_SI=
ZE_LAST] =3D {
>> + =A0 =A0 =A0 { =A0320, =A0240 },
>> + =A0 =A0 =A0 { =A0640, =A0480 },
>> + =A0 =A0 =A0 { 1280, =A0720 },
>> + =A0 =A0 =A0 { 1920, 1080 },
>> + =A0 =A0 =A0 { 2592, 1944 },
>> +};
>> +
>> +/* Find a frame size in an array */
>> +static int ov5640_find_framesize(u32 width, u32 height)
>> +{
>> + =A0 =A0 =A0 int i;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < OV5640_SIZE_LAST; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ov5640_frmsizes[i].width >=3D wid=
th) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ov5640_frmsizes[i].height >=3D=
 height))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* If not found, select biggest */
>> + =A0 =A0 =A0 if (i >=3D OV5640_SIZE_LAST)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D OV5640_SIZE_LAST - 1;
>> +
>> + =A0 =A0 =A0 return i;
>> +}
>> +
>> +struct ov5640 {
>> + =A0 =A0 =A0 struct v4l2_subdev subdev;
>> + =A0 =A0 =A0 struct media_pad pad;
>> + =A0 =A0 =A0 struct v4l2_mbus_framefmt format;
>> +
>> + =A0 =A0 =A0 struct v4l2_ctrl_handler ctrl_handler;
>> +
>> + =A0 =A0 =A0 const struct ov5640_platform_data *pdata;
>> +
>> + =A0 =A0 =A0 struct v4l2_ctrl *pixel_rate;
>> +};
>> +
>> +static inline struct ov5640 *to_ov5640(struct v4l2_subdev *sd)
>> +{
>> + =A0 =A0 =A0 return container_of(sd, struct ov5640, subdev);
>> +}
>> +
>> +/**
>> + * struct ov5640_reg - ov5640 register format
>> + * @reg: 16-bit offset to register
>> + * @val: 8/16/32-bit register value
>> + * @length: length of the register
>> + *
>> + * Define a structure for OV5640 register initialization values
>> + */
>> +struct ov5640_reg {
>> + =A0 =A0 =A0 u16 =A0 =A0 reg;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0val;
>> +};
>> +
>> +/* TODO: Divide this properly */
>> +static const struct ov5640_reg configscript_common1[] =3D {
>> + =A0 =A0 =A0 { 0x3103, 0x03 },
>> + =A0 =A0 =A0 { 0x3017, 0x00 },
>> + =A0 =A0 =A0 { 0x3018, 0x00 },
>> + =A0 =A0 =A0 { 0x3630, 0x2e },
>> + =A0 =A0 =A0 { 0x3632, 0xe2 },
>> + =A0 =A0 =A0 { 0x3633, 0x23 },
>> + =A0 =A0 =A0 { 0x3634, 0x44 },
>> + =A0 =A0 =A0 { 0x3621, 0xe0 },
>> + =A0 =A0 =A0 { 0x3704, 0xa0 },
>> + =A0 =A0 =A0 { 0x3703, 0x5a },
>> + =A0 =A0 =A0 { 0x3715, 0x78 },
>> + =A0 =A0 =A0 { 0x3717, 0x01 },
>> + =A0 =A0 =A0 { 0x370b, 0x60 },
>> + =A0 =A0 =A0 { 0x3705, 0x1a },
>> + =A0 =A0 =A0 { 0x3905, 0x02 },
>> + =A0 =A0 =A0 { 0x3906, 0x10 },
>> + =A0 =A0 =A0 { 0x3901, 0x0a },
>> + =A0 =A0 =A0 { 0x3731, 0x12 },
>> + =A0 =A0 =A0 { 0x3600, 0x04 },
>> + =A0 =A0 =A0 { 0x3601, 0x22 },
>> + =A0 =A0 =A0 { 0x471c, 0x50 },
>> + =A0 =A0 =A0 { 0x3002, 0x1c },
>> + =A0 =A0 =A0 { 0x3006, 0xc3 },
>> + =A0 =A0 =A0 { 0x300e, 0x05 },
>> + =A0 =A0 =A0 { 0x302e, 0x08 },
>> + =A0 =A0 =A0 { 0x3612, 0x4b },
>> + =A0 =A0 =A0 { 0x3618, 0x04 },
>> + =A0 =A0 =A0 { 0x3034, 0x18 },
>> + =A0 =A0 =A0 { 0x3035, 0x11 },
>> + =A0 =A0 =A0 { 0x3036, 0x54 },
>> + =A0 =A0 =A0 { 0x3037, 0x13 },
>> + =A0 =A0 =A0 { 0x3708, 0x21 },
>> + =A0 =A0 =A0 { 0x3709, 0x12 },
>> + =A0 =A0 =A0 { 0x370c, 0x00 },
>> +};
>> +
>> +/* TODO: Divide this properly */
>> +static const struct ov5640_reg configscript_common2[] =3D {
>> + =A0 =A0 =A0 { 0x3a02, 0x01 },
>> + =A0 =A0 =A0 { 0x3a03, 0xec },
>> + =A0 =A0 =A0 { 0x3a08, 0x01 },
>> + =A0 =A0 =A0 { 0x3a09, 0x27 },
>> + =A0 =A0 =A0 { 0x3a0a, 0x00 },
>> + =A0 =A0 =A0 { 0x3a0b, 0xf6 },
>> + =A0 =A0 =A0 { 0x3a0e, 0x06 },
>> + =A0 =A0 =A0 { 0x3a0d, 0x08 },
>> + =A0 =A0 =A0 { 0x3a14, 0x01 },
>> + =A0 =A0 =A0 { 0x3a15, 0xec },
>> + =A0 =A0 =A0 { 0x4001, 0x02 },
>> + =A0 =A0 =A0 { 0x4004, 0x06 },
>> + =A0 =A0 =A0 { 0x460b, 0x37 },
>> + =A0 =A0 =A0 { 0x4750, 0x00 },
>> + =A0 =A0 =A0 { 0x4751, 0x00 },
>> + =A0 =A0 =A0 { 0x4800, 0x24 },
>> + =A0 =A0 =A0 { 0x5a00, 0x08 },
>> + =A0 =A0 =A0 { 0x5a21, 0x00 },
>> + =A0 =A0 =A0 { 0x5a24, 0x00 },
>> + =A0 =A0 =A0 { 0x5000, 0x27 },
>> + =A0 =A0 =A0 { 0x5001, 0x87 },
>> + =A0 =A0 =A0 { 0x3820, 0x40 },
>> + =A0 =A0 =A0 { 0x3821, 0x06 },
>> + =A0 =A0 =A0 { 0x3824, 0x01 },
>> + =A0 =A0 =A0 { 0x5481, 0x08 },
>> + =A0 =A0 =A0 { 0x5482, 0x14 },
>> + =A0 =A0 =A0 { 0x5483, 0x28 },
>> + =A0 =A0 =A0 { 0x5484, 0x51 },
>> + =A0 =A0 =A0 { 0x5485, 0x65 },
>> + =A0 =A0 =A0 { 0x5486, 0x71 },
>> + =A0 =A0 =A0 { 0x5487, 0x7d },
>> + =A0 =A0 =A0 { 0x5488, 0x87 },
>> + =A0 =A0 =A0 { 0x5489, 0x91 },
>> + =A0 =A0 =A0 { 0x548a, 0x9a },
>> + =A0 =A0 =A0 { 0x548b, 0xaa },
>> + =A0 =A0 =A0 { 0x548c, 0xb8 },
>> + =A0 =A0 =A0 { 0x548d, 0xcd },
>> + =A0 =A0 =A0 { 0x548e, 0xdd },
>> + =A0 =A0 =A0 { 0x548f, 0xea },
>> + =A0 =A0 =A0 { 0x5490, 0x1d },
>> + =A0 =A0 =A0 { 0x5381, 0x20 },
>> + =A0 =A0 =A0 { 0x5382, 0x64 },
>> + =A0 =A0 =A0 { 0x5383, 0x08 },
>> + =A0 =A0 =A0 { 0x5384, 0x20 },
>> + =A0 =A0 =A0 { 0x5385, 0x80 },
>> + =A0 =A0 =A0 { 0x5386, 0xa0 },
>> + =A0 =A0 =A0 { 0x5387, 0xa2 },
>> + =A0 =A0 =A0 { 0x5388, 0xa0 },
>> + =A0 =A0 =A0 { 0x5389, 0x02 },
>> + =A0 =A0 =A0 { 0x538a, 0x01 },
>> + =A0 =A0 =A0 { 0x538b, 0x98 },
>> + =A0 =A0 =A0 { 0x5300, 0x08 },
>> + =A0 =A0 =A0 { 0x5301, 0x30 },
>> + =A0 =A0 =A0 { 0x5302, 0x10 },
>> + =A0 =A0 =A0 { 0x5303, 0x00 },
>> + =A0 =A0 =A0 { 0x5304, 0x08 },
>> + =A0 =A0 =A0 { 0x5305, 0x30 },
>> + =A0 =A0 =A0 { 0x5306, 0x08 },
>> + =A0 =A0 =A0 { 0x5307, 0x16 },
>> + =A0 =A0 =A0 { 0x5580, 0x00 },
>> + =A0 =A0 =A0 { 0x5587, 0x00 },
>> + =A0 =A0 =A0 { 0x5588, 0x00 },
>> + =A0 =A0 =A0 { 0x5583, 0x40 },
>> + =A0 =A0 =A0 { 0x5584, 0x10 },
>> + =A0 =A0 =A0 { 0x5589, 0x10 },
>> + =A0 =A0 =A0 { 0x558a, 0x00 },
>> + =A0 =A0 =A0 { 0x558b, 0xf8 },
>> + =A0 =A0 =A0 { 0x3a0f, 0x36 },
>> + =A0 =A0 =A0 { 0x3a10, 0x2e },
>> + =A0 =A0 =A0 { 0x3a1b, 0x38 },
>> + =A0 =A0 =A0 { 0x3a1e, 0x2c },
>> + =A0 =A0 =A0 { 0x3a11, 0x70 },
>> + =A0 =A0 =A0 { 0x3a1f, 0x18 },
>> + =A0 =A0 =A0 { 0x3a18, 0x00 },
>> + =A0 =A0 =A0 { 0x3a19, 0xf8 },
>> + =A0 =A0 =A0 { 0x3003, 0x03 },
>> + =A0 =A0 =A0 { 0x3003, 0x01 },
>> +};
>> +
>> +static const struct ov5640_timing_cfg timing_cfg[OV5640_SIZE_LAST] =
=3D {
>> + =A0 =A0 =A0 [OV5640_SIZE_QVGA] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_start =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_start =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_end =3D 2623,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_end =3D 1951,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_output_size =3D 320,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_output_size =3D 240,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_total_size =3D 2844,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_total_size =3D 1968,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_h_offset =3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_v_offset =3D 6,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 [OV5640_SIZE_VGA] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_start =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_start =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_end =3D 2623,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_end =3D 1951,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_output_size =3D 640,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_output_size =3D 480,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_total_size =3D 2844,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_total_size =3D 1968,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_h_offset =3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_v_offset =3D 6,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 [OV5640_SIZE_720P] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_start =3D 336,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_start =3D 434,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_end =3D 2287,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_end =3D 1522,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_output_size =3D 1280,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_output_size =3D 720,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_total_size =3D 2500,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_total_size =3D 1120,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_h_offset =3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_v_offset =3D 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 [OV5640_SIZE_1080P] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_start =3D 336,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_start =3D 434,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_end =3D 2287,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_end =3D 1522,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_output_size =3D 1920,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_output_size =3D 1080,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_total_size =3D 2500,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_total_size =3D 1120,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_h_offset =3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_v_offset =3D 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 [OV5640_SIZE_5MP] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_start =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_start =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_addr_end =3D 2623,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_addr_end =3D 1951,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_output_size =3D 2592,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_output_size =3D 1944,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_total_size =3D 2844,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_total_size =3D 1968,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_h_offset =3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .isp_v_offset =3D 6,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .h_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_odd_ss_inc =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .v_even_ss_inc =3D 1,
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/**
>> + * ov5640_reg_read - Read a value from a register in an ov5640 sens=
or device
>> + * @client: i2c driver client structure
>> + * @reg: register address / offset
>> + * @val: stores the value that gets read
>> + *
>> + * Read a value from a register in an ov5640 sensor device.
>> + * The value is returned in 'val'.
>> + * Returns zero if successful, or non-zero otherwise.
>> + */
>> +static int ov5640_reg_read(struct i2c_client *client, u16 reg, u8 *=
val)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 data[2] =3D {0};
>> + =A0 =A0 =A0 struct i2c_msg msg =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =A0 =3D client->addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =A0 =A0=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .buf =A0 =A0=3D data,
>> + =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 data[0] =3D (u8)(reg >> 8);
>> + =A0 =A0 =A0 data[1] =3D (u8)(reg & 0xff);
>> +
>> + =A0 =A0 =A0 ret =3D i2c_transfer(client->adapter, &msg, 1);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> +
>> + =A0 =A0 =A0 msg.flags =3D I2C_M_RD;
>> + =A0 =A0 =A0 msg.len =3D 1;
>> + =A0 =A0 =A0 ret =3D i2c_transfer(client->adapter, &msg, 1);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> +
>> + =A0 =A0 =A0 *val =3D data[0];
>> + =A0 =A0 =A0 return 0;
>> +
>> +err:
>> + =A0 =A0 =A0 dev_err(&client->dev, "Failed reading register 0x%02x!=
\n", reg);
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> + * Write a value to a register in ov5640 sensor device.
>> + * @client: i2c driver client structure.
>> + * @reg: Address of the register to read value from.
>> + * @val: Value to be written to a specific register.
>> + * Returns zero if successful, or non-zero otherwise.
>> + */
>> +static int ov5640_reg_write(struct i2c_client *client, u16 reg, u8 =
val)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 unsigned char data[3] =3D { (u8)(reg >> 8), (u8)(reg &=
 0xff), val };
>> + =A0 =A0 =A0 struct i2c_msg msg =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =A0 =3D client->addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =A0 =A0=3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .buf =A0 =A0=3D data,
>> + =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 ret =3D i2c_transfer(client->adapter, &msg, 1);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed writing =
register 0x%02x!\n", reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * Initialize a list of ov5640 registers.
>> + * The list of registers is terminated by the pair of values
>> + * @client: i2c driver client structure.
>> + * @reglist[]: List of address of the registers to write data.
>> + * Returns zero if successful, or non-zero otherwise.
>> + */
>> +static int ov5640_reg_writes(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struc=
t ov5640_reg reglist[],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int size)
>> +{
>> + =A0 =A0 =A0 int err =3D 0, i;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < size; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D ov5640_reg_write(client, regli=
st[i].reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reglis=
t[i].val);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int ov5640_reg_set(struct i2c_client *client, u16 reg, u8 va=
l)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 tmpval =3D 0;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_read(client, reg, &tmpval);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 return ov5640_reg_write(client, reg, tmpval | val);
>> +}
>> +
>> +static int ov5640_reg_clr(struct i2c_client *client, u16 reg, u8 va=
l)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 tmpval =3D 0;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_read(client, reg, &tmpval);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 return ov5640_reg_write(client, reg, tmpval & ~val);
>> +}
>> +
>> +static int ov5640_config_timing(struct v4l2_subdev *sd)
>> +{
>> + =A0 =A0 =A0 struct i2c_client *client =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 =A0 struct ov5640 *ov5640 =3D to_ov5640(sd);
>> + =A0 =A0 =A0 int ret, i;
>> +
>> + =A0 =A0 =A0 i =3D ov5640_find_framesize(ov5640->format.width, ov56=
40->format.height);
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].x_addr_=
start & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3801,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].x_addr_s=
tart & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3802,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].y_addr_=
start & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3803,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].y_addr_s=
tart & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3804,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].x_addr_=
end & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3805,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].x_addr_e=
nd & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3806,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].y_addr_=
end & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3807,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].y_addr_e=
nd & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3808,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].h_outpu=
t_size & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3809,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].h_output=
_size & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x380A,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].v_outpu=
t_size & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x380B,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].v_output=
_size & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x380C,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].h_total=
_size & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x380D,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].h_total_=
size & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x380E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].v_total=
_size & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x380F,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].v_total_=
size & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3810,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].isp_h_o=
ffset & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3811,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].isp_h_of=
fset & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3812,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].isp_v_o=
ffset & 0xFF00) >> 8);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3813,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_cfg[i].isp_v_of=
fset & 0xFF);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3814,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((timing_cfg[i].h_odd_=
ss_inc & 0xF) << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].h_even_=
ss_inc & 0xF));
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_write(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3815,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((timing_cfg[i].v_odd_=
ss_inc & 0xF) << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing_cfg[i].v_even_=
ss_inc & 0xF));
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static struct v4l2_mbus_framefmt *
>> +__ov5640_get_pad_format(struct ov5640 *ov5640, struct v4l2_subdev_f=
h *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int pad, e=
num v4l2_subdev_format_whence which)
>> +{
>> + =A0 =A0 =A0 switch (which) {
>> + =A0 =A0 =A0 case V4L2_SUBDEV_FORMAT_TRY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return v4l2_subdev_get_try_format(fh, =
pad);
>> + =A0 =A0 =A0 case V4L2_SUBDEV_FORMAT_ACTIVE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &ov5640->format;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 =A0 }
>> +}
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * V4L2 subdev internal operations
>> + */
>> +
>> +static int ov5640_s_power(struct v4l2_subdev *sd, int on)
>> +{
>> + =A0 =A0 =A0 struct ov5640 *ov5640 =3D to_ov5640(sd);
>> +
>> + =A0 =A0 =A0 return ov5640->pdata->s_power(sd, on);
>> +}
>> +
>> +static struct v4l2_subdev_core_ops ov5640_subdev_core_ops =3D {
>> + =A0 =A0 =A0 .s_power =A0 =A0 =A0 =A0=3D ov5640_s_power,
>> +};
>> +
>> +static int ov5640_g_fmt(struct v4l2_subdev *sd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev_fh =
*fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev_for=
mat *format)
>> +{
>> + =A0 =A0 =A0 struct ov5640 *ov5640 =3D to_ov5640(sd);
>> +
>> + =A0 =A0 =A0 format->format =3D *__ov5640_get_pad_format(ov5640, fh=
, format->pad,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0format->which);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int ov5640_s_fmt(struct v4l2_subdev *sd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev_fh =
*fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev_for=
mat *format)
>> +{
>> + =A0 =A0 =A0 struct ov5640 *ov5640 =3D to_ov5640(sd);
>> + =A0 =A0 =A0 struct v4l2_mbus_framefmt *__format;
>> +
>> + =A0 =A0 =A0 __format =3D __ov5640_get_pad_format(ov5640, fh, forma=
t->pad,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 format->which);
>> +
>> + =A0 =A0 =A0 *__format =3D format->format;
>> +
>> + =A0 =A0 =A0 /* NOTE: This is always true for now, revisit later. *=
/
>> + =A0 =A0 =A0 ov5640->pixel_rate->cur.val64 =3D 42000000;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int ov5640_enum_fmt(struct v4l2_subdev *subdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_sub=
dev_fh *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_sub=
dev_mbus_code_enum *code)
>> +{
>> + =A0 =A0 =A0 if (code->index >=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 switch (code->index) {
>> + =A0 =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 code->code =3D V4L2_MBUS_FMT_UYVY8_1X1=
6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 code->code =3D V4L2_MBUS_FMT_YUYV8_1X1=
6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int ov5640_enum_framesizes(struct v4l2_subdev *subdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct v4l2_subdev_fh *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct v4l2_subdev_frame_size_enum *fse)
>> +{
>> + =A0 =A0 =A0 if ((fse->index >=3D OV5640_SIZE_LAST) ||
>> + =A0 =A0 =A0 =A0 =A0 (fse->code !=3D V4L2_MBUS_FMT_UYVY8_1X16 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0fse->code !=3D V4L2_MBUS_FMT_YUYV8_1X16))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 fse->min_width =3D ov5640_frmsizes[fse->index].width;
>> + =A0 =A0 =A0 fse->max_width =3D fse->min_width;
>> + =A0 =A0 =A0 fse->min_height =3D ov5640_frmsizes[fse->index].height=
;
>> + =A0 =A0 =A0 fse->max_height =3D fse->min_height;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>> +{
>> + =A0 =A0 =A0 struct ov5640 *ov5640 =3D to_ov5640(sd);
>> + =A0 =A0 =A0 struct i2c_client *client =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 fmtreg =3D 0, fmtmuxreg =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch ((u32)ov5640->format.code) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case V4L2_MBUS_FMT_UYVY8_1X16:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmtreg =3D 0x32;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmtmuxreg =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case V4L2_MBUS_FMT_YUYV8_1X16:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmtreg =3D 0x30;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmtmuxreg =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This shouldn't happ=
en */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_write(client, 0x430=
0, fmtreg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_write(client, 0x501=
=46, fmtmuxreg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_config_timing(sd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D ov5640_find_framesize(ov5640->fo=
rmat.width, ov5640->format.height);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i =3D=3D OV5640_SIZE_QVGA) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (i =3D=3D OV5640_SIZE_VGA) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (i =3D=3D OV5640_SIZE_720P)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_wri=
te(client, 0x3108,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (i =3D=3D OV5640_SIZE_720P) ? 0x1 : 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_set=
(client, 0x5001, 0x20);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_clr=
(client, 0x5001, 0x20);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_wri=
te(client, 0x3108, 0x2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_clr(client, 0x3008,=
 0x40);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 tmpreg =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_read(client, 0x3008=
, &tmpreg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ov5640_reg_write(client, 0x300=
8, tmpreg | 0x40);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> +out:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static struct v4l2_subdev_video_ops ov5640_subdev_video_ops =3D {
>> + =A0 =A0 =A0 .s_stream =A0 =A0 =A0 =3D ov5640_s_stream,
>> +};
>> +
>> +static struct v4l2_subdev_pad_ops ov5640_subdev_pad_ops =3D {
>> + =A0 =A0 =A0 .enum_mbus_code =3D ov5640_enum_fmt,
>> + =A0 =A0 =A0 .enum_frame_size =3D ov5640_enum_framesizes,
>> + =A0 =A0 =A0 .get_fmt =3D ov5640_g_fmt,
>> + =A0 =A0 =A0 .set_fmt =3D ov5640_s_fmt,
>> +};
>> +
>> +static int ov5640_g_skip_frames(struct v4l2_subdev *sd, u32 *frames=
)
>> +{
>> + =A0 =A0 =A0 /* Quantity of initial bad frames to skip. Revisit. */
>> + =A0 =A0 =A0 *frames =3D 3;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static struct v4l2_subdev_sensor_ops ov5640_subdev_sensor_ops =3D {
>> + =A0 =A0 =A0 .g_skip_frames =A0=3D ov5640_g_skip_frames,
>> +};
>> +
>> +static struct v4l2_subdev_ops ov5640_subdev_ops =3D {
>> + =A0 =A0 =A0 .core =A0 =3D &ov5640_subdev_core_ops,
>> + =A0 =A0 =A0 .video =A0=3D &ov5640_subdev_video_ops,
>> + =A0 =A0 =A0 .pad =A0 =A0=3D &ov5640_subdev_pad_ops,
>> + =A0 =A0 =A0 .sensor =3D &ov5640_subdev_sensor_ops,
>> +};
>> +
>> +static int ov5640_registered(struct v4l2_subdev *subdev)
>> +{
>> + =A0 =A0 =A0 struct i2c_client *client =3D v4l2_get_subdevdata(subd=
ev);
>> + =A0 =A0 =A0 struct ov5640 *ov5640 =3D to_ov5640(subdev);
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 u8 revision =3D 0;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_s_power(subdev, 1);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "OV5640 power up=
 failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_read(client, 0x302A, &revision);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failure to dete=
ct OV5640 chip\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 revision &=3D 0xF;
>> +
>> + =A0 =A0 =A0 dev_info(&client->dev, "Detected a OV5640 chip, revisi=
on %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0revision);
>> +
>> + =A0 =A0 =A0 /* SW Reset */
>> + =A0 =A0 =A0 ret =3D ov5640_reg_set(client, 0x3008, 0x80);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 msleep(2);
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_clr(client, 0x3008, 0x80);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 /* SW Powerdown */
>> + =A0 =A0 =A0 ret =3D ov5640_reg_set(client, 0x3008, 0x40);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_writes(client, configscript_common1=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(configscrip=
t_common1));
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 ret =3D ov5640_reg_writes(client, configscript_common2=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(configscrip=
t_common2));
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 /* Init controls */
>> + =A0 =A0 =A0 ret =3D v4l2_ctrl_handler_init(&ov5640->ctrl_handler, =
1);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 ov5640->pixel_rate =3D v4l2_ctrl_new_std(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ov564=
0->ctrl_handler, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4L2_C=
ID_PIXEL_RATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, 0, =
1, 0);
>> +
>> + =A0 =A0 =A0 subdev->ctrl_handler =3D &ov5640->ctrl_handler;
>> +out:
>> + =A0 =A0 =A0 ov5640_s_power(subdev, 0);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int ov5640_open(struct v4l2_subdev *subdev, struct v4l2_subd=
ev_fh *fh)
>> +{
>> + =A0 =A0 =A0 struct v4l2_mbus_framefmt *format;
>> +
>> + =A0 =A0 =A0 format =3D v4l2_subdev_get_try_format(fh, 0);
>> + =A0 =A0 =A0 format->code =3D V4L2_MBUS_FMT_UYVY8_1X16;
>> + =A0 =A0 =A0 format->width =3D ov5640_frmsizes[OV5640_SIZE_VGA].wid=
th;
>> + =A0 =A0 =A0 format->height =3D ov5640_frmsizes[OV5640_SIZE_VGA].he=
ight;
>> + =A0 =A0 =A0 format->field =3D V4L2_FIELD_NONE;
>> + =A0 =A0 =A0 format->colorspace =3D V4L2_COLORSPACE_JPEG;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int ov5640_close(struct v4l2_subdev *subdev, struct v4l2_sub=
dev_fh *fh)
>> +{
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static struct v4l2_subdev_internal_ops ov5640_subdev_internal_ops =3D=
 {
>> + =A0 =A0 =A0 .registered =3D ov5640_registered,
>> + =A0 =A0 =A0 .open =3D ov5640_open,
>> + =A0 =A0 =A0 .close =3D ov5640_close,
>> +};
>> +
>> +static int ov5640_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct i2c_de=
vice_id *did)
>> +{
>> + =A0 =A0 =A0 struct ov5640 *ov5640;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 if (!client->dev.platform_data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "No platform dat=
a!!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ov5640 =3D kzalloc(sizeof(*ov5640), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!ov5640)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 ov5640->pdata =3D client->dev.platform_data;
>> +
>> + =A0 =A0 =A0 ov5640->format.code =3D V4L2_MBUS_FMT_UYVY8_1X16;
>> + =A0 =A0 =A0 ov5640->format.width =3D ov5640_frmsizes[OV5640_SIZE_V=
GA].width;
>> + =A0 =A0 =A0 ov5640->format.height =3D ov5640_frmsizes[OV5640_SIZE_=
VGA].height;
>> + =A0 =A0 =A0 ov5640->format.field =3D V4L2_FIELD_NONE;
>> + =A0 =A0 =A0 ov5640->format.colorspace =3D V4L2_COLORSPACE_JPEG;
>> +
>> + =A0 =A0 =A0 v4l2_i2c_subdev_init(&ov5640->subdev, client, &ov5640_=
subdev_ops);
>> + =A0 =A0 =A0 ov5640->subdev.internal_ops =3D &ov5640_subdev_interna=
l_ops;
>> + =A0 =A0 =A0 ov5640->subdev.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
>> + =A0 =A0 =A0 ov5640->subdev.entity.type =3D MEDIA_ENT_T_V4L2_SUBDEV=
_SENSOR;
>> +
>> + =A0 =A0 =A0 ov5640->pad.flags =3D MEDIA_PAD_FL_SOURCE;
>> + =A0 =A0 =A0 ret =3D media_entity_init(&ov5640->subdev.entity, 1, &=
ov5640->pad, 0);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_mediainit;
>> +
>> + =A0 =A0 =A0 return ret;
>> +
>> +err_mediainit:
>> + =A0 =A0 =A0 v4l2_device_unregister_subdev(&ov5640->subdev);
>> + =A0 =A0 =A0 kfree(ov5640);
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int ov5640_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 struct v4l2_subdev *subdev =3D i2c_get_clientdata(clie=
nt);
>> + =A0 =A0 =A0 struct ov5640 *ov5640 =3D to_ov5640(subdev);
>> +
>> + =A0 =A0 =A0 v4l2_ctrl_handler_free(&ov5640->ctrl_handler);
>> + =A0 =A0 =A0 v4l2_device_unregister_subdev(subdev);
>> + =A0 =A0 =A0 media_entity_cleanup(&subdev->entity);
>> + =A0 =A0 =A0 kfree(ov5640);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static const struct i2c_device_id ov5640_id[] =3D {
>> + =A0 =A0 =A0 { "ov5640", 0 },
>> + =A0 =A0 =A0 { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ov5640_id);
>> +
>> +static struct i2c_driver ov5640_i2c_driver =3D {
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "ov5640",
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D ov5640_probe,
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D ov5640_remove,
>> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D ov5640_id,
>> +};
>> +
>> +static int __init ov5640_mod_init(void)
>> +{
>> + =A0 =A0 =A0 return i2c_add_driver(&ov5640_i2c_driver);
>> +}
>> +
>> +static void __exit ov5640_mod_exit(void)
>> +{
>> + =A0 =A0 =A0 i2c_del_driver(&ov5640_i2c_driver);
>> +}
>> +
>> +module_init(ov5640_mod_init);
>> +module_exit(ov5640_mod_exit);
>> +
>> +MODULE_DESCRIPTION("OmniVision OV5640 Camera driver");
>> +MODULE_AUTHOR("Sergio Aguirre <saaguirre@ti.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/media/ov5640.h b/include/media/ov5640.h
>> new file mode 100644
>> index 0000000..65625ce
>> --- /dev/null
>> +++ b/include/media/ov5640.h
>> @@ -0,0 +1,10 @@
>> +#ifndef _MEDIA_OV5640_H
>> +#define _MEDIA_OV5640_H
>> +
>> +#include <media/v4l2-subdev.h>
>> +
>> +struct ov5640_platform_data {
>> + =A0 =A0 =A0int (*s_power)(struct v4l2_subdev *subdev, int on);
>> +};
>> +
>> +#endif
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-medi=
a" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
