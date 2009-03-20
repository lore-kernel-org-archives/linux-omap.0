From: Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 3/3] V4L2 Driver for OMAP3/3 DSS.
Date: Fri, 20 Mar 2009 15:23:11 +0300
Message-ID: <208cbae30903200523o1876f47fo11803037e03d735e@mail.gmail.com>
References: <1237526408-14249-1-git-send-email-hardik.shah@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1237526408-14249-1-git-send-email-hardik.shah@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Hardik Shah <hardik.shah@ti.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Brijesh Jadav <brijesh.j@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello, Hardik
Do you mind if i make few comments ?

On Fri, Mar 20, 2009 at 8:20 AM, Hardik Shah <hardik.shah@ti.com> wrote=
:
> This is the version 3rd of the driver. This is a review
> patch since the DSS2 library is not accepted.
> Most of the community comments are addressed like
> 1. V4L2 Driver for OMAP3/3 DSS.
> 2. Conversion of the custom ioctls to standard V4L2 ioctls like
> alpha blending, color keying, rotation and back ground color setting
> 3. Re-organised the code as per community comments.
>
> Following are the features tested.
> 1. Provides V4L2 user interface for the video pipelines of DSS
> 2. Basic streaming working on LCD and TV.
> 3. Support for various pixel formats like YUV, UYVY, RGB32, RGB24, RG=
B565
> 4. Supports Alpha blending.
> 5. Supports Color keying both source and destination.
> 6. Supports rotation with RGB565 and RGB32 pixels formats.
> 7. Supports cropping.
> 8. Supports Background color setting.
> 9. Works on latest DSS2 library from Tomi with minor changes.
> http://www.bat.org/~tomba/git/linux-omap-dss.git/
>
> TODOS
> 1. Flipping support.
> 2. Rotation support for YUV and UYVY format
> 3. Ioctls for programming the color space conversion matrix
> 4. DVI resolution test.
>
> Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
> Signed-off-by: Hardik Shah <hardik.shah@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0| =A0 19 +-
> =A0drivers/media/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 20 +
> =A0drivers/media/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0drivers/media/video/omap/Kconfig =A0 =A0 =A0 =A0| =A0 60 +
> =A0drivers/media/video/omap/Makefile =A0 =A0 =A0 | =A0 =A03 +
> =A0drivers/media/video/omap/omap_vout.c =A0 =A0| 2571 +++++++++++++++=
++++++++++++++++
> =A0drivers/media/video/omap/omap_voutdef.h | =A0137 ++
> =A0drivers/media/video/omap/omap_voutlib.c | =A0281 ++++
> =A0drivers/media/video/omap/omap_voutlib.h | =A0 34 +
> =A09 files changed, 3126 insertions(+), 3 deletions(-)
> =A0create mode 100644 drivers/media/video/omap/Kconfig
> =A0create mode 100644 drivers/media/video/omap/Makefile
> =A0create mode 100644 drivers/media/video/omap/omap_vout.c
> =A0create mode 100644 drivers/media/video/omap/omap_voutdef.h
> =A0create mode 100644 drivers/media/video/omap/omap_voutlib.c
> =A0create mode 100644 drivers/media/video/omap/omap_voutlib.h
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index 2740500..ffec76d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -42,7 +42,6 @@
> =A0#include "twl4030-generic-scripts.h"
> =A0#include "mmc-twl4030.h"
>
> -
> =A0static struct resource omap3evm_smc911x_resources[] =3D {
> =A0 =A0 =A0 =A0[0] =3D =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D OMAP3EVM_ETHR_START,
> @@ -63,6 +62,20 @@ static struct platform_device omap3evm_smc911x_dev=
ice =3D {
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D &omap3evm_smc911x_resources =
[0],
> =A0};
>
> +#ifdef CONFIG_FB_OMAP2
> +static struct resource omap3evm_vout_resource[3 - CONFIG_FB_OMAP2_NU=
M_FBS] =3D {
> +};
> +#else
> +static struct resource omap3evm_vout_resource[2] =3D {
> +};
> +#endif
> +
> +static struct platform_device omap3evm_vout_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "omap_vou=
t",
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(omap3evm_vout_resource=
),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &omap3evm_vou=
t_resource[0],
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> +};
> =A0static inline void __init omap3evm_init_smc911x(void)
> =A0{
> =A0 =A0 =A0 =A0int eth_cs;
> @@ -307,7 +320,6 @@ static struct omap_display_data omap3_evm_display=
_data_tv =3D {
> =A0 =A0 =A0 =A0.panel_disable =3D omap3_evm_panel_disable_tv,
> =A0};
>
> -
> =A0static int omap3_evm_panel_enable_dvi(struct omap_display *display=
)
> =A0{
> =A0 =A0 =A0 =A0if (lcd_enabled) {
> @@ -332,7 +344,6 @@ static void omap3_evm_panel_disable_dvi(struct om=
ap_display *display)
> =A0 =A0 =A0 =A0dvi_enabled =3D 0;
> =A0}
>
> -
> =A0static struct omap_display_data omap3_evm_display_data_dvi =3D {
> =A0 =A0 =A0 =A0.type =3D OMAP_DISPLAY_TYPE_DPI,
> =A0 =A0 =A0 =A0.name =3D "dvi",
> @@ -419,6 +430,8 @@ static struct omap_board_config_kernel omap3_evm_=
config[] __initdata =3D {
> =A0static struct platform_device *omap3_evm_devices[] __initdata =3D =
{
> =A0 =A0 =A0 =A0&omap3_evm_dss_device,
> =A0 =A0 =A0 =A0&omap3evm_smc911x_device,
> + =A0 =A0 =A0 &omap3evm_vout_device,
> +
> =A0};
>
> =A0static struct twl4030_hsmmc_info mmc[] __initdata =3D {
> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfi=
g
> index 19cf3b8..91e4529 100644
> --- a/drivers/media/video/Kconfig
> +++ b/drivers/media/video/Kconfig
> @@ -711,6 +711,26 @@ config VIDEO_CAFE_CCIC
> =A0 =A0 =A0 =A0 =A0CMOS camera controller. =A0This is the controller =
found on first-
> =A0 =A0 =A0 =A0 =A0generation OLPC systems.
>
> +#config VIDEO_OMAP3
> +# =A0 =A0 =A0 =A0tristate "OMAP 3 Camera support"
> +# =A0 =A0 =A0select VIDEOBUF_GEN
> +# =A0 =A0 =A0select VIDEOBUF_DMA_SG
> +# =A0 =A0 =A0depends on VIDEO_V4L2 && ARCH_OMAP34XX
> +# =A0 =A0 =A0---help---
> +# =A0 =A0 =A0 =A0Driver for an OMAP 3 camera controller.
> +
> +config VIDEO_OMAP3
> + =A0 =A0 =A0 bool "OMAP2/OMAP3 Camera and V4L2-DSS drivers"
> + =A0 =A0 =A0 select VIDEOBUF_GEN
> + =A0 =A0 =A0 select VIDEOBUF_DMA_SG
> + =A0 =A0 =A0 select OMAP2_DSS
> + =A0 =A0 =A0 depends on VIDEO_DEV && (ARCH_OMAP24XX || ARCH_OMAP34XX=
)
> + =A0 =A0 =A0 default y
> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 =A0V4L2 DSS and Camera driver support for OMAP2/3 based=
 boards.
> +
> +source "drivers/media/video/omap/Kconfig"
> +
> =A0config SOC_CAMERA
> =A0 =A0 =A0 =A0tristate "SoC camera support"
> =A0 =A0 =A0 =A0depends on VIDEO_V4L2 && HAS_DMA
> diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makef=
ile
> index 72f6d03..e8de241 100644
> --- a/drivers/media/video/Makefile
> +++ b/drivers/media/video/Makefile
> @@ -107,6 +107,10 @@ obj-$(CONFIG_VIDEO_CAFE_CCIC) +=3D cafe_ccic.o
> =A0obj-$(CONFIG_VIDEO_OV7670) =A0 =A0 +=3D ov7670.o
>
> =A0obj-$(CONFIG_VIDEO_TCM825X) +=3D tcm825x.o
> +obj-$(CONFIG_VIDEO_MT9P012) =A0 =A0+=3D mt9p012.o
> +obj-$(CONFIG_VIDEO_DW9710) +=3D dw9710.o
> +
> +obj-$(CONFIG_VIDEO_OMAP3) +=3D omap/
>
> =A0obj-$(CONFIG_USB_DABUSB) =A0 =A0 =A0 =A0+=3D dabusb.o
> =A0obj-$(CONFIG_USB_OV511) =A0 =A0 =A0 =A0 +=3D ov511.o
> diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/o=
map/Kconfig
> new file mode 100644
> index 0000000..00bd425
> --- /dev/null
> +++ b/drivers/media/video/omap/Kconfig
> @@ -0,0 +1,60 @@
> +config VIDEO_OMAP_VIDEOLIB
> + =A0 =A0 =A0 tristate "OMAP Video out library"
> + =A0 =A0 =A0 depends on VIDEO_OMAP3
> + =A0 =A0 =A0 default VIDEO_OMAP3
> +
> +config VIDEO_OMAP_VIDEOOUT
> + =A0 =A0 =A0 tristate "OMAP Video out driver"
> + =A0 =A0 =A0 select VIDEOBUF_DMA_SG
> + =A0 =A0 =A0 select VIDEOBUF_GEN
> + =A0 =A0 =A0 depends on VIDEO_OMAP3
> + =A0 =A0 =A0 default VIDEO_OMAP3
> +
> +choice
> + =A0 =A0 =A0 =A0prompt "VID1 Overlay manager"
> + =A0 =A0 =A0 =A0depends on VIDEO_OMAP_VIDEOOUT
> + =A0 =A0 =A0 =A0default VID1_LCD_MANAGER
> +
> +config VID1_TV_MANAGER
> + =A0 =A0 =A0 =A0bool "Use TV Manager"
> + =A0 =A0 =A0 =A0help
> + =A0 =A0 =A0 =A0 =A0Select this option if you want VID1 pipeline on =
TV Overlay manager
> +
> +config VID1_LCD_MANAGER
> + =A0 =A0 =A0 =A0bool "Use LCD Managaer"
> + =A0 =A0 =A0 =A0help
> + =A0 =A0 =A0 =A0 =A0Select this option if you want VID1 pipeline on =
LCD Overlay manager
> +endchoice
> +
> +choice
> + =A0 =A0 =A0 prompt "VID2 Overlay manager"
> + =A0 =A0 =A0 depends on VIDEO_OMAP_VIDEOOUT
> + =A0 =A0 =A0 default VID2_LCD_MANAGER
> +
> +config VID2_TV_MANAGER
> + =A0 =A0 =A0 bool "Use TV Manager"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this option if you want VID2 pipeline on TV =
Overlay manager
> +
> +config VID2_LCD_MANAGER
> + =A0 =A0 =A0 bool "Use LCD Managaer"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this option if you want VID2 pipeline on LCD=
 Overlay manager
> +endchoice
> +
> +choice
> + =A0 =A0 =A0 =A0prompt "TV Mode"
> + =A0 =A0 =A0 =A0depends on VID2_TV_MANAGER || VID1_TV_MANAGER
> + =A0 =A0 =A0 =A0default NTSC_M
> +
> +config NTSC_M
> + =A0 =A0 =A0 =A0bool "Use NTSC_M mode"
> + =A0 =A0 =A0 =A0help
> + =A0 =A0 =A0 =A0 =A0Select this option if you want NTSC_M mode on TV
> +
> +config PAL_BDGHI
> + =A0 =A0 =A0 =A0bool "Use PAL_BDGHI mode"
> + =A0 =A0 =A0 =A0help
> + =A0 =A0 =A0 =A0 =A0Select this option if you want PAL_BDGHI mode on=
 TV
> +
> +endchoice
> diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/=
omap/Makefile
> new file mode 100644
> index 0000000..75e01d3
> --- /dev/null
> +++ b/drivers/media/video/omap/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_VIDEO_OMAP_VIDEOLIB) +=3D omap_voutlib.o
> +obj-$(CONFIG_VIDEO_OMAP_VIDEOOUT) +=3D omap_vout.o
> +
> diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/vid=
eo/omap/omap_vout.c
> new file mode 100644
> index 0000000..841b6d4
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_vout.c
> @@ -0,0 +1,2571 @@
> +/*
> + * drivers/media/video/omap/omap_vout.c
> + *
> + * Copyright (C) 2005-2008 Texas Instruments.

Is years correct ? 2009 ?

> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. This program is licensed "as is" without any warranty =
of any
> + * kind, whether express or implied.
> + *
> + * Leveraged code from the OMAP2 camera driver
> + * Video-for-Linux (Version 2) camera capture driver for
> + * the OMAP24xx camera controller.
> + *
> + * Author: Andy Lowe (source@mvista.com)
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2008 Texas Instruments.
> + *
> + * History:
> + * 20-APR-2006 Khasim =A0 =A0 =A0 =A0 =A0Modified VRFB based Rotatio=
n,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The image=
 data is always read from 0 degree
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 view and =
written
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 to the vi=
rtual space of desired rotation angle
> + * 4-DEC-2006 Jian =A0 =A0 =A0 =A0 =A0 =A0 Changed to support better=
 memory management
> + *
> + * 17-Nov-2008 Hardik =A0 =A0 =A0 =A0 =A0Changed to used the new DSS=
 paches by Tomi
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Changed d=
river to use video_ioctl2
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/smp_lock.h>
> +#include <linux/interrupt.h>
> +#include <linux/kdev_t.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <linux/videodev2.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <media/videobuf-dma-sg.h>
> +#include <linux/input.h>
> +#include <linux/dma-mapping.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-ioctl.h>
> +#include <mach/display.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/semaphore.h>
> +#include <asm/processor.h>
> +#include <mach/dma.h>
> +#include <mach/vrfb.h>
> +#include <mach/display.h>
> +#include "omap_voutlib.h"
> +#include "omap_voutdef.h"
> +
> +#define OMAP_VIDEO1 0
> +#define OMAP_VIDEO2 1
> +
> +#undef DEBUG
> +/*
> + * Uncomment this if debugging support needs to be enabled
> + */
> +/* #define DEBUG */
> +
> +#ifdef DEBUG
> +#define DPRINTK(ARGS...) =A0(printk(KERN_DEBUG "<%s>: ", __func__); =
\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_DEBUG ARGS))
> +#else
> +#define DPRINTK(x...)
> +#endif
> +
> +/* configuration macros */
> +#define VOUT_NAME =A0 =A0 =A0 =A0 =A0 =A0 =A0"omap_vout"
> +
> +#define QQVGA_WIDTH =A0 =A0 =A0 =A0 =A0 =A0160
> +#define QQVGA_HEIGHT =A0 =A0 =A0 =A0 =A0 120
> +
> +#define NUM_OF_VIDEO_CHANNELS =A02
> +
> +#define VID_MAX_WIDTH =A0 =A0 =A0 =A0 =A01280 =A0 =A0/* Largest widt=
h */
> +#define VID_MAX_HEIGHT =A0 =A0 =A0 =A0 720/* Largest height */
> +
> +#define VID_MIN_WIDTH =A0 =A0 =A0 =A0 =A00
> +#define VID_MIN_HEIGHT =A0 =A0 =A0 =A0 0
> +
> +/* 2048 x 2048 is max res supported by OMAP display controller */
> +#define DMA_CHAN_ALLOTED =A0 =A0 =A0 =A01
> +#define DMA_CHAN_NOT_ALLOTED =A0 =A00
> +#define MAX_PIXELS_PER_LINE =A0 =A0 2048
> +#define VRFB_TX_TIMEOUT =A0 =A0 =A0 =A0 1000
> +
> +/* VRFB offset computation parameters */
> +#define SIDE_H =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +#define SIDE_W =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> +
> +/* SDRAM page size parameters used for VRFB settings */
> +#define PAGE_WIDTH_EXP =A0 =A0 =A0 =A0 =A05 =A0 =A0 =A0 /* page widt=
h =3D 1 << PAGE_WIDTH_EXP */
> +#define PAGE_HEIGHT_EXP =A0 =A0 =A0 =A0 5 =A0 =A0 =A0 /* page height=
 =3D 1 << PAGE_HEIGHT_EXP */
> +
> +/* IRQ Bits mask of DSS */
> +#define OMAP_VOUT_MAX_BUF_SIZE (VID_MAX_WIDTH*VID_MAX_HEIGHT*4)
> +
> +static struct omap_vout_device *saved_v1out, *saved_v2out;
> +
> +#define STREAMING_IS_ON() =A0 =A0 =A0((saved_v1out && saved_v1out->s=
treaming) || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (saved_=
v2out && saved_v2out->streaming))
> +
> +static struct videobuf_queue_ops video_vbq_ops;
> +
> +static u32 video1_numbuffers =3D 3;
> +static u32 video2_numbuffers =3D 3;
> +static u32 video1_bufsize =3D OMAP_VOUT_MAX_BUF_SIZE;
> +static u32 video2_bufsize =3D OMAP_VOUT_MAX_BUF_SIZE;
> +module_param(video1_numbuffers, uint, S_IRUGO);
> +module_param(video2_numbuffers, uint, S_IRUGO);
> +module_param(video1_bufsize, uint, S_IRUGO);
> +module_param(video2_bufsize, uint, S_IRUGO);
> +
> +static int omap_vout_create_video_devices(struct platform_device *pd=
ev);
> +static int omapvid_apply_changes(struct omap_vout_device *vout, u32 =
addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int init);
> +static int omapvid_setup_overlay(struct omap_vout_device *vout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl, int posx, int=
 posy,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int outw, int outh, u32 addr, int tv_fi=
eld1_offset, int init);
> +static enum omap_color_mode video_mode_to_dss_mode(struct omap_vout_=
device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *vout);
> +static void omap_vout_isr(void *arg, unsigned int irqstatus);
> +static void omap_vout_cleanup_device(struct omap_vout_device *vout);
> +/* module parameters */
> +
> +/*
> + * Maximum amount of memory to use for rendering buffers.
> + * Default is enough to four (RGB24) VGA buffers.
> + */
> +#define MAX_ALLOWED_VIDBUFFERS =A0 =A0 =A0 =A0 =A0 =A04
> +
> +static struct v4l2_queryctrl omap_vout_qctrl[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0=3D V4L2_CID=
_ROTATION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=3D "Rotation"=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .minimum =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maximum =A0 =A0 =A0 =3D 270,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .step =A0 =A0 =A0 =A0 =A0=3D 90,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .default_value =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0=3D V4L2_CTRL_=
TYPE_INTEGER,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0=3D V4L2_CID=
_BG_COLOR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=3D "Backgroun=
d color",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .minimum =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maximum =A0 =A0 =A0 =3D 16777215,/* 24=
bit RGB Max Value 2^24-1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .step =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .default_value =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0=3D V4L2_CTRL_=
TYPE_INTEGER,
> + =A0 =A0 =A0 }
> +
> +
> +};
> +
> +/* list of image formats supported by OMAP2 video pipelines */
> +const static struct v4l2_fmtdesc omap_formats[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0/* Note: =A0V4L2 defines RGB565 as:
> + =A0 =A0 =A0 =A0 *
> + =A0 =A0 =A0 =A0 * =A0 =A0 =A0Byte 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0Byte 1
> + =A0 =A0 =A0 =A0 * =A0 =A0 =A0g2 g1 g0 r4 r3 r2 r1 r0 =A0 b4 b3 b2 b=
1 b0 g5 g4 g3
> + =A0 =A0 =A0 =A0 *
> + =A0 =A0 =A0 =A0 * We interpret RGB565 as:
> + =A0 =A0 =A0 =A0 *
> + =A0 =A0 =A0 =A0 * =A0 =A0 =A0Byte 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0Byte 1
> + =A0 =A0 =A0 =A0 * =A0 =A0 =A0g2 g1 g0 b4 b3 b2 b1 b0 =A0 r4 r3 r2 r=
1 r0 g5 g4 g3
> + =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0.description =3D "RGB565, le",
> + =A0 =A0 =A0 =A0.pixelformat =3D V4L2_PIX_FMT_RGB565,
> + =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0/* Note: =A0V4L2 defines RGB32 as: RGB-8-8-8-8 =A0we=
 use
> + =A0 =A0 =A0 =A0 * =A0this for RGB24 unpack mode, the last 8 bits ar=
e ignored
> + =A0 =A0 =A0 =A0 * */
> + =A0 =A0 =A0 =A0.description =3D "RGB32, le",
> + =A0 =A0 =A0 =A0.pixelformat =3D V4L2_PIX_FMT_RGB32,
> + =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0/* Note: =A0V4L2 defines RGB24 as: RGB-8-8-8 =A0we u=
se
> + =A0 =A0 =A0 =A0 * =A0 =A0 =A0 =A0this for RGB24 packed mode
> + =A0 =A0 =A0 =A0 *
> + =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0.description =3D "RGB24, le",
> + =A0 =A0 =A0 =A0.pixelformat =3D V4L2_PIX_FMT_RGB24,
> + =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0.description =3D "YUYV (YUV 4:2:2), packed",
> + =A0 =A0 =A0 =A0.pixelformat =3D V4L2_PIX_FMT_YUYV,
> + =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0.description =3D "UYVY, packed",
> + =A0 =A0 =A0 =A0.pixelformat =3D V4L2_PIX_FMT_UYVY,
> + =A0 =A0 =A0 =A0},
> +};
> +
> +#define NUM_OUTPUT_FORMATS (sizeof(omap_formats)/sizeof(omap_formats=
[0]))
> +
> +static unsigned long
> +omap_vout_alloc_buffer(u32 buf_size, u32 *phys_addr)
> +{
> + =A0 =A0 =A0 unsigned long virt_addr, addr;
> + =A0 =A0 =A0 u32 order, size;
> + =A0 =A0 =A0 size =3D PAGE_ALIGN(buf_size);
> + =A0 =A0 =A0 order =3D get_order(size);
> + =A0 =A0 =A0 virt_addr =3D __get_free_pages(GFP_KERNEL | GFP_DMA, or=
der);
> + =A0 =A0 =A0 addr =3D virt_addr;
> + =A0 =A0 =A0 if (virt_addr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (size > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SetPageReserved(virt_to=
_page(addr));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr +=3D PAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D PAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 *phys_addr =3D (u32) virt_to_phys((void *) virt_addr);
> + =A0 =A0 =A0 return virt_addr;
> +}
> +
> +static void
> +omap_vout_free_buffer(unsigned long virtaddr, u32 phys_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 buf_size)
> +{
> + =A0 =A0 =A0 unsigned long addr =3D virtaddr;
> + =A0 =A0 =A0 u32 order, size;
> + =A0 =A0 =A0 size =3D PAGE_ALIGN(buf_size);
> + =A0 =A0 =A0 order =3D get_order(size);
> + =A0 =A0 =A0 while (size > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ClearPageReserved(virt_to_page(addr));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr +=3D PAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D PAGE_SIZE;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 free_pages((unsigned long) virtaddr, order);
> +}
> +
> +static int omap_vout_try_format(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
v4l2_pix_format *def_pix)
> +{
> + =A0 =A0 =A0 int ifmt, bpp =3D 0;
> +
> + =A0 =A0 =A0 if (pix->width > VID_MAX_WIDTH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->width =3D VID_MAX_WIDTH;
> + =A0 =A0 =A0 if (pix->height > VID_MAX_HEIGHT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->height =3D VID_MAX_HEIGHT;
> +
> + =A0 =A0 =A0 if (pix->width <=3D VID_MIN_WIDTH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->width =3D def_pix->width;
> + =A0 =A0 =A0 if (pix->height <=3D VID_MIN_HEIGHT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->height =3D def_pix->height;
> +
> + =A0 =A0 =A0 for (ifmt =3D 0; ifmt < NUM_OUTPUT_FORMATS; ifmt++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pix->pixelformat =3D=3D omap_format=
s[ifmt].pixelformat)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (ifmt =3D=3D NUM_OUTPUT_FORMATS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ifmt =3D 0;
> +
> + =A0 =A0 =A0 pix->pixelformat =3D omap_formats[ifmt].pixelformat;
> + =A0 =A0 =A0 pix->field =3D V4L2_FIELD_ANY;
> + =A0 =A0 =A0 pix->priv =3D 0;
> +
> + =A0 =A0 =A0 switch (pix->pixelformat) {
> + =A0 =A0 =A0 case V4L2_PIX_FMT_YUYV:
> + =A0 =A0 =A0 case V4L2_PIX_FMT_UYVY:
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->colorspace =3D V4L2_COLORSPACE_JPE=
G;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bpp =3D YUYV_BPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB565:
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB565X:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->colorspace =3D V4L2_COLORSPACE_SRG=
B;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bpp =3D RGB565_BPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB24:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->colorspace =3D V4L2_COLORSPACE_SRG=
B;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bpp =3D RGB24_BPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB32:
> + =A0 =A0 =A0 case V4L2_PIX_FMT_BGR32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->colorspace =3D V4L2_COLORSPACE_SRG=
B;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bpp =3D RGB32_BPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 pix->bytesperline =3D pix->width * bpp;
> + =A0 =A0 =A0 pix->sizeimage =3D pix->bytesperline * pix->height;
> + =A0 =A0 =A0 return bpp;
> +}
> +
> +/*
> + * omap_vout_uservirt_to_phys: This inline function is used to conve=
rt user
> + * space virtual address to physical address.
> + */
> +static inline u32 omap_vout_uservirt_to_phys(u32 virtp)
> +{
> + =A0 =A0 =A0 unsigned long physp =3D 0;
> + =A0 =A0 =A0 struct mm_struct *mm =3D current->mm;
> + =A0 =A0 =A0 struct vm_area_struct *vma;
> +
> + =A0 =A0 =A0 vma =3D find_vma(mm, virtp);
> + =A0 =A0 =A0 /* For kernel direct-mapped memory, take the easy way *=
/
> + =A0 =A0 =A0 if (virtp >=3D PAGE_OFFSET) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D virt_to_phys((void *) virtp);
> + =A0 =A0 =A0 } else if ((vma) && (vma->vm_flags & VM_IO)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (vma->vm_pgoff)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this will catch, kernel-allocated,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmaped-to-usermode addresses */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D (vma->vm_pgoff << PAGE_SHIFT)=
 + (virtp - vma->vm_start);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* otherwise, use get_user_pages() for =
general userland pages */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int res, nr_pages =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct page *pages;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 down_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D get_user_pages(current, current=
->mm, virtp, nr_pages,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, 0, &=
pages, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res =3D=3D nr_pages) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D =A0__pa(page_=
address(&pages[0]) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (virtp & ~PAGE_MASK));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "om=
ap_vout_uservirt_to_phys:\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 get_user_pages failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return physp;
> +}
> +
> +/* This functions wakes up the application once
> + * the DMA transfer to VRFB space is completed. */
> +static void omap_vout_vrfb_dma_tx_callback(int lch, u16 ch_status, v=
oid *data)
> +{
> + =A0 =A0 =A0 struct vid_vrfb_dma *t =3D (struct vid_vrfb_dma *) data=
;
> + =A0 =A0 =A0 t->tx_status =3D 1;
> + =A0 =A0 =A0 wake_up_interruptible(&t->wait);
> +}
> +
> +/* Function used to find the VRFB Alignement */
> +static inline u32 pages_per_side(u32 img_side, u32 page_exp)
> +{
> + =A0 =A0 =A0 /* =A0page_side =3D 2 ^ page_exp
> + =A0 =A0 =A0 =A0* (page_side - 1) is added for rounding up
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 return (u32) (img_side + (1 << page_exp) - 1) >> page_e=
xp;
> +}
> +
> +/* Buffer setup function is called by videobuf layer when REQBUF ioc=
tl is
> + * called. This is used to setup buffers and return size and count o=
f
> + * buffers allocated. After the call to this buffer, videobuf layer =
will
> + * setup buffer queue depending on the size and count of buffers
> + */
> +static int omap_vout_buffer_setup(struct videobuf_queue *q, unsigned=
 int *count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *size)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *fh =3D (struct omap_vout_fh *) q->=
priv_data;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh->vout;
> + =A0 =A0 =A0 int startindex =3D 0, i, j;
> + =A0 =A0 =A0 u32 phy_addr =3D 0, virt_addr =3D 0;
> +
> + =A0 =A0 =A0 if (!vout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (V4L2_BUF_TYPE_VIDEO_OUTPUT !=3D q->type)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 startindex =3D (vout->vid =3D=3D OMAP_VIDEO1) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video1_numbuffers : video2_numbuffers;
> + =A0 =A0 =A0 if (V4L2_MEMORY_MMAP =3D=3D vout->memory && *count < st=
artindex)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *count =3D startindex;
> +
> + =A0 =A0 =A0 if (vout->rotation !=3D -1 && *count > 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *count =3D 4;
> +
> + =A0 =A0 =A0 /* If rotation is enabled, allocate memory for VRFB spa=
ce also */
> + =A0 =A0 =A0 if (vout->rotation >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < *count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout->smsshado_vir=
t_addr[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->s=
msshado_virt_addr[i] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vo=
ut_alloc_buffer(vout->smsshado_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &vout->=
smsshado_phy_addr[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout->smsshado_vir=
t_addr[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (V4L=
2_MEMORY_MMAP =3D=3D vout->memory
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 && i >=3D startindex)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =
=3D 0; j < i; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap_vout_free_buffer(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vout->smsshado_virt_addr[j],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vout->smsshado_phy_addr[j],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vout->smsshado_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_virt_addr[j] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_phy_addr[j] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *count =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset((void *) vout->s=
msshado_virt_addr[i], 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vout->sm=
sshado_size);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->rotation =3D=3D=
 1 || vout->rotation =3D=3D 3) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vr=
fb_setup(&vout->vrfb_context[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_phy_addr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->pix.height,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->pix.width,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->bpp);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vr=
fb_setup(&vout->vrfb_context[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_phy_addr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->pix.width,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->pix.height,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->bpp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (V4L2_MEMORY_MMAP !=3D vout->memory)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 *size =3D vout->buffer_size;
> + =A0 =A0 =A0 startindex =3D (vout->vid =3D=3D OMAP_VIDEO1) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video1_numbuffers : video2_numbuffers;
> + =A0 =A0 =A0 for (i =3D startindex; i < *count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buffer_size =3D *size;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_addr =3D omap_vout_alloc_buffer(vo=
ut->buffer_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &phy_ad=
dr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!virt_addr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->rotation < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D i; j < *coun=
t; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vo=
ut_free_buffer(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_virt_addr[j],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_phy_addr[j],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->s=
msshado_virt_addr[j] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->s=
msshado_phy_addr[j] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =3D virt_addr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_phy_addr[i] =3D phy_addr;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 *count =3D vout->buffer_allocated =3D i;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* This function will be called when VIDIOC_QBUF ioctl is called.
> + * It prepare buffers before give out for the display. This function
> + * user space virtual address into physical address if userptr memor=
y
> + * exchange mechanism is used. If rotation is enabled, it copies ent=
ire
> + * buffer into VRFB memory space before giving it to the DSS.
> + */
> +static int omap_vout_buffer_prepare(struct videobuf_queue *q,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct videobuf=
_buffer *vb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum v4l2_field=
 field)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *fh =3D (struct omap_vout_fh *) q->=
priv_data;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh->vout;
> + =A0 =A0 =A0 u32 dest_frame_index =3D 0, src_element_index =3D 0;
> + =A0 =A0 =A0 u32 dest_element_index =3D 0, src_frame_index =3D 0;
> + =A0 =A0 =A0 u32 elem_count =3D 0, frame_count =3D 0, pixsize =3D 2;
> + =A0 =A0 =A0 struct videobuf_dmabuf *dmabuf =3D NULL;
> +
> + =A0 =A0 =A0 if (VIDEOBUF_NEEDS_INIT =3D=3D vb->state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb->width =3D vout->pix.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb->height =3D vout->pix.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb->size =3D vb->width * vb->height * v=
out->bpp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb->field =3D field;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vb->state =3D VIDEOBUF_PREPARED;
> + =A0 =A0 =A0 /* if user pointer memory mechanism is used, get the ph=
ysical
> + =A0 =A0 =A0 =A0* address of the buffer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vb->memory) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D vb->baddr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Virtual address */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* priv points to struct videobuf_pci_s=
g_memory. But we went
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* pointer to videobuf_dmabuf, which =
is member of
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* videobuf_pci_sg_memory */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf =3D videobuf_to_dma(q->bufs[vb->=
i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf->vmalloc =3D (void *) vb->baddr;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Physical address */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf->bus_addr =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dma_addr_t) omap_vout_=
uservirt_to_phys(vb->baddr);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout->rotation >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf =3D videobuf_to_dma(q->bufs[vb->=
i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If rotation is enabled, copy input b=
uffer into VRFB
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* memory space using DMA. We are cop=
ying input buffer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* into VRFB memory space of desired =
angle and DSS will
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* read image VRFB memory for 0 degre=
e angle
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixsize =3D vout->bpp * vout->vrfb_bpp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* DMA transfer in double index mode
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Frame index */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dest_frame_index =3D ((MAX_PIXELS_PER_L=
INE * pixsize) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (vout->pix.width * vout->bpp)) + 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Source and destination parameters */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_element_index =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_frame_index =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dest_element_index =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Number of elements per frame */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elem_count =3D vout->pix.width * vout->=
bpp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_count =3D vout->pix.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_dma_tx.tx_status =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_transfer_params(vout->vrfb=
_dma_tx.dma_ch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0OMAP_DMA_DATA_TYPE_S32,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(elem_count / 4), frame_count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0OMAP_DMA_SYNC_ELEMENT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0vout->vrfb_dma_tx.dev_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* src_port required only for OMAP1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_src_params(vout->vrfb_dma_=
tx.dma_ch, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_DMA_AMODE_POST_INC,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 dmabuf->bus_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 src_element_index,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 src_frame_index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*set dma source burst mode for VRFB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_src_burst_mode(vout->vrfb_=
dma_tx.dma_ch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 OMAP_DMA_DATA_BURST_16);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* dest_port required only for OMAP1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_dest_params(vout->vrfb_dma=
_tx.dma_ch, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_DMA_AMODE_DOUBL=
E_IDX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vout->vrfb_context[v=
b->i].paddr[vout->rotation],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dest_element_index, =
dest_frame_index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*set dma dest burst mode for VRFB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_dest_burst_mode(vout->vrfb=
_dma_tx.dma_ch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0OMAP_DMA_DATA_BURST_16);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_set_global_params(DMA_DEFAULT_=
ARB_RATE, 0x20, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_start_dma(vout->vrfb_dma_tx.dma_ch=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interruptible_sleep_on_timeout(&vout->v=
rfb_dma_tx.wait,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0VRFB_TX_TIMEOUT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->vrfb_dma_tx.tx_status =3D=3D =
0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(vout->vrf=
b_dma_tx.dma_ch);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Store buffers physical address into =
an array. Addresses
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* from this array will be used to co=
nfigure DSS */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->queued_buf_addr[vb->i] =3D (u8 *)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_context[vb->=
i].paddr[0];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf =3D videobuf_to_=
dma(q->bufs[vb->i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->queued_buf_addr[v=
b->i] =3D (u8 *) dmabuf->bus_addr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +}
> +
> +/* Buffer queue funtion will be called from the videobuf layer when =
_QBUF
> + * ioctl is called. It is used to enqueue buffer, which is ready to =
be
> + * displayed. */
> +static void omap_vout_buffer_queue(struct videobuf_queue *q,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct videobuf_buf=
fer *vb)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *fh =3D (struct omap_vout_fh *) q->=
priv_data;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh->vout;
> +
> + =A0 =A0 =A0 /* Driver is also maintainig a queue. So enqueue buffer=
 in the driver
> + =A0 =A0 =A0 =A0* queue */
> + =A0 =A0 =A0 list_add_tail(&vb->queue, &vout->dma_queue);
> +
> + =A0 =A0 =A0 vb->state =3D VIDEOBUF_PREPARED;
> +}
> +
> +/* Buffer release function is called from videobuf layer to release =
buffer
> + * which are already allocated */
> +static void omap_vout_buffer_release(struct videobuf_queue *q,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct videobuf=
_buffer *vb)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *fh =3D (struct omap_vout_fh *) q->=
priv_data;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh->vout;
> +
> + =A0 =A0 =A0 vb->state =3D VIDEOBUF_NEEDS_INIT;
> +
> + =A0 =A0 =A0 if (V4L2_MEMORY_MMAP !=3D vout->memory)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +}
> +
> +static int omap_disp_get_vrfb_offset(u32 img_len, u32 bytes_per_pixe=
l, int side)
> +{
> + =A0 =A0 =A0 int page_width_exp, page_height_exp, pixel_size_exp, of=
fset =3D 0;
> +
> + =A0 =A0 =A0 /* Maximum supported is 4 bytes (RGB32) */
> + =A0 =A0 =A0 if (bytes_per_pixel > 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 page_width_exp =3D PAGE_WIDTH_EXP;
> + =A0 =A0 =A0 page_height_exp =3D PAGE_HEIGHT_EXP;
> + =A0 =A0 =A0 pixel_size_exp =3D bytes_per_pixel >> 1;
> +
> + =A0 =A0 =A0 if (side =3D=3D SIDE_W) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D ((1 << page_width_exp) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pages_per_side(img_len=
 *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes_per_pixel, page_w=
idth_exp))) >> pixel_size_exp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* in pixels */
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D (1 << page_height_exp) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pages_per_side(img_len=
, page_height_exp));
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return offset;
> +}
> +EXPORT_SYMBOL(omap_disp_get_vrfb_offset);

I'm not sure, but is it okay to declare function as static if it
exported with EXPORT_SYMBOL ?

The second question - may be you dont need to use EXPORT_SYMBOL ?

> +static int omap_vout_calculate_offset(struct omap_vout_device *vout)
> +{
> + =A0 =A0 =A0 struct v4l2_pix_format *pix =3D &(vout->pix);
> + =A0 =A0 =A0 struct v4l2_rect *crop =3D &(vout->crop);
> + =A0 =A0 =A0 struct v4l2_window *win =3D &(vout->win);
> + =A0 =A0 =A0 int rotation_deg;
> + =A0 =A0 =A0 int mirroring =3D vout->mirror;
> + =A0 =A0 =A0 int vr_ps =3D 1, ps =3D 2, temp_ps =3D 2;
> + =A0 =A0 =A0 int offset =3D 0, ctop =3D 0, cleft =3D 0, line_length =
=3D 0;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_display *cur_display;
> + =A0 =A0 =A0 int *cropped_offset =3D &(vout->cropped_offset);
> +
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->display)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 cur_display =3D ovl->manager->display;
> +
> + =A0 =A0 =A0 if ((cur_display->type =3D=3D OMAP_DISPLAY_TYPE_VENC) &=
&
> + =A0 =A0 =A0 =A0 =A0 ((win->w.width =3D=3D crop->width)
> + =A0 =A0 =A0 =A0 =A0 =A0&& (win->w.height =3D=3D crop->height)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->flicker_filter =3D 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->flicker_filter =3D 0;
> +
> + =A0 =A0 =A0 if (1 =3D=3D vout->mirror && vout->rotation >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotation_deg =3D (vout->rotation =3D=3D=
 1) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 270 : (vout->rotation =3D=
=3D 3) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 90 : (vout->rotation =3D=
=3D =A02) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 : 180;
> +
> + =A0 =A0 =A0 } else if (vout->rotation >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotation_deg =3D vout->rotation;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotation_deg =3D -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (V4L2_PIX_FMT_YUYV =3D=3D pix->pixelformat ||
> + =A0 =A0 =A0 =A0 =A0 V4L2_PIX_FMT_UYVY =3D=3D pix->pixelformat) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rotation_deg >=3D 0 || mirroring =3D=
=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ps =A0 =A0- Actual=
 pixel size for YUYV/UYVY for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0=
 =A0 =A0VRFB/Mirroring is 4 bytes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* vr_ps - Virtually =
pixel size for YUYV/UYVY is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0=
 =A0 =A02 bytes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vr_ps =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps =3D 2; /* otherwise =
the pixel size is 2 byte */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else if (V4L2_PIX_FMT_RGB32 =3D=3D pix->pixelformat) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps =3D 4;
> + =A0 =A0 =A0 } else if (V4L2_PIX_FMT_RGB24 =3D=3D pix->pixelformat) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps =3D 3;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vout->ps =3D ps;
> + =A0 =A0 =A0 vout->vr_ps =3D vr_ps;
> + =A0 =A0 =A0 if (rotation_deg >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 line_length =3D MAX_PIXELS_PER_LINE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctop =3D (pix->height - crop->height) -=
 crop->top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleft =3D (pix->width - crop->width) - =
crop->left;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 line_length =3D pix->width;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vout->line_length =3D line_length;
> + =A0 =A0 =A0 switch (rotation_deg) {
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D (omap_disp_get_vrfb_offset(p=
ix->width, ps, SIDE_H) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pix->w=
idth / vr_ps)) * ps * line_length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_ps =3D ps / vr_ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mirroring =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D off=
set + line_length *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_ps=
 * cleft + crop->top * temp_ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D off=
set + line_length * temp_ps *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleft +=
 crop->top * temp_ps + (line_length *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((crop-=
>width / (vr_ps)) - 1) * ps);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D (omap_disp_get_vrfb_offset(p=
ix->height, ps, SIDE_H) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->he=
ight) * ps * line_length +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (omap_d=
isp_get_vrfb_offset(pix->width,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps, SID=
E_W) - (pix->width / vr_ps)) * ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mirroring =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D off=
set + (line_length * ps * ctop) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cleft =
/ vr_ps) * ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D off=
set + (line_length * ps * ctop) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cleft =
/ vr_ps) * ps + (line_length *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crop->=
height - 1) * ps);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D (omap_disp_get_vrfb_offset(p=
ix->height, ps, SIDE_W) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->he=
ight) * ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_ps =3D ps / vr_ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mirroring =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D off=
set + line_length *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_ps * crop-=
>left + ctop * ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D off=
set + line_length *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_ps=
 * crop->left + ctop * ps +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (line_l=
ength * ((crop->width / vr_ps) - 1) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mirroring =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D (li=
ne_length * ps) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->t=
op + (crop->left / vr_ps) * ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D (li=
ne_length * ps) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->t=
op + (crop->left / vr_ps) * ps +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (line_l=
ength * (crop->height - 1) * ps);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mirroring =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 line_length * p=
s * crop->top + crop->left * ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cropped_offset =3D (li=
ne_length * ps * crop->top) /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vr_ps +=
 (crop->left * ps) / vr_ps +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((crop-=
>width / vr_ps) - 1) * ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout->flicker_filter =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->tv_field1_offset =3D 0;
> + =A0 =A0 =A0 else if (vout->rotation >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->mirror =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->tv_field1_offset =
=3D -vout->line_length * vout->ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->tv_field1_offset =
=3D vout->line_length * vout->ps;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->mirror =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->tv_field1_offset =
=3D vout->line_length
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * vout-=
>ps / vout->vr_ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->tv_field1_offset =
=3D vout->line_length * vout->ps;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * =A0File operations
> + */
> +static void omap_vout_vm_open(struct vm_area_struct *vma)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D vma->vm_private_data;
> + =A0 =A0 =A0 DPRINTK("vm_open [vma=3D%08lx-%08lx]\n", vma->vm_start,=
 vma->vm_end);
> + =A0 =A0 =A0 vout->mmap_count++;
> +}
> +
> +static void omap_vout_vm_close(struct vm_area_struct *vma)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D vma->vm_private_data;
> + =A0 =A0 =A0 DPRINTK("vm_close [vma=3D%08lx-%08lx]\n", vma->vm_start=
, vma->vm_end);
> + =A0 =A0 =A0 vout->mmap_count--;
> +}
> +
> +static struct vm_operations_struct omap_vout_vm_ops =3D {
> + =A0 =A0 =A0 .open =3D omap_vout_vm_open,
> + =A0 =A0 =A0 .close =3D omap_vout_vm_close,
> +};
> +
> +static int omap_vout_mmap(struct file *file, struct vm_area_struct *=
vma)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *fh =3D file->private_data;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh->vout;
> + =A0 =A0 =A0 struct videobuf_queue *q =3D &fh->vbq;
> + =A0 =A0 =A0 unsigned long size =3D (vma->vm_end - vma->vm_start);
> + =A0 =A0 =A0 unsigned long start =3D vma->vm_start;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 void *pos;
> + =A0 =A0 =A0 struct videobuf_dmabuf *dmabuf =3D NULL;
> +
> + =A0 =A0 =A0 DPRINTK("pgoff=3D0x%lx, start=3D0x%lx, end=3D0x%lx\n", =
vma->vm_pgoff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vma->vm_start, vma->vm_end);
> +
> + =A0 =A0 =A0 /* look for the buffer to map */
> + =A0 =A0 =A0 for (i =3D 0; i < VIDEO_MAX_FRAME; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (NULL =3D=3D q->bufs[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (V4L2_MEMORY_MMAP !=3D q->bufs[i]->m=
emory)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (q->bufs[i]->boff =3D=3D (vma->vm_pg=
off << PAGE_SHIFT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (VIDEO_MAX_FRAME =3D=3D i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DPRINTK("offset invalid [offset=3D0x%lx=
]\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vma->vm_pgoff << PAGE_=
SHIFT));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 q->bufs[i]->baddr =3D vma->vm_start;
> +
> + =A0 =A0 =A0 vma->vm_flags |=3D VM_RESERVED;
> + =A0 =A0 =A0 vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_=
prot);
> + =A0 =A0 =A0 vma->vm_ops =3D &omap_vout_vm_ops;
> + =A0 =A0 =A0 vma->vm_private_data =3D (void *) vout;
> + =A0 =A0 =A0 dmabuf =3D videobuf_to_dma(q->bufs[i]);
> + =A0 =A0 =A0 pos =3D dmabuf->vmalloc;
> + =A0 =A0 =A0 while (size > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pfn;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfn =3D virt_to_phys((void *) pos) >> P=
AGE_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (remap_pfn_range(vma, start, pfn, PA=
GE_SIZE, PAGE_SHARED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start +=3D PAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pos +=3D PAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D PAGE_SIZE;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vout->mmap_count++;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void omap_vout_free_allbuffers(struct omap_vout_device *vout)
> +{
> + =A0 =A0 =A0 int num_buffers =3D 0, i;
> + =A0 =A0 =A0 num_buffers =3D (vout->vid =3D=3D OMAP_VIDEO1) ?
> + =A0 =A0 =A0 =A0 =A0 video1_numbuffers : video2_numbuffers;
> + =A0 =A0 =A0 for (i =3D num_buffers; i < vout->buffer_allocated; i++=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->buf_virt_addr[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_buffer(v=
out->buf_virt_addr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vout=
->buf_phy_addr[i], vout->buffer_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_phy_addr[i] =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 for (i =3D 0; i < 4; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->smsshado_virt_addr[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_buffer(v=
out->smsshado_virt_addr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_phy_addr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 vout->smsshado_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->smsshado_virt_add=
r[i] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->smsshado_phy_addr=
[i] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vout->buffer_allocated =3D num_buffers;
> +}
> +
> +static int omap_vout_release(struct file *file)
> +{
> +
> + =A0 =A0 =A0 struct omap_vout_fh *fh =3D file->private_data;
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 struct videobuf_queue *q;
> + =A0 =A0 =A0 unsigned int t;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 unsigned int r;
> +
> + =A0 =A0 =A0 vout =3D fh->vout;
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> +
> + =A0 =A0 =A0 if (fh =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!vout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 q =3D &fh->vbq;
> +
> + =A0 =A0 =A0 /* Disable all the overlay managers connected with this=
 interface */
> + =A0 =A0 =A0 for (t =3D 0; t < ovid->num_overlays; t++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ov=
l =3D ovid->overlays[t];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl=
->manager->display) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
omap_overlay_info info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->ge=
t_overlay_info(ovl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.en=
abled =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->se=
t_overlay_info(ovl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 r =3D omapvid_apply_changes(vout, 0, 0);
> + =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "Unable to apply ch=
anges\n");

It's better to add module name here.

> +
> + =A0 =A0 =A0 /* Even if apply changes fails we should continue
> + =A0 =A0 =A0 =A0 =A0freeing allocated memeory */
> + =A0 =A0 =A0 if (fh->io_allowed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 videobuf_streamoff(q);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 videobuf_queue_cancel(q);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free all buffers */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_allbuffers(vout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 videobuf_mmap_free(q);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout->streaming =3D=3D fh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 mask =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mask =3D DISPC_IRQ_VSYNC | DISPC_IRQ_EV=
SYNC_EVEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DISPC_IRQ_EVSYNC_ODD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dispc_unregister_isr(omap_vout_isr=
, vout, mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->streaming =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout->mmap_count !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->mmap_count =3D 0;
> +
> + =A0 =A0 =A0 vout->opened -=3D 1;
> + =A0 =A0 =A0 file->private_data =3D NULL;
> +
> + =A0 =A0 =A0 if (vout->buffer_allocated)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 videobuf_mmap_free(q);
> +
> + =A0 =A0 =A0 kfree(fh);
> +
> + =A0 =A0 =A0 return r;
> +}
> +
> +static int omap_vout_open(struct file *file)
> +{
> + =A0 =A0 =A0 int minor =3D video_devdata(file)->minor;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D NULL;
> + =A0 =A0 =A0 struct omap_vout_fh *fh;
> + =A0 =A0 =A0 struct videobuf_queue *q;
> +
> + =A0 =A0 =A0 DPRINTK("entering\n");
> +
> + =A0 =A0 =A0 if (saved_v1out && saved_v1out->vfd
> + =A0 =A0 =A0 =A0 =A0 && (saved_v1out->vfd->minor =3D=3D minor)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout =3D saved_v1out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (saved_v2out && saved_v2out->vfd
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (saved_v2out->vfd->minor =3D=
=3D minor)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout =3D saved_v2out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 /* for now, we only support single open */
> + =A0 =A0 =A0 if (vout->opened)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 vout->opened +=3D 1;
> +
> + =A0 =A0 =A0 fh =3D kmalloc(sizeof(*fh), GFP_KERNEL);
> + =A0 =A0 =A0 if (NULL =3D=3D fh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 memset(fh, 0, sizeof(*fh));

Instead of kmalloc + memset (fh, 0, ..) you can use kzalloc() if i'm no=
t wrong.

> + =A0 =A0 =A0 file->private_data =3D fh;
> + =A0 =A0 =A0 fh->vout =3D vout;
> + =A0 =A0 =A0 fh->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +
> + =A0 =A0 =A0 q =3D &fh->vbq;
> + =A0 =A0 =A0 video_vbq_ops.buf_setup =3D omap_vout_buffer_setup;
> + =A0 =A0 =A0 video_vbq_ops.buf_prepare =3D omap_vout_buffer_prepare;
> + =A0 =A0 =A0 video_vbq_ops.buf_release =3D omap_vout_buffer_release;
> + =A0 =A0 =A0 video_vbq_ops.buf_queue =3D omap_vout_buffer_queue;
> + =A0 =A0 =A0 spin_lock_init(&vout->vbq_lock);
> +
> + =A0 =A0 =A0 videobuf_queue_sg_init(q, &video_vbq_ops, NULL, &vout->=
vbq_lock,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fh->type=
, V4L2_FIELD_NONE, sizeof
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(struct =
videobuf_buffer), fh);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_querycap(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_capability *cap)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> +
> + =A0 =A0 =A0 memset(cap, 0, sizeof(*cap));
> + =A0 =A0 =A0 strncpy(cap->driver, VOUT_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(cap->driver));
> + =A0 =A0 =A0 strncpy(cap->card, vout->vfd->name, sizeof(cap->card));
> + =A0 =A0 =A0 cap->bus_info[0] =3D '\0';
> + =A0 =A0 =A0 cap->capabilities =3D V4L2_CAP_STREAMING | V4L2_CAP_VID=
EO_OUTPUT;
> + =A0 =A0 =A0 return 0;
> +}
> +static int vidioc_enum_fmt_vid_out(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_fmtdesc *fm=
t)
> +{
> + =A0 =A0 =A0 int index =3D fmt->index;
> + =A0 =A0 =A0 enum v4l2_buf_type type =3D fmt->type;
> +
> + =A0 =A0 =A0 memset(fmt, 0, sizeof(*fmt));
> + =A0 =A0 =A0 fmt->index =3D index;
> + =A0 =A0 =A0 fmt->type =3D type;
> + =A0 =A0 =A0 if (index >=3D NUM_OUTPUT_FORMATS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 fmt->flags =3D omap_formats[index].flags;
> + =A0 =A0 =A0 strncpy(fmt->description, omap_formats[index].descripti=
on,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(fmt->description=
));
> + =A0 =A0 =A0 fmt->pixelformat =3D omap_formats[index].pixelformat;
> + =A0 =A0 =A0 return 0;
> +}
> +static int vidioc_g_fmt_vid_out(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_format *f)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> +
> + =A0 =A0 =A0 struct v4l2_pix_format *pix =3D &f->fmt.pix;
> + =A0 =A0 =A0 memset(pix, 0, sizeof(*pix));
> + =A0 =A0 =A0 *pix =3D vout->pix;
> + =A0 =A0 =A0 return 0;
> +
> +}
> +
> +static int vidioc_try_fmt_vid_out(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_format *f)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_video_timings *timing;
> +
> + =A0 =A0 =A0 if (vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->display)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 timing =3D &ovl->manager->display->panel->timings;
> +
> + =A0 =A0 =A0 vout->fbuf.fmt.height =3D timing->y_res;
> + =A0 =A0 =A0 vout->fbuf.fmt.width =3D timing->x_res;
> +
> + =A0 =A0 =A0 omap_vout_try_format(&f->fmt.pix, &vout->fbuf.fmt);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_s_fmt_vid_out(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_format *f)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *ofh =3D (struct omap_vout_fh *)fh;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ofh->vout;
> + =A0 =A0 =A0 int bpp;
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_video_timings *timing;
> +
> + =A0 =A0 =A0 if (vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 if (down_interruptible(&vout->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->display) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 timing =3D &ovl->manager->display->panel->timings;
> +
> + =A0 =A0 =A0 /* We dont support RGB24-packed mode if vrfb rotation
> + =A0 =A0 =A0 =A0* is enabled*/
> + =A0 =A0 =A0 if (vout->rotation !=3D -1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && f->fmt.pix.pixelform=
at =3D=3D V4L2_PIX_FMT_RGB24) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* get the framebuffer parameters */
> +
> + =A0 =A0 =A0 if (vout->rotation =3D=3D 1 || vout->rotation =3D=3D 3)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.height =3D timing->x_res=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.width =3D timing->y_res;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.height =3D timing->y_res=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.width =3D timing->x_res;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* change to samller size is OK */
> +
> + =A0 =A0 =A0 bpp =3D omap_vout_try_format(&f->fmt.pix, &vout->fbuf.f=
mt);
> + =A0 =A0 =A0 f->fmt.pix.sizeimage =3D f->fmt.pix.width * f->fmt.pix.=
height * bpp;
> +
> + =A0 =A0 =A0 /* try & set the new output format */
> + =A0 =A0 =A0 vout->bpp =3D bpp;
> + =A0 =A0 =A0 vout->pix =3D f->fmt.pix;
> + =A0 =A0 =A0 vout->vrfb_bpp =3D 1;
> +
> + =A0 =A0 =A0 /* If YUYV then vrfb bpp is 2, for =A0others its 1 */
> + =A0 =A0 =A0 if (V4L2_PIX_FMT_YUYV =3D=3D vout->pix.pixelformat ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4L2_PIX_FMT_UYVY =3D=3D vout->pix.pixe=
lformat)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_bpp =3D 2;
> +
> + =A0 =A0 =A0 /* set default crop and win */
> + =A0 =A0 =A0 omap_vout_new_format(&vout->pix, &vout->fbuf, &vout->cr=
op, &vout->win);
> +
> + =A0 =A0 =A0 /* Save the changes in the overlay strcuture */
> + =A0 =A0 =A0 r =3D omapvid_apply_changes(vout, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME "failed to change mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_try_fmt_vid_overlay(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_format *f)
> +{
> + =A0 =A0 =A0 int err =3D -EINVAL;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> + =A0 =A0 =A0 struct v4l2_window *win =3D &f->fmt.win;
> +
> + =A0 =A0 =A0 err =3D omap_vout_try_window(&vout->fbuf, win);
> +
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 if (vout->vid =3D=3D OMAP_VIDEO1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->global_alpha =3D 255;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_s_fmt_vid_overlay(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_format *f)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> + =A0 =A0 =A0 int err =3D -EINVAL;
> + =A0 =A0 =A0 struct v4l2_window *win =3D &f->fmt.win;
> +
> + =A0 =A0 =A0 if (down_interruptible(&vout->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 err =3D omap_vout_new_window(&vout->crop, &vout->win, &=
vout->fbuf, win);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (vout->vid =3D=3D OMAP_VIDEO1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->win.global_alpha =3D 255;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->win.global_alpha =3D f->fmt.win.g=
lobal_alpha;
> +
> + =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_enum_fmt_vid_overlay(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_fmtdesc *fm=
t)
> +{
> + =A0 =A0 =A0 int index =3D fmt->index;
> + =A0 =A0 =A0 enum v4l2_buf_type type =3D fmt->type;
> +
> + =A0 =A0 =A0 memset(fmt, 0, sizeof(*fmt));
> + =A0 =A0 =A0 fmt->index =3D index;
> + =A0 =A0 =A0 fmt->type =3D type;
> + =A0 =A0 =A0 if (index >=3D NUM_OUTPUT_FORMATS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 fmt->flags =3D omap_formats[index].flags;
> + =A0 =A0 =A0 strncpy(fmt->description, omap_formats[index].descripti=
on,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(fmt->description));
> + =A0 =A0 =A0 fmt->pixelformat =3D omap_formats[index].pixelformat;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_g_fmt_vid_overlay(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_format *f)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> +
> + =A0 =A0 =A0 struct v4l2_window *win =3D &f->fmt.win;
> + =A0 =A0 =A0 memset(win, 0, sizeof(*win));
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The API has a bit of a problem here.
> + =A0 =A0 =A0 =A0* We're returning a v4l2_window
> + =A0 =A0 =A0 =A0* structure, but that structure
> + =A0 =A0 =A0 =A0* contains pointers to variable-sized
> + =A0 =A0 =A0 =A0* objects for clipping rectangles and
> + =A0 =A0 =A0 =A0* clipping bitmaps.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 win->w =3D vout->win.w;
> + =A0 =A0 =A0 win->field =3D vout->win.field;
> + =A0 =A0 =A0 win->chromakey =3D vout->win.chromakey;
> + =A0 =A0 =A0 win->global_alpha =3D vout->win.global_alpha;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_cropcap(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_cropcap *cr=
opcap)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> + =A0 =A0 =A0 enum v4l2_buf_type type =3D cropcap->type;
> +
> + =A0 =A0 =A0 memset(cropcap, 0, sizeof(*cropcap));
> + =A0 =A0 =A0 cropcap->type =3D type;
> + =A0 =A0 =A0 if (type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_pix_format *pix =3D &vout->=
pix;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Width and height are always even */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropcap->bounds.width =3D pix->width & =
~1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropcap->bounds.height =3D pix->height =
& ~1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_default_crop(&vout->pix, &vou=
t->fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cropca=
p->defrect);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropcap->pixelaspect.numerator =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropcap->pixelaspect.denominator =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +}
> +static int vidioc_g_crop(struct file *file, void *fh,
> + =A0 =A0 =A0 struct v4l2_crop *crop)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> +
> + =A0 =A0 =A0 if (crop->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->c =3D vout->crop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +}
> +static int vidioc_s_crop(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_crop *crop)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> + =A0 =A0 =A0 int err =3D -EINVAL;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_video_timings *timing;
> +
> + =A0 =A0 =A0 if (vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 if (down_interruptible(&vout->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->display) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 timing =3D &ovl->manager->display->panel->timings;
> +
> + =A0 =A0 =A0 if (vout->rotation =3D=3D 1 || vout->rotation =3D=3D 3)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.height =3D timing->x_res=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.width =3D timing->y_res;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.height =3D timing->y_res=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.fmt.width =3D timing->x_res;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (crop->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D omap_vout_new_crop(&vout->pix, =
&vout->crop, &vout->win,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &vout->fbuf, &crop->c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +}
> +
> +static int vidioc_queryctrl(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_queryctrl *a)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(omap_vout_qctrl); i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (a->id && a->id =3D=3D omap_vout_qct=
rl[i].id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(a, &omap_vout_qc=
trl[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sizeof(struct v4l2_queryctrl));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static int vidioc_g_ctrl(struct file *file, void *fh, struct v4l2_co=
ntrol *a)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> +
> + =A0 =A0 =A0 switch (a->id) {
> + =A0 =A0 =A0 case V4L2_CID_ROTATION:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(omap_vout_=
qctrl); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (a->id =3D=3D vout->=
control[i].id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a->valu=
e =3D vout->control[i].value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case V4L2_CID_BG_COLOR:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int color;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->get=
_default_color)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->get_default_color(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->ma=
nager, &color);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a->value =3D color;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(omap_vout_=
qctrl); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (a->id =3D=3D vout->=
control[i].id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->c=
ontrol[i].value =3D color;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +}
> +
> +static int vidioc_s_ctrl(struct file *file, void *fh, struct v4l2_co=
ntrol *a)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> +
> + =A0 =A0 =A0 switch (a->id) {
> + =A0 =A0 =A0 case V4L2_CID_ROTATION:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int rotation =3D a->value;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->pix.pixelformat =3D=3D V4L2_P=
IX_FMT_RGB24 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rotatio=
n !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (down_interruptible(&vout->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((rotation =3D=3D 0) || (rotation =3D=
=3D 90) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rotation =3D=3D 180) || (rotat=
ion =3D=3D 270)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->control[0].value =
=3D rotation;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (rotation) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 90:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->r=
otation =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 180:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->r=
otation =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 270:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->r=
otation =3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->r=
otation =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case V4L2_CID_BG_COLOR:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int =A0color =3D a->value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (down_interruptible(&vout->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->set=
_default_color) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->set_default_color(ovl->ma=
nager,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 color);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> +}
> +
> +static int vidioc_reqbufs(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_requestbuff=
ers *req)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ((struct omap_vout_fh=
 *) fh)->vout;
> + =A0 =A0 =A0 struct videobuf_queue *q =3D &(((struct omap_vout_fh *)=
 fh)->vbq);
> + =A0 =A0 =A0 unsigned int i, num_buffers =3D 0;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct videobuf_dmabuf *dmabuf =3D NULL;
> +
> + =A0 =A0 =A0 if (down_interruptible(&vout->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if ((req->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) || (req=
->count < 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* if memory is not mmp or userptr
> + =A0 =A0 =A0 =A0 =A0return error */
> + =A0 =A0 =A0 if ((V4L2_MEMORY_MMAP !=3D req->memory) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (V4L2_MEMORY_USERPTR !=3D req->memory))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Cannot be requested when streaming is on */
> + =A0 =A0 =A0 if (vout->streaming) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If buffers are already allocated free them */
> + =A0 =A0 =A0 if (q->bufs[0] && (V4L2_MEMORY_MMAP =3D=3D q->bufs[0]->=
memory)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->mmap_count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_buffers =3D (vout->vid =3D=3D OMAP_=
VIDEO1) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video1_numbuffers : vid=
eo2_numbuffers;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D num_buffers; i < vout->buffe=
r_allocated; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf =3D videobuf_to_=
dma(q->bufs[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_buffer((=
u32)dmabuf->vmalloc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf-=
>bus_addr, vout->buffer_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_phy_addr[i] =3D=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buffer_allocated =3D num_buffers;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 videobuf_mmap_free(q);
> + =A0 =A0 =A0 } else if (q->bufs[0] && (V4L2_MEMORY_USERPTR =3D=3D q-=
>bufs[0]->memory)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->buffer_allocated) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 videobuf_mmap_free(q);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < vout-=
>buffer_allocated; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(q=
->bufs[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 q->bufs=
[i] =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buffer_allocated =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ((struct omap_vout_fh *) fh)->io_allowed =3D 1;
> +
> + =A0 =A0 =A0 /*store the memory type in data structure */
> + =A0 =A0 =A0 vout->memory =3D req->memory;
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&vout->dma_queue);
> +
> + =A0 =A0 =A0 /* call videobuf_reqbufs api */
> + =A0 =A0 =A0 ret =3D videobuf_reqbufs(q, req);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vout->buffer_allocated =3D req->count;
> + =A0 =A0 =A0 for (i =3D 0; i < req->count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf =3D videobuf_to_dma(q->bufs[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf->vmalloc =3D (void *) vout->buf_=
virt_addr[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf->bus_addr =3D (dma_addr_t) vout-=
>buf_phy_addr[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabuf->sglen =3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 return 0;
> +}
> +static int vidioc_querybuf(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_buffer *b)
> +{
> + =A0 =A0 =A0 return videobuf_querybuf(&(((struct omap_vout_fh *) fh)=
->vbq), b);
> +}
> +static int vidioc_qbuf(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_buffer *buf=
fer)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *ofh =3D (struct omap_vout_fh *)fh;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ofh->vout;
> + =A0 =A0 =A0 struct videobuf_queue *q =3D &ofh->vbq;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!ofh->io_allowed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if ((V4L2_BUF_TYPE_VIDEO_OUTPUT !=3D buffer->type) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (buffer->index >=3D vou=
t->buffer_allocated) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (q->bufs[buffer->index]=
->memory !=3D buffer->memory)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D buffer->memory) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buffer->length < vout->pix.sizeima=
ge) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 =3D=3D buffer->m.use=
rptr)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout->rotation >=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_dma_tx.req_s=
tatus =3D=3D DMA_CHAN_NOT_ALLOTED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "DMA Channel not al=
located for Rotation\n");

Again, it's better to add module name.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D videobuf_qbuf(q, buffer);
> + =A0 =A0 =A0 return ret;
> +}
> +static int vidioc_dqbuf(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_buffer *b)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *ofh =3D (struct omap_vout_fh *)fh;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ofh->vout;
> + =A0 =A0 =A0 struct videobuf_queue *q =3D &ofh->vbq;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!vout->streaming || !ofh->io_allowed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (file->f_flags & O_NONBLOCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Call videobuf_dqbuf for non blocking=
 mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D videobuf_dqbuf(q, (struct v4l2_=
buffer *)b, 1);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Call videobuf_dqbuf for =A0blocking =
mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D videobuf_dqbuf(q, (struct v4l2_=
buffer *)b, 0);
> + =A0 =A0 =A0 return ret;
> +}
> +static int vidioc_streamon(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum v4l2_buf_type i)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *ofh =3D (struct omap_vout_fh *)fh;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ofh->vout;
> + =A0 =A0 =A0 struct videobuf_queue *q =3D &ofh->vbq;
> + =A0 =A0 =A0 u32 addr =3D 0;
> + =A0 =A0 =A0 int r =3D 0;
> + =A0 =A0 =A0 int t;
> + =A0 =A0 =A0 struct omapvideo_info *ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 u32 mask =3D 0;
> +
> + =A0 =A0 =A0 if (down_interruptible(&vout->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (!ofh->io_allowed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vout->streaming) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 r =3D videobuf_streamon(q);
> + =A0 =A0 =A0 if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (list_empty(&vout->dma_queue)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Get the next frame from the buffer queue */
> + =A0 =A0 =A0 vout->nextFrm =3D vout->curFrm =3D list_entry(vout->dma=
_queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
videobuf_buffer, queue);
> + =A0 =A0 =A0 /* Remove buffer from the buffer queue */
> + =A0 =A0 =A0 list_del(&vout->curFrm->queue);
> + =A0 =A0 =A0 /* Mark state of the current frame to active */
> + =A0 =A0 =A0 vout->curFrm->state =3D VIDEOBUF_ACTIVE;
> + =A0 =A0 =A0 /* Initialize field_id and started member */
> + =A0 =A0 =A0 vout->field_id =3D 0;
> +
> + =A0 =A0 =A0 /* set flag here. Next QBUF will start DMA */
> + =A0 =A0 =A0 vout->streaming =3D ofh;
> +
> + =A0 =A0 =A0 vout->first_int =3D 1;
> +
> + =A0 =A0 =A0 if (omap_vout_calculate_offset(vout)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 addr =3D (unsigned long) vout->queued_buf_addr[vout->cu=
rFrm->i]
> + =A0 =A0 =A0 + vout->cropped_offset;
> +
> + =A0 =A0 =A0 mask =3D DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_EVEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DISPC_IRQ_EVSYNC_ODD;
> +
> + =A0 =A0 =A0 omap_dispc_register_isr(omap_vout_isr, vout, mask);
> +
> + =A0 =A0 =A0 for (t =3D 0; t < ovid->num_overlays; t++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl =3D ovid->over=
lays[t];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl->manager->displ=
ay) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay_inf=
o info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->get_overlay_info(o=
vl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.enabled =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->set_overlay_info(o=
vl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 r =3D omapvid_apply_changes(vout, addr, 0);
> + =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NAME "failed to ch=
ange mode\n");
> +
> + =A0 =A0 =A0 up(&vout->lock);
> + =A0 =A0 =A0 return 0;
> +}
> +static int vidioc_streamoff(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum v4l2_buf_type i)
> +{
> +
> + =A0 =A0 =A0 struct omap_vout_fh *ofh =3D (struct omap_vout_fh *)fh;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ofh->vout;
> + =A0 =A0 =A0 int t, r =3D 0;
> + =A0 =A0 =A0 struct omapvideo_info *ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 u32 mask =3D 0;
> +
> + =A0 =A0 =A0 if (!ofh->io_allowed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (!vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (vout->streaming =3D=3D fh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->streaming =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mask =3D DISPC_IRQ_VSYNC | DISPC_IRQ_EV=
SYNC_EVEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DISPC_IRQ_EVSYNC_ODD;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dispc_unregister_isr(omap_vout_isr=
, vout, mask);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (t =3D 0; t < ovid->num_overlays; t=
++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ov=
l =3D ovid->overlays[t];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl=
->manager->display) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
omap_overlay_info info;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->ge=
t_overlay_info(ovl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.en=
abled =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
ovl->set_overlay_info(ovl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_apply_changes(vout, 0, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME "failed to change mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_s_fbuf(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *a)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *ofh =3D (struct omap_vout_fh *)fh;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ofh->vout;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 enum omap_dss_color_key_type key_type =3D OMAP_DSS_COLO=
R_KEY_GFX_DST;
> + =A0 =A0 =A0 int enable =3D 0;
> +
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 /* OMAP DSS doesn't support Source and Destination colo=
r
> + =A0 =A0 =A0 =A0 =A0key together */
> + =A0 =A0 =A0 if ((a->flags & V4L2_FBUF_FLAG_SRC_CHROMAKEY) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (a->flags & V4L2_FBUF_F=
LAG_CHROMAKEY))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 /* OMAP DSS Doesn't support the Destination color key
> + =A0 =A0 =A0 =A0 =A0and alpha blending together */
> + =A0 =A0 =A0 if (a->flags & V4L2_FBUF_FLAG_CHROMAKEY &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (a->flags & V4L2_FBUF_F=
LAG_LOCAL_ALPHA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if ((a->flags & V4L2_FBUF_FLAG_SRC_CHROMAKEY)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.flags |=3D V4L2_FBUF_FLAG_SR=
C_CHROMAKEY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_type =3D =A0OMAP_DSS_COLOR_KEY_VID_=
SRC;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.flags &=3D ~V4L2_FBUF_FLAG_S=
RC_CHROMAKEY;
> +
> + =A0 =A0 =A0 if ((a->flags & V4L2_FBUF_FLAG_CHROMAKEY)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.flags |=3D V4L2_FBUF_FLAG_CH=
ROMAKEY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_type =3D =A0OMAP_DSS_COLOR_KEY_GFX_=
DST;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.flags &=3D =A0~V4L2_FBUF_FLA=
G_CHROMAKEY;
> +
> + =A0 =A0 =A0 if (a->flags & (V4L2_FBUF_FLAG_CHROMAKEY |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4L2_FB=
UF_FLAG_SRC_CHROMAKEY))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable =3D 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable =3D 0;
> + =A0 =A0 =A0 if (ovl->manager && ovl->manager->enable_trans_key &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->set_trans=
_key) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->enable_trans_key(ovl->man=
ager, enable);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->set_trans_key(ovl->manage=
r, key_type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->w=
in.chromakey);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (a->flags & V4L2_FBUF_FLAG_LOCAL_ALPHA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.flags |=3D V4L2_FBUF_FLAG_LO=
CAL_ALPHA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable =3D 1;
> + =A0 =A0 =A0 } else if (!(a->flags & V4L2_FBUF_FLAG_LOCAL_ALPHA)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->fbuf.flags &=3D ~V4L2_FBUF_FLAG_L=
OCAL_ALPHA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (ovl->manager && ovl->manager->enable_alpha_blending=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->enable_alpha_blending(ovl=
->manager, enable);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vidioc_g_fbuf(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *a)
> +{
> + =A0 =A0 =A0 struct omap_vout_fh *ofh =3D (struct omap_vout_fh *)fh;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D ofh->vout;
> +
> + =A0 =A0 =A0 a->flags =3D 0x0;
> + =A0 =A0 =A0 a->capability =3D 0x0;
> +
> + =A0 =A0 =A0 a->capability =3D V4L2_FBUF_CAP_LOCAL_ALPHA | V4L2_FBUF=
_CAP_CHROMAKEY
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | V4L2_FBUF_CAP_SRC_CHROMAKEY;
> +
> + =A0 =A0 =A0 if (vout->fbuf.flags & V4L2_FBUF_FLAG_CHROMAKEY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a->flags |=3D V4L2_FBUF_FLAG_CHROMAKEY;
> + =A0 =A0 =A0 if (vout->fbuf.flags & V4L2_FBUF_FLAG_LOCAL_ALPHA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a->flags |=3D V4L2_FBUF_FLAG_LOCAL_ALPH=
A;
> + =A0 =A0 =A0 if (vout->fbuf.flags =A0 & V4L2_FBUF_FLAG_SRC_CHROMAKEY=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a->flags |=3D V4L2_FBUF_FLAG_SRC_CHROMA=
KEY;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct v4l2_ioctl_ops vout_ioctl_ops =3D {
> + =A0 =A0 =A0 .vidioc_querycap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=3D vidioc_querycap,
> + =A0 =A0 =A0 .vidioc_querycap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=3D vidioc_querycap,
> + =A0 =A0 =A0 .vidioc_enum_fmt_vid_out =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D vidioc_enum_fmt_vid_out,
> + =A0 =A0 =A0 .vidioc_g_fmt_vid_out =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D vidioc_g_fmt_vid_out,
> + =A0 =A0 =A0 .vidioc_try_fmt_vid_out =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D vidioc_try_fmt_vid_out,
> + =A0 =A0 =A0 .vidioc_s_fmt_vid_out =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D vidioc_s_fmt_vid_out,
> + =A0 =A0 =A0 .vidioc_queryctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =3D vidioc_queryctrl,
> + =A0 =A0 =A0 .vidioc_g_ctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D vidioc_g_ctrl,
> + =A0 =A0 =A0 .vidioc_s_fbuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D vidioc_s_fbuf,
> + =A0 =A0 =A0 .vidioc_g_fbuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D vidioc_g_fbuf,
> + =A0 =A0 =A0 .vidioc_s_ctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D vidioc_s_ctrl,
> + =A0 =A0 =A0 .vidioc_try_fmt_vid_overlay =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 vidioc_try_fmt_vid_overlay,
> + =A0 =A0 =A0 .vidioc_s_fmt_vid_overlay =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 vidioc_s_fmt_vid_overlay,
> + =A0 =A0 =A0 .vidioc_enum_fmt_vid_overlay =A0 =A0 =A0 =A0 =A0 =A0=3D=
 vidioc_enum_fmt_vid_overlay,
> + =A0 =A0 =A0 .vidioc_g_fmt_vid_overlay =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 vidioc_g_fmt_vid_overlay,
> + =A0 =A0 =A0 .vidioc_cropcap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =3D vidioc_cropcap,
> + =A0 =A0 =A0 .vidioc_g_crop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D vidioc_g_crop,
> + =A0 =A0 =A0 .vidioc_s_crop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D vidioc_s_crop,
> + =A0 =A0 =A0 .vidioc_reqbufs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =3D vidioc_reqbufs,
> + =A0 =A0 =A0 .vidioc_querybuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=3D vidioc_querybuf,
> + =A0 =A0 =A0 .vidioc_qbuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D vidioc_qbuf,
> + =A0 =A0 =A0 .vidioc_dqbuf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =3D vidioc_dqbuf,
> + =A0 =A0 =A0 .vidioc_streamon =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=3D vidioc_streamon,
> + =A0 =A0 =A0 .vidioc_streamoff =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =3D vidioc_streamoff,
> +};
> +static struct v4l2_file_operations omap_vout_fops =3D {
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .ioctl =A0 =A0 =A0 =A0 =A0=3D video_ioctl2,
> + =A0 =A0 =A0 .mmap =A0 =A0 =A0 =A0 =A0 =3D omap_vout_mmap,
> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D omap_vout_open,
> + =A0 =A0 =A0 .release =A0 =A0 =A0 =A0=3D omap_vout_release,
> +};
> +
> +static int omap_vout_remove(struct platform_device *pdev)
> +{
> +
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D platform_get_drvd=
ata(pdev);
> + =A0 =A0 =A0 int k;
> +
> + =A0 =A0 =A0 for (k =3D 0; k < pdev->num_resources; k++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_cleanup_device(vid_dev->vouts=
[k]);
> +
> + =A0 =A0 =A0 for (k =3D 0; k < vid_dev->num_displays; k++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vid_dev->displays[k]->state !=3D OM=
AP_DSS_DISPLAY_DISABLED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->displays[k]->d=
isable(vid_dev->displays[k]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dss_put_display(vid_dev->displays[=
k]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(vid_dev);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap_vout_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int r =3D 0, i, t;
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D NULL;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_display *def_display;
> +
> + =A0 =A0 =A0 if (pdev->num_resources =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "probed for an unkn=
own device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;

As i understand it's no need to make r =3D -ENODEV, just return -ENODEV=
 directly.

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vid_dev =3D kzalloc(sizeof(struct omap2video_device), G=
=46P_KERNEL);
> + =A0 =A0 =A0 if (vid_dev =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;

The same here.

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, vid_dev);
> +
> + =A0 =A0 =A0 vid_dev->num_displays =3D 0;
> + =A0 =A0 =A0 t =3D omap_dss_get_num_displays();
> + =A0 =A0 =A0 for (i =3D 0; i < t; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_display *display;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 display =3D omap_dss_get_display(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!display) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pr=
obed for an unknown device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->displays[vid_dev->num_displays=
++] =3D display;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vid_dev->num_displays =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "probed for an unkn=
own device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vid_dev->num_overlays =3D omap_dss_get_num_overlays();
> + =A0 =A0 =A0 for (i =3D 0; i < vid_dev->num_overlays; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->overlays[i] =3D omap_dss_get_o=
verlay(i);
> +
> + =A0 =A0 =A0 vid_dev->num_managers =3D omap_dss_get_num_overlay_mana=
gers();
> + =A0 =A0 =A0 for (i =3D 0; i < vid_dev->num_managers; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->managers[i] =3D omap_dss_get_o=
verlay_manager(i);
> +
> + =A0 =A0 =A0 /* Get the Video1 overlay and video2 overlay.
> + =A0 =A0 =A0 =A0* Setup the Display attached to that overlays
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0for (i =3D 1; i < 3; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D omap_dss_get_overlay(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl->manager->displ=
ay) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_display =3D ovl->ma=
nager->display;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pr=
obed for an unknown device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D def_display->enable(def_display);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Here we are not cons=
idering a error as display may be
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enabled by frame buffer=
 driver */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "Di=
splay already enabled\n");

Module name?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set the update mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display->caps & OMAP_DSS_DISPLA=
Y_CAP_MANUAL_UPDATE) {
> +#ifdef CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display->set_up=
date_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_dis=
play->set_update_mode(def_display,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_UPDATE_AUTO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display->enable=
_te)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_dis=
play->enable_te(def_display, 1);
> +#else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display->set_up=
date_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_dis=
play->set_update_mode(def_display,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_UPDATE_MANUAL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display->enable=
_te)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_dis=
play->enable_te(def_display, 0);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display->set_up=
date_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_dis=
play->set_update_mode(def_display,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_UPDATE_AUTO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 r =3D omap_vout_create_video_devices(pdev);
> + =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error0;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < vid_dev->num_displays; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_display *display =3D vid_de=
v->displays[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (display->update)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 display->update(display=
, 0, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 display->panel->timings=
=2Ex_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 display->panel->timings=
=2Ey_res);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 printk(KERN_INFO "display->updated\n");

Again, module name.

> + =A0 =A0 =A0 return 0;
> +
> +error0:
> + =A0 =A0 =A0 kfree(vid_dev);
> + =A0 =A0 =A0 return r;
> +}
> +
> +static void omap_vout_release_vrfb(struct omap_vout_device *vout)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 4; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vrfb_release_ctx(&vout->vrfb_conte=
xt[i]);
> +
> + =A0 =A0 =A0 if (vout->vrfb_dma_tx.req_status =3D=3D DMA_CHAN_ALLOTE=
D) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_dma_tx.req_status =3D DMA_CH=
AN_NOT_ALLOTED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(vout->vrfb_dma_tx.dma_ch)=
;
> + =A0 =A0 =A0 }
> +
> +}
> +
> +static void omap_vout_free_buffers(struct omap_vout_device *vout)
> +{
> + =A0 =A0 =A0 int i, numbuffers;
> + =A0 =A0 =A0 /* Allocate memory for the buffes */
> + =A0 =A0 =A0 numbuffers =3D (vout->vid) ? =A0video2_numbuffers : vid=
eo1_numbuffers;
> + =A0 =A0 =A0 vout->buffer_size =3D (vout->vid) ? video2_bufsize : vi=
deo1_bufsize;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < numbuffers; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_buffer(vout->buf_virt_ad=
dr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vout->buf_phy_addr[i=
], vout->buffer_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_phy_addr[i] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =3D 0;
> + =A0 =A0 =A0 }
> +}
> +
> +static int omap_vout_setup_video_data(struct omap_vout_device *vout)
> +{
> + =A0 =A0 =A0 struct v4l2_pix_format *pix;
> + =A0 =A0 =A0 struct video_device *vfd;
> + =A0 =A0 =A0 struct v4l2_control *control;
> + =A0 =A0 =A0 struct omap_display *display =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays[0]->manager->di=
splay;
> +
> + =A0 =A0 =A0 /* set the default pix */
> + =A0 =A0 =A0 pix =3D &vout->pix;
> +
> + =A0 =A0 =A0 /* Set the default picture of QVGA =A0*/
> + =A0 =A0 =A0 pix->width =3D QQVGA_WIDTH;
> + =A0 =A0 =A0 pix->height =3D QQVGA_HEIGHT;
> +
> + =A0 =A0 =A0 /* Default pixel format is RGB 5-6-5 */
> + =A0 =A0 =A0 pix->pixelformat =3D V4L2_PIX_FMT_RGB565;
> + =A0 =A0 =A0 pix->field =3D V4L2_FIELD_ANY;
> + =A0 =A0 =A0 pix->bytesperline =3D pix->width * 2;
> + =A0 =A0 =A0 pix->sizeimage =3D pix->bytesperline * pix->height;
> + =A0 =A0 =A0 pix->priv =3D 0;
> + =A0 =A0 =A0 pix->colorspace =3D V4L2_COLORSPACE_JPEG;
> +
> + =A0 =A0 =A0 vout->bpp =3D RGB565_BPP;
> + =A0 =A0 =A0 vout->fbuf.fmt.width =A0=3D =A0display->panel->timings.=
x_res;
> + =A0 =A0 =A0 vout->fbuf.fmt.height =3D =A0display->panel->timings.y_=
res;
> +
> + =A0 =A0 =A0 /* Set the data structures for the overlay parameters*/
> + =A0 =A0 =A0 vout->win.global_alpha =3D 255;
> + =A0 =A0 =A0 vout->fbuf.flags =3D 0;
> + =A0 =A0 =A0 vout->fbuf.capability =3D V4L2_FBUF_CAP_LOCAL_ALPHA |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4L2_FBUF_CAP_SRC_CHROMAKEY | V4L2_FBUF=
_CAP_CHROMAKEY;
> + =A0 =A0 =A0 vout->win.chromakey =3D 0;
> +
> + =A0 =A0 =A0 omap_vout_new_format(pix, &vout->fbuf, &vout->crop, &vo=
ut->win);
> +
> + =A0 =A0 =A0 /*Disable the rotation. */
> + =A0 =A0 =A0 control =3D vout->control;
> +
> + =A0 =A0 =A0 control[0].id =3D V4L2_CID_ROTATION;
> + =A0 =A0 =A0 control[0].value =3D 0;
> + =A0 =A0 =A0 vout->rotation =3D -1;
> + =A0 =A0 =A0 vout->vrfb_bpp =3D 2;
> +
> + =A0 =A0 =A0 control[1].id =3D V4L2_CID_BG_COLOR;
> + =A0 =A0 =A0 control[1].value =3D 0;
> +
> +
> + =A0 =A0 =A0 /* initialize the video_device struct */
> + =A0 =A0 =A0 vfd =3D vout->vfd =3D video_device_alloc();
> +
> + =A0 =A0 =A0 if (!vfd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NAME ": could not =
allocate\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video d=
evice struct\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vfd->release =3D video_device_release;
> + =A0 =A0 =A0 vfd->ioctl_ops =3D &vout_ioctl_ops;
> +
> + =A0 =A0 =A0 strncpy(vfd->name, VOUT_NAME, sizeof(vfd->name));
> + =A0 =A0 =A0 vfd->vfl_type =3D VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY=
;
> +
> + =A0 =A0 =A0 /* need to register for a VID_HARDWARE_* ID in videodev=
=2Eh */
> + =A0 =A0 =A0 vfd->fops =3D &omap_vout_fops;
> + =A0 =A0 =A0 init_MUTEX(&vout->lock);
> +
> + =A0 =A0 =A0 vfd->minor =3D -1;
> + =A0 =A0 =A0 return 0;
> +
> +}
> +static int omap_vout_setup_video_bufs(struct platform_device *pdev, =
int vid_num)
> +{
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D platform_get_drvd=
ata(pdev);
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 int i, j, r =3D 0;
> + =A0 =A0 =A0 int image_width, image_height;
> + =A0 =A0 =A0 unsigned numbuffers;
> + =A0 =A0 =A0 struct video_device *vfd;
> +
> + =A0 =A0 =A0 vout =3D vid_dev->vouts[vid_num];
> + =A0 =A0 =A0 vfd =3D vout->vfd;
> +
> + =A0 =A0 =A0 numbuffers =3D (vid_num =3D=3D 0) ? video1_numbuffers :=
 video2_numbuffers;
> + =A0 =A0 =A0 vout->buffer_size =3D (vid_num =3D=3D 0) ? video1_bufsi=
ze : video2_bufsize;
> + =A0 =A0 =A0 printk(KERN_INFO "Buffer Size =3D %d\n", vout->buffer_s=
ize);
> + =A0 =A0 =A0 for (i =3D 0; i < numbuffers; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_alloc_buffer(=
vout->buffer_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u32 *)=
 &vout->buf_phy_addr[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout->buf_virt_addr[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 numbuff=
ers =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -=
ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fr=
ee_buffers;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 4; i++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vrfb_request_ctx(&vout->vrfb_c=
ontext[i])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO VOUT_N=
AME ": VRFB Region allocation \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 for rotation failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (r =3D=3D -ENOMEM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < i; j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vrfb_release_ctx(&=
vout->vrfb_context[j]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_buffers;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vout->cropped_offset =3D 0;
> +
> + =A0 =A0 =A0 /* Calculate VRFB memory size */
> + =A0 =A0 =A0 /* allocate for worst case size */
> + =A0 =A0 =A0 image_width =3D VID_MAX_WIDTH / TILE_SIZE;
> + =A0 =A0 =A0 if (VID_MAX_WIDTH % TILE_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 image_width++;
> +
> + =A0 =A0 =A0 image_width =3D image_width * TILE_SIZE;
> + =A0 =A0 =A0 image_height =3D VID_MAX_HEIGHT / TILE_SIZE;
> +
> + =A0 =A0 =A0 if (VID_MAX_HEIGHT % TILE_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 image_height++;
> +
> + =A0 =A0 =A0 image_height =3D image_height * TILE_SIZE;
> + =A0 =A0 =A0 vout->smsshado_size =3D PAGE_ALIGN(image_width * image_=
height * 2 * 2);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Request and Initialize DMA, for DMA based VRFB tra=
nsfer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 vout->vrfb_dma_tx.dev_id =3D OMAP_DMA_NO_DEVICE;
> + =A0 =A0 =A0 vout->vrfb_dma_tx.dma_ch =3D -1;
> + =A0 =A0 =A0 vout->vrfb_dma_tx.req_status =3D DMA_CHAN_ALLOTED;
> + =A0 =A0 =A0 r =3D omap_request_dma(vout->vrfb_dma_tx.dev_id, "VRFB =
DMA TX",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_vrfb_dma_tx_c=
allback,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *) &vout->vrfb_dm=
a_tx, &vout->vrfb_dma_tx.dma_ch);
> + =A0 =A0 =A0 if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_dma_tx.req_status =3D DMA_CH=
AN_NOT_ALLOTED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO VOUT_NAME ": DMA Chann=
el not alloted\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for video%d [v4l2]\n", =
vfd->minor);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 init_waitqueue_head(&vout->vrfb_dma_tx.wait);
> +
> + =A0 =A0 =A0 return 0;
> +
> +free_buffers:
> + =A0 =A0 =A0 for (i =3D 0; i < numbuffers; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_buffer(vout->buf_virt_ad=
dr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_phy_addr[i], =
vout->buffer_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_phy_addr[i] =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return r;
> +
> +}
> +
> +static int omap_vout_create_video_devices(struct platform_device *pd=
ev)
> +{
> + =A0 =A0 =A0 int r =3D 0, k;
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 struct video_device *vfd =3D NULL;
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D platform_get_drvd=
ata(pdev);
> +
> + =A0 =A0 =A0 for (k =3D 0; k < pdev->num_resources; k++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout =3D kmalloc(sizeof(struct omap_vou=
t_device), GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME ": could not allocate \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(vout, 0, sizeof(struct omap_vout=
_device));

Again, you can use kzalloc if i'm not wrong.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid =3D k;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->vouts[k] =3D vout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.vid_dev =3D vid_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays[0] =3D vid_dev-=
>overlays[k + 1];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.num_overlays =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.id =3D k + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->num_videos++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the default configuration for =
the video devices
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vout_setup_video_data(vout) !=3D=
 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Allocate default number of buffers f=
or the video streaming
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and reserve the VRFB space for rot=
ation
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vout_setup_video_bufs(pdev, k)=
 !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Register the Video device with V4L2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfd =3D vout->vfd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (video_register_device(vfd, VFL_TYPE=
_GRABBER, k + 1) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME ": could not register \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 Video for Linux device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfd->minor =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (k =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v1out =3D vout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v2out =3D vout;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_apply_changes(vid_dev->vo=
uts[k], 0, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto success;
> +error2:
> + =A0 =A0 =A0 omap_vout_release_vrfb(vout);
> + =A0 =A0 =A0 omap_vout_free_buffers(vout);
> +error1:
> + =A0 =A0 =A0 video_device_release(vfd);
> +error:
> + =A0 =A0 =A0 kfree(vout);
> + =A0 =A0 =A0 return r;
> +
> +success:
> + =A0 =A0 =A0 printk(KERN_INFO VOUT_NAME ": registered and initialize=
d\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video device %d [v4l2]\=
n", vfd->minor);
> + =A0 =A0 =A0 if (k =3D=3D (pdev->num_resources - 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -ENODEV;
> +
> +}
> +
> +int omapvid_apply_changes(struct omap_vout_device *vout, u32 addr, i=
nt init)
> +{
> + =A0 =A0 =A0 int r =3D 0;
> + =A0 =A0 =A0 struct omapvideo_info *ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 int posx, posy;
> + =A0 =A0 =A0 int outw, outh, temp, rotation;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct v4l2_window *win;
> + =A0 =A0 =A0 struct omap_video_timings *timing;
> + =A0 =A0 =A0 struct omap_display *cur_display;
> +
> + =A0 =A0 =A0 win =3D &vout->win;
> + =A0 =A0 =A0 rotation =3D vout->rotation;
> + =A0 =A0 =A0 for (i =3D 0; i < ovid->num_overlays; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D ovid->overlays[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->dis=
play)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing =3D &ovl->manager->display->pane=
l->timings;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_display =3D ovl->manager->display;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (init || (ovl->caps & OMAP_DSS_OVL_C=
AP_SCALE) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D win->w.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D win->w.height;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D win->w.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D win->w.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (init) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (rotation) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Inve=
rt the height and widht for 90
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* an=
d 270 degree rotation
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D=
 outw;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D=
 outh;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D=
 temp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 (timing->y_res - win->w.width)-
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 (timing->x_res - win->w.width) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 (timing->y_res - win->w.height) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D=
 outw;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D=
 outh;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D=
 temp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 (timing->x_res - win->w.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 - win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cur_display->type =3D=3D OMAP_DISPL=
AY_TYPE_VENC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D posy/2;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_setup_overlay(vout, ovl, =
posx, posy, outw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh, a=
ddr, vout->tv_field1_offset, init);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!init && ovl->manager)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->apply(ovl=
->manager);
> +
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +err:
> + =A0 =A0 =A0 printk(KERN_WARNING "apply_changes failed\n");

Module name.

> + =A0 =A0 =A0 return r;
> +}
> +
> +int omapvid_setup_overlay(struct omap_vout_device *vout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl, int posx, int=
 posy, int outw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int outh, u32 addr, int tv_field1_offse=
t, int init)
> +{
> + =A0 =A0 =A0 int r =3D 0;
> + =A0 =A0 =A0 enum omap_color_mode mode =3D 0;
> + =A0 =A0 =A0 int rotation, mirror;
> + =A0 =A0 =A0 int cropheight, cropwidth, pixheight, pixwidth;
> + =A0 =A0 =A0 struct omap_overlay_info info;
> +
> + =A0 =A0 =A0 if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) =3D=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (outw !=3D vout->pix.wi=
dth || outh !=3D vout->pix.height)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mode =3D video_mode_to_dss_mode(vout);
> +
> + =A0 =A0 =A0 if (mode =3D=3D -EINVAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rotation =3D vout->rotation;
> + =A0 =A0 =A0 mirror =3D 0;
> +
> + =A0 =A0 =A0 /* Setup the input plane parameters according to
> + =A0 =A0 =A0 =A0* rotation value selected.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (rotation =3D=3D 1 || rotation =3D=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropheight =3D vout->crop.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropwidth =3D vout->crop.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixheight =3D vout->pix.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixwidth =3D vout->pix.height;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropheight =3D vout->crop.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropwidth =3D vout->crop.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixheight =3D vout->pix.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixwidth =3D vout->pix.width;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ovl->get_overlay_info(ovl, &info);
> + =A0 =A0 =A0 info.paddr =3D addr;
> + =A0 =A0 =A0 info.vaddr =3D NULL;
> + =A0 =A0 =A0 if (vout->rotation >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.screen_width =3D 2048;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.screen_width =3D pixwidth;
> + =A0 =A0 =A0 info.width =3D cropwidth;
> + =A0 =A0 =A0 info.height =3D cropheight;
> + =A0 =A0 =A0 info.color_mode =3D mode;
> + =A0 =A0 =A0 info.rotation =3D rotation;
> + =A0 =A0 =A0 info.mirror =3D mirror;
> + =A0 =A0 =A0 info.pos_x =3D posx;
> + =A0 =A0 =A0 info.pos_y =3D posy;
> + =A0 =A0 =A0 info.out_width =3D outw;
> + =A0 =A0 =A0 info.out_height =3D outh;
> + =A0 =A0 =A0 info.rotation =3D 0;
> + =A0 =A0 =A0 info.mirror =3D 0;
> + =A0 =A0 =A0 info.global_alpha =3D vout->win.global_alpha;
> +
> + =A0 =A0 =A0 r =3D ovl->set_overlay_info(ovl, &info);
> + =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 return 0;
> +err:
> + =A0 =A0 =A0 printk(KERN_WARNING "setup_overlay failed\n");

Module name.

> + =A0 =A0 =A0 return r;
> +}
> +
> +static enum omap_color_mode video_mode_to_dss_mode(struct omap_vout_=
device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *vout)
> +{
> + =A0 =A0 =A0 struct v4l2_pix_format *pix =3D &vout->pix;
> + =A0 =A0 =A0 switch (pix->pixelformat) {
> +
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_YUYV:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_YUV2;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_UYVY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_UYVY;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB565:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGB16;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB24:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGB24P;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB32:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->vid =3D=3D OMAP_VIDEO1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_R=
GB24U;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_A=
RGB32;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case V4L2_PIX_FMT_BGR32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGBX32;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static struct platform_driver omap_vout_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D VOUT_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .probe =3D omap_vout_probe,
> + =A0 =A0 =A0 .remove =3D omap_vout_remove,
> +};
> +
> +void omap_vout_isr(void *arg, unsigned int irqstatus)
> +{
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 struct timeval timevalue;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D
> + =A0 =A0 =A0 =A0 =A0 (struct omap_vout_device *) arg;
> + =A0 =A0 =A0 u32 addr, fid;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_display *cur_display;
> +
> + =A0 =A0 =A0 if (!vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->display)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 cur_display =3D ovl->manager->display;
> +
> + =A0 =A0 =A0 spin_lock(&vout->vbq_lock);
> + =A0 =A0 =A0 do_gettimeofday(&timevalue);
> + =A0 =A0 =A0 if (cur_display->type =3D=3D OMAP_DISPLAY_TYPE_DPI) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(irqstatus & DISPC_IRQ_VSYNC))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout->first_int && (vout->curFrm !=
=3D vout->nextFrm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->ts =3D ti=
mevalue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->state =3D=
 VIDEOBUF_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&=
vout->curFrm->done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm =3D vout->=
nextFrm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->first_int =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&vout->dma_queue)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm =3D list_entry(vout->dma_=
queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct videobuf_buffer, queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&vout->nextFrm->queue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm->state =3D VIDEOBUF_ACTIV=
E;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D (unsigned long) vout->queued_b=
uf_addr[vout->nextFrm->i] +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->c=
ropped_offset ;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_apply_changes(vout, addr,=
 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME "failed to change mode\n");
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->first_int) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->first_int =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqstatus & DISPC_IRQ_EVSYNC_ODD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fid =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (irqstatus & DISPC_IRQ_EVSYNC=
_EVEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fid =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->field_id ^=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fid !=3D vout->field_id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D fid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->f=
ield_id =3D fid;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D fid) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->curFrm =3D=3D=
 vout->nextFrm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_un=
lock(&vout->vbq_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->ts =3D ti=
mevalue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->state =3D=
 VIDEOBUF_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&=
vout->curFrm->done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm =3D vout->=
nextFrm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (1 =3D=3D fid) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&vout->d=
ma_queue) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vout->curFrm !=
=3D vout->nextFrm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_un=
lock(&vout->vbq_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm =3D list_=
entry(vout->dma_queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0struct videobuf_buffer, queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&vout->nextFrm=
->queue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm->state =3D=
 VIDEOBUF_ACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D (unsigned long=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->queued_bu=
f_addr[vout->nextFrm->i] +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cropped_o=
ffset =A0 =A0 =A0 =A0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_apply_cha=
nges(vout, addr, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR VOUT_NAME "failed to\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 change mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock(&vout->vbq_lock);
> +}
> +
> +static void omap_vout_cleanup_device(struct omap_vout_device *vout)
> +{
> +
> + =A0 =A0 =A0 struct video_device *vfd;
> +
> + =A0 =A0 =A0 if (!vout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 vfd =3D vout->vfd;
> +
> + =A0 =A0 =A0 if (vfd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vfd->minor =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The device was nev=
er registered, so release the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* video_device struc=
t directly.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video_device_release(vf=
d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The unregister fun=
ction will release the video_device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* struct as well as =
unregistering it.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video_unregister_device=
(vfd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 omap_vout_release_vrfb(vout);
> +
> + =A0 =A0 =A0 omap_vout_free_buffers(vout);
> +
> + =A0 =A0 =A0 kfree(vout);
> +
> + =A0 =A0 =A0 if (!(vout->vid))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v1out =3D NULL;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v2out =3D NULL;
> +}
> +
> +static int __init omap_vout_init(void)
> +{
> +
> + =A0 =A0 =A0 if (platform_driver_register(&omap_vout_driver) !=3D 0)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NAME ": could not =
register \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Video d=
river\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void omap_vout_cleanup(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&omap_vout_driver);
> +}
> +
> +MODULE_AUTHOR("Texas Instruments.");
> +MODULE_DESCRIPTION("OMAP Video for Linux Video out driver");
> +MODULE_LICENSE("GPL");
> +
> +late_initcall(omap_vout_init);
> +module_exit(omap_vout_cleanup);
> diff --git a/drivers/media/video/omap/omap_voutdef.h b/drivers/media/=
video/omap/omap_voutdef.h
> new file mode 100644
> index 0000000..d9bbc10
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutdef.h
> @@ -0,0 +1,137 @@
> +/*
> + * drivers/media/video/omap/omap_voutdef.h
> + *
> + * Copyright (C) 2005 Texas Instruments.

Year ?

> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. This program is licensed "as is" without any warranty =
of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef OMAP_VOUTDEF_H
> +#define OMAP_VOUTDEF_H
> +
> +#include <mach/display.h>
> +
> +#define YUYV_BPP =A0 =A0 =A0 =A02
> +#define RGB565_BPP =A0 =A0 =A02
> +#define RGB24_BPP =A0 =A0 =A0 3
> +#define RGB32_BPP =A0 =A0 =A0 4
> +#define TILE_SIZE =A0 =A0 =A0 32
> +#define YUYV_VRFB_BPP =A0 2
> +#define RGB_VRFB_BPP =A0 =A01
> +#define MAX_CID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> +
> +
> +/*
> + * This structure is used to store the DMA transfer parameters
> + * for VRFB hidden buffer
> + */
> +struct vid_vrfb_dma {
> + =A0 =A0 =A0 int dev_id;
> + =A0 =A0 =A0 int dma_ch;
> + =A0 =A0 =A0 int req_status;
> + =A0 =A0 =A0 int tx_status;
> + =A0 =A0 =A0 wait_queue_head_t wait;
> +};
> +
> +struct omapvideo_info {
> + =A0 =A0 =A0 int id;
> + =A0 =A0 =A0 int num_overlays;
> + =A0 =A0 =A0 struct omap_overlay *overlays[3];
> + =A0 =A0 =A0 struct omap2video_device *vid_dev;
> +};
> +
> +struct omap2video_device {
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct mutex =A0mtx;
> +
> + =A0 =A0 =A0 int state;
> +
> + =A0 =A0 =A0 int num_videos;
> + =A0 =A0 =A0 struct omap_vout_device *vouts[10];
> +
> + =A0 =A0 =A0 int num_displays;
> + =A0 =A0 =A0 struct omap_display *displays[10];
> + =A0 =A0 =A0 int num_overlays;
> + =A0 =A0 =A0 struct omap_overlay *overlays[10];
> + =A0 =A0 =A0 int num_managers;
> + =A0 =A0 =A0 struct omap_overlay_manager *managers[10];
> +};
> +
> +/* per-device data structure */
> +struct omap_vout_device {
> +
> + =A0 =A0 =A0 struct omapvideo_info vid_info;
> + =A0 =A0 =A0 struct device dev;
> + =A0 =A0 =A0 struct video_device *vfd;
> + =A0 =A0 =A0 int vid;
> + =A0 =A0 =A0 int opened;
> +
> + =A0 =A0 =A0 /* we don't allow to change image fmt/size once buffer =
has
> + =A0 =A0 =A0 =A0* been allocated
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int buffer_allocated;
> + =A0 =A0 =A0 /* allow to reuse previosuly allocated buffer which is =
big enough */
> + =A0 =A0 =A0 int buffer_size;
> + =A0 =A0 =A0 /* keep buffer info accross opens */
> + =A0 =A0 =A0 unsigned long buf_virt_addr[VIDEO_MAX_FRAME];
> + =A0 =A0 =A0 unsigned long buf_phy_addr[VIDEO_MAX_FRAME];
> +
> + =A0 =A0 =A0 /* we don't allow to request new buffer when old buffer=
s are
> + =A0 =A0 =A0 =A0* still mmaped
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int mmap_count;
> +
> + =A0 =A0 =A0 spinlock_t vbq_lock; =A0 =A0 =A0 =A0 =A0 =A0/* spinlock=
 for videobuf queues */
> + =A0 =A0 =A0 unsigned long field_count; =A0 =A0 =A0/* field counter =
for videobuf_buffer */
> +
> + =A0 =A0 =A0 /* non-NULL means streaming is in progress. */
> + =A0 =A0 =A0 struct omap_vout_fh *streaming;
> +
> + =A0 =A0 =A0 struct v4l2_pix_format pix;
> + =A0 =A0 =A0 struct v4l2_rect crop;
> + =A0 =A0 =A0 struct v4l2_window win;
> + =A0 =A0 =A0 struct v4l2_framebuffer fbuf;
> +
> + =A0 =A0 =A0 /* Lock to protect the shared data structures in ioctl =
*/
> + =A0 =A0 =A0 struct semaphore lock;
> +
> +
> + =A0 =A0 =A0 /* V4L2 control structure for different control id */
> + =A0 =A0 =A0 struct v4l2_control control[MAX_CID];
> + =A0 =A0 =A0 int rotation;
> + =A0 =A0 =A0 int mirror;
> + =A0 =A0 =A0 int flicker_filter;
> + =A0 =A0 =A0 /* V4L2 control structure for different control id */
> +
> + =A0 =A0 =A0 int bpp; /* bytes per pixel */
> + =A0 =A0 =A0 int vrfb_bpp; /* bytes per pixel with respect to VRFB *=
/
> +
> + =A0 =A0 =A0 struct vid_vrfb_dma vrfb_dma_tx;
> + =A0 =A0 =A0 unsigned int smsshado_phy_addr[4];
> + =A0 =A0 =A0 unsigned int smsshado_virt_addr[4];
> + =A0 =A0 =A0 struct vrfb vrfb_context[4];
> + =A0 =A0 =A0 unsigned int smsshado_size;
> + =A0 =A0 =A0 unsigned char pos;
> +
> + =A0 =A0 =A0 int ps, vr_ps, line_length, first_int, field_id;
> + =A0 =A0 =A0 enum v4l2_memory memory;
> + =A0 =A0 =A0 struct videobuf_buffer *curFrm, *nextFrm;
> + =A0 =A0 =A0 struct list_head dma_queue;
> + =A0 =A0 =A0 u8 *queued_buf_addr[32];
> + =A0 =A0 =A0 u32 cropped_offset;
> + =A0 =A0 =A0 s32 tv_field1_offset;
> + =A0 =A0 =A0 void *isr_handle;
> +
> +};
> +
> +/* per-filehandle data structure */
> +struct omap_vout_fh {
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 enum v4l2_buf_type type;
> + =A0 =A0 =A0 struct videobuf_queue vbq;
> + =A0 =A0 =A0 int io_allowed;
> +};
> +
> +#endif /* ifndef OMAP_VOUTDEF_H */
> diff --git a/drivers/media/video/omap/omap_voutlib.c b/drivers/media/=
video/omap/omap_voutlib.c
> new file mode 100644
> index 0000000..c51a413
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutlib.c
> @@ -0,0 +1,281 @@
> +/*
> + * drivers/media/video/omap/omap_voutlib.c
> + *
> + * Copyright (C) 2008 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. This program is licensed "as is" without any warranty =
of any
> + * kind, whether express or implied.
> + *
> + * Based on the OMAP2 camera driver
> + * Video-for-Linux (Version 2) camera capture driver for
> + * the OMAP24xx camera controller.
> + *
> + * Author: Andy Lowe (source@mvista.com)
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2004 Texas Instruments.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/smp_lock.h>
> +#include <linux/kdev_t.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <linux/videodev2.h>
> +#include <linux/semaphore.h>
> +
> +/* Return the default overlay cropping rectangle in crop given the i=
mage
> + * size in pix and the video display size in fbuf. =A0The default
> + * cropping rectangle is the largest rectangle no larger than the ca=
pture size
> + * that will fit on the display. =A0The default cropping rectangle i=
s centered in
> + * the image. =A0All dimensions and offsets are rounded down to even=
 numbers.
> + */
> +void omap_vout_default_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, stru=
ct v4l2_rect *crop)
> +{
> + =A0 =A0 =A0 crop->width =3D (pix->width < fbuf->fmt.width) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->width : fbuf->fmt.width;
> + =A0 =A0 =A0 crop->height =3D (pix->height < fbuf->fmt.height) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->height : fbuf->fmt.height;
> + =A0 =A0 =A0 crop->width &=3D ~1;
> + =A0 =A0 =A0 crop->height &=3D ~1;
> + =A0 =A0 =A0 crop->left =3D ((pix->width - crop->width) >> 1) & ~1;
> + =A0 =A0 =A0 crop->top =3D ((pix->height - crop->height) >> 1) & ~1;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_default_crop);
> +/* Given a new render window in new_win, adjust the window to the
> + * nearest supported configuration. =A0The adjusted window parameter=
s are
> + * returned in new_win.
> + * Returns zero if succesful, or -EINVAL if the requested window is
> + * impossible and cannot reasonably be adjusted.
> + */
> +int omap_vout_try_window(struct v4l2_framebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new=
_win)
> +{
> + =A0 =A0 =A0 struct v4l2_rect try_win;
> +
> + =A0 =A0 =A0 /* make a working copy of the new_win rectangle */
> + =A0 =A0 =A0 try_win =3D new_win->w;
> +
> + =A0 =A0 =A0 /* adjust the preview window so it fits on the display =
by clipping any
> + =A0 =A0 =A0 =A0* offscreen areas
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (try_win.left < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.width +=3D try_win.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.left =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (try_win.top < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.height +=3D try_win.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.top =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 try_win.width =3D (try_win.width < fbuf->fmt.width) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.width : fbuf->fmt.width;
> + =A0 =A0 =A0 try_win.height =3D (try_win.height < fbuf->fmt.height) =
?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.height : fbuf->fmt.height;
> + =A0 =A0 =A0 if (try_win.left + try_win.width > fbuf->fmt.width)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.width =3D fbuf->fmt.width - try=
_win.left;
> + =A0 =A0 =A0 if (try_win.top + try_win.height > fbuf->fmt.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.height =3D fbuf->fmt.height - t=
ry_win.top;
> + =A0 =A0 =A0 try_win.width &=3D ~1;
> + =A0 =A0 =A0 try_win.height &=3D ~1;
> +
> + =A0 =A0 =A0 if (try_win.width <=3D 0 || try_win.height <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* We now have a valid preview window, so go with it */
> + =A0 =A0 =A0 new_win->w =3D try_win;
> + =A0 =A0 =A0 new_win->field =3D /*V4L2_FIELD_NONE*/V4L2_FIELD_ANY;
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_try_window);
> +
> +/* Given a new render window in new_win, adjust the window to the
> + * nearest supported configuration. =A0The image cropping window in =
crop
> + * will also be adjusted if necessary. =A0Preference is given to kee=
ping the
> + * the window as close to the requested configuration as possible. =A0=
If
> + * successful, new_win, vout->win, and crop are updated.
> + * Returns zero if succesful, or -EINVAL if the requested preview wi=
ndow is
> + * impossible and cannot reasonably be adjusted.
> + */
> +int omap_vout_new_window(struct v4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win, struct v4l2_fr=
amebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new_win)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D omap_vout_try_window(fbuf, new_win);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 /* update our preview window */
> + =A0 =A0 =A0 win->w =3D new_win->w;
> + =A0 =A0 =A0 win->field =3D new_win->field;
> + =A0 =A0 =A0 win->chromakey =3D new_win->chromakey;
> +
> + =A0 =A0 =A0 /* adjust the cropping window to allow for resizing lim=
itations */
> + =A0 =A0 =A0 if ((crop->height/win->w.height) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum vertical downsizing rati=
o is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->height =3D win->w.height * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((crop->width/win->w.width) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum horizontal downsizing ra=
tio is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->width =3D win->w.width * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (crop->width > 768) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The OMAP2420 vertical resizing line =
buffer is 768 pixels
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wide. =A0If the cropped image is w=
ider than 768 pixels then it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cannot be vertically resized.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (crop->height !=3D win->w.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->width =3D 768;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_new_window);
> +
> +/* Given a new cropping rectangle in new_crop, adjust the cropping r=
ectangle to
> + * the nearest supported configuration. =A0The image render window i=
n win will
> + * also be adjusted if necessary. =A0The preview window is adjusted =
such that the
> + * horizontal and vertical rescaling ratios stay constant. =A0If the=
 render
> + * window would fall outside the display boundaries, the cropping re=
ctangle
> + * will also be adjusted to maintain the rescaling ratios. =A0If suc=
cessful, crop
> + * and win are updated.
> + * Returns zero if succesful, or -EINVAL if the requested cropping r=
ectangle is
> + * impossible and cannot reasonably be adjusted.
> + */
> +int omap_vout_new_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_rect *crop, struct v4l2_window =
*win,
> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, const struct=
 v4l2_rect *new_crop)
> +{
> + =A0 =A0 =A0 struct v4l2_rect try_crop;
> + =A0 =A0 =A0 unsigned long vresize, hresize;
> +
> + =A0 =A0 =A0 /* make a working copy of the new_crop rectangle */
> + =A0 =A0 =A0 try_crop =3D *new_crop;
> +
> + =A0 =A0 =A0 /* adjust the cropping rectangle so it fits in the imag=
e */
> + =A0 =A0 =A0 if (try_crop.left < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width +=3D try_crop.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.left =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (try_crop.top < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height +=3D try_crop.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.top =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 try_crop.width =3D (try_crop.width < pix->width) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width : pix->width;
> + =A0 =A0 =A0 try_crop.height =3D (try_crop.height < pix->height) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height : pix->height;
> + =A0 =A0 =A0 if (try_crop.left + try_crop.width > pix->width)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D pix->width - try_cro=
p.left;
> + =A0 =A0 =A0 if (try_crop.top + try_crop.height > pix->height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height =3D pix->height - try_c=
rop.top;
> + =A0 =A0 =A0 try_crop.width &=3D ~1;
> + =A0 =A0 =A0 try_crop.height &=3D ~1;
> + =A0 =A0 =A0 if (try_crop.width <=3D 0 || try_crop.height <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (crop->height !=3D win->w.height) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If we're resizing vertically, we can=
't support a crop width
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wider than 768 pixels.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.width > 768)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D 768;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* vertical resizing */
> + =A0 =A0 =A0 vresize =3D (1024 * crop->height) / win->w.height;
> + =A0 =A0 =A0 if (vresize > 2048)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vresize =3D 2048;
> + =A0 =A0 =A0 else if (vresize =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vresize =3D 1;
> + =A0 =A0 =A0 win->w.height =3D ((1024 * try_crop.height) / vresize) =
& ~1;
> + =A0 =A0 =A0 if (win->w.height =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.height =3D 2;
> + =A0 =A0 =A0 if (win->w.height + win->w.top > fbuf->fmt.height) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We made the preview window extend be=
low the bottom of the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* display, so clip it to the display=
 boundary and resize the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cropping height to maintain the ve=
rtical resizing ratio.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.height =3D (fbuf->fmt.height - w=
in->w.top) & ~1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.height =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height =3D 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* horizontal resizing */
> + =A0 =A0 =A0 hresize =3D (1024 * crop->width) / win->w.width;
> + =A0 =A0 =A0 if (hresize > 2048)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hresize =3D 2048;
> + =A0 =A0 =A0 else if (hresize =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hresize =3D 1;
> + =A0 =A0 =A0 win->w.width =3D ((1024 * try_crop.width) / hresize) & =
~1;
> + =A0 =A0 =A0 if (win->w.width =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.width =3D 2;
> + =A0 =A0 =A0 if (win->w.width + win->w.left > fbuf->fmt.width) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We made the preview window extend pa=
st the right side of the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* display, so clip it to the display=
 boundary and resize the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cropping width to maintain the hor=
izontal resizing ratio.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.width =3D (fbuf->fmt.width - win=
->w.left) & ~1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.width =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D 2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Check for resizing constraints */
> + =A0 =A0 =A0 if ((try_crop.height/win->w.height) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum vertical downsizing rati=
o is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height =3D win->w.height * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((try_crop.width/win->w.width) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum horizontal downsizing ra=
tio is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D win->w.width * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (try_crop.width > 768) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The OMAP2420 vertical resizing line =
buffer is 768 pixels
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wide. =A0If the cropped image is w=
ider than 768 pixels then it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cannot be vertically resized.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.height !=3D win->w.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D 768;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* update our cropping rectangle and we're done */
> + =A0 =A0 =A0 *crop =3D try_crop;
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_new_crop);
> +
> +/* Given a new format in pix and fbuf, =A0crop and win
> + * structures are initialized to default values. crop
> + * is initialized to the largest window size that will fit on the di=
splay. =A0The
> + * crop window is centered in the image. win is initialized to
> + * the same size as crop and is centered on the display.
> + * All sizes and offsets are constrained to be even numbers.
> + */
> +void omap_vout_new_format(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, struct v=
4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win)
> +{
> + =A0 =A0 =A0 /* crop defines the preview source window in the image =
capture
> + =A0 =A0 =A0 =A0* buffer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 omap_vout_default_crop(pix, fbuf, crop);
> +
> + =A0 =A0 =A0 /* win defines the preview target window on the display=
 */
> + =A0 =A0 =A0 win->w.width =3D crop->width;
> + =A0 =A0 =A0 win->w.height =3D crop->height;
> + =A0 =A0 =A0 win->w.left =3D ((fbuf->fmt.width - win->w.width) >> 1)=
 & ~1;
> + =A0 =A0 =A0 win->w.top =3D ((fbuf->fmt.height - win->w.height) >> 1=
) & ~1;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_new_format);
> +
> +MODULE_AUTHOR("Texas Instruments.");
> +MODULE_DESCRIPTION("OMAP Video library");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/video/omap/omap_voutlib.h b/drivers/media/=
video/omap/omap_voutlib.h
> new file mode 100644
> index 0000000..d98f659
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutlib.h
> @@ -0,0 +1,34 @@
> +/*
> + * drivers/media/video/omap/omap_voutlib.h
> + *
> + * Copyright (C) 2008 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. This program is licensed "as is" without any warranty =
of any
> + * kind, whether express or implied.
> + *
> + */
> +
> +#ifndef OMAP_VOUTLIB_H
> +#define OMAP_VOUTLIB_H
> +
> +extern void omap_vout_default_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, struct v=
4l2_rect *crop);
> +
> +extern int omap_vout_new_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_rect *crop, struct v4l2_win=
dow *win,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct v4l2_rect *new_crop);
> +
> +extern int omap_vout_try_window(struct v4l2_framebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new_win);
> +
> +extern int omap_vout_new_window(struct v4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win, struct v4l2_fr=
amebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new_win);
> +
> +extern void omap_vout_new_format(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, struct v=
4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win);
> +#endif /* #ifndef OMAP_LIB_H */

Please, check the year in all patch.

--=20
Best regards, Klimov Alexey
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
