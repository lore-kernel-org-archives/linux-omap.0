From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2: Camera: Add driver.
Date: Tue, 21 Aug 2007 22:38:42 +0530
Message-ID: <5d5443650708211008x11d022b6qe513e75c6aa56585@mail.gmail.com>
References: <46C982CD.80802@nokia.com>
	<11876114351486-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11876114351486-git-send-email-sakari.ailus@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Sakari,

On 8/20/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
> Add a driver for the OMAP 2 camera block. OMAP 2 is used in e.g. Nokia
> N800 internet tablet.
>
> This driver uses the new V4L2 internal ioctl interface.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/media/video/Kconfig           |    8 +
>  drivers/media/video/Makefile          |    1 +
>  drivers/media/video/omap24xxcam-dma.c |  603 +++++++++++
>  drivers/media/video/omap24xxcam.c     | 1847 +++++++++++++++++++++++++++++++++
>  drivers/media/video/omap24xxcam.h     |  584 +++++++++++
>  5 files changed, 3043 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/omap24xxcam-dma.c
>  create mode 100644 drivers/media/video/omap24xxcam.c
>  create mode 100644 drivers/media/video/omap24xxcam.h
>
> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
> index c6b5011..7328375 100644
> --- a/drivers/media/video/Kconfig
> +++ b/drivers/media/video/Kconfig
> @@ -700,6 +700,14 @@ config VIDEO_CAFE_CCIC
>           CMOS camera controller.  This is the controller found on first-
>           generation OLPC systems.
>
> +config VIDEO_OMAP2
> +       tristate "OMAP 2 Camera support (EXPERIMENTAL)"
> +       select VIDEO_BUF
> +       depends on VIDEO_V4L2 && ARCH_OMAP24XX
> +       ---help---
> +         Driver for an OMAP 2 camera controller.
> +
> +
>  #
>  # USB Multimedia device configuration
>  #
> diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
> index 0c0c5f5..658d8d9 100644
> --- a/drivers/media/video/Makefile
> +++ b/drivers/media/video/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_VIDEO_CX2341X) += cx2341x.o
>  obj-$(CONFIG_VIDEO_CAFE_CCIC) += cafe_ccic.o
>  obj-$(CONFIG_VIDEO_OV7670)     += ov7670.o
>
> +obj-$(CONFIG_VIDEO_OMAP2) += omap24xxcam.o omap24xxcam-dma.o
>  obj-$(CONFIG_VIDEO_TCM825X) += tcm825x.o
>
>  obj-$(CONFIG_USB_DABUSB)        += dabusb.o

...

> diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
> new file mode 100644
> index 0000000..a6e481f
> --- /dev/null
> +++ b/drivers/media/video/omap24xxcam.c
> @@ -0,0 +1,1847 @@
> +/*
> + * drivers/media/video/omap24xxcam.c
> + *
> + * OMAP 2 camera block driver.
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2004 Texas Instruments.
> + * Copyright (C) 2007 Nokia Corporation.
> + *
> + * Contact: Sakari Ailus <sakari.ailus@nokia.com>
> + *
> + * Based on code from Andy Lowe <source@mvista.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/videodev2.h>
> +#include <linux/pci.h>         /* needed for videobufs */
> +#include <linux/version.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <media/v4l2-common.h>
> +
> +#include "omap24xxcam.h"
> +
> +#define OMAP24XXCAM_VERSION KERNEL_VERSION(0, 0, 0)
> +
> +#define RESET_TIMEOUT_NS 10000

...

> +
> +}
> +
> +/*
> + *
> + * Sensor handling.
> + *
> + */
> +
> +/*
> + * Initialise the sensor hardware.
> + */
> +static int omap24xxcam_sensor_init(struct omap24xxcam_device *cam)
> +{
> +       int err = 0;
> +       struct v4l2_int_device *sdev = cam->sdev;
> +       u32 xclk;
> +       struct v4l2_ifparm p;
> +
> +       /*
> +        * Get sensor interface parameters from sensor and prepare
> +        * cc_ctrl value that can be used when enabling camera core.
> +        */
> +       cam->cc_ctrl = CC_CTRL_CC_EN;
> +
> +       err = vidioc_int_g_ifparm(cam->sdev, &p);
> +       if (err) {
> +               dev_err(cam->dev, "vidioc_int_g_ifparm failed with %d\n", err);
> +               return err;
> +       }
> +
> +       switch (p.if_type) {
> +       case V4L2_IF_TYPE_PARALLEL:
> +               if (p.u.parallel.frame_start_on_rising_vs)
> +                       cam->cc_ctrl |= CC_CTRL_NOBT_SYNCHRO;
> +               if (p.u.parallel.bt_sync_correct)
> +                       cam->cc_ctrl |= CC_CTRL_BT_CORRECT;
> +               if (p.u.parallel.swap)
> +                       cam->cc_ctrl |= CC_CTRL_PAR_ORDERCAM;

In case of earlier omap2 camera driver with ov9640 combination above bit was
set based on the pixelformat being passed. I am just copying that code here.

-----------------------snip-------------------------------------
        switch (pix->pixelformat) {
        case V4L2_PIX_FMT_UYVY:
        case V4L2_PIX_FMT_RGB565:
        case V4L2_PIX_FMT_RGB555:
        default:
                /* These formats need a 16-bit byte swap */
                cam->cc_ctrl |= CC_CTRL_PAR_ORDERCAM;
        case V4L2_PIX_FMT_YUYV:
        case V4L2_PIX_FMT_RGB565X:
        case V4L2_PIX_FMT_RGB555X:
                /* These formats don't need a 16-bit byte swap */
                break;
        }
-----------------------snip-------------------------------------

So, we might need to add support for above also.

> +               if (p.u.parallel.latch_clk_inv)
> +                       cam->cc_ctrl |= CC_CTRL_PAR_CLK_POL;
> +               if (p.u.parallel.nobt_hs_inv)
> +                       cam->cc_ctrl |= CC_CTRL_NOBT_HS_POL;
> +               if (p.u.parallel.nobt_hs_inv)

Above should be nobt_vs_inv instead :)

> +                       cam->cc_ctrl |= CC_CTRL_NOBT_VS_POL;
> +
> +               switch (p.u.parallel.mode) {
> +               case V4L2_IF_TYPE_PARALLEL_MODE_NOBT_8BIT:
> +                       cam->cc_ctrl |= CC_CTRL_PAR_MODE_NOBT8;
> +                       break;
> +               case V4L2_IF_TYPE_PARALLEL_MODE_NOBT_10BIT:
> +                       cam->cc_ctrl |= CC_CTRL_PAR_MODE_NOBT10;
> +                       break;
> +               case V4L2_IF_TYPE_PARALLEL_MODE_NOBT_12BIT:
> +                       cam->cc_ctrl |= CC_CTRL_PAR_MODE_NOBT12;
> +                       break;
> +               case V4L2_IF_TYPE_PARALLEL_MODE_BT_8BIT:
> +                       cam->cc_ctrl |= CC_CTRL_PAR_MODE_BT8;
> +                       break;
> +               case V4L2_IF_TYPE_PARALLEL_MODE_BT_10BIT:
> +                       cam->cc_ctrl |= CC_CTRL_PAR_MODE_BT10;
> +                       break;
> +               }
> +               break;
> +       default:
> +               /* FIXME: how about other interfaces? */
> +               dev_err(cam->dev, "interface type %d not supported\n",
> +                       p.if_type);
> +               return err;
> +       }
> +
> +       omap24xxcam_clock_on(cam);
> +       vidioc_int_g_ext_clk(sdev, &xclk);
> +       omap24xxcam_core_xclk_set(cam, xclk);
> +

I have updated ov9640 driver with the changes you have suggested and
with new "ifparm" bits, but ov9640 on H4 is still not working. I will
post that incremental patches for ov9640, so that someone can debug on
H4/OMAP1(once that core gets converted to this new interface).

-- 
--Trilok Soni
