From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v3 00/10] v4l2: OMAP4 ISS driver + Sensor + Board support
Date: Wed, 2 May 2012 10:32:01 -0500
Message-ID: <CAKnK67TMqN4M3ppSemO0Wm8fpeh+FgNAaGUVbzagpqAxXCXbbw@mail.gmail.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:59472 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754574Ab2EBPc0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 11:32:26 -0400
Received: by qcsq13 with SMTP id q13so565027qcs.31
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 08:32:22 -0700 (PDT)
In-Reply-To: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

On Wed, May 2, 2012 at 10:15 AM, Sergio Aguirre <saaguirre@ti.com> wrot=
e:
> Hi everyone,
>
> It's been a long time since last version (5 months)! :)
>
> This is the third version of the OMAP4 ISS driver,
> which uses Media Controller and videobuf2 frameworks.
>
> This patchset should apply cleanly on top of v3.4-rc5 kernel tag.
>
> This driver attempts to provide an fully open source solution to
> control the OMAP4 Imaging SubSystem (a.k.a. ISS).
>
> Starts with just CSI2-A/B interface support, and pretends to be
> ready for expansion to add support to the many ISS block modules
> as possible.
>
> Please see newly added documentation for more details:
>
> Documentation/video4linux/omap4_camera.txt
>
> Any comments/complaints are welcome. :)

Apologies, forgot to mention this:

Tested with these patchsets:
- Sakari's patches for N9 and some v4l2 changes:
http://www.spinics.net/lists/linux-media/msg45052.html
- CMA v24: http://www.spinics.net/lists/linux-media/msg46106.html

Both rebased to v3.4-rc5.

Regards,
Sergio

>
> Changes since v2:
> - Supports CSI2B now!
> - Add support for RAW8.
> - Usage of V4L2_CID_PIXEL_RATE, instead of dphy configuration in boar=
dfile
> =A0(similar to omap3isp)
> - Removes save/restore support for now, as it is broken.
> - Attend several comments form Sakari Ailus (Thanks Sakari!)
> - Populate hw_revision in media_dev struct.
> - Ported several fixes pushed for omap3isp (Thanks Laurent!)
> - Use module_platform_driver.
> - Use proposed generic v4l2_subdev_link_validate.
> - Move OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_CAMERA_RX handle to omap4is=
s code,
> =A0instead of board file.
>
> Changes since v1:
> - Simplification of auxclk handlign in board files
> - Use of HWMOD declaration for assisted platform_device creation.
> - Videobuf2 migration (Removal of custom iss_queue buffer handling dr=
iver)
>
> Regards,
> Sergio
>
> Sergio Aguirre (10):
> =A0mfd: twl6040: Fix wrong TWL6040_GPO3 bitfield value
> =A0OMAP4: hwmod: Include CSI2A/B and CSIPHY1/2 memory sections
> =A0OMAP4: Add base addresses for ISS
> =A0v4l: Add support for omap4iss driver
> =A0v4l: Add support for ov5640 sensor
> =A0v4l: Add support for ov5650 sensor
> =A0arm: omap4430sdp: Add support for omap4iss camera
> =A0arm: omap4panda: Add support for omap4iss camera
> =A0omap2plus: Add support for omap4iss camera
> =A0arm: Add support for CMA for omap4iss driver
>
> =A0Documentation/video4linux/omap4_camera.txt =A0 =A0| =A0 64 ++
> =A0arch/arm/configs/omap2plus_defconfig =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +
> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 32 +
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 +
> =A0arch/arm/mach-omap2/board-4430sdp-camera.c =A0 =A0| =A0415 +++++++=
+
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0 | =A0 20 +
> =A0arch/arm/mach-omap2/board-omap4panda-camera.c | =A0209 ++++
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 40 +
> =A0arch/arm/mach-omap2/devices.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A04 +
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c =A0 =A0| =A0 22 +-
> =A0drivers/media/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 25 +
> =A0drivers/media/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 +
> =A0drivers/media/video/omap4iss/Makefile =A0 =A0 =A0 =A0 | =A0 =A06 +
> =A0drivers/media/video/omap4iss/iss.c =A0 =A0 =A0 =A0 =A0 =A0| 1159 +=
++++++++++++++++++++
> =A0drivers/media/video/omap4iss/iss.h =A0 =A0 =A0 =A0 =A0 =A0| =A0121=
 +++
> =A0drivers/media/video/omap4iss/iss_csi2.c =A0 =A0 =A0 | 1368 +++++++=
++++++++++++++++++
> =A0drivers/media/video/omap4iss/iss_csi2.h =A0 =A0 =A0 | =A0155 +++
> =A0drivers/media/video/omap4iss/iss_csiphy.c =A0 =A0 | =A0281 +++++
> =A0drivers/media/video/omap4iss/iss_csiphy.h =A0 =A0 | =A0 51 +
> =A0drivers/media/video/omap4iss/iss_regs.h =A0 =A0 =A0 | =A0244 +++++
> =A0drivers/media/video/omap4iss/iss_video.c =A0 =A0 =A0| 1123 +++++++=
+++++++++++++
> =A0drivers/media/video/omap4iss/iss_video.h =A0 =A0 =A0| =A0201 ++++
> =A0drivers/media/video/ov5640.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0948 +++++++++++++++++
> =A0drivers/media/video/ov5650.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0733 +++++++++++++
> =A0include/linux/mfd/twl6040.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
> =A0include/media/omap4iss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 65 ++
> =A0include/media/ov5640.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 10 +
> =A0include/media/ov5650.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 10 +
> =A028 files changed, 7314 insertions(+), 2 deletions(-)
> =A0create mode 100644 Documentation/video4linux/omap4_camera.txt
> =A0create mode 100644 arch/arm/mach-omap2/board-4430sdp-camera.c
> =A0create mode 100644 arch/arm/mach-omap2/board-omap4panda-camera.c
> =A0create mode 100644 drivers/media/video/omap4iss/Makefile
> =A0create mode 100644 drivers/media/video/omap4iss/iss.c
> =A0create mode 100644 drivers/media/video/omap4iss/iss.h
> =A0create mode 100644 drivers/media/video/omap4iss/iss_csi2.c
> =A0create mode 100644 drivers/media/video/omap4iss/iss_csi2.h
> =A0create mode 100644 drivers/media/video/omap4iss/iss_csiphy.c
> =A0create mode 100644 drivers/media/video/omap4iss/iss_csiphy.h
> =A0create mode 100644 drivers/media/video/omap4iss/iss_regs.h
> =A0create mode 100644 drivers/media/video/omap4iss/iss_video.c
> =A0create mode 100644 drivers/media/video/omap4iss/iss_video.h
> =A0create mode 100644 drivers/media/video/ov5640.c
> =A0create mode 100644 drivers/media/video/ov5650.c
> =A0create mode 100644 include/media/omap4iss.h
> =A0create mode 100644 include/media/ov5640.h
> =A0create mode 100644 include/media/ov5650.h
>
> --
> 1.7.5.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
