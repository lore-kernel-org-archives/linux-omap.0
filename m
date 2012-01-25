From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 06/11] v4l: Add support for omap4iss driver
Date: Wed, 25 Jan 2012 02:58:57 -0600
Message-ID: <CAKnK67SnZZ95JC6hzqv4saR8KXTayV4gkbGy4rJFq8qYCZ23sg@mail.gmail.com>
References: <1322698500-29924-7-git-send-email-saaguirre@ti.com> <20120114175111.GA11467@valkosipuli.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20120114175111.GA11467@valkosipuli.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org

Hi Sakari,

On Sat, Jan 14, 2012 at 11:51 AM, Sakari Ailus <sakari.ailus@iki.fi> wr=
ote:
> Hi Sergio,
>
> Thanks again for the patch! My previous review escaped me too fast. T=
he rest
> is here.

No problem. Thanks for reviewing such a long patch :)

>
> On Wed, Nov 30, 2011 at 06:14:55PM -0600, Sergio Aguirre wrote:
>> This adds a very simplistic driver to utilize the
>> CSI2A interface inside the ISS subsystem in OMAP4,
>> and dump the data to memory.
>>
>> Tested so far on omap4430sdp w/ ES2.1 GP & w/ ES2.2 EMU.
>>
>> Check newly added Documentation/video4linux/omap4_camera.txt
>> for details.
>>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> ---
>> =A0Documentation/video4linux/omap4_camera.txt =A0| =A0 60 ++
>> =A0arch/arm/plat-omap/include/plat/omap4-iss.h | =A0 42 +
>> =A0drivers/media/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 13 +
>> =A0drivers/media/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
>> =A0drivers/media/video/omap4iss/Makefile =A0 =A0 =A0 | =A0 =A06 +
>> =A0drivers/media/video/omap4iss/iss.c =A0 =A0 =A0 =A0 =A0| 1179 ++++=
++++++++++++++++++++
>> =A0drivers/media/video/omap4iss/iss.h =A0 =A0 =A0 =A0 =A0| =A0133 ++=
+
>> =A0drivers/media/video/omap4iss/iss_csi2.c =A0 =A0 | 1324 ++++++++++=
+++++++++++++++++
>> =A0drivers/media/video/omap4iss/iss_csi2.h =A0 =A0 | =A0166 ++++
>> =A0drivers/media/video/omap4iss/iss_csiphy.c =A0 | =A0215 +++++
>> =A0drivers/media/video/omap4iss/iss_csiphy.h =A0 | =A0 69 ++
>> =A0drivers/media/video/omap4iss/iss_regs.h =A0 =A0 | =A0238 +++++
>> =A0drivers/media/video/omap4iss/iss_video.c =A0 =A0| 1192 ++++++++++=
++++++++++++++
>> =A0drivers/media/video/omap4iss/iss_video.h =A0 =A0| =A0205 +++++
>> =A014 files changed, 4843 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/video4linux/omap4_camera.txt
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
>>
>> diff --git a/Documentation/video4linux/omap4_camera.txt b/Documentat=
ion/video4linux/omap4_camera.txt
>> new file mode 100644
>> index 0000000..a60c80f
>> --- /dev/null
>> +++ b/Documentation/video4linux/omap4_camera.txt
>> @@ -0,0 +1,60 @@
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4 I=
SS Driver
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Introduction
>> +------------
>> +
>> +The OMAP44XX family of chips contains the Imaging SubSystem (a.k.a.=
 ISS),
>> +Which contains several components that can be categorized in 3 big =
groups:
>> +
>> +- Interfaces (2 Interfaces: CSI2-A & CSI2-B/CCP2)
>> +- ISP (Image Signal Processor)
>> +- SIMCOP (Still Image Coprocessor)
>> +
>> +For more information, please look in [1] for latest version of:
>> + =A0 =A0 "OMAP4430 Multimedia Device Silicon Revision 2.x"
>> +
>> +As of Revision L, the ISS is described in detail in section 8.
>> +
>> +This driver is supporting _only_ the CSI2-A interface for now.
>> +
>> +It makes use of the Media Controller framework [2], and inherited m=
ost of the
>> +code from OMAP3 ISP driver (found under drivers/media/video/omap3is=
p/*), except
>> +that it doesn't need an IOMMU now for ISS buffers memory mapping.
>> +
>> +Supports usage of MMAP buffers only (for now).
>> +
>> +IMPORTANT: It is recommended to have this patchset:
>> + =A0Contiguous Memory Allocator (v15) [3].
>> +
>> +Tested platforms
>> +----------------
>> +
>> +- OMAP4430SDP, w/ ES2.1 GP & SEVM4430-CAM-V1-0 (Contains IMX060 & O=
V5640, in
>> + =A0which only the last one is supported, outputting YUV422 frames)=
=2E
>> +
>> +- PandaBoard, Rev. A2, w/ OMAP4430 ES2.1 GP & OV adapter board, tes=
ted with
>> + =A0following sensors:
>> + =A0* OV5640
>> + =A0* OV5650
>> +
>> +- Tested on mainline kernel:
>> +
>> + =A0 =A0 http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux=
-2.6.git;a=3Dsummary
>> +
>> + =A0Tag: v3.0 (commit 02f8c6aee8df3cdc935e9bdd4f2d020306035dbe)
>> +
>> +File list
>> +---------
>> +drivers/media/video/omap4iss/
>> +
>> +References
>> +----------
>> +
>> +[1] http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?na=
vigationId=3D12037&templateId=3D6123#62
>> +[2] http://lwn.net/Articles/420485/
>> +[3] http://lwn.net/Articles/455801/
>> +--
>> +Author: Sergio Aguirre <saaguirre@ti.com>
>> +Copyright (C) 2011, Texas Instruments
>> +
>> diff --git a/arch/arm/plat-omap/include/plat/omap4-iss.h b/arch/arm/=
plat-omap/include/plat/omap4-iss.h
>> new file mode 100644
>> index 0000000..3a1c6b6
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/omap4-iss.h
>> @@ -0,0 +1,42 @@
>> +#ifndef ARCH_ARM_PLAT_OMAP4_ISS_H
>> +#define ARCH_ARM_PLAT_OMAP4_ISS_H
>> +
>> +#include <linux/i2c.h>
>> +
>> +struct iss_device;
>> +
>> +enum iss_interface_type {
>> + =A0 =A0 ISS_INTERFACE_CSI2A_PHY1,
>> +};
>> +
>> +/**
>> + * struct iss_csi2_platform_data - CSI2 interface platform data
>> + * @crc: Enable the cyclic redundancy check
>> + * @vpclk_div: Video port output clock control
>> + */
>> +struct iss_csi2_platform_data {
>> + =A0 =A0 unsigned crc:1;
>> + =A0 =A0 unsigned vpclk_div:2;
>> +};
>> +
>> +struct iss_subdev_i2c_board_info {
>> + =A0 =A0 struct i2c_board_info *board_info;
>> + =A0 =A0 int i2c_adapter_id;
>> +};
>> +
>> +struct iss_v4l2_subdevs_group {
>> + =A0 =A0 struct iss_subdev_i2c_board_info *subdevs;
>> + =A0 =A0 enum iss_interface_type interface;
>> + =A0 =A0 union {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct iss_csi2_platform_data csi2;
>> + =A0 =A0 } bus; /* gcc < 4.6.0 chokes on anonymous union initialize=
rs */
>> +};
>> +
>> +struct iss_platform_data {
>> + =A0 =A0 struct iss_v4l2_subdevs_group *subdevs;
>> + =A0 =A0 void (*set_constraints)(struct iss_device *iss, bool enabl=
e);
>> +};
>> +
>> +extern int omap4_init_camera(struct iss_platform_data *pdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_boa=
rd_data *bdata);
>> +#endif
>> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconf=
ig
>> index b303a3f..ae2a99d 100644
>> --- a/drivers/media/video/Kconfig
>> +++ b/drivers/media/video/Kconfig
>> @@ -796,6 +796,19 @@ config VIDEO_OMAP3_DEBUG
>> =A0 =A0 =A0 ---help---
>> =A0 =A0 =A0 =A0 Enable debug messages on OMAP 3 camera controller dr=
iver.
>>
>> +config VIDEO_OMAP4
>> + =A0 =A0 tristate "OMAP 4 Camera support (EXPERIMENTAL)"
>> + =A0 =A0 depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && A=
RCH_OMAP4 && EXPERIMENTAL
>> + =A0 =A0 select VIDEOBUF2_DMA_CONTIG
>> + =A0 =A0 ---help---
>> + =A0 =A0 =A0 Driver for an OMAP 4 ISS controller.
>> +
>> +config VIDEO_OMAP4_DEBUG
>> + =A0 =A0 bool "OMAP 4 Camera debug messages"
>> + =A0 =A0 depends on VIDEO_OMAP4
>> + =A0 =A0 ---help---
>> + =A0 =A0 =A0 Enable debug messages on OMAP 4 ISS controller driver.
>> +
>> =A0config SOC_CAMERA
>> =A0 =A0 =A0 tristate "SoC camera support"
>> =A0 =A0 =A0 depends on VIDEO_V4L2 && HAS_DMA && I2C
>> diff --git a/drivers/media/video/Makefile b/drivers/media/video/Make=
file
>> index 117f9c4..f02a4c4 100644
>> --- a/drivers/media/video/Makefile
>> +++ b/drivers/media/video/Makefile
>> @@ -140,6 +140,7 @@ obj-$(CONFIG_VIDEO_MMP_CAMERA) +=3D marvell-ccic=
/
>> =A0obj-$(CONFIG_VIDEO_VIA_CAMERA) +=3D via-camera.o
>>
>> =A0obj-$(CONFIG_VIDEO_OMAP3) =A0 =A0+=3D omap3isp/
>> +obj-$(CONFIG_VIDEO_OMAP4) =A0 =A0+=3D omap4iss/
>>
>> =A0obj-$(CONFIG_USB_ZR364XX) =A0 =A0 =A0 +=3D zr364xx.o
>> =A0obj-$(CONFIG_USB_STKWEBCAM) =A0 =A0 +=3D stkwebcam.o
>> diff --git a/drivers/media/video/omap4iss/Makefile b/drivers/media/v=
ideo/omap4iss/Makefile
>> new file mode 100644
>> index 0000000..1d3b0a7
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/Makefile
>> @@ -0,0 +1,6 @@
>> +# Makefile for OMAP4 ISS driver
>> +
>> +omap4-iss-objs +=3D \
>> + =A0 =A0 iss.o iss_csi2.o iss_csiphy.o iss_video.o
>> +
>> +obj-$(CONFIG_VIDEO_OMAP4) +=3D omap4-iss.o
>> diff --git a/drivers/media/video/omap4iss/iss.c b/drivers/media/vide=
o/omap4iss/iss.c
>> new file mode 100644
>> index 0000000..255738b
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss.c
>> @@ -0,0 +1,1179 @@
>> +/*
>> + * V4L2 Driver for OMAP4 ISS
>> + *
>> + * Copyright (C) 2011, Texas Instruments
>> + *
>> + * Author: Sergio Aguirre <saaguirre@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/sched.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include <media/v4l2-common.h>
>> +#include <media/v4l2-device.h>
>> +
>> +#include "iss.h"
>> +#include "iss_regs.h"
>> +
>> +static void iss_save_ctx(struct iss_device *iss);
>> +
>> +static void iss_restore_ctx(struct iss_device *iss);
>> +
>> +/* Structure for saving/restoring ISS module registers */
>> +static struct iss_reg iss_reg_list[] =3D {
>> + =A0 =A0 {OMAP4_ISS_MEM_TOP, ISS_HL_SYSCONFIG, 0},
>> + =A0 =A0 {OMAP4_ISS_MEM_TOP, ISS_CTRL, 0},
>> + =A0 =A0 {OMAP4_ISS_MEM_TOP, ISS_CLKCTRL, 0},
>> + =A0 =A0 {0, ISS_TOK_TERM, 0}
>> +};
>> +
>> +/*
>> + * omap4iss_flush - Post pending L3 bus writes by doing a register =
readback
>> + * @iss: OMAP4 ISS device
>> + *
>> + * In order to force posting of pending writes, we need to write an=
d
>> + * readback the same register, in this case the revision register.
>> + *
>> + * See this link for reference:
>> + * =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg08=
149.html
>> + */
>> +void omap4iss_flush(struct iss_device *iss)
>> +{
>> + =A0 =A0 writel(0, iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_REVISION);
>> + =A0 =A0 readl(iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_REVISION);
>> +}
>> +
>> +/*
>> + * iss_enable_interrupts - Enable ISS interrupts.
>> + * @iss: OMAP4 ISS device
>> + */
>> +static void iss_enable_interrupts(struct iss_device *iss)
>> +{
>> + =A0 =A0 static const u32 irq =3D ISS_HL_IRQ_CSIA;
>> +
>> + =A0 =A0 /* Enable HL interrupts */
>> + =A0 =A0 writel(irq, iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_IRQSTATU=
S_5);
>> + =A0 =A0 writel(irq, iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_IRQENABL=
E_5_SET);
>> +}
>> +
>> +/*
>> + * iss_disable_interrupts - Disable ISS interrupts.
>> + * @iss: OMAP4 ISS device
>> + */
>> +static void iss_disable_interrupts(struct iss_device *iss)
>> +{
>> + =A0 =A0 writel(-1, iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_IRQENABLE=
_5_CLR);
>> +}
>> +
>> +static inline void iss_isr_dbg(struct iss_device *iss, u32 irqstatu=
s)
>> +{
>> + =A0 =A0 static const char *name[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 "ISP_IRQ0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "ISP_IRQ1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "ISP_IRQ2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "ISP_IRQ3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CSIA_IRQ",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CSIB_IRQ",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CCP2_IRQ0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CCP2_IRQ1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CCP2_IRQ2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CCP2_IRQ3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CBUFF_IRQ",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "BTE_IRQ",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "SIMCOP_IRQ0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "SIMCOP_IRQ1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "SIMCOP_IRQ2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "SIMCOP_IRQ3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "CCP2_IRQ8",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "HS_VS_IRQ",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res18",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res19",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res20",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res21",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res22",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res23",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res24",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res25",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res26",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res27",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res28",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res29",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res30",
>> + =A0 =A0 =A0 =A0 =A0 =A0 "res31",
>> + =A0 =A0 };
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 dev_dbg(iss->dev, "ISS IRQ: ");
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(name); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((1 << i) & irqstatus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_CONT "%s ", na=
me[i]);
>> + =A0 =A0 }
>> + =A0 =A0 printk(KERN_CONT "\n");
>> +}
>> +
>> +/*
>> + * iss_isr - Interrupt Service Routine for ISS module.
>> + * @irq: Not used currently.
>> + * @_iss: Pointer to the OMAP4 ISS device
>> + *
>> + * Handles the corresponding callback if plugged in.
>> + *
>> + * Returns IRQ_HANDLED when IRQ was correctly handled, or IRQ_NONE =
when the
>> + * IRQ wasn't handled.
>> + */
>> +static irqreturn_t iss_isr(int irq, void *_iss)
>> +{
>> + =A0 =A0 struct iss_device *iss =3D _iss;
>> + =A0 =A0 u32 irqstatus;
>> +
>> + =A0 =A0 irqstatus =3D readl(iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_=
IRQSTATUS_5);
>> + =A0 =A0 writel(irqstatus, iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_IR=
QSTATUS_5);
>> +
>> + =A0 =A0 if (irqstatus & ISS_HL_IRQ_CSIA)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_csi2_isr(&iss->csi2a);
>> +
>> + =A0 =A0 omap4iss_flush(iss);
>> +
>> +#if defined(DEBUG) && defined(ISS_ISR_DEBUG)
>> + =A0 =A0 iss_isr_dbg(iss, irqstatus);
>> +#endif
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * Pipeline power management
>> + *
>> + * Entities must be powered up when part of a pipeline that contain=
s at least
>> + * one open video device node.
>> + *
>> + * To achieve this use the entity use_count field to track the numb=
er of users.
>> + * For entities corresponding to video device nodes the use_count f=
ield stores
>> + * the users count of the node. For entities corresponding to subde=
vs the
>> + * use_count field stores the total number of users of all video de=
vice nodes
>> + * in the pipeline.
>> + *
>> + * The omap4iss_pipeline_pm_use() function must be called in the op=
en() and
>> + * close() handlers of video device nodes. It increments or decreme=
nts the use
>> + * count of all subdev entities in the pipeline.
>> + *
>> + * To react to link management on powered pipelines, the link setup=
 notification
>> + * callback updates the use count of all entities in the source and=
 sink sides
>> + * of the link.
>> + */
>> +
>> +/*
>> + * iss_pipeline_pm_use_count - Count the number of users of a pipel=
ine
>> + * @entity: The entity
>> + *
>> + * Return the total number of users of all video device nodes in th=
e pipeline.
>> + */
>> +static int iss_pipeline_pm_use_count(struct media_entity *entity)
>> +{
>> + =A0 =A0 struct media_entity_graph graph;
>> + =A0 =A0 int use =3D 0;
>> +
>> + =A0 =A0 media_entity_graph_walk_start(&graph, entity);
>> +
>> + =A0 =A0 while ((entity =3D media_entity_graph_walk_next(&graph))) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (media_entity_type(entity) =3D=3D MEDIA=
_ENT_T_DEVNODE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use +=3D entity->use_count=
;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return use;
>> +}
>> +
>> +/*
>> + * iss_pipeline_pm_power_one - Apply power change to an entity
>> + * @entity: The entity
>> + * @change: Use count change
>> + *
>> + * Change the entity use count by @change. If the entity is a subde=
v update its
>> + * power state by calling the core::s_power operation when the use =
count goes
>> + * from 0 to !=3D 0 or from !=3D 0 to 0.
>> + *
>> + * Return 0 on success or a negative error code on failure.
>> + */
>> +static int iss_pipeline_pm_power_one(struct media_entity *entity, i=
nt change)
>> +{
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> +
>> + =A0 =A0 subdev =3D media_entity_type(entity) =3D=3D MEDIA_ENT_T_V4=
L2_SUBDEV
>> + =A0 =A0 =A0 =A0 =A0 =A0? media_entity_to_v4l2_subdev(entity) : NUL=
L;
>> +
>> + =A0 =A0 if (entity->use_count =3D=3D 0 && change > 0 && subdev !=3D=
 NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D v4l2_subdev_call(subdev, core, s_p=
ower, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0 && ret !=3D -ENOIOCTLCMD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 entity->use_count +=3D change;
>> + =A0 =A0 WARN_ON(entity->use_count < 0);
>> +
>> + =A0 =A0 if (entity->use_count =3D=3D 0 && change < 0 && subdev !=3D=
 NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 v4l2_subdev_call(subdev, core, s_power, 0)=
;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * iss_pipeline_pm_power - Apply power change to all entities in a =
pipeline
>> + * @entity: The entity
>> + * @change: Use count change
>> + *
>> + * Walk the pipeline to update the use count and the power state of=
 all non-node
>> + * entities.
>> + *
>> + * Return 0 on success or a negative error code on failure.
>> + */
>> +static int iss_pipeline_pm_power(struct media_entity *entity, int c=
hange)
>> +{
>> + =A0 =A0 struct media_entity_graph graph;
>> + =A0 =A0 struct media_entity *first =3D entity;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (!change)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 media_entity_graph_walk_start(&graph, entity);
>> +
>> + =A0 =A0 while (!ret && (entity =3D media_entity_graph_walk_next(&g=
raph)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (media_entity_type(entity) !=3D MEDIA_E=
NT_T_DEVNODE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D iss_pipeline_pm_po=
wer_one(entity, change);
>> +
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 media_entity_graph_walk_start(&graph, first);
>> +
>> + =A0 =A0 while ((first =3D media_entity_graph_walk_next(&graph))
>> + =A0 =A0 =A0 =A0 =A0 =A0&& first !=3D entity)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (media_entity_type(first) !=3D MEDIA_EN=
T_T_DEVNODE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iss_pipeline_pm_power_one(=
first, -change);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/*
>> + * omap4iss_pipeline_pm_use - Update the use count of an entity
>> + * @entity: The entity
>> + * @use: Use (1) or stop using (0) the entity
>> + *
>> + * Update the use count of all entities in the pipeline and power e=
ntities on or
>> + * off accordingly.
>> + *
>> + * Return 0 on success or a negative error code on failure. Powerin=
g entities
>> + * off is assumed to never fail. No failure can occur when the use =
parameter is
>> + * set to 0.
>> + */
>> +int omap4iss_pipeline_pm_use(struct media_entity *entity, int use)
>> +{
>> + =A0 =A0 int change =3D use ? 1 : -1;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 mutex_lock(&entity->parent->graph_mutex);
>> +
>> + =A0 =A0 /* Apply use count to node. */
>> + =A0 =A0 entity->use_count +=3D change;
>> + =A0 =A0 WARN_ON(entity->use_count < 0);
>> +
>> + =A0 =A0 /* Apply power change to connected non-nodes. */
>> + =A0 =A0 ret =3D iss_pipeline_pm_power(entity, change);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 entity->use_count -=3D change;
>> +
>> + =A0 =A0 mutex_unlock(&entity->parent->graph_mutex);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/*
>> + * iss_pipeline_link_notify - Link management notification callback
>> + * @source: Pad at the start of the link
>> + * @sink: Pad at the end of the link
>> + * @flags: New link flags that will be applied
>> + *
>> + * React to link management on powered pipelines by updating the us=
e count of
>> + * all entities in the source and sink sides of the link. Entities =
are powered
>> + * on or off accordingly.
>> + *
>> + * Return 0 on success or a negative error code on failure. Powerin=
g entities
>> + * off is assumed to never fail. This function will not fail for di=
sconnection
>> + * events.
>> + */
>> +static int iss_pipeline_link_notify(struct media_pad *source,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct media_pad *sink, u32 flags)
>> +{
>> + =A0 =A0 int source_use =3D iss_pipeline_pm_use_count(source->entit=
y);
>> + =A0 =A0 int sink_use =3D iss_pipeline_pm_use_count(sink->entity);
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (!(flags & MEDIA_LNK_FL_ENABLED)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Powering off entities is assumed to nev=
er fail. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_pipeline_pm_power(source->entity, -sin=
k_use);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_pipeline_pm_power(sink->entity, -sourc=
e_use);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D iss_pipeline_pm_power(source->entity, sink_use);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 ret =3D iss_pipeline_pm_power(sink->entity, source_use);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_pipeline_pm_power(source->entity, -sin=
k_use);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * Pipeline stream management
>> + */
>> +
>> +/*
>> + * iss_pipeline_enable - Enable streaming on a pipeline
>> + * @pipe: ISS pipeline
>> + * @mode: Stream mode (single shot or continuous)
>> + *
>> + * Walk the entities chain starting at the pipeline output video no=
de and start
>> + * all modules in the chain in the given mode.
>> + *
>> + * Return 0 if successful, or the return value of the failed video:=
:s_stream
>> + * operation otherwise.
>> + */
>> +static int iss_pipeline_enable(struct iss_pipeline *pipe,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum iss_pi=
peline_stream_state mode)
>> +{
>> + =A0 =A0 struct media_entity *entity;
>> + =A0 =A0 struct media_pad *pad;
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 spin_lock_irqsave(&pipe->lock, flags);
>> + =A0 =A0 pipe->state &=3D ~(ISS_PIPELINE_IDLE_INPUT | ISS_PIPELINE_=
IDLE_OUTPUT);
>> + =A0 =A0 spin_unlock_irqrestore(&pipe->lock, flags);
>> +
>> + =A0 =A0 pipe->do_propagation =3D false;
>> +
>> + =A0 =A0 entity =3D &pipe->output->video.entity;
>> + =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pad =3D &entity->pads[0];
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(pad->flags & MEDIA_PAD_FL_SINK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pad =3D media_entity_remote_source(pad);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pad =3D=3D NULL ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 media_entity_type(pad->entity) !=3D=
 MEDIA_ENT_T_V4L2_SUBDEV)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 entity =3D pad->entity;
>> + =A0 =A0 =A0 =A0 =A0 =A0 subdev =3D media_entity_to_v4l2_subdev(ent=
ity);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D v4l2_subdev_call(subdev, video, s_=
stream, mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0 && ret !=3D -ENOIOCTLCMD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/*
>> + * iss_pipeline_disable - Disable streaming on a pipeline
>> + * @pipe: ISS pipeline
>> + *
>> + * Walk the entities chain starting at the pipeline output video no=
de and stop
>> + * all modules in the chain. Wait synchronously for the modules to =
be stopped if
>> + * necessary.
>> + */
>> +static int iss_pipeline_disable(struct iss_pipeline *pipe)
>> +{
>> + =A0 =A0 struct media_entity *entity;
>> + =A0 =A0 struct media_pad *pad;
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 int failure =3D 0;
>> +
>> + =A0 =A0 entity =3D &pipe->output->video.entity;
>> + =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pad =3D &entity->pads[0];
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(pad->flags & MEDIA_PAD_FL_SINK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pad =3D media_entity_remote_source(pad);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pad =3D=3D NULL ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 media_entity_type(pad->entity) !=3D=
 MEDIA_ENT_T_V4L2_SUBDEV)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 entity =3D pad->entity;
>> + =A0 =A0 =A0 =A0 =A0 =A0 subdev =3D media_entity_to_v4l2_subdev(ent=
ity);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 v4l2_subdev_call(subdev, video, s_stream, =
0);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return failure;
>> +}
>> +
>> +/*
>> + * omap4iss_pipeline_set_stream - Enable/disable streaming on a pip=
eline
>> + * @pipe: ISS pipeline
>> + * @state: Stream state (stopped, single shot or continuous)
>> + *
>> + * Set the pipeline to the given stream state. Pipelines can be sta=
rted in
>> + * single-shot or continuous mode.
>> + *
>> + * Return 0 if successful, or the return value of the failed video:=
:s_stream
>> + * operation otherwise. The pipeline state is not updated when the =
operation
>> + * fails, except when stopping the pipeline.
>> + */
>> +int omap4iss_pipeline_set_stream(struct iss_pipeline *pipe,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum is=
s_pipeline_stream_state state)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (state =3D=3D ISS_PIPELINE_STREAM_STOPPED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D iss_pipeline_disable(pipe);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D iss_pipeline_enable(pipe, state);
>> +
>> + =A0 =A0 if (ret =3D=3D 0 || state =3D=3D ISS_PIPELINE_STREAM_STOPP=
ED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->stream_state =3D state;
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/*
>> + * iss_pipeline_is_last - Verify if entity has an enabled link to t=
he output
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video node
>> + * @me: ISS module's media entity
>> + *
>> + * Returns 1 if the entity has an enabled link to the output video =
node or 0
>> + * otherwise. It's true only while pipeline can have no more than o=
ne output
>> + * node.
>> + */
>> +static int iss_pipeline_is_last(struct media_entity *me)
>> +{
>> + =A0 =A0 struct iss_pipeline *pipe;
>> + =A0 =A0 struct media_pad *pad;
>> +
>> + =A0 =A0 if (!me->pipe)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 pipe =3D to_iss_pipeline(me);
>> + =A0 =A0 if (pipe->stream_state =3D=3D ISS_PIPELINE_STREAM_STOPPED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 pad =3D media_entity_remote_source(&pipe->output->pad);
>> + =A0 =A0 return pad->entity =3D=3D me;
>> +}
>> +
>> +static int iss_reset(struct iss_device *iss)
>> +{
>> + =A0 =A0 unsigned long timeout =3D 0;
>> +
>> + =A0 =A0 writel(readl(iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_SYSCONF=
IG) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ISS_HL_SYSCONFIG_SOFTRESET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_SYSC=
ONFIG);
>> +
>> + =A0 =A0 while (readl(iss->regs[OMAP4_ISS_MEM_TOP] + ISS_HL_SYSCONF=
IG) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ISS_HL_SYSCONFIG_SOFTRESET=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (timeout++ > 10000) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_alert(iss->dev, "canno=
t reset ISS\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * iss_save_context - Saves the values of the ISS module registers.
>> + * @iss: OMAP4 ISS device
>> + * @reg_list: Structure containing pairs of register address and va=
lue to
>> + * =A0 =A0 =A0 =A0 =A0 =A0modify on OMAP.
>> + */
>> +static void
>> +iss_save_context(struct iss_device *iss, struct iss_reg *reg_list)
>> +{
>> + =A0 =A0 struct iss_reg *next =3D reg_list;
>> +
>> + =A0 =A0 for (; next->reg !=3D ISS_TOK_TERM; next++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 next->val =3D readl(iss->regs[next->mmio_r=
ange] + next->reg);
>> +}
>> +
>> +/*
>> + * iss_restore_context - Restores the values of the ISS module regi=
sters.
>> + * @iss: OMAP4 ISS device
>> + * @reg_list: Structure containing pairs of register address and va=
lue to
>> + * =A0 =A0 =A0 =A0 =A0 =A0modify on OMAP.
>> + */
>> +static void
>> +iss_restore_context(struct iss_device *iss, struct iss_reg *reg_lis=
t)
>> +{
>> + =A0 =A0 struct iss_reg *next =3D reg_list;
>> +
>> + =A0 =A0 for (; next->reg !=3D ISS_TOK_TERM; next++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(next->val, iss->regs[next->mmio_ran=
ge] + next->reg);
>> +}
>> +
>> +/*
>> + * iss_save_ctx - Saves ISS context.
>> + * @iss: OMAP4 ISS device
>> + *
>> + * Routine for saving the context of each module in the ISS.
>> + */
>> +static void iss_save_ctx(struct iss_device *iss)
>> +{
>> + =A0 =A0 iss_save_context(iss, iss_reg_list);
>> +}
>
> Do you really, really need to save context related data? Couldn't you
> initialise the device the usual way when e.g. returning from suspende=
d
> state?

I'll actually have to revisit this more carefuly. I haven't really
tested Runtime PM on this.

I think I'll remove this for now, until i come up with something better=
=2E

>
>> +/*
>> + * iss_restore_ctx - Restores ISS context.
>> + * @iss: OMAP4 ISS device
>> + *
>> + * Routine for restoring the context of each module in the ISS.
>> + */
>> +static void iss_restore_ctx(struct iss_device *iss)
>> +{
>> + =A0 =A0 iss_restore_context(iss, iss_reg_list);
>> +}
>> +
>> +/*
>> + * iss_module_sync_idle - Helper to sync module with its idle state
>> + * @me: ISS submodule's media entity
>> + * @wait: ISS submodule's wait queue for streamoff/interrupt synchr=
onization
>> + * @stopping: flag which tells module wants to stop
>> + *
>> + * This function checks if ISS submodule needs to wait for next int=
errupt. If
>> + * yes, makes the caller to sleep while waiting for such event.
>> + */
>> +int omap4iss_module_sync_idle(struct media_entity *me, wait_queue_h=
ead_t *wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_t *stop=
ping)
>> +{
>> + =A0 =A0 struct iss_pipeline *pipe =3D to_iss_pipeline(me);
>> +
>> + =A0 =A0 if (pipe->stream_state =3D=3D ISS_PIPELINE_STREAM_STOPPED =
||
>> + =A0 =A0 =A0 =A0 (pipe->stream_state =3D=3D ISS_PIPELINE_STREAM_SIN=
GLESHOT &&
>> + =A0 =A0 =A0 =A0 =A0!iss_pipeline_ready(pipe)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* atomic_set() doesn't include memory barrier on ARM pl=
atform for SMP
>> + =A0 =A0 =A0* scenario. We'll call it here to avoid race conditions=
=2E
>> + =A0 =A0 =A0*/
>> + =A0 =A0 atomic_set(stopping, 1);
>> + =A0 =A0 smp_mb();
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If module is the last one, it's writing to memory. In=
 this case,
>> + =A0 =A0 =A0* it's necessary to check if the module is already paus=
ed due to
>> + =A0 =A0 =A0* DMA queue underrun or if it has to wait for next inte=
rrupt to be
>> + =A0 =A0 =A0* idle.
>> + =A0 =A0 =A0* If it isn't the last one, the function won't sleep bu=
t *stopping
>> + =A0 =A0 =A0* will still be set to warn next submodule caller's int=
errupt the
>> + =A0 =A0 =A0* module wants to be idle.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (iss_pipeline_is_last(me)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct iss_video *video =3D pipe->output;
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&video->qlock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (video->dmaqueue_flags & ISS_VIDEO_DMAQ=
UEUE_UNDERRUN) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&vi=
deo->qlock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(stopping, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_mb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&video->qlock, flag=
s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!wait_event_timeout(*wait, !atomic_rea=
d(stopping),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 msecs_to_jiffies(1000))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(stopping, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_mb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * omap4iss_module_sync_is_stopped - Helper to verify if module was=
 stopping
>> + * @wait: ISS submodule's wait queue for streamoff/interrupt synchr=
onization
>> + * @stopping: flag which tells module wants to stop
>> + *
>> + * This function checks if ISS submodule was stopping. In case of y=
es, it
>> + * notices the caller by setting stopping to 0 and waking up the wa=
it queue.
>> + * Returns 1 if it was stopping or 0 otherwise.
>> + */
>> +int omap4iss_module_sync_is_stopping(wait_queue_head_t *wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
atomic_t *stopping)
>> +{
>> + =A0 =A0 if (atomic_cmpxchg(stopping, 1, 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_up(wait);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* ----------------------------------------------------------------=
----------
>> + * Clock management
>> + */
>> +
>> +#define ISS_CLKCTRL_MASK =A0 =A0 (ISS_CLKCTRL_CSI2_A)
>> +
>> +static int __iss_subclk_update(struct iss_device *iss)
>> +{
>> + =A0 =A0 u32 clk =3D 0;
>> + =A0 =A0 int ret =3D 0, timeout =3D 1000;
>> +
>> + =A0 =A0 if (iss->subclk_resources & OMAP4_ISS_SUBCLK_CSI2_A)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk |=3D ISS_CLKCTRL_CSI2_A;
>> +
>> + =A0 =A0 writel((readl(iss->regs[OMAP4_ISS_MEM_TOP] + ISS_CLKCTRL) =
&
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~ISS_CLKCTRL_MASK) | clk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss->regs[OMAP4_ISS_MEM_TOP] + ISS_CLKCTRL=
);
>> +
>> + =A0 =A0 /* Wait for HW assertion */
>> + =A0 =A0 while (timeout-- > 0) {
>
> The value must be decremented before the comparison. Otherwise the re=
sult
> could be negative, and the check a few lines below will fail even if =
the
> timeout happened.

Oops yes. Missed that. Will fix.

>
> I guess it's not a crime to use a for loop either in situations like =
this.

Ok.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(iss->regs[OMAP4_ISS_MEM_TOP] + =
ISS_CLKSTAT) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISS_CLKCTRL_MASK) =3D=3D clk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!timeout)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +int omap4iss_subclk_enable(struct iss_device *iss,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum iss_subclk_re=
source res)
>> +{
>> + =A0 =A0 iss->subclk_resources |=3D res;
>> +
>> + =A0 =A0 return __iss_subclk_update(iss);
>> +}
>> +
>> +int omap4iss_subclk_disable(struct iss_device *iss,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum iss_subclk=
_resource res)
>> +{
>> + =A0 =A0 iss->subclk_resources &=3D ~res;
>> +
>> + =A0 =A0 return __iss_subclk_update(iss);
>> +}
>> +
>> +/*
>> + * iss_enable_clocks - Enable ISS clocks
>> + * @iss: OMAP4 ISS device
>> + *
>> + * Return 0 if successful, or clk_enable return value if any of tth=
em fails.
>> + */
>> +static int iss_enable_clocks(struct iss_device *iss)
>> +{
>> + =A0 =A0 int r;
>> +
>> + =A0 =A0 r =3D clk_enable(iss->iss_fck);
>> + =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "clk_enable iss_fck fail=
ed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out_clk_enable_fck;
>
> You can return the error here and your error handling below becomes m=
ore
> simple.

Right. Will fix.

>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 r =3D clk_enable(iss->iss_ctrlclk);
>> + =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "clk_enable iss_ctrlclk =
failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out_clk_enable_ctrlclk;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +
>> +out_clk_enable_ctrlclk:
>> + =A0 =A0 clk_disable(iss->iss_fck);
>> +out_clk_enable_fck:
>> + =A0 =A0 return r;
>> +}
>> +
>> +/*
>> + * iss_disable_clocks - Disable ISS clocks
>> + * @iss: OMAP4 ISS device
>> + */
>> +static void iss_disable_clocks(struct iss_device *iss)
>> +{
>> + =A0 =A0 clk_disable(iss->iss_ctrlclk);
>> + =A0 =A0 clk_disable(iss->iss_fck);
>> +}
>> +
>> +static void iss_put_clocks(struct iss_device *iss)
>> +{
>> + =A0 =A0 if (iss->iss_fck) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_put(iss->iss_fck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss->iss_fck =3D NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (iss->iss_ctrlclk) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_put(iss->iss_ctrlclk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss->iss_ctrlclk =3D NULL;
>> + =A0 =A0 }
>> +}
>> +
>> +static int iss_get_clocks(struct iss_device *iss)
>> +{
>> + =A0 =A0 iss->iss_fck =3D clk_get(iss->dev, "iss_fck");
>> + =A0 =A0 if (IS_ERR(iss->iss_fck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "Unable to get iss_fck c=
lock info\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_put_clocks(iss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(iss->iss_fck);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 iss->iss_ctrlclk =3D clk_get(iss->dev, "iss_ctrlclk");
>> + =A0 =A0 if (IS_ERR(iss->iss_ctrlclk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "Unable to get iss_ctrlc=
lk clock info\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_put_clocks(iss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(iss->iss_fck);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * omap4iss_get - Acquire the ISS resource.
>> + *
>> + * Initializes the clocks for the first acquire.
>> + *
>> + * Increment the reference count on the ISS. If the first reference=
 is taken,
>> + * enable clocks and power-up all submodules.
>> + *
>> + * Return a pointer to the ISS device structure, or NULL if an erro=
r occurred.
>> + */
>> +struct iss_device *omap4iss_get(struct iss_device *iss)
>> +{
>> + =A0 =A0 struct iss_device *__iss =3D iss;
>> +
>> + =A0 =A0 if (iss =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 mutex_lock(&iss->iss_mutex);
>> + =A0 =A0 if (iss->ref_count > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 if (iss_enable_clocks(iss) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 __iss =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* We don't want to restore context before saving it! */
>> + =A0 =A0 if (iss->has_context)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_restore_ctx(iss);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss->has_context =3D 1;
>> +
>> + =A0 =A0 iss_enable_interrupts(iss);
>> +
>> +out:
>> + =A0 =A0 if (__iss !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss->ref_count++;
>> + =A0 =A0 mutex_unlock(&iss->iss_mutex);
>> +
>> + =A0 =A0 return __iss;
>> +}
>> +
>> +/*
>> + * omap4iss_put - Release the ISS
>> + *
>> + * Decrement the reference count on the ISS. If the last reference =
is released,
>> + * power-down all submodules, disable clocks and free temporary buf=
fers.
>> + */
>> +void omap4iss_put(struct iss_device *iss)
>> +{
>> + =A0 =A0 if (iss =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 mutex_lock(&iss->iss_mutex);
>> + =A0 =A0 BUG_ON(iss->ref_count =3D=3D 0);
>> + =A0 =A0 if (--iss->ref_count =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_disable_interrupts(iss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_save_ctx(iss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_disable_clocks(iss);
>> + =A0 =A0 }
>> + =A0 =A0 mutex_unlock(&iss->iss_mutex);
>> +}
>> +
>> +static int iss_map_mem_resource(struct platform_device *pdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iss=
_device *iss,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum iss_m=
em_resources res)
>> +{
>> + =A0 =A0 struct resource *mem;
>> +
>> + =A0 =A0 /* request the mem region for the camera registers */
>> +
>> + =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, res);
>> + =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "no mem resource?\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!request_mem_region(mem->start, resource_size(mem), pd=
ev->name)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cannot reserve camera reg=
ister I/O region\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> + =A0 =A0 iss->res[res] =3D mem;
>> +
>> + =A0 =A0 /* map the region */
>> + =A0 =A0 iss->regs[res] =3D ioremap_nocache(mem->start, resource_si=
ze(mem));
>> + =A0 =A0 if (!iss->regs[res]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "cannot map camera regis=
ter I/O region\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void iss_unregister_entities(struct iss_device *iss)
>> +{
>> + =A0 =A0 omap4iss_csi2_unregister_entities(&iss->csi2a);
>> +
>> + =A0 =A0 v4l2_device_unregister(&iss->v4l2_dev);
>> + =A0 =A0 media_device_unregister(&iss->media_dev);
>> +}
>> +
>> +/*
>> + * iss_register_subdev_group - Register a group of subdevices
>> + * @iss: OMAP4 ISS device
>> + * @board_info: I2C subdevs board information array
>> + *
>> + * Register all I2C subdevices in the board_info array. The array m=
ust be
>> + * terminated by a NULL entry, and the first entry must be the sens=
or.
>> + *
>> + * Return a pointer to the sensor media entity if it has been succe=
ssfully
>> + * registered, or NULL otherwise.
>> + */
>> +static struct v4l2_subdev *
>> +iss_register_subdev_group(struct iss_device *iss,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_subdev_i2c_board_inf=
o *board_info)
>> +{
>> + =A0 =A0 struct v4l2_subdev *sensor =3D NULL;
>> + =A0 =A0 unsigned int first;
>> +
>> + =A0 =A0 if (board_info->board_info =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 for (first =3D 1; board_info->board_info; ++board_info, fi=
rst =3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_adapter *adapter;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 adapter =3D i2c_get_adapter(board_info->i2=
c_adapter_id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (adapter =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Unabl=
e to get I2C adapter %d for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "device %s=
\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 board_info=
->i2c_adapter_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 board_info=
->board_info->type);
>
> Why printk? I think you already have access to struct device.

You're right. Will fix.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 subdev =3D v4l2_i2c_new_subdev_board(&iss-=
>v4l2_dev, adapter,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 board_info=
->board_info, NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (subdev =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Unabl=
e to register subdev %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, =
board_info->board_info->type);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (first)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sensor =3D subdev;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return sensor;
>> +}
>> +
>> +static int iss_register_entities(struct iss_device *iss)
>> +{
>> + =A0 =A0 struct iss_platform_data *pdata =3D iss->pdata;
>> + =A0 =A0 struct iss_v4l2_subdevs_group *subdevs;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 iss->media_dev.dev =3D iss->dev;
>> + =A0 =A0 strlcpy(iss->media_dev.model, "TI OMAP4 ISS",
>> + =A0 =A0 =A0 =A0 =A0 =A0 sizeof(iss->media_dev.model));
>> + =A0 =A0 iss->media_dev.link_notify =3D iss_pipeline_link_notify;
>> + =A0 =A0 ret =3D media_device_register(&iss->media_dev);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Media device registra=
tion failed (%d)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 iss->v4l2_dev.mdev =3D &iss->media_dev;
>> + =A0 =A0 ret =3D v4l2_device_register(iss->dev, &iss->v4l2_dev);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: V4L2 device registrat=
ion failed (%d)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Register internal entities */
>> + =A0 =A0 ret =3D omap4iss_csi2_register_entities(&iss->csi2a, &iss-=
>v4l2_dev);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 /* Register external entities */
>> + =A0 =A0 for (subdevs =3D pdata->subdevs; subdevs && subdevs->subde=
vs; ++subdevs) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_subdev *sensor;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct media_entity *input;
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int flags;
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pad;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 sensor =3D iss_register_subdev_group(iss, =
subdevs->subdevs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sensor =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 sensor->host_priv =3D subdevs;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Connect the sensor to the correct inter=
face module.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* CSI2a receiver through CSIPHY1.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (subdevs->interface) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case ISS_INTERFACE_CSI2A_PHY1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input =3D &iss->csi2a.subd=
ev.entity;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pad =3D CSI2_PAD_SINK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MEDIA_LNK_FL_IMM=
UTABLE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | MEDIA_LNK_FL=
_ENABLED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: inval=
id interface type %u\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, s=
ubdevs->interface);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D media_entity_create_link(&sensor->=
entity, 0, input, pad,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D v4l2_device_register_subdev_nodes(&iss->v4l2_dev);
>> +
>> +done:
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_unregister_entities(iss);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static void iss_cleanup_modules(struct iss_device *iss)
>> +{
>> + =A0 =A0 omap4iss_csi2_cleanup(iss);
>> +}
>> +
>> +static int iss_initialize_modules(struct iss_device *iss)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D omap4iss_csiphy_init(iss);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "CSI PHY initialization =
failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_csiphy;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D omap4iss_csi2_init(iss);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "CSI2 initialization fai=
led\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_csi2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +error_csi2:
>> +error_csiphy:
>> + =A0 =A0 return ret;
>
> If there's nothing special you need to do here, I suggest to return t=
he
> error where it happened.

Agreed. Will fix.

>
>> +}
>> +
>> +static int iss_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct iss_platform_data *pdata =3D pdev->dev.platform_dat=
a;
>> + =A0 =A0 struct iss_device *iss;
>> + =A0 =A0 int i, ret;
>> +
>> + =A0 =A0 if (pdata =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 iss =3D kzalloc(sizeof(*iss), GFP_KERNEL);
>> + =A0 =A0 if (!iss) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Could not allocate me=
mory\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_init(&iss->iss_mutex);
>> +
>> + =A0 =A0 iss->dev =3D &pdev->dev;
>> + =A0 =A0 iss->pdata =3D pdata;
>> + =A0 =A0 iss->ref_count =3D 0;
>> +
>> + =A0 =A0 iss->raw_dmamask =3D DMA_BIT_MASK(32);
>> + =A0 =A0 iss->dev->dma_mask =3D &iss->raw_dmamask;
>> + =A0 =A0 iss->dev->coherent_dma_mask =3D DMA_BIT_MASK(32);
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, iss);
>> +
>> + =A0 =A0 /* Clocks */
>> + =A0 =A0 ret =3D iss_map_mem_resource(pdev, iss, OMAP4_ISS_MEM_TOP)=
;
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 ret =3D iss_get_clocks(iss);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 if (omap4iss_get(iss) =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 ret =3D iss_reset(iss);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_iss;
>> +
>> + =A0 =A0 iss->revision =3D readl(iss->regs[OMAP4_ISS_MEM_TOP] + ISS=
_HL_REVISION);
>> + =A0 =A0 dev_info(iss->dev, "Revision %08x found\n", iss->revision)=
;
>> +
>> + =A0 =A0 for (i =3D 1; i < OMAP4_ISS_MEM_LAST; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D iss_map_mem_resource(pdev, iss, i)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_iss;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Interrupt */
>> + =A0 =A0 iss->irq_num =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 if (iss->irq_num <=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "No IRQ resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_iss;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (request_irq(iss->irq_num, iss_isr, IRQF_SHARED, "OMAP4=
 ISS", iss)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(iss->dev, "Unable to request IRQ\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_iss;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Entities */
>> + =A0 =A0 ret =3D iss_initialize_modules(iss);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_irq;
>> +
>> + =A0 =A0 ret =3D iss_register_entities(iss);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_modules;
>> +
>> + =A0 =A0 omap4iss_put(iss);
>> +
>> + =A0 =A0 return 0;
>> +
>> +error_modules:
>> + =A0 =A0 iss_cleanup_modules(iss);
>> +error_irq:
>> + =A0 =A0 free_irq(iss->irq_num, iss);
>> +error_iss:
>> + =A0 =A0 omap4iss_put(iss);
>> +error:
>> + =A0 =A0 iss_put_clocks(iss);
>> +
>> + =A0 =A0 for (i =3D 0; i < OMAP4_ISS_MEM_LAST; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (iss->regs[i]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(iss->regs[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iss->regs[i] =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (iss->res[i]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(iss->re=
s[i]->start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0resource_size(iss->res[i]));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iss->res[i] =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 platform_set_drvdata(pdev, NULL);
>> + =A0 =A0 kfree(iss);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int iss_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct iss_device *iss =3D platform_get_drvdata(pdev);
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 iss_unregister_entities(iss);
>> + =A0 =A0 iss_cleanup_modules(iss);
>> +
>> + =A0 =A0 free_irq(iss->irq_num, iss);
>> + =A0 =A0 iss_put_clocks(iss);
>> +
>> + =A0 =A0 for (i =3D 0; i < OMAP4_ISS_MEM_LAST; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (iss->regs[i]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(iss->regs[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iss->regs[i] =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (iss->res[i]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(iss->re=
s[i]->start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0resource_size(iss->res[i]));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iss->res[i] =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 kfree(iss);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_device_id omap4iss_id_table[] =3D {
>> + =A0 =A0 { "omap4iss", 0 },
>> + =A0 =A0 { },
>> +};
>> +MODULE_DEVICE_TABLE(platform, omap4iss_id_table);
>> +
>> +static struct platform_driver iss_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D iss_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D iss_remove,
>> + =A0 =A0 .id_table =A0 =A0 =A0 =3D omap4iss_id_table,
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap4iss",
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init iss_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&iss_driver);
>> +}
>> +
>> +static void __exit iss_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&iss_driver);
>> +}
>> +
>> +/*
>> + * FIXME: Had to make it late_initcall. Strangely while being modul=
e_init,
>> + * The I2C communication was failing in the sensor, because no XCLK=
 was
>> + * provided.
>> + */
>> +late_initcall(iss_init);
>> +module_exit(iss_exit);
>> +
>> +MODULE_DESCRIPTION("TI OMAP4 ISS driver");
>> +MODULE_AUTHOR("Sergio Aguirre <saaguirre@ti.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/media/video/omap4iss/iss.h b/drivers/media/vide=
o/omap4iss/iss.h
>> new file mode 100644
>> index 0000000..8346c80
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss.h
>> @@ -0,0 +1,133 @@
>> +/*
>> + * iss.h
>> + *
>> + * Copyright (C) 2011 Texas Instruments.
>> + *
>> + * Author: Sergio Aguirre <saaguirre@ti.com>
>> + */
>
> Have you intentionally left out the more verbose notice? It's also 20=
12 now.
> :)

:) Not intentional... Will fix.

>
>> +#ifndef _OMAP4_ISS_H_
>> +#define _OMAP4_ISS_H_
>> +
>> +#include <media/v4l2-device.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/wait.h>
>> +
>> +#include <plat/omap4-iss.h>
>> +
>> +#include "iss_regs.h"
>> +#include "iss_csiphy.h"
>> +#include "iss_csi2.h"
>> +
>> +#define ISS_TOK_TERM =A0 =A0 =A0 =A0 0xFFFFFFFF =A0 =A0 =A0/*
>
> Minor thing, but lowercase hex are preferred.

I'll actually get rid of this, along with the context save-restore for =
now.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0* terminating token for ISS
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0* modules reg list
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0*/
>> +#define to_iss_device(ptr_module) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 container_of(ptr_module, struct iss_device, ptr_module)
>> +#define to_device(ptr_module) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 (to_iss_device(ptr_module)->dev)
>> +
>> +enum iss_mem_resources {
>> + =A0 =A0 OMAP4_ISS_MEM_TOP,
>> + =A0 =A0 OMAP4_ISS_MEM_CSI2_A_REGS1,
>> + =A0 =A0 OMAP4_ISS_MEM_CAMERARX_CORE1,
>> + =A0 =A0 OMAP4_ISS_MEM_LAST,
>> +};
>> +
>> +enum iss_subclk_resource {
>> + =A0 =A0 OMAP4_ISS_SUBCLK_SIMCOP =A0 =A0 =A0 =A0 =3D (1 << 0),
>> + =A0 =A0 OMAP4_ISS_SUBCLK_ISP =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 1),
>> + =A0 =A0 OMAP4_ISS_SUBCLK_CSI2_A =A0 =A0 =A0 =A0 =3D (1 << 2),
>> + =A0 =A0 OMAP4_ISS_SUBCLK_CSI2_B =A0 =A0 =A0 =A0 =3D (1 << 3),
>> + =A0 =A0 OMAP4_ISS_SUBCLK_CCP2 =A0 =A0 =A0 =A0 =A0 =3D (1 << 4),
>> +};
>> +
>> +/*
>> + * struct iss_reg - Structure for ISS register values.
>> + * @reg: 32-bit Register address.
>> + * @val: 32-bit Register value.
>> + */
>> +struct iss_reg {
>> + =A0 =A0 enum iss_mem_resources mmio_range;
>> + =A0 =A0 u32 reg;
>> + =A0 =A0 u32 val;
>> +};
>> +
>> +struct iss_platform_callback {
>> + =A0 =A0 int (*csiphy_config)(struct iss_csiphy *phy,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_csip=
hy_dphy_cfg *dphy,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_csip=
hy_lanes_cfg *lanes);
>> +};
>
> You might want to look my recent patchset (a few days ago). You can p=
robably
> get rid of this callback easily.

Ok. I'll pay attention to it.

>
>> +struct iss_device {
>> + =A0 =A0 struct v4l2_device v4l2_dev;
>> + =A0 =A0 struct media_device media_dev;
>> + =A0 =A0 struct device *dev;
>> + =A0 =A0 u32 revision;
>> +
>> + =A0 =A0 /* platform HW resources */
>> + =A0 =A0 struct iss_platform_data *pdata;
>> + =A0 =A0 unsigned int irq_num;
>> +
>> + =A0 =A0 struct resource *res[OMAP4_ISS_MEM_LAST];
>> + =A0 =A0 void __iomem *regs[OMAP4_ISS_MEM_LAST];
>> +
>> + =A0 =A0 u64 raw_dmamask;
>> +
>> + =A0 =A0 struct mutex iss_mutex; /* For handling ref_count field */
>> + =A0 =A0 int has_context;
>> + =A0 =A0 int ref_count;
>> +
>> + =A0 =A0 struct clk *iss_fck;
>> + =A0 =A0 struct clk *iss_ctrlclk;
>> +
>> + =A0 =A0 /* ISS modules */
>> + =A0 =A0 struct iss_csi2_device csi2a;
>> + =A0 =A0 struct iss_csiphy csiphy1;
>> +
>> + =A0 =A0 unsigned int subclk_resources;
>> +
>> + =A0 =A0 struct iss_platform_callback platform_cb;
>> +};
>> +
>> +#define v4l2_dev_to_iss_device(dev) \
>> + =A0 =A0 container_of(dev, struct iss_device, v4l2_dev)
>> +
>> +int omap4iss_module_sync_idle(struct media_entity *me, wait_queue_h=
ead_t *wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_t *stop=
ping);
>> +
>> +int omap4iss_module_sync_is_stopping(wait_queue_head_t *wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
atomic_t *stopping);
>> +
>> +int omap4iss_pipeline_set_stream(struct iss_pipeline *pipe,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum is=
s_pipeline_stream_state state);
>> +
>> +struct iss_device *omap4iss_get(struct iss_device *iss);
>> +void omap4iss_put(struct iss_device *iss);
>> +int omap4iss_subclk_enable(struct iss_device *iss,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum iss_subclk_res=
ource res);
>> +int omap4iss_subclk_disable(struct iss_device *iss,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum iss_subclk_re=
source res);
>> +
>> +int omap4iss_pipeline_pm_use(struct media_entity *entity, int use);
>> +
>> +int omap4iss_register_entities(struct platform_device *pdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2=
_device *v4l2_dev);
>> +void omap4iss_unregister_entities(struct platform_device *pdev);
>> +
>> +static inline enum v4l2_buf_type
>> +iss_pad_buffer_type(const struct v4l2_subdev *subdev, int pad)
>> +{
>> + =A0 =A0 if (pad >=3D subdev->entity.num_pads)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> Hmm. Is it just me or is this function unused?

Oops, yes. Will fix.

>
>> + =A0 =A0 if (subdev->entity.pads[pad].flags & MEDIA_PAD_FL_SINK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return V4L2_BUF_TYPE_VIDEO_OUTPUT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +}
>> +
>> +#endif /* _OMAP4_ISS_H_ */
>> diff --git a/drivers/media/video/omap4iss/iss_csi2.c b/drivers/media=
/video/omap4iss/iss_csi2.c
>> new file mode 100644
>> index 0000000..916d5ef
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss_csi2.c
>> @@ -0,0 +1,1324 @@
>> +/*
>> + * iss_csi2.c
>> + *
>> + * TI OMAP4 ISS - CSI PHY module
>> + *
>> + * Copyright (C) 2011 Texas Instruments, Inc.
>> + *
>> + * Contacts: Sergio Aguirre <saaguirre@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + */
>> +#include <linux/delay.h>
>> +#include <media/v4l2-common.h>
>> +#include <linux/v4l2-mediabus.h>
>> +#include <linux/mm.h>
>> +
>> +#include "iss.h"
>> +#include "iss_regs.h"
>> +#include "iss_csi2.h"
>> +
>> +/*
>> + * csi2_if_enable - Enable CSI2 Receiver interface.
>> + * @enable: enable flag
>> + *
>> + */
>> +static void csi2_if_enable(struct iss_csi2_device *csi2, u8 enable)
>> +{
>> + =A0 =A0 struct iss_csi2_ctrl_cfg *currctrl =3D &csi2->ctrl;
>> +
>> + =A0 =A0 writel((readl(csi2->regs1 + CSI2_CTRL) & ~CSI2_CTRL_IF_EN)=
 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (enable ? CSI2_CTRL_IF_EN : 0),
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs1 + CSI2_CTRL);
>> +
>> + =A0 =A0 currctrl->if_enable =3D enable;
>> +}
>> +
>> +/*
>> + * csi2_recv_config - CSI2 receiver module configuration.
>> + * @currctrl: iss_csi2_ctrl_cfg structure
>> + *
>> + */
>> +static void csi2_recv_config(struct iss_csi2_device *csi2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_csi2=
_ctrl_cfg *currctrl)
>> +{
>> + =A0 =A0 u32 reg;
>> +
>> + =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_CTRL);
>> +
>> + =A0 =A0 if (currctrl->frame_mode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTRL_FRAME;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTRL_FRAME;
>> +
>> + =A0 =A0 if (currctrl->vp_clk_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTRL_VP_CLK_EN;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTRL_VP_CLK_EN;
>> +
>> + =A0 =A0 if (currctrl->vp_only_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTRL_VP_ONLY_EN;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTRL_VP_ONLY_EN;
>> +
>> + =A0 =A0 reg &=3D ~CSI2_CTRL_VP_OUT_CTRL_MASK;
>> + =A0 =A0 reg |=3D currctrl->vp_out_ctrl << CSI2_CTRL_VP_OUT_CTRL_SH=
IFT;
>> +
>> + =A0 =A0 if (currctrl->ecc_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTRL_ECC_EN;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTRL_ECC_EN;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Set MFlag assertion boundaries to:
>> + =A0 =A0 =A0* Low: 4/8 of FIFO size
>> + =A0 =A0 =A0* High: 6/8 of FIFO size
>> + =A0 =A0 =A0*/
>> + =A0 =A0 reg &=3D ~(CSI2_CTRL_MFLAG_LEVH_MASK | CSI2_CTRL_MFLAG_LEV=
L_MASK);
>> + =A0 =A0 reg |=3D (2 << CSI2_CTRL_MFLAG_LEVH_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0(4 << CSI2_CTRL_MFLAG_LEVL_SHIFT);
>> +
>> + =A0 =A0 /* Generation of 16x64-bit bursts (Recommended) */
>> + =A0 =A0 reg |=3D CSI2_CTRL_BURST_SIZE_EXPAND;
>> +
>> + =A0 =A0 /* Do Non-Posted writes (Recommended) */
>> + =A0 =A0 reg |=3D CSI2_CTRL_NON_POSTED_WRITE;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Enforce Little endian for all formats, including:
>> + =A0 =A0 =A0* YUV4:2:2 8-bit and YUV4:2:0 Legacy
>> + =A0 =A0 =A0*/
>> + =A0 =A0 reg |=3D CSI2_CTRL_ENDIANNESS;
>> +
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_CTRL);
>
> Is this register accessed elsewhere? If not, you could skip reading i=
t and
> just write the value there. This was very common in the original OMAP=
 3 ISP
> driver. :)

Right. Will fix.

>
>> +}
>> +
>> +static const unsigned int csi2_input_fmts[] =3D {
>> + =A0 =A0 V4L2_MBUS_FMT_SGRBG10_1X10,
>> + =A0 =A0 V4L2_MBUS_FMT_SGRBG10_DPCM8_1X8,
>> + =A0 =A0 V4L2_MBUS_FMT_SRGGB10_1X10,
>> + =A0 =A0 V4L2_MBUS_FMT_SRGGB10_DPCM8_1X8,
>> + =A0 =A0 V4L2_MBUS_FMT_SBGGR10_1X10,
>> + =A0 =A0 V4L2_MBUS_FMT_SBGGR10_DPCM8_1X8,
>> + =A0 =A0 V4L2_MBUS_FMT_SGBRG10_1X10,
>> + =A0 =A0 V4L2_MBUS_FMT_SGBRG10_DPCM8_1X8,
>> + =A0 =A0 V4L2_MBUS_FMT_UYVY8_1X16,
>> + =A0 =A0 V4L2_MBUS_FMT_YUYV8_1X16,
>> +};
>> +
>> +/* To set the format on the CSI2 requires a mapping function that t=
akes
>> + * the following inputs:
>> + * - 3 different formats (at this time)
>> + * - 2 destinations (mem, vp+mem) (vp only handled separately)
>> + * - 2 decompression options (on, off)
>> + * Output should be CSI2 frame format code
>> + * Array indices as follows: [format][dest][decompr]
>> + * Not all combinations are valid. 0 means invalid.
>> + */
>> +static const u16 __csi2_fmt_map[][2][2] =3D {
>> + =A0 =A0 /* RAW10 formats */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Output to memory */
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No DPCM decompression *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_PIX_FMT_RAW10_EXP16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DPCM decompression */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Output to both */
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No DPCM decompression *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_PIX_FMT_RAW10_EXP16_V=
P,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DPCM decompression */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 /* RAW10 DPCM8 formats */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Output to memory */
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No DPCM decompression *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_USERDEF_8BIT_DATA1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DPCM decompression */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_USERDEF_8BIT_DATA1_DP=
CM10,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Output to both */
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No DPCM decompression *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_PIX_FMT_RAW8_VP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DPCM decompression */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_USERDEF_8BIT_DATA1_DP=
CM10_VP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 /* YUV422 formats */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Output to memory */
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No DPCM decompression *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_PIX_FMT_YUV422_8BIT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DPCM decompression */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Output to both */
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No DPCM decompression *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_PIX_FMT_YUV422_8BIT_V=
P,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DPCM decompression */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> +};
>> +
>> +/*
>> + * csi2_ctx_map_format - Map CSI2 sink media bus format to CSI2 for=
mat ID
>> + * @csi2: ISS CSI2 device
>> + *
>> + * Returns CSI2 physical format id
>> + */
>> +static u16 csi2_ctx_map_format(struct iss_csi2_device *csi2)
>> +{
>> + =A0 =A0 const struct v4l2_mbus_framefmt *fmt =3D &csi2->formats[CS=
I2_PAD_SINK];
>> + =A0 =A0 int fmtidx, destidx;
>> +
>> + =A0 =A0 switch (fmt->code) {
>> + =A0 =A0 case V4L2_MBUS_FMT_SGRBG10_1X10:
>> + =A0 =A0 case V4L2_MBUS_FMT_SRGGB10_1X10:
>> + =A0 =A0 case V4L2_MBUS_FMT_SBGGR10_1X10:
>> + =A0 =A0 case V4L2_MBUS_FMT_SGBRG10_1X10:
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmtidx =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case V4L2_MBUS_FMT_SGRBG10_DPCM8_1X8:
>> + =A0 =A0 case V4L2_MBUS_FMT_SRGGB10_DPCM8_1X8:
>> + =A0 =A0 case V4L2_MBUS_FMT_SBGGR10_DPCM8_1X8:
>> + =A0 =A0 case V4L2_MBUS_FMT_SGBRG10_DPCM8_1X8:
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmtidx =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case V4L2_MBUS_FMT_UYVY8_1X16:
>> + =A0 =A0 case V4L2_MBUS_FMT_YUYV8_1X16:
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmtidx =3D 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "CSI2: pixel format %08x =
unsupported!\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fmt->code);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!(csi2->output & CSI2_OUTPUT_IPIPEIF) &&
>> + =A0 =A0 =A0 =A0 !(csi2->output & CSI2_OUTPUT_MEMORY)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Neither output enabled is a valid combi=
nation */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return CSI2_PIX_FMT_OTHERS;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* If we need to skip frames at the beginning of the strea=
m disable the
>> + =A0 =A0 =A0* video port to avoid sending the skipped frames to the=
 IPIPEIF.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 destidx =3D csi2->frame_skip ? 0 : !!(csi2->output & CSI2_=
OUTPUT_IPIPEIF);
>> +
>> + =A0 =A0 return __csi2_fmt_map[fmtidx][destidx][csi2->dpcm_decompre=
ss];
>> +}
>> +
>> +/*
>> + * csi2_set_outaddr - Set memory address to save output image
>> + * @csi2: Pointer to ISS CSI2a device.
>> + * @addr: 32-bit memory address aligned on 32 byte boundary.
>> + *
>> + * Sets the memory address where the output will be saved.
>> + *
>> + * Returns 0 if successful, or -EINVAL if the address is not in the=
 32 byte
>> + * boundary.
>> + */
>> +static void csi2_set_outaddr(struct iss_csi2_device *csi2, u32 addr=
)
>> +{
>> + =A0 =A0 struct iss_csi2_ctx_cfg *ctx =3D &csi2->contexts[0];
>> +
>> + =A0 =A0 ctx->ping_addr =3D addr;
>> + =A0 =A0 ctx->pong_addr =3D addr;
>> + =A0 =A0 writel(ctx->ping_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0csi2->regs1 + CSI2_CTX_PING_ADDR(ctx->ctxnu=
m));
>> + =A0 =A0 writel(ctx->pong_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0csi2->regs1 + CSI2_CTX_PONG_ADDR(ctx->ctxnu=
m));
>> +}
>> +
>> +/*
>> + * is_usr_def_mapping - Checks whether USER_DEF_MAPPING should
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 be enabled by CSI2.
>> + * @format_id: mapped format id
>> + *
>> + */
>> +static inline int is_usr_def_mapping(u32 format_id)
>> +{
>> + =A0 =A0 return (format_id & 0x40) ? 1 : 0;
>> +}
>> +
>> +/*
>> + * csi2_ctx_enable - Enable specified CSI2 context
>> + * @ctxnum: Context number, valid between 0 and 7 values.
>> + * @enable: enable
>> + *
>> + */
>> +static void csi2_ctx_enable(struct iss_csi2_device *csi2, u8 ctxnum=
, u8 enable)
>> +{
>> + =A0 =A0 struct iss_csi2_ctx_cfg *ctx =3D &csi2->contexts[ctxnum];
>> + =A0 =A0 u32 reg;
>> +
>> + =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_CTX_CTRL1(ctxnum));
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int skip =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (csi2->frame_skip)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skip =3D csi2->frame_skip;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (csi2->output & CSI2_OUTPUT_MEMORY=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skip =3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTX_CTRL1_COUNT_MASK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTX_CTRL1_COUNT_UNLOCK
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0(skip << CSI2_CTX_CTRL1_COUNT=
_SHIFT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0CSI2_CTX_CTRL1_CTX_EN;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTX_CTRL1_CTX_EN;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_CTX_CTRL1(ctxnum));
>> + =A0 =A0 ctx->enabled =3D enable;
>> +}
>> +
>> +/*
>> + * csi2_ctx_config - CSI2 context configuration.
>> + * @ctx: context configuration
>> + *
>> + */
>> +static void csi2_ctx_config(struct iss_csi2_device *csi2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iss_csi2_ct=
x_cfg *ctx)
>> +{
>> + =A0 =A0 u32 reg;
>> +
>> + =A0 =A0 /* Set up CSI2_CTx_CTRL1 */
>> + =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_CTX_CTRL1(ctx->ctxnum));
>>
>> + =A0 =A0 if (ctx->eof_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTX_CTRL1_EOF_EN;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTX_CTRL1_EOF_EN;
>> +
>> + =A0 =A0 if (ctx->eol_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTX_CTRL1_EOL_EN;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTX_CTRL1_EOL_EN;
>> +
>> + =A0 =A0 if (ctx->checksum_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTX_CTRL1_CS_EN;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTX_CTRL1_CS_EN;
>> +
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_CTX_CTRL1(ctx->ctxnum));
>> +
>> + =A0 =A0 /* Set up CSI2_CTx_CTRL2 */
>> + =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_CTX_CTRL2(ctx->ctxnum));
>
> CTX_CTRL2 is only used in this function. I don't think you'd need to =
read it
> back. How about other CTX_CTRL regs?

Right. Will fix.

>
>> + =A0 =A0 reg &=3D ~(CSI2_CTX_CTRL2_VIRTUAL_ID_MASK);
>> + =A0 =A0 reg |=3D ctx->virtual_id << CSI2_CTX_CTRL2_VIRTUAL_ID_SHIF=
T;
>> +
>> + =A0 =A0 reg &=3D ~(CSI2_CTX_CTRL2_FORMAT_MASK);
>> + =A0 =A0 reg |=3D ctx->format_id << CSI2_CTX_CTRL2_FORMAT_SHIFT;
>> +
>> + =A0 =A0 if (ctx->dpcm_decompress) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ctx->dpcm_predictor)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTX_CTRL2_DP=
CM_PRED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTX_CTRL2_D=
PCM_PRED;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (is_usr_def_mapping(ctx->format_id)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_CTX_CTRL2_USER_DEF_MAP_MASK=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D 2 << CSI2_CTX_CTRL2_USER_DEF_MAP_=
SHIFT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_CTX_CTRL2(ctx->ctxnum));
>> +
>> + =A0 =A0 /* Set up CSI2_CTx_CTRL3 */
>> + =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_CTX_CTRL3(ctx->ctxnum));
>> + =A0 =A0 reg &=3D ~(CSI2_CTX_CTRL3_ALPHA_MASK);
>> + =A0 =A0 reg |=3D (ctx->alpha << CSI2_CTX_CTRL3_ALPHA_SHIFT);
>> +
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_CTX_CTRL3(ctx->ctxnum));
>> +
>> + =A0 =A0 /* Set up CSI2_CTx_DAT_OFST */
>> + =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_CTX_DAT_OFST(ctx->ctxnum)=
);
>> + =A0 =A0 reg &=3D ~CSI2_CTX_DAT_OFST_MASK;
>> + =A0 =A0 reg |=3D ctx->data_offset;
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_CTX_DAT_OFST(ctx->ctxnum));
>> +
>> + =A0 =A0 writel(ctx->ping_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csi2->regs1 + CSI2_CTX_PING=
_ADDR(ctx->ctxnum));
>> +
>> + =A0 =A0 writel(ctx->pong_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csi2->regs1 + CSI2_CTX_PONG=
_ADDR(ctx->ctxnum));
>> +}
>> +
>> +/*
>> + * csi2_timing_config - CSI2 timing configuration.
>> + * @timing: csi2_timing_cfg structure
>> + */
>> +static void csi2_timing_config(struct iss_csi2_device *csi2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_=
csi2_timing_cfg *timing)
>> +{
>> + =A0 =A0 u32 reg;
>> +
>> + =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_TIMING);
>> +
>> + =A0 =A0 if (timing->force_rx_mode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_TIMING_FORCE_RX_MODE_IO1;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_TIMING_FORCE_RX_MODE_IO1;
>> +
>> + =A0 =A0 if (timing->stop_state_16x)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_TIMING_STOP_STATE_X16_IO1;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_TIMING_STOP_STATE_X16_IO1;
>> +
>> + =A0 =A0 if (timing->stop_state_4x)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_TIMING_STOP_STATE_X4_IO1;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~CSI2_TIMING_STOP_STATE_X4_IO1;
>> +
>> + =A0 =A0 reg &=3D ~CSI2_TIMING_STOP_STATE_COUNTER_IO1_MASK;
>> + =A0 =A0 reg |=3D timing->stop_state_counter <<
>> + =A0 =A0 =A0 =A0 =A0 =A0CSI2_TIMING_STOP_STATE_COUNTER_IO1_SHIFT;
>> +
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_TIMING);
>> +}
>> +
>> +/*
>> + * csi2_irq_ctx_set - Enables CSI2 Context IRQs.
>> + * @enable: Enable/disable CSI2 Context interrupts
>> + */
>> +static void csi2_irq_ctx_set(struct iss_csi2_device *csi2, int enab=
le)
>> +{
>> + =A0 =A0 u32 reg =3D CSI2_CTX_IRQ_FE;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 if (csi2->use_fs_irq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D CSI2_CTX_IRQ_FS;
>> +
>> + =A0 =A0 for (i =3D 0; i < 8; i++) {
>
> 8 =3D=3D number of contexts?

Yes. This loops from 0 to 7.

Are you implying that I need to add a define to this?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(reg, csi2->regs1 + CSI2_CTX_IRQSTAT=
US(i));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(readl(csi2->regs1 +=
 CSI2_CTX_IRQENABLE(i)) | reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs=
1 + CSI2_CTX_IRQENABLE(i));
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(readl(csi2->regs1 +=
 CSI2_CTX_IRQENABLE(i)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs=
1 + CSI2_CTX_IRQENABLE(i));
>> + =A0 =A0 }
>> +}
>> +
>> +/*
>> + * csi2_irq_complexio1_set - Enables CSI2 ComplexIO IRQs.
>> + * @enable: Enable/disable CSI2 ComplexIO #1 interrupts
>> + */
>> +static void csi2_irq_complexio1_set(struct iss_csi2_device *csi2, i=
nt enable)
>> +{
>> + =A0 =A0 u32 reg;
>> + =A0 =A0 reg =3D CSI2_COMPLEXIO_IRQ_STATEALLULPMEXIT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_STATEALLULPMENTER |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_STATEULPM5 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRCONTROL5 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRESC5 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS5 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTHS5 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_STATEULPM4 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRCONTROL4 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRESC4 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS4 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTHS4 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_STATEULPM3 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRCONTROL3 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRESC3 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS3 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTHS3 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_STATEULPM2 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRCONTROL2 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRESC2 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS2 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTHS2 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_STATEULPM1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRCONTROL1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRESC1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_IRQ_ERRSOTHS1;
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_COMPLEXIO_IRQSTATUS);
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D readl(csi2->regs1 + CSI2_COMPLEXI=
O_IRQENABLE);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D 0;
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_COMPLEXIO_IRQENABLE);
>> +}
>> +
>> +/*
>> + * csi2_irq_status_set - Enables CSI2 Status IRQs.
>> + * @enable: Enable/disable CSI2 Status interrupts
>> + */
>> +static void csi2_irq_status_set(struct iss_csi2_device *csi2, int e=
nable)
>> +{
>> + =A0 =A0 u32 reg;
>> + =A0 =A0 reg =3D CSI2_IRQ_OCP_ERR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_SHORT_PACKET |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_ECC_CORRECTION |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_ECC_NO_CORRECTION |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_COMPLEXIO_ERR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_FIFO_OVF |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_CONTEXT0;
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_IRQSTATUS);
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D readl(csi2->regs1 + CSI2_IRQENABL=
E);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D 0;
>> +
>> + =A0 =A0 writel(reg, csi2->regs1 + CSI2_IRQENABLE);
>> +}
>> +
>> +/*
>> + * omap4iss_csi2_reset - Resets the CSI2 module.
>> + *
>> + * Must be called with the phy lock held.
>> + *
>> + * Returns 0 if successful, or -EBUSY if power command didn't respo=
nd.
>> + */
>> +int omap4iss_csi2_reset(struct iss_csi2_device *csi2)
>> +{
>> + =A0 =A0 u8 soft_reset_retries =3D 0;
>> + =A0 =A0 u32 reg;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 if (!csi2->available)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 if (csi2->phy->phy_in_use)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 writel(readl(csi2->regs1 + CSI2_SYSCONFIG) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_SYSCONFIG_SOFT_RESET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs1 + CSI2_SYSCONFIG);
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D readl(csi2->regs1 + CSI2_SYSSTATUS=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CS=
I2_SYSSTATUS_RESET_DONE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (reg =3D=3D CSI2_SYSSTATUS_RESET_DONE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 soft_reset_retries++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (soft_reset_retries < 5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(100);
>
> How about usleep_range() here? Or omit such a long busyloop. Hardware
> typically resets quite fast.

I guess i'll try to fine-tune this then.

>
>> + =A0 =A0 } while (soft_reset_retries < 5);
>> +
>> + =A0 =A0 if (soft_reset_retries =3D=3D 5) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "CSI2: Soft reset try coun=
t exceeded!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 writel(readl(csi2->regs1 + CSI2_COMPLEXIO_CFG) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_CFG_RESET_CTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs1 + CSI2_COMPLEXIO_CFG);
>> +
>> + =A0 =A0 i =3D 100;
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D readl(csi2->phy->phy_regs + REGIST=
ER1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & REGISTER1_RESET_DONE_CTRLCLK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (reg =3D=3D REGISTER1_RESET_DONE_CTRLCL=
K)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(100);
>
> Same here.

Ok. Will do too.

>
>> + =A0 =A0 } while (--i > 0);
>> +
>> + =A0 =A0 if (i =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"CSI2: Reset for CSI2_96M_F=
CLK domain Failed!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 writel((readl(csi2->regs1 + CSI2_SYSCONFIG) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(CSI2_SYSCONFIG_MSTANDBY_MODE_MASK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_SYSCONFIG_AUTO_IDLE)) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 CSI2_SYSCONFIG_MSTANDBY_MODE_NO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs1 + CSI2_SYSCONFIG);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int csi2_configure(struct iss_csi2_device *csi2)
>> +{
>> + =A0 =A0 const struct iss_v4l2_subdevs_group *pdata;
>> + =A0 =A0 struct iss_csi2_timing_cfg *timing =3D &csi2->timing[0];
>> + =A0 =A0 struct v4l2_subdev *sensor;
>> + =A0 =A0 struct media_pad *pad;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* CSI2 fields that can be updated while the context has
>> + =A0 =A0 =A0* been enabled or the interface has been enabled are no=
t
>> + =A0 =A0 =A0* updated dynamically currently. So we do not allow to
>> + =A0 =A0 =A0* reconfigure if either has been enabled
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (csi2->contexts[0].enabled || csi2->ctrl.if_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 pad =3D media_entity_remote_source(&csi2->pads[CSI2_PAD_SI=
NK]);
>> + =A0 =A0 sensor =3D media_entity_to_v4l2_subdev(pad->entity);
>> + =A0 =A0 pdata =3D sensor->host_priv;
>> +
>> + =A0 =A0 csi2->frame_skip =3D 0;
>> + =A0 =A0 v4l2_subdev_call(sensor, sensor, g_skip_frames, &csi2->fra=
me_skip);
>> +
>> + =A0 =A0 csi2->ctrl.vp_out_ctrl =3D pdata->bus.csi2.vpclk_div;
>> + =A0 =A0 csi2->ctrl.frame_mode =3D ISS_CSI2_FRAME_IMMEDIATE;
>> + =A0 =A0 csi2->ctrl.ecc_enable =3D pdata->bus.csi2.crc;
>> +
>> + =A0 =A0 timing->force_rx_mode =3D 1;
>> + =A0 =A0 timing->stop_state_16x =3D 1;
>> + =A0 =A0 timing->stop_state_4x =3D 1;
>> + =A0 =A0 timing->stop_state_counter =3D 0x1FF;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* The CSI2 receiver can't do any format conversion exce=
pt DPCM
>> + =A0 =A0 =A0* decompression, so every set_format call configures bo=
th pads
>> + =A0 =A0 =A0* and enables DPCM decompression as a special case:
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (csi2->formats[CSI2_PAD_SINK].code !=3D
>> + =A0 =A0 =A0 =A0 csi2->formats[CSI2_PAD_SOURCE].code)
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->dpcm_decompress =3D true;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->dpcm_decompress =3D false;
>> +
>> + =A0 =A0 csi2->contexts[0].format_id =3D csi2_ctx_map_format(csi2);
>> +
>> + =A0 =A0 if (csi2->video_out.bpl_padding =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->contexts[0].data_offset =3D 0;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->contexts[0].data_offset =3D csi2->vi=
deo_out.bpl_value;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Enable end of frame and end of line signals generatio=
n for
>> + =A0 =A0 =A0* context 0. These signals are generated from CSI2 rece=
iver to
>> + =A0 =A0 =A0* qualify the last pixel of a frame and the last pixel =
of a line.
>> + =A0 =A0 =A0* Without enabling the signals CSI2 receiver writes dat=
a to memory
>> + =A0 =A0 =A0* beyond buffer size and/or data line offset is not han=
dled correctly.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 csi2->contexts[0].eof_enabled =3D 1;
>> + =A0 =A0 csi2->contexts[0].eol_enabled =3D 1;
>> +
>> + =A0 =A0 csi2_irq_complexio1_set(csi2, 1);
>> + =A0 =A0 csi2_irq_ctx_set(csi2, 1);
>> + =A0 =A0 csi2_irq_status_set(csi2, 1);
>> +
>> + =A0 =A0 /* Set configuration (timings, format and links) */
>> + =A0 =A0 csi2_timing_config(csi2, timing);
>> + =A0 =A0 csi2_recv_config(csi2, &csi2->ctrl);
>> + =A0 =A0 csi2_ctx_config(csi2, &csi2->contexts[0]);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * csi2_print_status - Prints CSI2 debug information.
>> + */
>> +#define CSI2_PRINT_REGISTER(iss, regs, name)\
>> + =A0 =A0 dev_dbg(iss->dev, "###CSI2 " #name "=3D0x%08x\n", \
>> + =A0 =A0 =A0 =A0 =A0 =A0 readl(regs + CSI2_##name))
>> +
>> +static void csi2_print_status(struct iss_csi2_device *csi2)
>> +{
>> + =A0 =A0 struct iss_device *iss =3D csi2->iss;
>> +
>> + =A0 =A0 if (!csi2->available)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 dev_dbg(iss->dev, "-------------CSI2 Register dump--------=
-----\n");
>> +
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, SYSCONFIG);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, SYSSTATUS);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, IRQENABLE);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, IRQSTATUS);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTRL);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, DBG_H);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, COMPLEXIO_CFG);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, COMPLEXIO_IRQSTATUS)=
;
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, SHORT_PACKET);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, COMPLEXIO_IRQENABLE)=
;
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, DBG_P);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, TIMING);
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_CTRL1(0));
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_CTRL2(0));
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_DAT_OFST(0));
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_PING_ADDR(0));
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_PONG_ADDR(0));
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_IRQENABLE(0));
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_IRQSTATUS(0));
>> + =A0 =A0 CSI2_PRINT_REGISTER(iss, csi2->regs1, CTX_CTRL3(0));
>> +
>> + =A0 =A0 dev_dbg(iss->dev, "---------------------------------------=
-----\n");
>
> _If_ this is user-triggered, you might want to consider using debugfs=
 for
> the same. Just FYI.

Ok. I'll see what can I do.

>
>> +}
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * Interrupt handling
>> + */
>> +
>> +/*
>> + * csi2_isr_buffer - Does buffer handling at end-of-frame
>> + * when writing to memory.
>> + */
>> +static void csi2_isr_buffer(struct iss_csi2_device *csi2)
>> +{
>> + =A0 =A0 struct iss_buffer *buffer;
>> +
>> + =A0 =A0 csi2_ctx_enable(csi2, 0, 0);
>> +
>> + =A0 =A0 buffer =3D omap4iss_video_buffer_next(&csi2->video_out, 0)=
;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Let video queue operation restart engine if there is =
an underrun
>> + =A0 =A0 =A0* condition.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (buffer =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 csi2_set_outaddr(csi2, buffer->iss_addr);
>> + =A0 =A0 csi2_ctx_enable(csi2, 0, 1);
>> +}
>> +
>> +static void csi2_isr_ctx(struct iss_csi2_device *csi2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_csi2_ctx_cfg=
 *ctx)
>> +{
>> + =A0 =A0 unsigned int n =3D ctx->ctxnum;
>> + =A0 =A0 u32 status;
>> +
>> + =A0 =A0 status =3D readl(csi2->regs1 + CSI2_CTX_IRQSTATUS(n));
>> + =A0 =A0 writel(status, csi2->regs1 + CSI2_CTX_IRQSTATUS(n));
>> +
>> + =A0 =A0 /* Propagate frame number */
>> + =A0 =A0 if (status & CSI2_CTX_IRQ_FS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct iss_pipeline *pipe =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
to_iss_pipeline(&csi2->subdev.entity);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pipe->do_propagation)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_inc(&pipe->frame_nu=
mber);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!(status & CSI2_CTX_IRQ_FE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /* Skip interrupts until we reach the frame skip count. Th=
e CSI2 will be
>> + =A0 =A0 =A0* automatically disabled, as the frame skip count has b=
een programmed
>> + =A0 =A0 =A0* in the CSI2_CTx_CTRL1::COUNT field, so reenable it.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* It would have been nice to rely on the FRAME_NUMBER i=
nterrupt instead
>> + =A0 =A0 =A0* but it turned out that the interrupt is only generate=
d when the CSI2
>> + =A0 =A0 =A0* writes to memory (the CSI2_CTx_CTRL1::COUNT field is =
decreased
>> + =A0 =A0 =A0* correctly and reaches 0 when data is forwarded to the=
 video port only
>> + =A0 =A0 =A0* but no interrupt arrives). Maybe a CSI2 hardware bug.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (csi2->frame_skip) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->frame_skip--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (csi2->frame_skip =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx->format_id =3D csi2_ct=
x_map_format(csi2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2_ctx_config(csi2, ctx)=
;
>
> Is configuration of the context needed elsewhere than in streamon? Wh=
at
> changes while streaming?

Nothing I think...

Same thing is done for OMAP3, so I tried to keep the driver as similar
as possible.

I'll try removing this then.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2_ctx_enable(csi2, n, 1=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (csi2->output & CSI2_OUTPUT_MEMORY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_isr_buffer(csi2);
>> +}
>> +
>> +/*
>> + * omap4iss_csi2_isr - CSI2 interrupt handling.
>> + *
>> + * Return -EIO on Transmission error
>> + */
>> +int omap4iss_csi2_isr(struct iss_csi2_device *csi2)
>> +{
>> + =A0 =A0 u32 csi2_irqstatus, cpxio1_irqstatus;
>> + =A0 =A0 struct iss_device *iss =3D csi2->iss;
>> + =A0 =A0 int retval =3D 0;
>> +
>> + =A0 =A0 if (!csi2->available)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 csi2_irqstatus =3D readl(csi2->regs1 + CSI2_IRQSTATUS);
>> + =A0 =A0 writel(csi2_irqstatus, csi2->regs1 + CSI2_IRQSTATUS);
>> +
>> + =A0 =A0 /* Failure Cases */
>> + =A0 =A0 if (csi2_irqstatus & CSI2_IRQ_COMPLEXIO_ERR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpxio1_irqstatus =3D readl(csi2->regs1 +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0CSI2_COMPLEXIO_IRQSTATUS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(cpxio1_irqstatus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2->regs1 + CSI2_COMPLEX=
IO_IRQSTATUS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(iss->dev, "CSI2: ComplexIO Error I=
RQ "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%x\n", cpxio1_irqstatus);
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (csi2_irqstatus & (CSI2_IRQ_OCP_ERR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_SHORT=
_PACKET |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_ECC_N=
O_CORRECTION |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_COMPL=
EXIO_ERR |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_IRQ_FIFO_=
OVF)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(iss->dev, "CSI2 Err:"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " OCP:%d,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " Short_pack:%d,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " ECC:%d,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " CPXIO:%d,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " FIFO_OVF:%d,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (csi2_irqstatus &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSI2_IRQ_OCP_ERR) ? 1 :=
 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (csi2_irqstatus &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSI2_IRQ_SHORT_PACKET) =
? 1 : 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (csi2_irqstatus &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSI2_IRQ_ECC_NO_CORRECT=
ION) ? 1 : 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (csi2_irqstatus &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSI2_IRQ_COMPLEXIO_ERR)=
 ? 1 : 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (csi2_irqstatus &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSI2_IRQ_FIFO_OVF) ? 1 =
: 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (omap4iss_module_sync_is_stopping(&csi2->wait, &csi2->s=
topping))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 /* Successful cases */
>> + =A0 =A0 if (csi2_irqstatus & CSI2_IRQ_CONTEXT0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_isr_ctx(csi2, &csi2->contexts[0]);
>> +
>> + =A0 =A0 if (csi2_irqstatus & CSI2_IRQ_ECC_CORRECTION)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(iss->dev, "CSI2: ECC correction do=
ne\n");
>> +
>> + =A0 =A0 return retval;
>> +}
>>
>> +/* ----------------------------------------------------------------=
-------------
>> + * ISS video operations
>> + */
>> +
>> +/*
>> + * csi2_queue - Queues the first buffer when using memory output
>> + * @video: The video node
>> + * @buffer: buffer to queue
>> + */
>> +static int csi2_queue(struct iss_video *video, struct iss_buffer *b=
uffer)
>> +{
>> + =A0 =A0 struct iss_device *iss =3D video->iss;
>> + =A0 =A0 struct iss_csi2_device *csi2 =3D &iss->csi2a;
>> +
>> + =A0 =A0 csi2_set_outaddr(csi2, buffer->iss_addr);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If streaming was enabled before there was a buffer qu=
eued
>> + =A0 =A0 =A0* or underrun happened in the ISR, the hardware was not=
 enabled
>> + =A0 =A0 =A0* and DMA queue flag ISS_VIDEO_DMAQUEUE_UNDERRUN is sti=
ll set.
>> + =A0 =A0 =A0* Enable it now.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (csi2->video_out.dmaqueue_flags & ISS_VIDEO_DMAQUEUE_UN=
DERRUN) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Enable / disable context 0 and IRQs */
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_if_enable(csi2, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_ctx_enable(csi2, 0, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_video_dmaqueue_flags_clr(&csi2->video_=
out);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct iss_video_operations csi2_issvideo_ops =3D {
>> + =A0 =A0 .queue =3D csi2_queue,
>> +};
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * V4L2 subdev operations
>> + */
>> +
>> +static struct v4l2_mbus_framefmt *
>> +__csi2_get_format(struct iss_csi2_device *csi2, struct v4l2_subdev_=
fh *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pad, enum v4l2_subdev_for=
mat_whence which)
>> +{
>> + =A0 =A0 if (which =3D=3D V4L2_SUBDEV_FORMAT_TRY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return v4l2_subdev_get_try_format(fh, pad)=
;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return &csi2->formats[pad];
>> +}
>> +
>> +static void
>> +csi2_try_format(struct iss_csi2_device *csi2, struct v4l2_subdev_fh=
 *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pad, struct v4l2_mbus_framefm=
t *fmt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 enum v4l2_subdev_format_whence which)
>> +{
>> + =A0 =A0 enum v4l2_mbus_pixelcode pixelcode;
>> + =A0 =A0 struct v4l2_mbus_framefmt *format;
>> + =A0 =A0 const struct iss_format_info *info;
>> + =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 switch (pad) {
>> + =A0 =A0 case CSI2_PAD_SINK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Clamp the width and height to valid ran=
ge (1-8191). */
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(csi2_input_fm=
ts); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fmt->code =3D=3D csi2_=
input_fmts[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* If not found, use SGRBG10 as default */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i >=3D ARRAY_SIZE(csi2_input_fmts))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt->code =3D V4L2_MBUS_FM=
T_SGRBG10_1X10;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt->width =3D clamp_t(u32, fmt->width, 1,=
 8191);
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt->height =3D clamp_t(u32, fmt->height, =
1, 8191);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case CSI2_PAD_SOURCE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Source format same as sink format, exce=
pt for DPCM
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* compression.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 pixelcode =3D fmt->code;
>> + =A0 =A0 =A0 =A0 =A0 =A0 format =3D __csi2_get_format(csi2, fh, CSI=
2_PAD_SINK, which);
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(fmt, format, sizeof(*fmt));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Only Allow DPCM decompression, and ch=
eck that the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* pattern is preserved
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 info =3D omap4iss_video_format_info(fmt->c=
ode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->uncompressed =3D=3D pixelcode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt->code =3D pixelcode;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* RGB, non-interlaced */
>> + =A0 =A0 fmt->colorspace =3D V4L2_COLORSPACE_SRGB;
>> + =A0 =A0 fmt->field =3D V4L2_FIELD_NONE;
>> +}
>> +
>> +/*
>> + * csi2_enum_mbus_code - Handle pixel format enumeration
>> + * @sd =A0 =A0 : pointer to v4l2 subdev structure
>> + * @fh =A0 =A0 : V4L2 subdev file handle
>> + * @code =A0 : pointer to v4l2_subdev_mbus_code_enum structure
>> + * return -EINVAL or zero on success
>> + */
>> +static int csi2_enum_mbus_code(struct v4l2_subdev *sd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2=
_subdev_fh *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2=
_subdev_mbus_code_enum *code)
>> +{
>> + =A0 =A0 struct iss_csi2_device *csi2 =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 struct v4l2_mbus_framefmt *format;
>> + =A0 =A0 const struct iss_format_info *info;
>> +
>> + =A0 =A0 if (code->pad =3D=3D CSI2_PAD_SINK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (code->index >=3D ARRAY_SIZE(csi2_input=
_fmts))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 code->code =3D csi2_input_fmts[code->index=
];
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 format =3D __csi2_get_format(csi2, fh, CSI=
2_PAD_SINK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0V4L2_SUBDEV_FORMAT_TRY);
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (code->index) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Passthrough sink pad co=
de */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code->code =3D format->cod=
e;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Uncompressed code */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info =3D omap4iss_video_fo=
rmat_info(format->code);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->uncompressed =3D=
=3D format->code)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EI=
NVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code->code =3D info->uncom=
pressed;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int csi2_enum_frame_size(struct v4l2_subdev *sd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l=
2_subdev_fh *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l=
2_subdev_frame_size_enum *fse)
>> +{
>> + =A0 =A0 struct iss_csi2_device *csi2 =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 struct v4l2_mbus_framefmt format;
>> +
>> + =A0 =A0 if (fse->index !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 format.code =3D fse->code;
>> + =A0 =A0 format.width =3D 1;
>> + =A0 =A0 format.height =3D 1;
>> + =A0 =A0 csi2_try_format(csi2, fh, fse->pad, &format, V4L2_SUBDEV_F=
ORMAT_TRY);
>> + =A0 =A0 fse->min_width =3D format.width;
>> + =A0 =A0 fse->min_height =3D format.height;
>> +
>> + =A0 =A0 if (format.code !=3D fse->code)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 format.code =3D fse->code;
>> + =A0 =A0 format.width =3D -1;
>> + =A0 =A0 format.height =3D -1;
>> + =A0 =A0 csi2_try_format(csi2, fh, fse->pad, &format, V4L2_SUBDEV_F=
ORMAT_TRY);
>> + =A0 =A0 fse->max_width =3D format.width;
>> + =A0 =A0 fse->max_height =3D format.height;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * csi2_get_format - Handle get format by pads subdev method
>> + * @sd : pointer to v4l2 subdev structure
>> + * @fh : V4L2 subdev file handle
>> + * @fmt: pointer to v4l2 subdev format structure
>> + * return -EINVAL or zero on success
>> + */
>> +static int csi2_get_format(struct v4l2_subdev *sd, struct v4l2_subd=
ev_fh *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_subdev_=
format *fmt)
>> +{
>> + =A0 =A0 struct iss_csi2_device *csi2 =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 struct v4l2_mbus_framefmt *format;
>> +
>> + =A0 =A0 format =3D __csi2_get_format(csi2, fh, fmt->pad, fmt->whic=
h);
>> + =A0 =A0 if (format =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 fmt->format =3D *format;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * csi2_set_format - Handle set format by pads subdev method
>> + * @sd : pointer to v4l2 subdev structure
>> + * @fh : V4L2 subdev file handle
>> + * @fmt: pointer to v4l2 subdev format structure
>> + * return -EINVAL or zero on success
>> + */
>> +static int csi2_set_format(struct v4l2_subdev *sd, struct v4l2_subd=
ev_fh *fh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct v4l2_subdev_=
format *fmt)
>> +{
>> + =A0 =A0 struct iss_csi2_device *csi2 =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 struct v4l2_mbus_framefmt *format;
>> +
>> + =A0 =A0 format =3D __csi2_get_format(csi2, fh, fmt->pad, fmt->whic=
h);
>> + =A0 =A0 if (format =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 csi2_try_format(csi2, fh, fmt->pad, &fmt->format, fmt->whi=
ch);
>> + =A0 =A0 *format =3D fmt->format;
>> +
>> + =A0 =A0 /* Propagate the format from sink to source */
>> + =A0 =A0 if (fmt->pad =3D=3D CSI2_PAD_SINK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 format =3D __csi2_get_format(csi2, fh, CSI=
2_PAD_SOURCE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0fmt->which);
>> + =A0 =A0 =A0 =A0 =A0 =A0 *format =3D fmt->format;
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_try_format(csi2, fh, CSI2_PAD_SOURCE,=
 format, fmt->which);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * csi2_init_formats - Initialize formats on all pads
>> + * @sd: ISS CSI2 V4L2 subdevice
>> + * @fh: V4L2 subdev file handle
>> + *
>> + * Initialize all pad formats with default values. If fh is not NUL=
L, try
>> + * formats are initialized on the file handle. Otherwise active for=
mats are
>> + * initialized on the device.
>> + */
>> +static int csi2_init_formats(struct v4l2_subdev *sd, struct v4l2_su=
bdev_fh *fh)
>> +{
>> + =A0 =A0 struct v4l2_subdev_format format;
>> +
>> + =A0 =A0 memset(&format, 0, sizeof(format));
>> + =A0 =A0 format.pad =3D CSI2_PAD_SINK;
>> + =A0 =A0 format.which =3D fh ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV=
_FORMAT_ACTIVE;
>> + =A0 =A0 format.format.code =3D V4L2_MBUS_FMT_SGRBG10_1X10;
>> + =A0 =A0 format.format.width =3D 4096;
>> + =A0 =A0 format.format.height =3D 4096;
>> + =A0 =A0 csi2_set_format(sd, fh, &format);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * csi2_set_stream - Enable/Disable streaming on the CSI2 module
>> + * @sd: ISS CSI2 V4L2 subdevice
>> + * @enable: ISS pipeline stream state
>> + *
>> + * Return 0 on success or a negative error code otherwise.
>> + */
>> +static int csi2_set_stream(struct v4l2_subdev *sd, int enable)
>> +{
>> + =A0 =A0 struct iss_csi2_device *csi2 =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 struct iss_device *iss =3D csi2->iss;
>> + =A0 =A0 struct iss_pipeline *pipe =3D to_iss_pipeline(&csi2->subde=
v.entity);
>> + =A0 =A0 struct iss_video *video_out =3D &csi2->video_out;
>> +
>> + =A0 =A0 if (csi2->state =3D=3D ISS_PIPELINE_STREAM_STOPPED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enable =3D=3D ISS_PIPELINE_STREAM_STOP=
PED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_subclk_enable(iss, OMAP4_ISS_SUBC=
LK_CSI2_A);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (enable) {
>> + =A0 =A0 case ISS_PIPELINE_STREAM_CONTINUOUS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (omap4iss_csiphy_acquire(csi2->phy) < 0=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2->use_fs_irq =3D pipe->do_propagation;
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_configure(csi2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_print_status(csi2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* When outputting to memory with no buf=
fer available, let the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* buffer queue handler start the hardwa=
re. A DMA queue flag
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* ISS_VIDEO_DMAQUEUE_QUEUED will be set=
 as soon as there is
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* a buffer available.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (csi2->output & CSI2_OUTPUT_MEMORY &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(video_out->dmaqueue_flags & ISS_=
VIDEO_DMAQUEUE_QUEUED))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Enable context 0 and IRQs */
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&csi2->stopping, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_ctx_enable(csi2, 0, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_if_enable(csi2, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_video_dmaqueue_flags_clr(video_out);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case ISS_PIPELINE_STREAM_STOPPED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (csi2->state =3D=3D ISS_PIPELINE_STREAM=
_STOPPED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (omap4iss_module_sync_idle(&sd->entity,=
 &csi2->wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 &csi2->stopping))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(iss->dev, "%s: mod=
ule stop timeout.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_ctx_enable(csi2, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_if_enable(csi2, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 csi2_irq_ctx_set(csi2, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_csiphy_release(csi2->phy);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_subclk_disable(iss, OMAP4_ISS_SUB=
CLK_CSI2_A);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iss_video_dmaqueue_flags_clr(video_out);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 csi2->state =3D enable;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* subdev video operations */
>> +static const struct v4l2_subdev_video_ops csi2_video_ops =3D {
>> + =A0 =A0 .s_stream =3D csi2_set_stream,
>> +};
>> +
>> +/* subdev pad operations */
>> +static const struct v4l2_subdev_pad_ops csi2_pad_ops =3D {
>> + =A0 =A0 .enum_mbus_code =3D csi2_enum_mbus_code,
>> + =A0 =A0 .enum_frame_size =3D csi2_enum_frame_size,
>> + =A0 =A0 .get_fmt =3D csi2_get_format,
>> + =A0 =A0 .set_fmt =3D csi2_set_format,
>> +};
>> +
>> +/* subdev operations */
>> +static const struct v4l2_subdev_ops csi2_ops =3D {
>> + =A0 =A0 .video =3D &csi2_video_ops,
>> + =A0 =A0 .pad =3D &csi2_pad_ops,
>> +};
>> +
>> +/* subdev internal operations */
>> +static const struct v4l2_subdev_internal_ops csi2_internal_ops =3D =
{
>> + =A0 =A0 .open =3D csi2_init_formats,
>> +};
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * Media entity operations
>> + */
>> +
>> +/*
>> + * csi2_link_setup - Setup CSI2 connections.
>> + * @entity : Pointer to media entity structure
>> + * @local =A0: Pointer to local pad array
>> + * @remote : Pointer to remote pad array
>> + * @flags =A0: Link flags
>> + * return -EINVAL or zero on success
>> + */
>> +static int csi2_link_setup(struct media_entity *entity,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct media_=
pad *local,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct media_=
pad *remote, u32 flags)
>> +{
>> + =A0 =A0 struct v4l2_subdev *sd =3D media_entity_to_v4l2_subdev(ent=
ity);
>> + =A0 =A0 struct iss_csi2_device *csi2 =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 struct iss_csi2_ctrl_cfg *ctrl =3D &csi2->ctrl;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* The ISS core doesn't support pipelines with multiple =
video outputs.
>> + =A0 =A0 =A0* Revisit this when it will be implemented, and return =
-EBUSY for now.
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 switch (local->index | media_entity_type(remote->entity)) =
{
>> + =A0 =A0 case CSI2_PAD_SOURCE | MEDIA_ENT_T_DEVNODE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (flags & MEDIA_LNK_FL_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (csi2->output & ~CSI2_O=
UTPUT_MEMORY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EB=
USY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2->output |=3D CSI2_OUT=
PUT_MEMORY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2->output &=3D ~CSI2_OU=
TPUT_MEMORY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case CSI2_PAD_SOURCE | MEDIA_ENT_T_V4L2_SUBDEV:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (flags & MEDIA_LNK_FL_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (csi2->output & ~CSI2_O=
UTPUT_IPIPEIF)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EB=
USY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2->output |=3D CSI2_OUT=
PUT_IPIPEIF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csi2->output &=3D ~CSI2_OU=
TPUT_IPIPEIF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Link from camera to CSI2 is fixed... */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ctrl->vp_only_enable =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 (csi2->output & CSI2_OUTPUT_MEMORY) ? fals=
e : true;
>> + =A0 =A0 ctrl->vp_clk_enable =3D !!(csi2->output & CSI2_OUTPUT_IPIP=
EIF);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* media operations */
>> +static const struct media_entity_operations csi2_media_ops =3D {
>> + =A0 =A0 .link_setup =3D csi2_link_setup,
>> +};
>> +
>> +/*
>> + * csi2_init_entities - Initialize subdev and media entity.
>> + * @csi2: Pointer to csi2 structure.
>> + * return -ENOMEM or zero on success
>> + */
>> +static int csi2_init_entities(struct iss_csi2_device *csi2)
>> +{
>> + =A0 =A0 struct v4l2_subdev *sd =3D &csi2->subdev;
>> + =A0 =A0 struct media_pad *pads =3D csi2->pads;
>> + =A0 =A0 struct media_entity *me =3D &sd->entity;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 v4l2_subdev_init(sd, &csi2_ops);
>> + =A0 =A0 sd->internal_ops =3D &csi2_internal_ops;
>> + =A0 =A0 strlcpy(sd->name, "OMAP4 ISS CSI2a", sizeof(sd->name));
>> +
>> + =A0 =A0 sd->grp_id =3D 1 << 16; =A0 /* group ID for iss subdevs */
>> + =A0 =A0 v4l2_set_subdevdata(sd, csi2);
>> + =A0 =A0 sd->flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
>> +
>> + =A0 =A0 pads[CSI2_PAD_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE;
>> + =A0 =A0 pads[CSI2_PAD_SINK].flags =3D MEDIA_PAD_FL_SINK;
>> +
>> + =A0 =A0 me->ops =3D &csi2_media_ops;
>> + =A0 =A0 ret =3D media_entity_init(me, CSI2_PADS_NUM, pads, 0);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 csi2_init_formats(sd, NULL);
>> +
>> + =A0 =A0 /* Video device node */
>> + =A0 =A0 csi2->video_out.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> + =A0 =A0 csi2->video_out.ops =3D &csi2_issvideo_ops;
>> + =A0 =A0 csi2->video_out.bpl_alignment =3D 32;
>> + =A0 =A0 csi2->video_out.bpl_zero_padding =3D 1;
>> + =A0 =A0 csi2->video_out.bpl_max =3D 0x1ffe0;
>> + =A0 =A0 csi2->video_out.iss =3D csi2->iss;
>> + =A0 =A0 csi2->video_out.capture_mem =3D PAGE_ALIGN(4096 * 4096) * =
3;
>> +
>> + =A0 =A0 ret =3D omap4iss_video_init(&csi2->video_out, "CSI2a");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 /* Connect the CSI2 subdev to the video node. */
>> + =A0 =A0 ret =3D media_entity_create_link(&csi2->subdev.entity, CSI=
2_PAD_SOURCE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0&csi2->video_out.video.entity, 0, 0);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +void omap4iss_csi2_unregister_entities(struct iss_csi2_device *csi2=
)
>> +{
>> + =A0 =A0 media_entity_cleanup(&csi2->subdev.entity);
>> +
>> + =A0 =A0 v4l2_device_unregister_subdev(&csi2->subdev);
>> + =A0 =A0 omap4iss_video_unregister(&csi2->video_out);
>> +}
>> +
>> +int omap4iss_csi2_register_entities(struct iss_csi2_device *csi2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct v4l2_device *vdev)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 /* Register the subdev and video nodes. */
>> + =A0 =A0 ret =3D v4l2_device_register_subdev(vdev, &csi2->subdev);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 ret =3D omap4iss_video_register(&csi2->video_out, vdev);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 return 0;
>> +
>> +error:
>> + =A0 =A0 omap4iss_csi2_unregister_entities(csi2);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * ISS CSI2 initialisation and cleanup
>> + */
>> +
>> +/*
>> + * omap4iss_csi2_cleanup - Routine for module driver cleanup
>> + */
>> +void omap4iss_csi2_cleanup(struct iss_device *iss)
>> +{
>> +}
>> +
>> +/*
>> + * omap4iss_csi2_init - Routine for module driver init
>> + */
>> +int omap4iss_csi2_init(struct iss_device *iss)
>> +{
>> + =A0 =A0 struct iss_csi2_device *csi2a =3D &iss->csi2a;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 csi2a->iss =3D iss;
>> + =A0 =A0 csi2a->available =3D 1;
>> + =A0 =A0 csi2a->regs1 =3D iss->regs[OMAP4_ISS_MEM_CSI2_A_REGS1];
>> + =A0 =A0 csi2a->phy =3D &iss->csiphy1;
>> + =A0 =A0 csi2a->state =3D ISS_PIPELINE_STREAM_STOPPED;
>> + =A0 =A0 init_waitqueue_head(&csi2a->wait);
>> +
>> + =A0 =A0 ret =3D csi2_init_entities(csi2a);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>> + =A0 =A0 return 0;
>> +fail:
>> + =A0 =A0 omap4iss_csi2_cleanup(iss);
>> + =A0 =A0 return ret;
>> +}
>> diff --git a/drivers/media/video/omap4iss/iss_csi2.h b/drivers/media=
/video/omap4iss/iss_csi2.h
>> new file mode 100644
>> index 0000000..4fa94cf
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss_csi2.h
>> @@ -0,0 +1,166 @@
>> +/*
>> + * iss_csi2.h
>> + *
>> + * TI OMAP4 ISS - CSI2 module
>> + *
>> + * Copyright (C) 2011 Texas Instruments, Inc.
>> + *
>> + * Contacts: Sergio Aguirre <saaguirre@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + */
>> +
>> +#ifndef OMAP4_ISS_CSI2_H
>> +#define OMAP4_ISS_CSI2_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/videodev2.h>
>> +
>> +#include "iss_video.h"
>> +
>> +struct iss_csiphy;
>> +
>> +/* This is not an exhaustive list */
>> +enum iss_csi2_pix_formats {
>> + =A0 =A0 CSI2_PIX_FMT_OTHERS =3D 0,
>> + =A0 =A0 CSI2_PIX_FMT_YUV422_8BIT =3D 0x1e,
>> + =A0 =A0 CSI2_PIX_FMT_YUV422_8BIT_VP =3D 0x9e,
>> + =A0 =A0 CSI2_PIX_FMT_RAW10_EXP16 =3D 0xab,
>> + =A0 =A0 CSI2_PIX_FMT_RAW10_EXP16_VP =3D 0x12f,
>> + =A0 =A0 CSI2_PIX_FMT_RAW8 =3D 0x2a,
>> + =A0 =A0 CSI2_PIX_FMT_RAW8_DPCM10_EXP16 =3D 0x2aa,
>> + =A0 =A0 CSI2_PIX_FMT_RAW8_DPCM10_VP =3D 0x32a,
>> + =A0 =A0 CSI2_PIX_FMT_RAW8_VP =3D 0x12a,
>> + =A0 =A0 CSI2_USERDEF_8BIT_DATA1_DPCM10_VP =3D 0x340,
>> + =A0 =A0 CSI2_USERDEF_8BIT_DATA1_DPCM10 =3D 0x2c0,
>> + =A0 =A0 CSI2_USERDEF_8BIT_DATA1 =3D 0x40,
>
> What are the USERDEF formats?

Again, inherited and adapted these from OMAP3 driver.

Should I delete them?

>
>> +};
>> +
>> +enum iss_csi2_irqevents {
>> + =A0 =A0 OCP_ERR_IRQ =3D 0x4000,
>> + =A0 =A0 SHORT_PACKET_IRQ =3D 0x2000,
>> + =A0 =A0 ECC_CORRECTION_IRQ =3D 0x1000,
>> + =A0 =A0 ECC_NO_CORRECTION_IRQ =3D 0x800,
>> + =A0 =A0 COMPLEXIO2_ERR_IRQ =3D 0x400,
>> + =A0 =A0 COMPLEXIO1_ERR_IRQ =3D 0x200,
>> + =A0 =A0 FIFO_OVF_IRQ =3D 0x100,
>> + =A0 =A0 CONTEXT7 =3D 0x80,
>> + =A0 =A0 CONTEXT6 =3D 0x40,
>> + =A0 =A0 CONTEXT5 =3D 0x20,
>> + =A0 =A0 CONTEXT4 =3D 0x10,
>> + =A0 =A0 CONTEXT3 =3D 0x8,
>> + =A0 =A0 CONTEXT2 =3D 0x4,
>> + =A0 =A0 CONTEXT1 =3D 0x2,
>> + =A0 =A0 CONTEXT0 =3D 0x1,
>> +};
>> +
>> +enum iss_csi2_ctx_irqevents {
>> + =A0 =A0 CTX_ECC_CORRECTION =3D 0x100,
>> + =A0 =A0 CTX_LINE_NUMBER =3D 0x80,
>> + =A0 =A0 CTX_FRAME_NUMBER =3D 0x40,
>> + =A0 =A0 CTX_CS =3D 0x20,
>> + =A0 =A0 CTX_LE =3D 0x8,
>> + =A0 =A0 CTX_LS =3D 0x4,
>> + =A0 =A0 CTX_FE =3D 0x2,
>> + =A0 =A0 CTX_FS =3D 0x1,
>> +};
>> +
>> +enum iss_csi2_frame_mode {
>> + =A0 =A0 ISS_CSI2_FRAME_IMMEDIATE,
>> + =A0 =A0 ISS_CSI2_FRAME_AFTERFEC,
>> +};
>> +
>> +#define ISS_CSI2_MAX_CTX_NUM 7
>> +
>> +struct iss_csi2_ctx_cfg {
>> + =A0 =A0 u8 ctxnum; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* context number 0 =
- 7 */
>> + =A0 =A0 u8 dpcm_decompress;
>> +
>> + =A0 =A0 /* Fields in CSI2_CTx_CTRL2 - locked by CSI2_CTx_CTRL1.CTX=
_EN */
>> + =A0 =A0 u8 virtual_id;
>> + =A0 =A0 u16 format_id; =A0 =A0 =A0 =A0 =A0/* as in CSI2_CTx_CTRL2[=
9:0] */
>> + =A0 =A0 u8 dpcm_predictor; =A0 =A0 =A0/* 1: simple, 0: advanced */
>> +
>> + =A0 =A0 /* Fields in CSI2_CTx_CTRL1/3 - Shadowed */
>> + =A0 =A0 u16 alpha;
>> + =A0 =A0 u16 data_offset;
>> + =A0 =A0 u32 ping_addr;
>> + =A0 =A0 u32 pong_addr;
>> + =A0 =A0 u8 eof_enabled;
>> + =A0 =A0 u8 eol_enabled;
>> + =A0 =A0 u8 checksum_enabled;
>> + =A0 =A0 u8 enabled;
>> +};
>> +
>> +struct iss_csi2_timing_cfg {
>> + =A0 =A0 u8 ionum; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* I=
O1 or IO2 as in CSI2_TIMING */
>> + =A0 =A0 unsigned force_rx_mode:1;
>> + =A0 =A0 unsigned stop_state_16x:1;
>> + =A0 =A0 unsigned stop_state_4x:1;
>> + =A0 =A0 u16 stop_state_counter;
>> +};
>> +
>> +struct iss_csi2_ctrl_cfg {
>> + =A0 =A0 bool vp_clk_enable;
>> + =A0 =A0 bool vp_only_enable;
>> + =A0 =A0 u8 vp_out_ctrl;
>> + =A0 =A0 enum iss_csi2_frame_mode frame_mode;
>> + =A0 =A0 bool ecc_enable;
>> + =A0 =A0 bool if_enable;
>> +};
>> +
>> +#define CSI2_PAD_SINK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define CSI2_PAD_SOURCE =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define CSI2_PADS_NUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> +
>> +#define CSI2_OUTPUT_IPIPEIF =A0(1 << 0)
>> +#define CSI2_OUTPUT_MEMORY =A0 (1 << 1)
>> +
>> +struct iss_csi2_device {
>> + =A0 =A0 struct v4l2_subdev subdev;
>> + =A0 =A0 struct media_pad pads[CSI2_PADS_NUM];
>> + =A0 =A0 struct v4l2_mbus_framefmt formats[CSI2_PADS_NUM];
>> +
>> + =A0 =A0 struct iss_video video_out;
>> + =A0 =A0 struct iss_device *iss;
>> +
>> + =A0 =A0 u8 available; =A0 =A0 =A0 =A0 =A0 /* Is the IP present on =
the silicon? */
>> +
>> + =A0 =A0 /* Pointer to register remaps into kernel space */
>> + =A0 =A0 void __iomem *regs1;
>> + =A0 =A0 void __iomem *regs2;
>> +
>> + =A0 =A0 u32 output; /* output to IPIPEIF, memory or both? */
>> + =A0 =A0 bool dpcm_decompress;
>> + =A0 =A0 unsigned int frame_skip;
>> + =A0 =A0 bool use_fs_irq;
>> +
>> + =A0 =A0 struct iss_csiphy *phy;
>> + =A0 =A0 struct iss_csi2_ctx_cfg contexts[ISS_CSI2_MAX_CTX_NUM + 1]=
;
>> + =A0 =A0 struct iss_csi2_timing_cfg timing[2];
>> + =A0 =A0 struct iss_csi2_ctrl_cfg ctrl;
>> + =A0 =A0 enum iss_pipeline_stream_state state;
>> + =A0 =A0 wait_queue_head_t wait;
>> + =A0 =A0 atomic_t stopping;
>> +};
>> +
>> +int omap4iss_csi2_isr(struct iss_csi2_device *csi2);
>> +int omap4iss_csi2_reset(struct iss_csi2_device *csi2);
>> +int omap4iss_csi2_init(struct iss_device *iss);
>> +void omap4iss_csi2_cleanup(struct iss_device *iss);
>> +void omap4iss_csi2_unregister_entities(struct iss_csi2_device *csi2=
);
>> +int omap4iss_csi2_register_entities(struct iss_csi2_device *csi2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct v4l2_device *vdev);
>> +#endif =A0 =A0 =A0 /* OMAP4_ISS_CSI2_H */
>> diff --git a/drivers/media/video/omap4iss/iss_csiphy.c b/drivers/med=
ia/video/omap4iss/iss_csiphy.c
>> new file mode 100644
>> index 0000000..9545622
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss_csiphy.c
>> @@ -0,0 +1,215 @@
>> +/*
>> + * iss_csiphy.c
>> + *
>> + * TI OMAP4 ISS - CSI PHY module
>> + *
>> + * Copyright (C) 2011 Texas Instruments, Inc.
>> + *
>> + * Contacts: Sergio Aguirre <saaguirre@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +
>> +#include "iss.h"
>> +#include "iss_regs.h"
>> +#include "iss_csiphy.h"
>> +
>> +/*
>> + * csiphy_lanes_config - Configuration of CSIPHY lanes.
>> + *
>> + * Updates HW configuration.
>> + * Called with phy->mutex taken.
>> + */
>> +static void csiphy_lanes_config(struct iss_csiphy *phy)
>> +{
>> + =A0 =A0 unsigned int i;
>> + =A0 =A0 u32 reg;
>> +
>> + =A0 =A0 reg =3D readl(phy->cfg_regs + CSI2_COMPLEXIO_CFG);
>> +
>> + =A0 =A0 for (i =3D 0; i < phy->num_data_lanes; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(CSI2_COMPLEXIO_CFG_DATA_POL(i +=
 1) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSI2_COMPLEXIO_CFG_DATA=
_POSITION_MASK(i + 1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (phy->lanes.data[i].pol ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_CFG_DATA_PO=
L(i + 1) : 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (phy->lanes.data[i].pos <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPLEXIO_CFG_DATA_PO=
SITION_SHIFT(i + 1));
>> + =A0 =A0 }
>> +
>> + =A0 =A0 reg &=3D ~(CSI2_COMPLEXIO_CFG_CLOCK_POL |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0CSI2_COMPLEXIO_CFG_CLOCK_POSITION_MASK)=
;
>> + =A0 =A0 reg |=3D phy->lanes.clk.pol ? CSI2_COMPLEXIO_CFG_CLOCK_POL=
 : 0;
>> + =A0 =A0 reg |=3D phy->lanes.clk.pos << CSI2_COMPLEXIO_CFG_CLOCK_PO=
SITION_SHIFT;
>> +
>> + =A0 =A0 writel(reg, phy->cfg_regs + CSI2_COMPLEXIO_CFG);
>> +}
>> +
>> +/*
>> + * csiphy_set_power
>> + * @power: Power state to be set.
>> + *
>> + * Returns 0 if successful, or -EBUSY if the retry count is exceede=
d.
>> + */
>> +static int csiphy_set_power(struct iss_csiphy *phy, u32 power)
>> +{
>> + =A0 =A0 u32 reg;
>> + =A0 =A0 u8 retry_count;
>> +
>> + =A0 =A0 writel((readl(phy->cfg_regs + CSI2_COMPLEXIO_CFG) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~CSI2_COMPLEXIO_CFG_PWD_CMD_MASK) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 power,
>> + =A0 =A0 =A0 =A0 =A0 =A0 phy->cfg_regs + CSI2_COMPLEXIO_CFG);
>> +
>> + =A0 =A0 retry_count =3D 0;
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(50);
>
> I guess udelay(1) should do. There's no reason to busyloop longer, if=
 at
> all. How much is a typical value for retry_count?

Ok. Will check this, not sure what's the count.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D readl(phy->cfg_regs + CSI2_COMPLEX=
IO_CFG) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CSI2_COMPL=
EXIO_CFG_PWD_STATUS_MASK;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (reg !=3D power >> 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retry_count++;
>> +
>> + =A0 =A0 } while ((reg !=3D power >> 2) && (retry_count < 100));
>> +
>> + =A0 =A0 if (retry_count =3D=3D 100) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "CSI2 CIO set power failed=
!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * csiphy_dphy_config - Configure CSI2 D-PHY parameters.
>> + *
>> + * Called with phy->mutex taken.
>> + */
>> +static void csiphy_dphy_config(struct iss_csiphy *phy)
>> +{
>> + =A0 =A0 u32 reg;
>> +
>> + =A0 =A0 /* Set up REGISTER0 */
>> + =A0 =A0 reg =3D readl(phy->phy_regs + REGISTER0);
>> +
>> + =A0 =A0 reg &=3D ~(REGISTER0_THS_TERM_MASK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0REGISTER0_THS_SETTLE_MASK);
>> + =A0 =A0 reg |=3D phy->dphy.ths_term << REGISTER0_THS_TERM_SHIFT;
>> + =A0 =A0 reg |=3D phy->dphy.ths_settle << REGISTER0_THS_SETTLE_SHIF=
T;
>> +
>> + =A0 =A0 writel(reg, phy->phy_regs + REGISTER0);
>> +
>> + =A0 =A0 /* Set up REGISTER1 */
>> + =A0 =A0 reg =3D readl(phy->phy_regs + REGISTER1);
>> +
>> + =A0 =A0 reg &=3D ~(REGISTER1_TCLK_TERM_MASK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0REGISTER1_CTRLCLK_DIV_FACTOR_MASK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0REGISTER1_TCLK_SETTLE_MASK);
>> + =A0 =A0 reg |=3D phy->dphy.tclk_term << REGISTER1_TCLK_TERM_SHIFT;
>> + =A0 =A0 reg |=3D phy->dphy.tclk_miss << REGISTER1_CTRLCLK_DIV_FACT=
OR_SHIFT;
>> + =A0 =A0 reg |=3D phy->dphy.tclk_settle << REGISTER1_TCLK_SETTLE_SH=
IFT;
>> +
>> + =A0 =A0 writel(reg, phy->phy_regs + REGISTER1);
>
> REGISTER0 or 1 aren't really used elsewhere. You could omit reading t=
hem
> back.

Right. Will fix.

>
>> +}
>> +
>> +static int csiphy_config(struct iss_csiphy *phy,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_csiphy_dphy_=
cfg *dphy,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iss_csiphy_lanes=
_cfg *lanes)
>> +{
>> + =A0 =A0 unsigned int used_lanes =3D 0;
>> + =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 /* Clock and data lanes verification */
>> + =A0 =A0 for (i =3D 0; i < phy->num_data_lanes; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lanes->data[i].pos =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lanes->data[i].pol > 1 || lanes->data[=
i].pos > 5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (used_lanes & (1 << lanes->data[i].pos)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 used_lanes |=3D 1 << lanes->data[i].pos;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (lanes->clk.pol > 1 || lanes->clk.pos > 4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 if (lanes->clk.pos =3D=3D 0 || used_lanes & (1 << lanes->c=
lk.pos))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&phy->mutex);
>> + =A0 =A0 phy->dphy =3D *dphy;
>> + =A0 =A0 phy->lanes =3D *lanes;
>> + =A0 =A0 mutex_unlock(&phy->mutex);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int omap4iss_csiphy_acquire(struct iss_csiphy *phy)
>> +{
>> + =A0 =A0 int rval;
>> +
>> + =A0 =A0 mutex_lock(&phy->mutex);
>> +
>> + =A0 =A0 rval =3D omap4iss_csi2_reset(phy->csi2);
>> + =A0 =A0 if (rval)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 csiphy_dphy_config(phy);
>> + =A0 =A0 csiphy_lanes_config(phy);
>> +
>> + =A0 =A0 rval =3D csiphy_set_power(phy, CSI2_COMPLEXIO_CFG_PWD_CMD_=
ON);
>> + =A0 =A0 if (rval)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 phy->phy_in_use =3D 1;
>> +
>> +done:
>> + =A0 =A0 mutex_unlock(&phy->mutex);
>> + =A0 =A0 return rval;
>> +}
>> +
>> +void omap4iss_csiphy_release(struct iss_csiphy *phy)
>> +{
>> + =A0 =A0 mutex_lock(&phy->mutex);
>> + =A0 =A0 if (phy->phy_in_use) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 csiphy_set_power(phy, CSI2_COMPLEXIO_CFG_P=
WD_CMD_OFF);
>> + =A0 =A0 =A0 =A0 =A0 =A0 phy->phy_in_use =3D 0;
>> + =A0 =A0 }
>> + =A0 =A0 mutex_unlock(&phy->mutex);
>> +}
>> +
>> +/*
>> + * omap4iss_csiphy_init - Initialize the CSI PHY frontends
>> + */
>> +int omap4iss_csiphy_init(struct iss_device *iss)
>> +{
>> + =A0 =A0 struct iss_csiphy *phy1 =3D &iss->csiphy1;
>> +
>> + =A0 =A0 iss->platform_cb.csiphy_config =3D csiphy_config;
>> +
>> + =A0 =A0 phy1->iss =3D iss;
>> + =A0 =A0 phy1->csi2 =3D &iss->csi2a;
>> + =A0 =A0 phy1->num_data_lanes =3D ISS_CSIPHY1_NUM_DATA_LANES;
>> + =A0 =A0 phy1->cfg_regs =3D iss->regs[OMAP4_ISS_MEM_CSI2_A_REGS1];
>> + =A0 =A0 phy1->phy_regs =3D iss->regs[OMAP4_ISS_MEM_CAMERARX_CORE1]=
;
>> + =A0 =A0 mutex_init(&phy1->mutex);
>> +
>> + =A0 =A0 return 0;
>> +}
>> diff --git a/drivers/media/video/omap4iss/iss_csiphy.h b/drivers/med=
ia/video/omap4iss/iss_csiphy.h
>> new file mode 100644
>> index 0000000..c513ba8
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss_csiphy.h
>> @@ -0,0 +1,69 @@
>> +/*
>> + * iss_csiphy.h
>> + *
>> + * TI OMAP4 ISS - CSI PHY module
>> + *
>> + * Copyright (C) 2011 Texas Instruments, Inc.
>> + *
>> + * Contacts: Sergio Aguirre <saaguirre@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + */
>> +
>> +#ifndef OMAP4_ISS_CSI_PHY_H
>> +#define OMAP4_ISS_CSI_PHY_H
>> +
>> +struct iss_csi2_device;
>> +
>> +struct csiphy_lane {
>> + =A0 =A0 u8 pos;
>> + =A0 =A0 u8 pol;
>> +};
>> +
>> +#define ISS_CSIPHY1_NUM_DATA_LANES =A0 4
>> +
>> +struct iss_csiphy_lanes_cfg {
>> + =A0 =A0 struct csiphy_lane data[ISS_CSIPHY1_NUM_DATA_LANES];
>> + =A0 =A0 struct csiphy_lane clk;
>> +};
>> +
>> +struct iss_csiphy_dphy_cfg {
>> + =A0 =A0 u8 ths_term;
>> + =A0 =A0 u8 ths_settle;
>> + =A0 =A0 u8 tclk_term;
>> + =A0 =A0 unsigned tclk_miss:1;
>> + =A0 =A0 u8 tclk_settle;
>> +};
>> +
>> +struct iss_csiphy {
>> + =A0 =A0 struct iss_device *iss;
>> + =A0 =A0 struct mutex mutex; =A0 =A0 /* serialize csiphy configurat=
ion */
>> + =A0 =A0 u8 phy_in_use;
>> + =A0 =A0 struct iss_csi2_device *csi2;
>> +
>> + =A0 =A0 /* Pointer to register remaps into kernel space */
>> + =A0 =A0 void __iomem *cfg_regs;
>> + =A0 =A0 void __iomem *phy_regs;
>> +
>> + =A0 =A0 u8 num_data_lanes; =A0 =A0 =A0/* number of CSI2 Data Lanes=
 supported */
>> + =A0 =A0 struct iss_csiphy_lanes_cfg lanes;
>> + =A0 =A0 struct iss_csiphy_dphy_cfg dphy;
>> +};
>> +
>> +int omap4iss_csiphy_acquire(struct iss_csiphy *phy);
>> +void omap4iss_csiphy_release(struct iss_csiphy *phy);
>> +int omap4iss_csiphy_init(struct iss_device *iss);
>> +
>> +#endif =A0 =A0 =A0 /* OMAP4_ISS_CSI_PHY_H */
>> diff --git a/drivers/media/video/omap4iss/iss_regs.h b/drivers/media=
/video/omap4iss/iss_regs.h
>> new file mode 100644
>> index 0000000..0bd70ac
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss_regs.h
>> @@ -0,0 +1,238 @@
>> +/*
>> + * iss_regs.h
>> + *
>> + * Copyright (C) 2011 Texas Instruments.
>> + *
>> + * Author: Sergio Aguirre <saaguirre@ti.com>
>> + */
>> +
>> +#ifndef _OMAP4_ISS_REGS_H_
>> +#define _OMAP4_ISS_REGS_H_
>> +
>> +/* ISS */
>> +#define ISS_HL_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0)
>
> No need for parenthesis for hexadecimals.

Ok. Will fix.

>
>> +#define ISS_HL_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (0x10)
>> +#define ISS_HL_SYSCONFIG_IDLEMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A02
>> +#define ISS_HL_SYSCONFIG_IDLEMODE_FORCEIDLE =A0 =A0 =A0 =A0 =A00x0
>> +#define ISS_HL_SYSCONFIG_IDLEMODE_NOIDLE =A0 =A0 =A0 =A0 =A0 =A0 0x=
1
>> +#define ISS_HL_SYSCONFIG_IDLEMODE_SMARTIDLE =A0 =A0 =A0 =A0 =A00x2
>> +#define ISS_HL_SYSCONFIG_SOFTRESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 0)
>> +
>> +#define ISS_HL_IRQSTATUS_5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x24 + (0x10 * 5))
>> +#define ISS_HL_IRQENABLE_5_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (0x28 + (0x10 * 5))
>> +#define ISS_HL_IRQENABLE_5_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (0x2C + (0x10 * 5))
>> +
>> +#define ISS_HL_IRQ_BTE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 11)
>> +#define ISS_HL_IRQ_CBUFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 10)
>> +#define ISS_HL_IRQ_CSIA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
>> +
>> +#define ISS_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (0x80)
>> +
>> +#define ISS_CLKCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x84)
>> +#define ISS_CLKCTRL_VPORT2_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 30)
>> +#define ISS_CLKCTRL_VPORT1_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 29)
>> +#define ISS_CLKCTRL_VPORT0_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 28)
>> +#define ISS_CLKCTRL_CCP2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 4)
>> +#define ISS_CLKCTRL_CSI2_B =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 3)
>> +#define ISS_CLKCTRL_CSI2_A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 2)
>> +#define ISS_CLKCTRL_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>> +#define ISS_CLKCTRL_SIMCOP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 0)
>> +
>> +#define ISS_CLKSTAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x88)
>> +#define ISS_CLKSTAT_VPORT2_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 30)
>> +#define ISS_CLKSTAT_VPORT1_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 29)
>> +#define ISS_CLKSTAT_VPORT0_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 28)
>> +#define ISS_CLKSTAT_CCP2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 4)
>> +#define ISS_CLKSTAT_CSI2_B =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 3)
>> +#define ISS_CLKSTAT_CSI2_A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 2)
>> +#define ISS_CLKSTAT_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>> +#define ISS_CLKSTAT_SIMCOP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 0)
>> +
>> +#define ISS_PM_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x8C)
>> +#define ISS_PM_STATUS_CBUFF_PM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(3 << 12)
>> +#define ISS_PM_STATUS_BTE_PM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(3 << 10)
>> +#define ISS_PM_STATUS_SIMCOP_PM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (3 << 8)
>> +#define ISS_PM_STATUS_ISP_PM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(3 << 6)
>> +#define ISS_PM_STATUS_CCP2_PM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (3 << 4)
>> +#define ISS_PM_STATUS_CSI2_B_PM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (3 << 2)
>> +#define ISS_PM_STATUS_CSI2_A_PM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (3 << 0)
>> +
>> +#define REGISTER0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x0)
>> +#define REGISTER0_HSCLOCKCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>> +#define REGISTER0_THS_TERM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0xFF << 8)
>> +#define REGISTER0_THS_TERM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 8
>> +#define REGISTER0_THS_SETTLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0xFF << 0)
>> +#define REGISTER0_THS_SETTLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0
>> +
>> +#define REGISTER1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x4)
>> +#define REGISTER1_RESET_DONE_CTRLCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 29)
>> +#define REGISTER1_CLOCK_MISS_DETECTOR_STATUS =A0 =A0 =A0 =A0 (1 << =
25)
>> +#define REGISTER1_TCLK_TERM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (0x3F << 18)
>> +#define REGISTER1_TCLK_TERM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A018
>> +#define REGISTER1_DPHY_HS_SYNC_PATTERN_MASK =A0 =A0 =A0 =A0 =A0(0xF=
=46 << 10)
>> +#define REGISTER1_CTRLCLK_DIV_FACTOR_MASK =A0 =A0 =A0 =A0 =A0 =A0(0=
x3 << 8)
>> +#define REGISTER1_CTRLCLK_DIV_FACTOR_SHIFT =A0 =A0 =A0 =A0 =A0 8
>> +#define REGISTER1_TCLK_SETTLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0xFF << 0)
>> +#define REGISTER1_TCLK_SETTLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00
>> +
>> +#define REGISTER2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x8)
>> +
>> +#define CSI2_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10)
>> +#define CSI2_SYSCONFIG_MSTANDBY_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0(3=
 << 12)
>> +#define CSI2_SYSCONFIG_MSTANDBY_MODE_FORCE =A0 =A0 =A0 =A0 =A0 (0 <=
< 12)
>> +#define CSI2_SYSCONFIG_MSTANDBY_MODE_NO =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 12)
>> +#define CSI2_SYSCONFIG_MSTANDBY_MODE_SMART =A0 =A0 =A0 =A0 =A0 (2 <=
< 12)
>> +#define CSI2_SYSCONFIG_SOFT_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 1)
>> +#define CSI2_SYSCONFIG_AUTO_IDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 0)
>> +
>> +#define CSI2_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x14)
>> +#define CSI2_SYSSTATUS_RESET_DONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 0)
>> +
>> +#define CSI2_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x18)
>> +#define CSI2_IRQENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1C)
>> +
>> +/* Shared bits across CSI2_IRQENABLE and IRQSTATUS */
>> +
>> +#define CSI2_IRQ_OCP_ERR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 14)
>> +#define CSI2_IRQ_SHORT_PACKET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 13)
>> +#define CSI2_IRQ_ECC_CORRECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 12)
>> +#define CSI2_IRQ_ECC_NO_CORRECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 11)
>> +#define CSI2_IRQ_COMPLEXIO_ERR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 9)
>> +#define CSI2_IRQ_FIFO_OVF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 8)
>> +#define CSI2_IRQ_CONTEXT0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 0)
>> +
>> +#define CSI2_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x40)
>> +#define CSI2_CTRL_MFLAG_LEVH_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(7 << 20)
>> +#define CSI2_CTRL_MFLAG_LEVH_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 20
>> +#define CSI2_CTRL_MFLAG_LEVL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(7 << 17)
>> +#define CSI2_CTRL_MFLAG_LEVL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 17
>> +#define CSI2_CTRL_BURST_SIZE_EXPAND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 16)
>> +#define CSI2_CTRL_VP_CLK_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 15)
>> +#define CSI2_CTRL_NON_POSTED_WRITE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 13)
>> +#define CSI2_CTRL_VP_ONLY_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (1 << 11)
>> +#define CSI2_CTRL_VP_OUT_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (3 << 8)
>> +#define CSI2_CTRL_VP_OUT_CTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A08
>> +#define CSI2_CTRL_DBG_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 7)
>> +#define CSI2_CTRL_BURST_SIZE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(3 << 5)
>> +#define CSI2_CTRL_ENDIANNESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (1 << 4)
>> +#define CSI2_CTRL_FRAME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 3)
>> +#define CSI2_CTRL_ECC_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 2)
>> +#define CSI2_CTRL_IF_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#define CSI2_DBG_H =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x44)
>> +
>> +#define CSI2_COMPLEXIO_CFG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x50)
>> +#define CSI2_COMPLEXIO_CFG_RESET_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 30)
>> +#define CSI2_COMPLEXIO_CFG_RESET_DONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 29)
>> +#define CSI2_COMPLEXIO_CFG_PWD_CMD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(3 << 27)
>> +#define CSI2_COMPLEXIO_CFG_PWD_CMD_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0 << 27)
>> +#define CSI2_COMPLEXIO_CFG_PWD_CMD_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 27)
>> +#define CSI2_COMPLEXIO_CFG_PWD_CMD_ULP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (2 << 27)
>> +#define CSI2_COMPLEXIO_CFG_PWD_STATUS_MASK =A0 =A0 =A0 =A0 =A0 (3 <=
< 25)
>> +#define CSI2_COMPLEXIO_CFG_PWD_STATUS_OFF =A0 =A0 =A0 =A0 =A0 =A0(0=
 << 25)
>> +#define CSI2_COMPLEXIO_CFG_PWD_STATUS_ON =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 25)
>> +#define CSI2_COMPLEXIO_CFG_PWD_STATUS_ULP =A0 =A0 =A0 =A0 =A0 =A0(2=
 << 25)
>> +#define CSI2_COMPLEXIO_CFG_PWR_AUTO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 24)
>> +#define CSI2_COMPLEXIO_CFG_DATA_POL(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << (((i) * 4) + 3))
>> +#define CSI2_COMPLEXIO_CFG_DATA_POSITION_MASK(i) =A0 =A0 (7 << ((i)=
 * 4))
>> +#define CSI2_COMPLEXIO_CFG_DATA_POSITION_SHIFT(i) =A0 =A0((i) * 4)
>> +#define CSI2_COMPLEXIO_CFG_CLOCK_POL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 3)
>> +#define CSI2_COMPLEXIO_CFG_CLOCK_POSITION_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (7 << 0)
>> +#define CSI2_COMPLEXIO_CFG_CLOCK_POSITION_SHIFT =A0 =A0 =A0 =A0 =A0=
 =A0 =A00
>> +
>> +#define CSI2_COMPLEXIO_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (0x54)
>> +
>> +#define CSI2_SHORT_PACKET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x5C)
>> +
>> +#define CSI2_COMPLEXIO_IRQENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (0x60)
>> +
>> +/* Shared bits across CSI2_COMPLEXIO_IRQENABLE and IRQSTATUS */
>> +#define CSI2_COMPLEXIO_IRQ_STATEALLULPMEXIT =A0 =A0 =A0 =A0 =A0(1 <=
< 26)
>> +#define CSI2_COMPLEXIO_IRQ_STATEALLULPMENTER =A0 =A0 =A0 =A0 (1 << =
25)
>> +#define CSI2_COMPLEXIO_IRQ_STATEULPM5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 24)
>> +#define CSI2_COMPLEXIO_IRQ_STATEULPM4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 23)
>> +#define CSI2_COMPLEXIO_IRQ_STATEULPM3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 22)
>> +#define CSI2_COMPLEXIO_IRQ_STATEULPM2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 21)
>> +#define CSI2_COMPLEXIO_IRQ_STATEULPM1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 20)
>> +#define CSI2_COMPLEXIO_IRQ_ERRCONTROL5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 19)
>> +#define CSI2_COMPLEXIO_IRQ_ERRCONTROL4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 18)
>> +#define CSI2_COMPLEXIO_IRQ_ERRCONTROL3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 17)
>> +#define CSI2_COMPLEXIO_IRQ_ERRCONTROL2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 16)
>> +#define CSI2_COMPLEXIO_IRQ_ERRCONTROL1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 15)
>> +#define CSI2_COMPLEXIO_IRQ_ERRESC5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 14)
>> +#define CSI2_COMPLEXIO_IRQ_ERRESC4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 13)
>> +#define CSI2_COMPLEXIO_IRQ_ERRESC3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 12)
>> +#define CSI2_COMPLEXIO_IRQ_ERRESC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 11)
>> +#define CSI2_COMPLEXIO_IRQ_ERRESC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 10)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS5 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 9)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS4 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 8)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS3 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 7)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS2 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 6)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTSYNCHS1 =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 5)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTHS5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 4)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTHS4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 3)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTHS3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 2)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTHS2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 1)
>> +#define CSI2_COMPLEXIO_IRQ_ERRSOTHS1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << 0)
>> +
>> +#define CSI2_DBG_P =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x68)
>> +
>> +#define CSI2_TIMING =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x6C)
>> +#define CSI2_TIMING_FORCE_RX_MODE_IO1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 15)
>> +#define CSI2_TIMING_STOP_STATE_X16_IO1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 14)
>> +#define CSI2_TIMING_STOP_STATE_X4_IO1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 13)
>> +#define CSI2_TIMING_STOP_STATE_COUNTER_IO1_MASK =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(0x1FFF << 0)
>> +#define CSI2_TIMING_STOP_STATE_COUNTER_IO1_SHIFT =A0 =A0 0
>> +
>> +#define CSI2_CTX_CTRL1(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x70 + (0x20 * i))
>> +#define CSI2_CTX_CTRL1_GENERIC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 30)
>> +#define CSI2_CTX_CTRL1_TRANSCODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (0xF << 24)
>> +#define CSI2_CTX_CTRL1_FEC_NUMBER_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xFF << 16)
>> +#define CSI2_CTX_CTRL1_COUNT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0xFF << 8)
>> +#define CSI2_CTX_CTRL1_COUNT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 8
>> +#define CSI2_CTX_CTRL1_EOF_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7)
>> +#define CSI2_CTX_CTRL1_EOL_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
>> +#define CSI2_CTX_CTRL1_CS_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (1 << 5)
>> +#define CSI2_CTX_CTRL1_COUNT_UNLOCK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 4)
>> +#define CSI2_CTX_CTRL1_PING_PONG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 3)
>> +#define CSI2_CTX_CTRL1_CTX_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#define CSI2_CTX_CTRL2(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x74 + (0x20 * i))
>> +#define CSI2_CTX_CTRL2_USER_DEF_MAP_SHIFT =A0 =A0 =A0 =A0 =A0 =A013
>> +#define CSI2_CTX_CTRL2_USER_DEF_MAP_MASK =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << CSI2_CTX_CTRL2_USER_DEF_MAP_SHIFT)
>> +#define CSI2_CTX_CTRL2_VIRTUAL_ID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (3 << 11)
>> +#define CSI2_CTX_CTRL2_VIRTUAL_ID_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A011
>> +#define CSI2_CTX_CTRL2_DPCM_PRED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 10)
>> +#define CSI2_CTX_CTRL2_FORMAT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x3FF << 0)
>> +#define CSI2_CTX_CTRL2_FORMAT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00
>> +
>> +#define CSI2_CTX_DAT_OFST(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (0x78 + (0x20 * i))
>> +#define CSI2_CTX_DAT_OFST_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (0xFFF << 5)
>> +
>> +#define CSI2_CTX_PING_ADDR(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0x7C + (0x20 * i))
>> +#define CSI2_CTX_PING_ADDR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A00xFFFFFFE0
>> +
>> +#define CSI2_CTX_PONG_ADDR(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0x80 + (0x20 * i))
>> +#define CSI2_CTX_PONG_ADDR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0CSI2_CTX_PING_ADDR_MASK
>> +
>> +#define CSI2_CTX_IRQENABLE(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0x84 + (0x20 * i))
>> +#define CSI2_CTX_IRQSTATUS(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0x88 + (0x20 * i))
>> +
>> +#define CSI2_CTX_CTRL3(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x8C + (0x20 * i))
>> +#define CSI2_CTX_CTRL3_ALPHA_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 5
>> +#define CSI2_CTX_CTRL3_ALPHA_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 (0x3fff << CSI2_CTX_CTRL3_ALPHA_SHIFT)
>> +
>> +/* Shared bits across CSI2_CTX_IRQENABLE and IRQSTATUS */
>> +#define CSI2_CTX_IRQ_ECC_CORRECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 8)
>> +#define CSI2_CTX_IRQ_LINE_NUMBER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 7)
>> +#define CSI2_CTX_IRQ_FRAME_NUMBER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 6)
>> +#define CSI2_CTX_IRQ_CS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 5)
>> +#define CSI2_CTX_IRQ_LE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 3)
>> +#define CSI2_CTX_IRQ_LS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
>> +#define CSI2_CTX_IRQ_FE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>> +#define CSI2_CTX_IRQ_FS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#endif /* _OMAP4_CAMERA_REGS_H_ */
>> diff --git a/drivers/media/video/omap4iss/iss_video.c b/drivers/medi=
a/video/omap4iss/iss_video.c
>> new file mode 100644
>> index 0000000..3248711
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss_video.c
>> @@ -0,0 +1,1192 @@
>> +/*
>> + * iss_video.c
>> + *
>> + * TI OMAP4 ISS - Generic video node
>> + *
>> + * Copyright (C) 2011 Texas Instruments, Inc.
>> + *
>> + * Contacts: Sergio Aguirre <saaguirre@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + */
>> +
>> +#include <asm/cacheflush.h>
>> +#include <linux/clk.h>
>> +#include <linux/mm.h>
>> +#include <linux/pagemap.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/module.h>
>> +#include <media/v4l2-dev.h>
>> +#include <media/v4l2-ioctl.h>
>> +#include <plat/omap-pm.h>
>> +
>> +#include "iss_video.h"
>> +#include "iss.h"
>> +
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * Helper functions
>> + */
>> +
>> +static struct iss_format_info formats[] =3D {
>> + =A0 =A0 { V4L2_MBUS_FMT_Y8_1X8, V4L2_MBUS_FMT_Y8_1X8,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_Y8_1X8, V4L2_MBUS_FMT_Y8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_GREY, 8, },
>> + =A0 =A0 { V4L2_MBUS_FMT_Y10_1X10, V4L2_MBUS_FMT_Y10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_Y10_1X10, V4L2_MBUS_FMT_Y8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_Y10, 10, },
>> + =A0 =A0 { V4L2_MBUS_FMT_Y12_1X12, V4L2_MBUS_FMT_Y10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_Y12_1X12, V4L2_MBUS_FMT_Y8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_Y12, 12, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SBGGR8_1X8, V4L2_MBUS_FMT_SBGGR8_1X8,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SBGGR8_1X8, V4L2_MBUS_FMT_SBGGR8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SBGGR8, 8, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SGBRG8_1X8, V4L2_MBUS_FMT_SGBRG8_1X8,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SGBRG8_1X8, V4L2_MBUS_FMT_SGBRG8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SGBRG8, 8, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SGRBG8_1X8, V4L2_MBUS_FMT_SGRBG8_1X8,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SGRBG8_1X8, V4L2_MBUS_FMT_SGRBG8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SGRBG8, 8, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SRGGB8_1X8, V4L2_MBUS_FMT_SRGGB8_1X8,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SRGGB8_1X8, V4L2_MBUS_FMT_SRGGB8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SRGGB8, 8, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SGRBG10_DPCM8_1X8, V4L2_MBUS_FMT_SGRBG10_D=
PCM8_1X8,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SGRBG10_1X10, 0,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SGRBG10DPCM8, 8, },
>
> I had a few patches (not acked yet) to add more supported media bus f=
ormats.
> It might make sense to add support for those for this driver as well =
once
> we've discussed 4cc's with Hans.

Ok. Will wait for that then.

>
>> + =A0 =A0 { V4L2_MBUS_FMT_SBGGR10_1X10, V4L2_MBUS_FMT_SBGGR10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SBGGR10_1X10, V4L2_MBUS_FMT_SBGGR8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SBGGR10, 10, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SGBRG10_1X10, V4L2_MBUS_FMT_SGBRG10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SGBRG10_1X10, V4L2_MBUS_FMT_SGBRG8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SGBRG10, 10, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SGRBG10_1X10, V4L2_MBUS_FMT_SGRBG10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SGRBG10_1X10, V4L2_MBUS_FMT_SGRBG8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SGRBG10, 10, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SRGGB10_1X10, V4L2_MBUS_FMT_SRGGB10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SRGGB10_1X10, V4L2_MBUS_FMT_SRGGB8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SRGGB10, 10, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SBGGR12_1X12, V4L2_MBUS_FMT_SBGGR10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SBGGR12_1X12, V4L2_MBUS_FMT_SBGGR8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SBGGR12, 12, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SGBRG12_1X12, V4L2_MBUS_FMT_SGBRG10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SGBRG12_1X12, V4L2_MBUS_FMT_SGBRG8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SGBRG12, 12, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SGRBG12_1X12, V4L2_MBUS_FMT_SGRBG10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SGRBG12_1X12, V4L2_MBUS_FMT_SGRBG8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SGRBG12, 12, },
>> + =A0 =A0 { V4L2_MBUS_FMT_SRGGB12_1X12, V4L2_MBUS_FMT_SRGGB10_1X10,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_SRGGB12_1X12, V4L2_MBUS_FMT_SRGGB8_1X8,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_SRGGB12, 12, },
>> + =A0 =A0 { V4L2_MBUS_FMT_UYVY8_1X16, V4L2_MBUS_FMT_UYVY8_1X16,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_UYVY8_1X16, 0,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_UYVY, 16, },
>> + =A0 =A0 { V4L2_MBUS_FMT_YUYV8_1X16, V4L2_MBUS_FMT_YUYV8_1X16,
>> + =A0 =A0 =A0 V4L2_MBUS_FMT_YUYV8_1X16, 0,
>> + =A0 =A0 =A0 V4L2_PIX_FMT_YUYV, 16, },
>> +};
>> +
>> +const struct iss_format_info *
>> +omap4iss_video_format_info(enum v4l2_mbus_pixelcode code)
>> +{
>> + =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(formats); ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (formats[i].code =3D=3D code)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &formats[i];
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +/*
>> + * iss_video_mbus_to_pix - Convert v4l2_mbus_framefmt to v4l2_pix_f=
ormat
>> + * @video: ISS video instance
>> + * @mbus: v4l2_mbus_framefmt format (input)
>> + * @pix: v4l2_pix_format format (output)
>> + *
>> + * Fill the output pix structure with information from the input mb=
us format.
>> + * The bytesperline and sizeimage fields are computed from the requ=
ested bytes
>> + * per line value in the pix format and information from the video =
instance.
>> + *
>> + * Return the number of padding bytes at end of line.
>> + */
>> +static unsigned int iss_video_mbus_to_pix(const struct iss_video *v=
ideo,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 const struct v4l2_mbus_framefmt *mbus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct v4l2_pix_format *pix)
>> +{
>> + =A0 =A0 unsigned int bpl =3D pix->bytesperline;
>> + =A0 =A0 unsigned int min_bpl;
>> + =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 memset(pix, 0, sizeof(*pix));
>> + =A0 =A0 pix->width =3D mbus->width;
>> + =A0 =A0 pix->height =3D mbus->height;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(formats); ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (formats[i].code =3D=3D mbus->code)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (WARN_ON(i =3D=3D ARRAY_SIZE(formats)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 min_bpl =3D pix->width * ALIGN(formats[i].bpp, 8) / 8;
>> +
>> + =A0 =A0 /* Clamp the requested bytes per line value. If the maximu=
m bytes per
>> + =A0 =A0 =A0* line value is zero, the module doesn't support user c=
onfigurable line
>> + =A0 =A0 =A0* sizes. Override the requested value with the minimum =
in that case.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (video->bpl_max)
>> + =A0 =A0 =A0 =A0 =A0 =A0 bpl =3D clamp(bpl, min_bpl, video->bpl_max=
);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 bpl =3D min_bpl;
>> +
>> + =A0 =A0 if (!video->bpl_zero_padding || bpl !=3D min_bpl)
>> + =A0 =A0 =A0 =A0 =A0 =A0 bpl =3D ALIGN(bpl, video->bpl_alignment);
>> +
>> + =A0 =A0 pix->pixelformat =3D formats[i].pixelformat;
>> + =A0 =A0 pix->bytesperline =3D bpl;
>> + =A0 =A0 pix->sizeimage =3D pix->bytesperline * pix->height;
>> + =A0 =A0 pix->colorspace =3D mbus->colorspace;
>> + =A0 =A0 pix->field =3D mbus->field;
>> +
>> + =A0 =A0 return bpl - min_bpl;
>> +}
>> +
>> +static void iss_video_pix_to_mbus(const struct v4l2_pix_format *pix=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 v4l2_mbus_framefmt *mbus)
>> +{
>> + =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 memset(mbus, 0, sizeof(*mbus));
>> + =A0 =A0 mbus->width =3D pix->width;
>> + =A0 =A0 mbus->height =3D pix->height;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(formats); ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (formats[i].pixelformat =3D=3D pix->pix=
elformat)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (WARN_ON(i =3D=3D ARRAY_SIZE(formats)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 mbus->code =3D formats[i].code;
>> + =A0 =A0 mbus->colorspace =3D pix->colorspace;
>> + =A0 =A0 mbus->field =3D pix->field;
>> +}
>> +
>> +static struct v4l2_subdev *
>> +iss_video_remote_subdev(struct iss_video *video, u32 *pad)
>> +{
>> + =A0 =A0 struct media_pad *remote;
>> +
>> + =A0 =A0 remote =3D media_entity_remote_source(&video->pad);
>> +
>> + =A0 =A0 if (remote =3D=3D NULL ||
>> + =A0 =A0 =A0 =A0 media_entity_type(remote->entity) !=3D MEDIA_ENT_T=
_V4L2_SUBDEV)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 if (pad)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *pad =3D remote->index;
>> +
>> + =A0 =A0 return media_entity_to_v4l2_subdev(remote->entity);
>> +}
>> +
>> +/* Return a pointer to the ISS video instance at the far end of the=
 pipeline. */
>> +static struct iss_video *
>> +iss_video_far_end(struct iss_video *video)
>> +{
>> + =A0 =A0 struct media_entity_graph graph;
>> + =A0 =A0 struct media_entity *entity =3D &video->video.entity;
>> + =A0 =A0 struct media_device *mdev =3D entity->parent;
>> + =A0 =A0 struct iss_video *far_end =3D NULL;
>> +
>> + =A0 =A0 mutex_lock(&mdev->graph_mutex);
>> + =A0 =A0 media_entity_graph_walk_start(&graph, entity);
>> +
>> + =A0 =A0 while ((entity =3D media_entity_graph_walk_next(&graph))) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (entity =3D=3D &video->video.entity)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (media_entity_type(entity) !=3D MEDIA_E=
NT_T_DEVNODE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 far_end =3D to_iss_video(media_entity_to_v=
ideo_device(entity));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (far_end->type !=3D video->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 far_end =3D NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_unlock(&mdev->graph_mutex);
>> + =A0 =A0 return far_end;
>> +}
>> +
>> +/*
>> + * Validate a pipeline by checking both ends of all links for forma=
t
>> + * discrepancies.
>> + *
>> + * Compute the minimum time per frame value as the maximum of time =
per frame
>> + * limits reported by every block in the pipeline.
>> + *
>> + * Return 0 if all formats match, or -EPIPE if at least one link is=
 found with
>> + * different formats on its two ends.
>> + */
>> +static int iss_video_validate_pipeline(struct iss_pipeline *pipe)
>> +{
>> + =A0 =A0 struct v4l2_subdev_format fmt_source;
>> + =A0 =A0 struct v4l2_subdev_format fmt_sink;
>> + =A0 =A0 struct media_pad *pad;
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 subdev =3D iss_video_remote_subdev(pipe->output, NULL);
>> + =A0 =A0 if (subdev =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EPIPE;
>> +
>> + =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Retrieve the sink format */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pad =3D &subdev->entity.pads[0];
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(pad->flags & MEDIA_PAD_FL_SINK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt_sink.pad =3D pad->index;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt_sink.which =3D V4L2_SUBDEV_FORMAT_ACTI=
VE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D v4l2_subdev_call(subdev, pad, get_=
fmt, NULL, &fmt_sink);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0 && ret !=3D -ENOIOCTLCMD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPIPE;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Retrieve the source format */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pad =3D media_entity_remote_source(pad);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pad =3D=3D NULL ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 media_entity_type(pad->entity) !=3D=
 MEDIA_ENT_T_V4L2_SUBDEV)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 subdev =3D media_entity_to_v4l2_subdev(pad=
->entity);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt_source.pad =3D pad->index;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fmt_source.which =3D V4L2_SUBDEV_FORMAT_AC=
TIVE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D v4l2_subdev_call(subdev, pad, get_=
fmt, NULL, &fmt_source);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0 && ret !=3D -ENOIOCTLCMD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPIPE;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Check if the two ends match */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (fmt_source.format.width !=3D fmt_sink.=
format.width ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt_source.format.height !=3D fmt_=
sink.format.height)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPIPE;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (fmt_source.format.code !=3D fmt_sink.f=
ormat.code)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPIPE;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>
> You won't need pipeline validation function anymore. This will be mov=
ed to
> media controller. The patches for the OMAP 3 ISP are one the list:
>
> <URL:http://www.spinics.net/lists/linux-media/msg42991.html>

Ok. Will wait for this to be accepted then.

>
>> +static int
>> +__iss_video_get_format(struct iss_video *video, struct v4l2_format =
*format)
>> +{
>> + =A0 =A0 struct v4l2_subdev_format fmt;
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 u32 pad;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 subdev =3D iss_video_remote_subdev(video, &pad);
>> + =A0 =A0 if (subdev =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&video->mutex);
>> +
>> + =A0 =A0 fmt.pad =3D pad;
>> + =A0 =A0 fmt.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
>> + =A0 =A0 ret =3D v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt)=
;
>> + =A0 =A0 if (ret =3D=3D -ENOIOCTLCMD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> +
>> + =A0 =A0 mutex_unlock(&video->mutex);
>> +
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 format->type =3D video->type;
>> + =A0 =A0 return iss_video_mbus_to_pix(video, &fmt.format, &format->=
fmt.pix);
>> +}
>> +
>> +static int
>> +iss_video_check_format(struct iss_video *video, struct iss_video_fh=
 *vfh)
>> +{
>> + =A0 =A0 struct v4l2_format format;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 memcpy(&format, &vfh->format, sizeof(format));
>> + =A0 =A0 ret =3D __iss_video_get_format(video, &format);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if (vfh->format.fmt.pix.pixelformat !=3D format.fmt.pix.pi=
xelformat ||
>> + =A0 =A0 =A0 =A0 vfh->format.fmt.pix.height !=3D format.fmt.pix.hei=
ght ||
>> + =A0 =A0 =A0 =A0 vfh->format.fmt.pix.width !=3D format.fmt.pix.widt=
h ||
>> + =A0 =A0 =A0 =A0 vfh->format.fmt.pix.bytesperline !=3D format.fmt.p=
ix.bytesperline ||
>> + =A0 =A0 =A0 =A0 vfh->format.fmt.pix.sizeimage !=3D format.fmt.pix.=
sizeimage)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * Video queue operations
>> + */
>> +
>> +static int iss_video_queue_setup(struct vb2_queue *vq, const struct=
 v4l2_format *fmt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d int *count, unsigned int *num_planes,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d int sizes[], void *alloc_ctxs[])
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D vb2_get_drv_priv(vq);
>> + =A0 =A0 struct iss_video *video =3D vfh->video;
>> +
>> + =A0 =A0 /* Revisit multi-planar support for NV12 */
>> + =A0 =A0 *num_planes =3D 1;
>> +
>> + =A0 =A0 sizes[0] =3D vfh->format.fmt.pix.sizeimage;
>> + =A0 =A0 if (sizes[0] =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 alloc_ctxs[0] =3D video->alloc_ctx;
>> +
>> + =A0 =A0 *count =3D min(*count, (unsigned int)(video->capture_mem /=
 PAGE_ALIGN(sizes[0])));
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void iss_video_buf_cleanup(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct iss_buffer *buffer =3D container_of(vb, struct iss_=
buffer, vb);
>> +
>> + =A0 =A0 if (buffer->iss_addr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 buffer->iss_addr =3D 0;
>> +}
>> +
>> +static int iss_video_buf_prepare(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D vb2_get_drv_priv(vb->vb2_queu=
e);
>> + =A0 =A0 struct iss_buffer *buffer =3D container_of(vb, struct iss_=
buffer, vb);
>> + =A0 =A0 struct iss_video *video =3D vfh->video;
>> + =A0 =A0 unsigned long size =3D vfh->format.fmt.pix.sizeimage;
>> + =A0 =A0 dma_addr_t addr;
>> +
>> + =A0 =A0 if (vb2_plane_size(vb, 0) < size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOBUFS;
>> +
>> + =A0 =A0 addr =3D vb2_dma_contig_plane_dma_addr(vb, 0);
>> + =A0 =A0 if (!IS_ALIGNED(addr, 32)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(video->iss->dev, "Buffer address m=
ust be "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "aligned to 32 bytes bound=
ary.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 vb2_set_plane_payload(vb, 0, size);
>> + =A0 =A0 buffer->iss_addr =3D addr;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void iss_video_buf_queue(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D vb2_get_drv_priv(vb->vb2_queu=
e);
>> + =A0 =A0 struct iss_video *video =3D vfh->video;
>> + =A0 =A0 struct iss_buffer *buffer =3D container_of(vb, struct iss_=
buffer, vb);
>> + =A0 =A0 struct iss_pipeline *pipe =3D to_iss_pipeline(&video->vide=
o.entity);
>> + =A0 =A0 unsigned int empty;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 spin_lock_irqsave(&video->qlock, flags);
>> + =A0 =A0 empty =3D list_empty(&video->dmaqueue);
>> + =A0 =A0 list_add_tail(&buffer->list, &video->dmaqueue);
>> + =A0 =A0 spin_unlock_irqrestore(&video->qlock, flags);
>> +
>> + =A0 =A0 if (empty) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 enum iss_pipeline_state state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int start;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (video->type =3D=3D V4L2_BUF_TYPE_VIDEO=
_CAPTURE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_QUE=
UE_OUTPUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_QUE=
UE_INPUT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&pipe->lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->state |=3D state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->ops->queue(video, buffer);
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->dmaqueue_flags |=3D ISS_VIDEO_DMAQU=
EUE_QUEUED;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 start =3D iss_pipeline_ready(pipe);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (start)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pipe->state |=3D ISS_PIPEL=
INE_STREAM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&pipe->lock, flags)=
;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (start)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_pipeline_set_stre=
am(pipe,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ISS_PIPELINE_STREAM_SINGLESHOT);
>> + =A0 =A0 }
>> +}
>> +
>> +static struct vb2_ops iss_video_vb2ops =3D {
>> + =A0 =A0 .queue_setup =A0 =A0=3D iss_video_queue_setup,
>> + =A0 =A0 .buf_prepare =A0 =A0=3D iss_video_buf_prepare,
>> + =A0 =A0 .buf_queue =A0 =A0 =A0=3D iss_video_buf_queue,
>> + =A0 =A0 .buf_cleanup =A0 =A0=3D iss_video_buf_cleanup,
>> +};
>> +
>> +/*
>> + * omap4iss_video_buffer_next - Complete the current buffer and ret=
urn the next
>> + * @video: ISS video object
>> + * @error: Whether an error occurred during capture
>> + *
>> + * Remove the current video buffer from the DMA queue and fill its =
timestamp,
>> + * field count and state fields before waking up its completion han=
dler.
>> + *
>> + * The buffer state is set to VIDEOBUF_DONE if no error occurred (@=
error is 0)
>> + * or VIDEOBUF_ERROR otherwise (@error is non-zero).
>> + *
>> + * The DMA queue is expected to contain at least one buffer.
>> + *
>> + * Return a pointer to the next buffer in the DMA queue, or NULL if=
 the queue is
>> + * empty.
>> + */
>> +struct iss_buffer *omap4iss_video_buffer_next(struct iss_video *vid=
eo,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 unsigned int error)
>> +{
>> + =A0 =A0 struct iss_pipeline *pipe =3D to_iss_pipeline(&video->vide=
o.entity);
>> + =A0 =A0 enum iss_pipeline_state state;
>> + =A0 =A0 struct iss_buffer *buf;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 struct timespec ts;
>> +
>> + =A0 =A0 spin_lock_irqsave(&video->qlock, flags);
>> + =A0 =A0 if (WARN_ON(list_empty(&video->dmaqueue))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&video->qlock, flag=
s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 buf =3D list_first_entry(&video->dmaqueue, struct iss_buff=
er,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list);
>> + =A0 =A0 list_del(&buf->list);
>> + =A0 =A0 spin_unlock_irqrestore(&video->qlock, flags);
>> +
>> + =A0 =A0 ktime_get_ts(&ts);
>> + =A0 =A0 buf->vb.v4l2_buf.timestamp.tv_sec =3D ts.tv_sec;
>> + =A0 =A0 buf->vb.v4l2_buf.timestamp.tv_usec =3D ts.tv_nsec / NSEC_P=
ER_USEC;
>> +
>> + =A0 =A0 /* Do frame number propagation only if this is the output =
video node.
>> + =A0 =A0 =A0* Frame number either comes from the CSI receivers or i=
t gets
>> + =A0 =A0 =A0* incremented here if H3A is not active.
>> + =A0 =A0 =A0* Note: There is no guarantee that the output buffer wi=
ll finish
>> + =A0 =A0 =A0* first, so the input number might lag behind by 1 in s=
ome cases.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (video =3D=3D pipe->output && !pipe->do_propagation)
>> + =A0 =A0 =A0 =A0 =A0 =A0 buf->vb.v4l2_buf.sequence =3D atomic_inc_r=
eturn(&pipe->frame_number);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 buf->vb.v4l2_buf.sequence =3D atomic_read(=
&pipe->frame_number);
>> +
>> + =A0 =A0 vb2_buffer_done(&buf->vb, error < 0 ? VB2_BUF_STATE_ERROR =
: VB2_BUF_STATE_DONE);
>> +
>> + =A0 =A0 spin_lock_irqsave(&video->qlock, flags);
>> + =A0 =A0 if (list_empty(&video->dmaqueue)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&video->qlock, flag=
s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (video->type =3D=3D V4L2_BUF_TYPE_VIDEO=
_CAPTURE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_QUE=
UE_OUTPUT
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | ISS_PIPELINE=
_STREAM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_QUE=
UE_INPUT
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | ISS_PIPELINE=
_STREAM;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&pipe->lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->state &=3D ~state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (video->pipe.stream_state =3D=3D ISS_PI=
PELINE_STREAM_CONTINUOUS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video->dmaqueue_flags |=3D=
 ISS_VIDEO_DMAQUEUE_UNDERRUN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&pipe->lock, flags)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (video->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE && pipe=
->input !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&pipe->lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->state &=3D ~ISS_PIPELINE_STREAM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&pipe->lock, flags)=
;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 buf =3D list_first_entry(&video->dmaqueue, struct iss_buff=
er,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list);
>> + =A0 =A0 spin_unlock_irqrestore(&video->qlock, flags);
>> + =A0 =A0 buf->vb.state =3D VB2_BUF_STATE_ACTIVE;
>> + =A0 =A0 return buf;
>> +}
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * V4L2 ioctls
>> + */
>> +
>> +static int
>> +iss_video_querycap(struct file *file, void *fh, struct v4l2_capabil=
ity *cap)
>> +{
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> +
>> + =A0 =A0 strlcpy(cap->driver, ISS_VIDEO_DRIVER_NAME, sizeof(cap->dr=
iver));
>> + =A0 =A0 strlcpy(cap->card, video->video.name, sizeof(cap->card));
>> + =A0 =A0 strlcpy(cap->bus_info, "media", sizeof(cap->bus_info));
>> + =A0 =A0 cap->version =3D ISS_VIDEO_DRIVER_VERSION;
>> +
>> + =A0 =A0 if (video->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cap->capabilities =3D V4L2_CAP_VIDEO_CAPTU=
RE | V4L2_CAP_STREAMING;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 cap->capabilities =3D V4L2_CAP_VIDEO_OUTPU=
T | V4L2_CAP_STREAMING;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_get_format(struct file *file, void *fh, struct v4l2_forma=
t *format)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> +
>> + =A0 =A0 if (format->type !=3D video->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&video->mutex);
>> + =A0 =A0 *format =3D vfh->format;
>> + =A0 =A0 mutex_unlock(&video->mutex);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_set_format(struct file *file, void *fh, struct v4l2_forma=
t *format)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct v4l2_mbus_framefmt fmt;
>> +
>> + =A0 =A0 if (format->type !=3D video->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&video->mutex);
>> +
>> + =A0 =A0 /* Fill the bytesperline and sizeimage fields by convertin=
g to media bus
>> + =A0 =A0 =A0* format and back to pixel format.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 iss_video_pix_to_mbus(&format->fmt.pix, &fmt);
>> + =A0 =A0 iss_video_mbus_to_pix(video, &fmt, &format->fmt.pix);
>> +
>> + =A0 =A0 vfh->format =3D *format;
>> +
>> + =A0 =A0 mutex_unlock(&video->mutex);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_try_format(struct file *file, void *fh, struct v4l2_forma=
t *format)
>> +{
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct v4l2_subdev_format fmt;
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 u32 pad;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (format->type !=3D video->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 subdev =3D iss_video_remote_subdev(video, &pad);
>> + =A0 =A0 if (subdev =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 iss_video_pix_to_mbus(&format->fmt.pix, &fmt.format);
>> +
>> + =A0 =A0 fmt.pad =3D pad;
>> + =A0 =A0 fmt.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
>> + =A0 =A0 ret =3D v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt)=
;
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret =3D=3D -ENOIOCTLCMD ? -EINVAL :=
 ret;
>> +
>> + =A0 =A0 iss_video_mbus_to_pix(video, &fmt.format, &format->fmt.pix=
);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_cropcap(struct file *file, void *fh, struct v4l2_cropcap =
*cropcap)
>> +{
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 subdev =3D iss_video_remote_subdev(video, NULL);
>> + =A0 =A0 if (subdev =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&video->mutex);
>> + =A0 =A0 ret =3D v4l2_subdev_call(subdev, video, cropcap, cropcap);
>> + =A0 =A0 mutex_unlock(&video->mutex);
>> +
>> + =A0 =A0 return ret =3D=3D -ENOIOCTLCMD ? -EINVAL : ret;
>> +}
>> +
>> +static int
>> +iss_video_get_crop(struct file *file, void *fh, struct v4l2_crop *c=
rop)
>> +{
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct v4l2_subdev_format format;
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 u32 pad;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 subdev =3D iss_video_remote_subdev(video, &pad);
>> + =A0 =A0 if (subdev =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* Try the get crop operation first and fallback to get fo=
rmat if not
>> + =A0 =A0 =A0* implemented.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ret =3D v4l2_subdev_call(subdev, video, g_crop, crop);
>> + =A0 =A0 if (ret !=3D -ENOIOCTLCMD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 format.pad =3D pad;
>> + =A0 =A0 format.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
>> + =A0 =A0 ret =3D v4l2_subdev_call(subdev, pad, get_fmt, NULL, &form=
at);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret =3D=3D -ENOIOCTLCMD ? -EINVAL :=
 ret;
>> +
>> + =A0 =A0 crop->c.left =3D 0;
>> + =A0 =A0 crop->c.top =3D 0;
>> + =A0 =A0 crop->c.width =3D format.format.width;
>> + =A0 =A0 crop->c.height =3D format.format.height;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_set_crop(struct file *file, void *fh, struct v4l2_crop *c=
rop)
>> +{
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct v4l2_subdev *subdev;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 subdev =3D iss_video_remote_subdev(video, NULL);
>> + =A0 =A0 if (subdev =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&video->mutex);
>> + =A0 =A0 ret =3D v4l2_subdev_call(subdev, video, s_crop, crop);
>> + =A0 =A0 mutex_unlock(&video->mutex);
>> +
>> + =A0 =A0 return ret =3D=3D -ENOIOCTLCMD ? -EINVAL : ret;
>> +}
>> +
>> +static int
>> +iss_video_get_param(struct file *file, void *fh, struct v4l2_stream=
parm *a)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> +
>> + =A0 =A0 if (video->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT ||
>> + =A0 =A0 =A0 =A0 video->type !=3D a->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 memset(a, 0, sizeof(*a));
>> + =A0 =A0 a->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT;
>> + =A0 =A0 a->parm.output.capability =3D V4L2_CAP_TIMEPERFRAME;
>> + =A0 =A0 a->parm.output.timeperframe =3D vfh->timeperframe;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_set_param(struct file *file, void *fh, struct v4l2_stream=
parm *a)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> +
>> + =A0 =A0 if (video->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT ||
>> + =A0 =A0 =A0 =A0 video->type !=3D a->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 if (a->parm.output.timeperframe.denominator =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 a->parm.output.timeperframe.denominator =3D=
 1;
>> +
>> + =A0 =A0 vfh->timeperframe =3D a->parm.output.timeperframe;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_reqbufs(struct file *file, void *fh, struct v4l2_requestb=
uffers *rb)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> +
>> + =A0 =A0 return vb2_reqbufs(&vfh->queue, rb);
>> +}
>> +
>> +static int
>> +iss_video_querybuf(struct file *file, void *fh, struct v4l2_buffer =
*b)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> +
>> + =A0 =A0 return vb2_querybuf(&vfh->queue, b);
>> +}
>> +
>> +static int
>> +iss_video_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> +
>> + =A0 =A0 return vb2_qbuf(&vfh->queue, b);
>> +}
>> +
>> +static int
>> +iss_video_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> +
>> + =A0 =A0 return vb2_dqbuf(&vfh->queue, b, file->f_flags & O_NONBLOC=
K);
>> +}
>> +
>> +/*
>> + * Stream management
>> + *
>> + * Every ISS pipeline has a single input and a single output. The i=
nput can be
>> + * either a sensor or a video node. The output is always a video no=
de.
>> + *
>> + * As every pipeline has an output video node, the ISS video object=
s at the
>> + * pipeline output stores the pipeline state. It tracks the streami=
ng state of
>> + * both the input and output, as well as the availability of buffer=
s.
>> + *
>> + * In sensor-to-memory mode, frames are always available at the pip=
eline input.
>> + * Starting the sensor usually requires I2C transfers and must be d=
one in
>> + * interruptible context. The pipeline is started and stopped synch=
ronously
>> + * to the stream on/off commands. All modules in the pipeline will =
get their
>> + * subdev set stream handler called. The module at the end of the p=
ipeline must
>> + * delay starting the hardware until buffers are available at its o=
utput.
>> + *
>> + * In memory-to-memory mode, starting/stopping the stream requires
>> + * synchronization between the input and output. ISS modules can't =
be stopped
>> + * in the middle of a frame, and at least some of the modules seem =
to become
>> + * busy as soon as they're started, even if they don't receive a fr=
ame start
>> + * event. For that reason frames need to be processed in single-sho=
t mode. The
>> + * driver needs to wait until a frame is completely processed and w=
ritten to
>> + * memory before restarting the pipeline for the next frame. Pipeli=
ned
>> + * processing might be possible but requires more testing.
>> + *
>> + * Stream start must be delayed until buffers are available at both=
 the input
>> + * and output. The pipeline must be started in the videobuf queue c=
allback with
>> + * the buffers queue spinlock held. The modules subdev set stream o=
peration must
>> + * not sleep.
>> + */
>> +static int
>> +iss_video_streamon(struct file *file, void *fh, enum v4l2_buf_type =
type)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 enum iss_pipeline_state state;
>> + =A0 =A0 struct iss_pipeline *pipe;
>> + =A0 =A0 struct iss_video *far_end;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (type !=3D video->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&video->stream_lock);
>> +
>> + =A0 =A0 if (video->streaming) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&video->stream_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Start streaming on the pipeline. No link touching an en=
tity in the
>> + =A0 =A0 =A0* pipeline can be activated or deactivated once streami=
ng is started.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 pipe =3D video->video.entity.pipe
>> + =A0 =A0 =A0 =A0 =A0? to_iss_pipeline(&video->video.entity) : &vide=
o->pipe;
>> + =A0 =A0 media_entity_pipeline_start(&video->video.entity, &pipe->p=
ipe);
>> +
>> + =A0 =A0 /* Verify that the currently configured format matches the=
 output of
>> + =A0 =A0 =A0* the connected subdev.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ret =3D iss_video_check_format(video, vfh);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 video->bpl_padding =3D ret;
>> + =A0 =A0 video->bpl_value =3D vfh->format.fmt.pix.bytesperline;
>> +
>> + =A0 =A0 /* Find the ISS video node connected at the far end of the=
 pipeline and
>> + =A0 =A0 =A0* update the pipeline.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 far_end =3D iss_video_far_end(video);
>> +
>> + =A0 =A0 if (video->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_STREAM_OUTPUT | ISS=
_PIPELINE_IDLE_OUTPUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->input =3D far_end;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->output =3D video;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (far_end =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EPIPE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_STREAM_INPUT | ISS_=
PIPELINE_IDLE_INPUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->input =3D video;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->output =3D far_end;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (video->iss->pdata->set_constraints)
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->iss->pdata->set_constraints(video->=
iss, true);
>> +
>> + =A0 =A0 /* Validate the pipeline and update its state. */
>> + =A0 =A0 ret =3D iss_video_validate_pipeline(pipe);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 spin_lock_irqsave(&pipe->lock, flags);
>> + =A0 =A0 pipe->state &=3D ~ISS_PIPELINE_STREAM;
>> + =A0 =A0 pipe->state |=3D state;
>> + =A0 =A0 spin_unlock_irqrestore(&pipe->lock, flags);
>> +
>> + =A0 =A0 /* Set the maximum time per frame as the value requested b=
y userspace.
>> + =A0 =A0 =A0* This is a soft limit that can be overridden if the ha=
rdware doesn't
>> + =A0 =A0 =A0* support the request limit.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (video->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pipe->max_timeperframe =3D vfh->timeperfra=
me;
>> +
>> + =A0 =A0 video->queue =3D &vfh->queue;
>> + =A0 =A0 INIT_LIST_HEAD(&video->dmaqueue);
>> + =A0 =A0 spin_lock_init(&video->qlock);
>> + =A0 =A0 atomic_set(&pipe->frame_number, -1);
>> +
>> + =A0 =A0 ret =3D vb2_streamon(&vfh->queue, type);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> +
>> + =A0 =A0 /* In sensor-to-memory mode, the stream can be started syn=
chronously
>> + =A0 =A0 =A0* to the stream on command. In memory-to-memory mode, i=
t will be
>> + =A0 =A0 =A0* started when buffers are queued on both the input and=
 output.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (pipe->input =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap4iss_pipeline_set_stream(pipe,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ISS_PIPELINE_STREAM_CONTINUOUS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&video->qlock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&video->dmaqueue))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video->dmaqueue_flags |=3D=
 ISS_VIDEO_DMAQUEUE_UNDERRUN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&video->qlock, flag=
s);
>> + =A0 =A0 }
>> +
>> +error:
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 vb2_streamoff(&vfh->queue, type);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (video->iss->pdata->set_constraints)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video->iss->pdata->set_con=
straints(video->iss, false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 media_entity_pipeline_stop(&video->video.e=
ntity);
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->queue =3D NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->streaming =3D 1;
>> +
>> + =A0 =A0 mutex_unlock(&video->stream_lock);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int
>> +iss_video_streamoff(struct file *file, void *fh, enum v4l2_buf_type=
 type)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(fh);
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct iss_pipeline *pipe =3D to_iss_pipeline(&video->vide=
o.entity);
>> + =A0 =A0 enum iss_pipeline_state state;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 if (type !=3D video->type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&video->stream_lock);
>> +
>> + =A0 =A0 if (!vb2_is_streaming(&vfh->queue))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> +
>> + =A0 =A0 /* Update the pipeline state. */
>> + =A0 =A0 if (video->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_STREAM_OUTPUT
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | ISS_PIPELINE_QUEUE_OUTPUT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 state =3D ISS_PIPELINE_STREAM_INPUT
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | ISS_PIPELINE_QUEUE_INPUT;
>> +
>> + =A0 =A0 spin_lock_irqsave(&pipe->lock, flags);
>> + =A0 =A0 pipe->state &=3D ~state;
>> + =A0 =A0 spin_unlock_irqrestore(&pipe->lock, flags);
>> +
>> + =A0 =A0 /* Stop the stream. */
>> + =A0 =A0 omap4iss_pipeline_set_stream(pipe, ISS_PIPELINE_STREAM_STO=
PPED);
>> + =A0 =A0 vb2_streamoff(&vfh->queue, type);
>> + =A0 =A0 video->queue =3D NULL;
>> + =A0 =A0 video->streaming =3D 0;
>> +
>> + =A0 =A0 if (video->iss->pdata->set_constraints)
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->iss->pdata->set_constraints(video->=
iss, false);
>> + =A0 =A0 media_entity_pipeline_stop(&video->video.entity);
>> +
>> +done:
>> + =A0 =A0 mutex_unlock(&video->stream_lock);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_enum_input(struct file *file, void *fh, struct v4l2_input=
 *input)
>> +{
>> + =A0 =A0 if (input->index > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 strlcpy(input->name, "camera", sizeof(input->name));
>> + =A0 =A0 input->type =3D V4L2_INPUT_TYPE_CAMERA;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_g_input(struct file *file, void *fh, unsigned int *input)
>> +{
>> + =A0 =A0 *input =3D 0;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int
>> +iss_video_s_input(struct file *file, void *fh, unsigned int input)
>> +{
>> + =A0 =A0 return input =3D=3D 0 ? 0 : -EINVAL;
>> +}
>
> While it's possible to support s_input support it provides no useful
> functionality for the user. The OMAP 3 ISP driver also supports it. I=
'd just
> remove it.

Ok. Will fix.

>
> The same will be properly provided to apps by the libv4l2pile(auto) i=
n the
> future.
>
>> +static const struct v4l2_ioctl_ops iss_video_ioctl_ops =3D {
>> + =A0 =A0 .vidioc_querycap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_vi=
deo_querycap,
>> + =A0 =A0 .vidioc_g_fmt_vid_cap =A0 =A0 =A0 =A0 =A0 =3D iss_video_ge=
t_format,
>> + =A0 =A0 .vidioc_s_fmt_vid_cap =A0 =A0 =A0 =A0 =A0 =3D iss_video_se=
t_format,
>> + =A0 =A0 .vidioc_try_fmt_vid_cap =A0 =A0 =A0 =A0 =3D iss_video_try_=
format,
>> + =A0 =A0 .vidioc_g_fmt_vid_out =A0 =A0 =A0 =A0 =A0 =3D iss_video_ge=
t_format,
>> + =A0 =A0 .vidioc_s_fmt_vid_out =A0 =A0 =A0 =A0 =A0 =3D iss_video_se=
t_format,
>> + =A0 =A0 .vidioc_try_fmt_vid_out =A0 =A0 =A0 =A0 =3D iss_video_try_=
format,
>> + =A0 =A0 .vidioc_cropcap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D iss_vi=
deo_cropcap,
>> + =A0 =A0 .vidioc_g_crop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_=
video_get_crop,
>> + =A0 =A0 .vidioc_s_crop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_=
video_set_crop,
>> + =A0 =A0 .vidioc_g_parm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_=
video_get_param,
>> + =A0 =A0 .vidioc_s_parm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_=
video_set_param,
>> + =A0 =A0 .vidioc_reqbufs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D iss_vi=
deo_reqbufs,
>> + =A0 =A0 .vidioc_querybuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_vi=
deo_querybuf,
>> + =A0 =A0 .vidioc_qbuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D is=
s_video_qbuf,
>> + =A0 =A0 .vidioc_dqbuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D iss_=
video_dqbuf,
>> + =A0 =A0 .vidioc_streamon =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_vi=
deo_streamon,
>> + =A0 =A0 .vidioc_streamoff =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D iss_vide=
o_streamoff,
>> + =A0 =A0 .vidioc_enum_input =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D iss_vide=
o_enum_input,
>> + =A0 =A0 .vidioc_g_input =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D iss_vi=
deo_g_input,
>> + =A0 =A0 .vidioc_s_input =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D iss_vi=
deo_s_input,
>> +};
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * V4L2 file operations
>> + */
>> +
>> +static int iss_video_open(struct file *file)
>> +{
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct iss_video_fh *handle;
>> + =A0 =A0 struct vb2_queue *q;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
>> + =A0 =A0 if (handle =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 v4l2_fh_init(&handle->vfh, &video->video);
>> + =A0 =A0 v4l2_fh_add(&handle->vfh);
>> +
>> + =A0 =A0 /* If this is the first user, initialise the pipeline. */
>> + =A0 =A0 if (omap4iss_get(video->iss) =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D omap4iss_pipeline_pm_use(&video->video.entity, 1);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_put(video->iss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 video->alloc_ctx =3D vb2_dma_contig_init_ctx(video->iss->d=
ev);
>> + =A0 =A0 if (IS_ERR(video->alloc_ctx)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(video->alloc_ctx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_put(video->iss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 q =3D &handle->queue;
>> +
>> + =A0 =A0 q->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> + =A0 =A0 q->io_modes =3D VB2_MMAP;
>> + =A0 =A0 q->drv_priv =3D handle;
>> + =A0 =A0 q->ops =3D &iss_video_vb2ops;
>> + =A0 =A0 q->mem_ops =3D &vb2_dma_contig_memops;
>> + =A0 =A0 q->buf_struct_size =3D sizeof(struct iss_buffer);
>> +
>> + =A0 =A0 ret =3D vb2_queue_init(q);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4iss_put(video->iss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 memset(&handle->format, 0, sizeof(handle->format));
>> + =A0 =A0 handle->format.type =3D video->type;
>> + =A0 =A0 handle->timeperframe.denominator =3D 1;
>> +
>> + =A0 =A0 handle->video =3D video;
>> + =A0 =A0 file->private_data =3D &handle->vfh;
>> +
>> +done:
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 v4l2_fh_del(&handle->vfh);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(handle);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int iss_video_release(struct file *file)
>> +{
>> + =A0 =A0 struct iss_video *video =3D video_drvdata(file);
>> + =A0 =A0 struct v4l2_fh *vfh =3D file->private_data;
>> + =A0 =A0 struct iss_video_fh *handle =3D to_iss_video_fh(vfh);
>> +
>> + =A0 =A0 /* Disable streaming and free the buffers queue resources.=
 */
>> + =A0 =A0 iss_video_streamoff(file, vfh, video->type);
>> +
>> + =A0 =A0 omap4iss_pipeline_pm_use(&video->video.entity, 0);
>> +
>> + =A0 =A0 /* Release the file handle. */
>> + =A0 =A0 v4l2_fh_del(vfh);
>> + =A0 =A0 kfree(handle);
>> + =A0 =A0 file->private_data =3D NULL;
>> +
>> + =A0 =A0 omap4iss_put(video->iss);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static unsigned int iss_video_poll(struct file *file, poll_table *w=
ait)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(file->private=
_data);
>> +
>> + =A0 =A0 return vb2_poll(&vfh->queue, file, wait);
>> +}
>> +
>> +static int iss_video_mmap(struct file *file, struct vm_area_struct =
*vma)
>> +{
>> + =A0 =A0 struct iss_video_fh *vfh =3D to_iss_video_fh(file->private=
_data);
>> +
>> + =A0 =A0 return vb2_mmap(&vfh->queue, vma);;
>> +}
>> +
>> +static struct v4l2_file_operations iss_video_fops =3D {
>> + =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 .unlocked_ioctl =3D video_ioctl2,
>> + =A0 =A0 .open =3D iss_video_open,
>> + =A0 =A0 .release =3D iss_video_release,
>> + =A0 =A0 .poll =3D iss_video_poll,
>> + =A0 =A0 .mmap =3D iss_video_mmap,
>> +};
>> +
>> +/* ----------------------------------------------------------------=
-------------
>> + * ISS video core
>> + */
>> +
>> +static const struct iss_video_operations iss_video_dummy_ops =3D {
>> +};
>> +
>> +int omap4iss_video_init(struct iss_video *video, const char *name)
>> +{
>> + =A0 =A0 const char *direction;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 switch (video->type) {
>> + =A0 =A0 case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 direction =3D "output";
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->pad.flags =3D MEDIA_PAD_FL_SINK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 direction =3D "input";
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->pad.flags =3D MEDIA_PAD_FL_SOURCE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D media_entity_init(&video->video.entity, 1, &video-=
>pad, 0);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 mutex_init(&video->mutex);
>> + =A0 =A0 atomic_set(&video->active, 0);
>> +
>> + =A0 =A0 spin_lock_init(&video->pipe.lock);
>> + =A0 =A0 mutex_init(&video->stream_lock);
>> +
>> + =A0 =A0 /* Initialize the video device. */
>> + =A0 =A0 if (video->ops =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 video->ops =3D &iss_video_dummy_ops;
>> +
>> + =A0 =A0 video->video.fops =3D &iss_video_fops;
>> + =A0 =A0 snprintf(video->video.name, sizeof(video->video.name),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"OMAP4 ISS %s %s", name, direction);
>> + =A0 =A0 video->video.vfl_type =3D VFL_TYPE_GRABBER;
>> + =A0 =A0 video->video.release =3D video_device_release_empty;
>> + =A0 =A0 video->video.ioctl_ops =3D &iss_video_ioctl_ops;
>> + =A0 =A0 video->pipe.stream_state =3D ISS_PIPELINE_STREAM_STOPPED;
>> +
>> + =A0 =A0 video_set_drvdata(&video->video, video);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int omap4iss_video_register(struct iss_video *video, struct v4l2_de=
vice *vdev)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 video->video.v4l2_dev =3D vdev;
>> +
>> + =A0 =A0 ret =3D video_register_device(&video->video, VFL_TYPE_GRAB=
BER, -1);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: could not register vi=
deo device (%d)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +void omap4iss_video_unregister(struct iss_video *video)
>> +{
>> + =A0 =A0 if (video_is_registered(&video->video)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 media_entity_cleanup(&video->video.entity)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 video_unregister_device(&video->video);
>> + =A0 =A0 }
>> +}
>> diff --git a/drivers/media/video/omap4iss/iss_video.h b/drivers/medi=
a/video/omap4iss/iss_video.h
>> new file mode 100644
>> index 0000000..fc123b0
>> --- /dev/null
>> +++ b/drivers/media/video/omap4iss/iss_video.h
>> @@ -0,0 +1,205 @@
>> +/*
>> + * iss_video.h
>> + *
>> + * TI OMAP4 ISS - Generic video node
>> + *
>> + * Copyright (C) 2011 Texas Instruments, Inc.
>> + *
>> + * Contacts: Sergio Aguirre <saaguirre@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + */
>> +
>> +#ifndef OMAP4_ISS_VIDEO_H
>> +#define OMAP4_ISS_VIDEO_H
>> +
>> +#include <linux/v4l2-mediabus.h>
>> +#include <linux/version.h>
>> +#include <media/media-entity.h>
>> +#include <media/v4l2-dev.h>
>> +#include <media/v4l2-fh.h>
>> +#include <media/videobuf2-core.h>
>> +#include <media/videobuf2-dma-contig.h>
>> +
>> +#define ISS_VIDEO_DRIVER_NAME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"issvi=
deo"
>> +#define ISS_VIDEO_DRIVER_VERSION =A0 =A0 KERNEL_VERSION(0, 0, 1)
>> +
>> +struct iss_device;
>> +struct iss_video;
>> +struct v4l2_mbus_framefmt;
>> +struct v4l2_pix_format;
>> +
>> +/*
>> + * struct iss_format_info - ISS media bus format information
>> + * @code: V4L2 media bus format code
>> + * @truncated: V4L2 media bus format code for the same format trunc=
ated to 10
>> + * =A0 bits. Identical to @code if the format is 10 bits wide or le=
ss.
>> + * @uncompressed: V4L2 media bus format code for the corresponding =
uncompressed
>> + * =A0 format. Identical to @code if the format is not DPCM compres=
sed.
>> + * @flavor: V4L2 media bus format code for the same pixel layout bu=
t
>> + * =A0 shifted to be 8 bits per pixel. =3D0 if format is not shifta=
ble.
>> + * @pixelformat: V4L2 pixel format FCC identifier
>> + * @bpp: Bits per pixel
>> + */
>> +struct iss_format_info {
>> + =A0 =A0 enum v4l2_mbus_pixelcode code;
>> + =A0 =A0 enum v4l2_mbus_pixelcode truncated;
>> + =A0 =A0 enum v4l2_mbus_pixelcode uncompressed;
>> + =A0 =A0 enum v4l2_mbus_pixelcode flavor;
>> + =A0 =A0 u32 pixelformat;
>> + =A0 =A0 unsigned int bpp;
>> +};
>> +
>> +enum iss_pipeline_stream_state {
>> + =A0 =A0 ISS_PIPELINE_STREAM_STOPPED =3D 0,
>> + =A0 =A0 ISS_PIPELINE_STREAM_CONTINUOUS =3D 1,
>> + =A0 =A0 ISS_PIPELINE_STREAM_SINGLESHOT =3D 2,
>> +};
>> +
>> +enum iss_pipeline_state {
>> + =A0 =A0 /* The stream has been started on the input video node. */
>> + =A0 =A0 ISS_PIPELINE_STREAM_INPUT =3D 1,
>> + =A0 =A0 /* The stream has been started on the output video node. *=
/
>> + =A0 =A0 ISS_PIPELINE_STREAM_OUTPUT =3D 2,
>> + =A0 =A0 /* At least one buffer is queued on the input video node. =
*/
>> + =A0 =A0 ISS_PIPELINE_QUEUE_INPUT =3D 4,
>> + =A0 =A0 /* At least one buffer is queued on the output video node.=
 */
>> + =A0 =A0 ISS_PIPELINE_QUEUE_OUTPUT =3D 8,
>> + =A0 =A0 /* The input entity is idle, ready to be started. */
>> + =A0 =A0 ISS_PIPELINE_IDLE_INPUT =3D 16,
>> + =A0 =A0 /* The output entity is idle, ready to be started. */
>> + =A0 =A0 ISS_PIPELINE_IDLE_OUTPUT =3D 32,
>> + =A0 =A0 /* The pipeline is currently streaming. */
>> + =A0 =A0 ISS_PIPELINE_STREAM =3D 64,
>
> I'd suggest using 1 << n to define flags instead.

Agreed. Will fix.

>
>> +};
>> +
>> +struct iss_pipeline {
>> + =A0 =A0 struct media_pipeline pipe;
>> + =A0 =A0 spinlock_t lock; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Pipelin=
e state and queue flags */
>> + =A0 =A0 unsigned int state;
>> + =A0 =A0 enum iss_pipeline_stream_state stream_state;
>> + =A0 =A0 struct iss_video *input;
>> + =A0 =A0 struct iss_video *output;
>> + =A0 =A0 atomic_t frame_number;
>> + =A0 =A0 bool do_propagation; /* of frame number */
>> + =A0 =A0 struct v4l2_fract max_timeperframe;
>> +};
>> +
>> +#define to_iss_pipeline(__e) \
>> + =A0 =A0 container_of((__e)->pipe, struct iss_pipeline, pipe)
>> +
>> +static inline int iss_pipeline_ready(struct iss_pipeline *pipe)
>> +{
>> + =A0 =A0 return pipe->state =3D=3D (ISS_PIPELINE_STREAM_INPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISS_PIPELIN=
E_STREAM_OUTPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISS_PIPELIN=
E_QUEUE_INPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISS_PIPELIN=
E_QUEUE_OUTPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISS_PIPELIN=
E_IDLE_INPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISS_PIPELIN=
E_IDLE_OUTPUT);
>> +}
>> +
>> +/*
>> + * struct iss_buffer - ISS buffer
>> + * @buffer: ISS video buffer
>> + * @iss_addr: Physical address of the buffer.
>> + */
>> +struct iss_buffer {
>> + =A0 =A0 /* common v4l buffer stuff -- must be first */
>> + =A0 =A0 struct vb2_buffer =A0 =A0 =A0 vb;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
>> + =A0 =A0 dma_addr_t iss_addr;
>> +};
>> +
>> +#define to_iss_buffer(buf) =A0 container_of(buf, struct iss_buffer,=
 buffer)
>> +
>> +enum iss_video_dmaqueue_flags {
>> + =A0 =A0 /* Set if DMA queue becomes empty when ISS_PIPELINE_STREAM=
_CONTINUOUS */
>> + =A0 =A0 ISS_VIDEO_DMAQUEUE_UNDERRUN =3D (1 << 0),
>> + =A0 =A0 /* Set when queuing buffer to an empty DMA queue */
>> + =A0 =A0 ISS_VIDEO_DMAQUEUE_QUEUED =3D (1 << 1),
>> +};
>> +
>> +#define iss_video_dmaqueue_flags_clr(video) =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ({ (video)->dmaqueue_flags=
 =3D 0; })
>> +
>> +/*
>> + * struct iss_video_operations - ISS video operations
>> + * @queue: =A0 Resume streaming when a buffer is queued. Called on =
VIDIOC_QBUF
>> + * =A0 =A0 =A0 =A0 =A0 if there was no buffer previously queued.
>> + */
>> +struct iss_video_operations {
>> + =A0 =A0 int(*queue)(struct iss_video *video, struct iss_buffer *bu=
ffer);
>> +};
>> +
>> +struct iss_video {
>> + =A0 =A0 struct video_device video;
>> + =A0 =A0 enum v4l2_buf_type type;
>> + =A0 =A0 struct media_pad pad;
>> +
>> + =A0 =A0 struct mutex mutex; =A0 =A0 =A0 =A0 =A0 =A0 /* format and =
crop settings */
>> + =A0 =A0 atomic_t active;
>> +
>> + =A0 =A0 struct iss_device *iss;
>> +
>> + =A0 =A0 unsigned int capture_mem;
>> + =A0 =A0 unsigned int bpl_alignment; =A0 =A0 /* alignment value */
>> + =A0 =A0 unsigned int bpl_zero_padding; =A0/* whether the alignment=
 is optional */
>> + =A0 =A0 unsigned int bpl_max; =A0 =A0 =A0 =A0 =A0 /* maximum bytes=
 per line value */
>> + =A0 =A0 unsigned int bpl_value; =A0 =A0 =A0 =A0 /* bytes per line =
value */
>> + =A0 =A0 unsigned int bpl_padding; =A0 =A0 =A0 /* padding at end of=
 line */
>> +
>> + =A0 =A0 /* Entity video node streaming */
>> + =A0 =A0 unsigned int streaming:1;
>> +
>> + =A0 =A0 /* Pipeline state */
>> + =A0 =A0 struct iss_pipeline pipe;
>> + =A0 =A0 struct mutex stream_lock; =A0 =A0 =A0 /* pipeline and stre=
am states */
>> +
>> + =A0 =A0 /* Video buffers queue */
>> + =A0 =A0 struct vb2_queue *queue;
>> + =A0 =A0 spinlock_t qlock; =A0 =A0 =A0 /* Spinlock for dmaqueue */
>> + =A0 =A0 struct list_head dmaqueue;
>> + =A0 =A0 enum iss_video_dmaqueue_flags dmaqueue_flags;
>> + =A0 =A0 struct vb2_alloc_ctx *alloc_ctx;
>> +
>> + =A0 =A0 const struct iss_video_operations *ops;
>> +};
>> +
>> +#define to_iss_video(vdev) =A0 container_of(vdev, struct iss_video,=
 video)
>> +
>> +struct iss_video_fh {
>> + =A0 =A0 struct v4l2_fh vfh;
>> + =A0 =A0 struct iss_video *video;
>> + =A0 =A0 struct vb2_queue queue;
>> + =A0 =A0 struct v4l2_format format;
>
> Format shouldn't be part of the file handle anymore. There was a reas=
on for
> it in the past before PREPARE_BUF --- which is also supported by vide=
obuf2.

Ok. So should I just remove it completely?

Sorry if i'm not understanding this PREPARE_BUF thing... What should I
have there?


Regards,
Sergio

>
>> + =A0 =A0 struct v4l2_fract timeperframe;
>> +};
>> +
>> +#define to_iss_video_fh(fh) =A0container_of(fh, struct iss_video_fh=
, vfh)
>> +#define iss_video_queue_to_iss_video_fh(q) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_=
of(q, struct iss_video_fh, queue)
>> +
>> +int omap4iss_video_init(struct iss_video *video, const char *name);
>> +int omap4iss_video_register(struct iss_video *video,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_device=
 *vdev);
>> +void omap4iss_video_unregister(struct iss_video *video);
>> +struct iss_buffer *omap4iss_video_buffer_next(struct iss_video *vid=
eo,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 unsigned int error);
>> +struct media_pad *omap4iss_video_remote_pad(struct iss_video *video=
);
>> +
>> +const struct iss_format_info *
>> +omap4iss_video_format_info(enum v4l2_mbus_pixelcode code);
>> +
>> +#endif /* OMAP4_ISS_VIDEO_H */
>
> Cheers,
>
> --
> Sakari Ailus
> e-mail: sakari.ailus@iki.fi =A0 =A0 jabber/XMPP/Gmail: sailus@retiisi=
=2Eorg.uk
