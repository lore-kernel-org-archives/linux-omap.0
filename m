From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 00/11] v4l2: OMAP4 ISS driver + Sensor + Board support
Date: Thu, 1 Dec 2011 11:43:24 -0600
Message-ID: <CAKnK67TrNS3o8-qSfZh7HaXpMZc=KQrJ=sxyuBSFTXzWviY9SQ@mail.gmail.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com> <201112011826.51587.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40325 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330Ab1LARnq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 12:43:46 -0500
In-Reply-To: <201112011826.51587.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, sakari.ailus@iki.fi

Hi Laurent,

On Thu, Dec 1, 2011 at 11:26 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Sergio,
>
> On Thursday 01 December 2011 01:14:49 Sergio Aguirre wrote:
>> Hi everyone,
>>
>> This is the second version of the OMAP4 ISS driver,
>> now ported to the Media Controller framework AND supporting
>> videobuf2 framework.
>
> Thanks a lot for working on this.

And thanks to you for the patience and interest. I hope to make faster
updates from now on :)

>
>> This patchset should apply cleanly on top of v3.2-rc3 kernel tag.
>>
>> This driver attempts to provide an fully open source solution to
>> control the OMAP4 Imaging SubSystem (a.k.a. ISS).
>>
>> Starts with just CSI2-A interface support, and pretends to be
>> ready for expansion to add support to the many ISS block modules
>> as possible.
>>
>> Please see newly added documentation for more details:
>>
>> Documentation/video4linux/omap4_camera.txt
>>
>> Any comments/complaints are welcome. :)
>
> I've started reviewing the patches, but it might take some time as I =
got lots
> on my plate at the moment. I will concentrate on the ISS patch (06/11=
) first.
> The sensor drivers are needed now for testing purpose, but can get th=
eir share
> of love later.

Brilliant! That's fine with me.

Thanks for your time. I really appreciate it.

Regards,
Sergio

>
>> Changes since v1:
>> - Simplification of auxclk handling in board files. (Pointed out by:=
 Roger
>> Quadros) - Cleanup of Camera support enablement for 4430sdp & panda.
>> (Pointed out by: Roger Quadros) - Use of HWMOD declaration for assis=
ted
>> platform_device creation. (Pointed out by: Felipe Balbi) - Videobuf2
>> migration (Removal of custom iss_queue buffer handling driver) - Pro=
per
>> GPO3 handling for CAM_SEL in 4430sdp.
>>
>> Sergio Aguirre (10):
>> =A0 TWL6030: Add mapping for auxiliary regs
>> =A0 mfd: twl6040: Fix wrong TWL6040_GPO3 bitfield value
>> =A0 OMAP4: hwmod: Include CSI2A and CSIPHY1 memory sections
>> =A0 OMAP4: Add base addresses for ISS
>> =A0 v4l: Add support for omap4iss driver
>> =A0 v4l: Add support for ov5640 sensor
>> =A0 v4l: Add support for ov5650 sensor
>> =A0 arm: omap4430sdp: Add support for omap4iss camera
>> =A0 arm: omap4panda: Add support for omap4iss camera
>> =A0 arm: Add support for CMA for omap4iss driver
>>
>> Stanimir Varbanov (1):
>> =A0 v4l: Introduce sensor operation for getting interface configurat=
ion
>>
>> =A0Documentation/video4linux/omap4_camera.txt =A0 =A0| =A0 60 ++
>> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 54 +
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A03 +
>> =A0arch/arm/mach-omap2/board-4430sdp-camera.c =A0 =A0| =A0221 ++++
>> =A0arch/arm/mach-omap2/board-omap4panda-camera.c | =A0198 ++++
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 40 +
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c =A0 =A0| =A0 16 +-
>> =A0arch/arm/plat-omap/include/plat/omap4-iss.h =A0 | =A0 42 +
>> =A0arch/arm/plat-omap/include/plat/omap44xx.h =A0 =A0| =A0 =A09 +
>> =A0drivers/media/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 25 +
>> =A0drivers/media/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A03 +
>> =A0drivers/media/video/omap4iss/Makefile =A0 =A0 =A0 =A0 | =A0 =A06 =
+
>> =A0drivers/media/video/omap4iss/iss.c =A0 =A0 =A0 =A0 =A0 =A0| 1179
>> ++++++++++++++++++++++ drivers/media/video/omap4iss/iss.h =A0 =A0 =A0=
 =A0 =A0 =A0|
>> 133 +++
>> =A0drivers/media/video/omap4iss/iss_csi2.c =A0 =A0 =A0 | 1324
>> +++++++++++++++++++++++++ drivers/media/video/omap4iss/iss_csi2.h =A0=
 =A0 =A0 |
>> 166 +++
>> =A0drivers/media/video/omap4iss/iss_csiphy.c =A0 =A0 | =A0215 ++++
>> =A0drivers/media/video/omap4iss/iss_csiphy.h =A0 =A0 | =A0 69 ++
>> =A0drivers/media/video/omap4iss/iss_regs.h =A0 =A0 =A0 | =A0238 ++++=
+
>> =A0drivers/media/video/omap4iss/iss_video.c =A0 =A0 =A0| 1192
>> ++++++++++++++++++++++ drivers/media/video/omap4iss/iss_video.h =A0 =
=A0 =A0|
>> 205 ++++
>> =A0drivers/media/video/ov5640.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0972 ++++++++++++++++++
>> =A0drivers/media/video/ov5650.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0524 ++++++++++
>> =A0drivers/mfd/twl-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +-
>> =A0include/linux/mfd/twl6040.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A02 +-
>> =A0include/media/ov5640.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 10 +
>> =A0include/media/ov5650.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 10 +
>> =A0include/media/v4l2-chip-ident.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
>> =A0include/media/v4l2-subdev.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 42 +
>> =A029 files changed, 6957 insertions(+), 5 deletions(-)
>> =A0create mode 100644 Documentation/video4linux/omap4_camera.txt
>> =A0create mode 100644 arch/arm/mach-omap2/board-4430sdp-camera.c
>> =A0create mode 100644 arch/arm/mach-omap2/board-omap4panda-camera.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/omap4-iss.h
>> =A0create mode 100644 drivers/media/video/omap4iss/Makefile
>> =A0create mode 100644 drivers/media/video/omap4iss/iss.c
>> =A0create mode 100644 drivers/media/video/omap4iss/iss.h
>> =A0create mode 100644 drivers/media/video/omap4iss/iss_csi2.c
>> =A0create mode 100644 drivers/media/video/omap4iss/iss_csi2.h
>> =A0create mode 100644 drivers/media/video/omap4iss/iss_csiphy.c
>> =A0create mode 100644 drivers/media/video/omap4iss/iss_csiphy.h
>> =A0create mode 100644 drivers/media/video/omap4iss/iss_regs.h
>> =A0create mode 100644 drivers/media/video/omap4iss/iss_video.c
>> =A0create mode 100644 drivers/media/video/omap4iss/iss_video.h
>> =A0create mode 100644 drivers/media/video/ov5640.c
>> =A0create mode 100644 drivers/media/video/ov5650.c
>> =A0create mode 100644 include/media/ov5640.h
>> =A0create mode 100644 include/media/ov5650.h
>
> --
> Regards,
>
> Laurent Pinchart
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
