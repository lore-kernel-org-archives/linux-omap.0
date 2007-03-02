From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC] V4L2 Based Video driver.
Date: Thu, 1 Mar 2007 19:56:08 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47622700@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Here is a patch for V4L2 based Video driver.

- Uses Video1 and Video2 pipeline of DSS.
- Supports RGB565/24 packed-unpacked/YUYV/UYVY
- Scaling (up/down)
- Mirroring (with & without VRFB)
- Windowing + Cropping
- Transparency color key (source/destination)
- Rotation with VRFB (0/90/180/270)
- All the above combinations

Needs more clean up. Please do let me know your comments.

Regards,
Khasim

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/drivers/media/video/omap/omap24xxvout.c
lin_for_twl/drivers/media/video/omap/omap24xxvout.c
--- linux-omap/drivers/media/video/omap/omap24xxvout.c	1969-12-31
18:00:00.000000000 -0600
+++ lin_for_twl/drivers/media/video/omap/omap24xxvout.c	2007-02-26
10:32:29.000000000 -0600
@@ -0,0 +1,1925 @@
+/*
+ * drivers/media/video/omap24xx/omap24xxvout.c
+ *
+ * Copyright (C) 2005-2006 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public
License
+ * version 2. This program is licensed "as is" without any warranty of
any
+ * kind, whether express or implied.
+ *
+ * Leveraged code from the OMAP2 camera driver
+ * Video-for-Linux (Version 2) camera capture driver for
+ * the OMAP24xx camera controller.
+ * Initial code : Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+#include <media/video-buf.h>
+#include <linux/input.h>
+#include <linux/dma-mapping.h>
+
+#ifdef CONFIG_PM
+#include <linux/notifier.h>
+#include <linux/pm.h>
+#endif
+#ifdef CONFIG_DPM
+#include <linux/dpm.h>
+#endif
+
+#include <asm/arch/display.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+#include <asm/processor.h>
+#include <asm/arch/bus.h>
+#include <asm/arch/dma.h>
+
+#include "omap24xxlib.h"
+
+/*
+ * Un-comment this to use Debug Write call
+ */
+/* #define DEBUG_ALLOW_WRITE */
+
+#include "omap24xxvoutdef.h"
+
+extern const char *global_mode_option;
+
+/*
+ * Uncomment this if debugging support needs to be enabled
+ */
+
+/* #define DEBUG */
+
+#undef DEBUG
+#ifdef DEBUG
+#define DPRINTK(ARGS...)  printk("<%s>: ",__FUNCTION__);printk(ARGS)
+#else
+#define DPRINTK( x... )
+#endif
+
+/*
+ * -1 means rotation support is disabled
+ * 0/90/180/270 are initial rotation angles
+ */
+
+static int rotation_support =3D -1;
+
+/* configuration macros */
+#define VOUT_NAME		"omap24xxvout"
+#define V1OUT_NAME		"omap24xxvout1"
+#define V2OUT_NAME		"omap24xxvout2"
+
+#define VGA_WIDTH		640
+#define VGA_HEIGHT		480
+#define QQVGA_WIDTH		160
+#define QQVGA_HEIGHT		120
+#define BYTESPERPIXEL		2
+#define DMA_CHAN_ALLOTED	1
+#define DMA_CHAN_NOT_ALLOTED	0
+#define NUM_OF_VIDEO_CHANNELS	2
+#define VRF_SIZE		MAX_PIXELS_PER_LINE * MAX_LINES * 4
+#define SMS_RGB_PIXSIZE	2
+#define SMS_YUYV_PIXSIZE	4
+#define VRFB_TX_TIMEOUT	1000
+
+static struct omap24xxvout_device *saved_v1out, *saved_v2out;
+
+/*
+ * this is the layer being linked to (slave layer). possible values
are:
+ * OMAP2_VIDEO1:  V1 is linked to V2. V1 uses V2's pix and crop.
+ * OMAP2_VIDEO2:  V2 is linked to V1. V2 uses V1's pix and crop.
+ * -1: no link.
+ */
+
+static int vout_linked;
+static spinlock_t vout_link_lock;
+
+static struct videobuf_queue_ops dummy_vbq_ops;
+
+/* module parameters */
+
+/*
+ * Maximum amount of memory to use for rendering buffers.
+ * Default is enough to four (RGB24) VGA buffers.
+ */
+#define MAX_ALLOWED_VIDBUFFERS		4
+static int render_mem =3D VGA_WIDTH * VGA_HEIGHT * 4 *
MAX_ALLOWED_VIDBUFFERS;
+
+/* list of image formats supported by OMAP2 video pipelines */
+const static struct v4l2_fmtdesc omap2_formats[] =3D {
+{
+	/* Note:  V4L2 defines RGB565 as:
+	 *
+	 *	  Byte 0			Byte 1
+	 *	  g2 g1 g0 r4 r3 r2 r1 r0   b4 b3 b2 b1 b0 g5 g4 g3
+	 *
+	 * We interpret RGB565 as:
+	 *
+	 *	  Byte 0			Byte 1
+	 *	  g2 g1 g0 b4 b3 b2 b1 b0   r4 r3 r2 r1 r0 g5 g4 g3
+	 */
+	.description	=3D "RGB565, le",
+	.pixelformat	=3D V4L2_PIX_FMT_RGB565,
+},
+{
+	/* Note:  V4L2 defines RGB565X as:
+	 *
+	 *	  Byte 0			Byte 1
+	 *	  b4 b3 b2 b1 b0 g5 g4 g3   g2 g1 g0 r4 r3 r2 r1 r0
+	 *
+	 * We interpret RGB565X as:
+	 *
+	 *	  Byte 0			Byte 1
+	 *	  r4 r3 r2 r1 r0 g5 g4 g3   g2 g1 g0 b4 b3 b2 b1 b0
+	 */
+	.description	=3D "RGB565, be",
+	.pixelformat	=3D V4L2_PIX_FMT_RGB565X,
+},
+{
+	/* Note:  V4L2 defines RGB32 as: RGB-8-8-8-8  we use
+	 *	this for RGB24 unpack mode, the last 8 bits are ignored
+	 *
+	 */
+	.description	=3D "RGB32, le",
+	.pixelformat	=3D V4L2_PIX_FMT_RGB32,
+},
+{
+	/* Note:  V4L2 defines RGB24 as: RGB-8-8-8  we use
+	 *	this for RGB24 packed mode
+	 *
+	 */
+	.description	=3D "RGB24, le",
+	.pixelformat	=3D V4L2_PIX_FMT_RGB24,
+},
+{
+	.description	=3D "YUYV (YUV 4:2:2), packed",
+	.pixelformat	=3D V4L2_PIX_FMT_YUYV,
+},
+{
+	.description	=3D "UYVY, packed",
+	.pixelformat	=3D V4L2_PIX_FMT_UYVY,
+},
+};
+
+#define NUM_OUTPUT_FORMATS
(sizeof(omap2_formats)/sizeof(omap2_formats[0]))
+
+/* CONFIG_PM */
+#ifdef CONFIG_PM
+#define omap24xxvout_suspend_lockout(s,f) \
+	if ((s)->suspended) {\
+		if ((f)->f_flags & O_NONBLOCK)\
+			return -EBUSY;\
+		wait_event_interruptible((s)->suspend_wq,\
+					(s)->suspended =3D=3D 0);\
+	}
+#else
+#define omap24xxvout_suspend_lockout(s, f) do {(s)->suspended =3D 0;}
while(0)
+#endif
+
+/*
------------------------------------------------------------------------
-- */
+
+static int
+try_format (struct v4l2_pix_format *pix)
+{
+	int ifmt,bpp =3D0;
+
+	if (pix->width > VGA_WIDTH)
+		pix->width =3D VGA_WIDTH;
+	if (pix->height > VGA_HEIGHT)
+		pix->height =3D VGA_HEIGHT;
+
+	for (ifmt =3D 0; ifmt < NUM_OUTPUT_FORMATS; ifmt++) {
+		if (pix->pixelformat =3D=3D omap2_formats[ifmt].pixelformat)
+			break;
+	}
+
+	if (ifmt =3D=3D NUM_OUTPUT_FORMATS)
+		ifmt =3D 0;
+
+	pix->pixelformat =3D omap2_formats[ifmt].pixelformat;
+	pix->field =3D V4L2_FIELD_NONE;
+	pix->priv =3D 0;
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+	default:
+		pix->colorspace =3D V4L2_COLORSPACE_JPEG;
+		bpp =3D YUYV_BPP;
+	break;
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_RGB565X:
+		pix->colorspace =3D V4L2_COLORSPACE_SRGB;
+		bpp =3D RGB565_BPP;
+	break;
+	case V4L2_PIX_FMT_RGB24:
+		pix->colorspace =3D V4L2_COLORSPACE_SRGB;
+		bpp =3D RGB24_BPP;
+	break;
+	case V4L2_PIX_FMT_RGB32:
+		pix->colorspace =3D V4L2_COLORSPACE_SRGB;
+		bpp =3D RGB32_BPP;
+	break;
+	}
+	pix->bytesperline =3D pix->width * bpp;
+	pix->sizeimage =3D pix->bytesperline * pix->height;
+	return(bpp);
+}
+
+static void
+vrfb_dma_tx_callback (int lch, u16 ch_status, void *data)
+{
+	struct vid_vrfb_dma *t =3D (struct vid_vrfb_dma *) data;
+	t->tx_status =3D 1;
+	wake_up_interruptible (&t->wait);
+}
+
+static void
+omap24xxvout_sync (struct omap24xxvout_device *dest,
+			struct omap24xxvout_device *src)
+{
+	/*
+	 * once linked, dest shares src's framebuffer, pix and crop
+	 */
+
+	dest->pix =3D src->pix;
+	dest->crop =3D src->crop;
+
+	if (src->streaming)
+		omap2_disp_config_vlayer (dest->vid, &dest->pix,
&dest->crop, &dest->win,
+			dest->rotation, dest->mirror);
+}
+
+static int
+omap24xxvout_do_ioctl (struct inode *inode, struct file *file,
+				unsigned int cmd, void *arg)
+{
+	struct omap24xxvout_fh *fh =3D (struct omap24xxvout_fh
*)file->private_data;
+	struct omap24xxvout_device *vout =3D fh->vout;
+	int err;
+
+	switch (cmd) {
+	case VIDIOC_ENUMOUTPUT:
+	{
+		struct v4l2_output *output =3D (struct v4l2_output *) arg;
+		int index =3D output->index;
+
+		if (index > 0)
+			return -EINVAL;
+
+		memset (output, 0, sizeof (*output));
+		output->index =3D index;
+
+		strncpy (output->name, "video out", sizeof
(output->name));
+		output->type =3D V4L2_OUTPUT_TYPE_MODULATOR;
+		return 0;
+	}
+
+	case VIDIOC_G_OUTPUT:
+	{
+		unsigned int *output =3D arg;
+		*output =3D 0;
+		return 0;
+	}
+
+	case VIDIOC_S_OUTPUT:
+	{
+		unsigned int *output =3D arg;
+
+		if (*output > 0)
+			return -EINVAL;
+		return 0;
+	}
+
+	case VIDIOC_QUERYCAP:
+	{
+		struct v4l2_capability *cap =3D (struct v4l2_capability *)
arg;
+		memset (cap, 0, sizeof (*cap));
+		strncpy (cap->driver, VOUT_NAME, sizeof (cap->driver));
+		strncpy (cap->card, vout->vfd->name, sizeof
(cap->card));
+		cap->bus_info[0] =3D '\0';
+		cap->capabilities =3D V4L2_CAP_STREAMING |
V4L2_CAP_VIDEO_OUTPUT;
+		return 0;
+	}
+	case VIDIOC_ENUM_FMT:
+	{
+		struct v4l2_fmtdesc *fmt =3D arg;
+		int index =3D fmt->index;
+		enum v4l2_buf_type type =3D fmt->type;
+		memset (fmt, 0, sizeof (*fmt));
+		fmt->index =3D index;
+		fmt->type =3D type;
+
+		switch (fmt->type) {
+			case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+	  		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+			if (index >=3D NUM_OUTPUT_FORMATS)
+				return -EINVAL;
+			break;
+			default:
+			return -EINVAL;
+		}
+
+		fmt->flags =3D omap2_formats[index].flags;
+		strncpy (fmt->description,
omap2_formats[index].description,
+			sizeof (fmt->description));
+		fmt->pixelformat =3D omap2_formats[index].pixelformat;
+
+		return 0;
+	}
+	case VIDIOC_G_FMT:
+	{
+		struct v4l2_format *f =3D (struct v4l2_format *) arg;
+
+		switch (f->type) {
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			struct v4l2_pix_format *pix =3D &f->fmt.pix;
+			memset (pix, 0, sizeof (*pix));
+			*pix =3D vout->pix;
+			return 0;
+		}
+
+		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		{
+			struct v4l2_window *win =3D &f->fmt.win;
+			memset (win, 0, sizeof (*win));
+
+			/*
+			 * The API has a bit of a problem here.
+			 * We're returning a v4l2_window
+			 * structure, but that structure
+			 * contains pointers to variable-sized
+			 * objects for clipping rectangles and
+			 * clipping bitmaps.  We will just
+			 * return NULLs for those pointers.
+			 */
+
+			win->w =3D vout->win.w;
+			win->field =3D vout->win.field;
+			win->chromakey =3D vout->win.chromakey;
+			return 0;
+		}
+		default:
+		return -EINVAL;
+		}
+	}
+	case VIDIOC_TRY_FMT:
+	{
+		struct v4l2_format *f =3D (struct v4l2_format *) arg;
+
+		if (vout->streaming)
+			return -EBUSY;
+
+		/* We dont support RGB24-packed mode if vrfb rotation is
enabled*/
+		if (vout->rotation !=3D -1 && f->fmt.pix.pixelformat =3D=3D
V4L2_PIX_FMT_RGB24)
+			return -EINVAL;
+
+		switch (f->type) {
+
+		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		{
+			struct v4l2_window *win =3D &f->fmt.win;
+			err =3D omap24xxvout_try_window (&vout->fbuf,
win);
+			return err;
+		}
+
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			/* don't allow to change img for the linked
layer */
+			if (vout->vid =3D=3D vout_linked)
+				return -EINVAL;
+			try_format (&f->fmt.pix);
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_S_FMT:
+	{
+		struct v4l2_format *f =3D (struct v4l2_format *) arg;
+
+		if (vout->streaming)
+			return -EBUSY;
+
+		/* We dont support RGB24-packed mode if vrfb rotation is
enabled*/
+		if (vout->rotation !=3D -1 && f->fmt.pix.pixelformat =3D=3D
V4L2_PIX_FMT_RGB24 )
+			return -EINVAL;
+
+		/* get the framebuffer parameters */
+		if (vout->rotation =3D=3D 90 || vout->rotation =3D=3D 270) {
+			omap2_disp_get_panel_size
(omap2_disp_get_output_dev (vout->vid),
+
&(vout->fbuf.fmt.height),&(vout->fbuf.fmt.width));
+		}
+		else{
+			omap2_disp_get_panel_size
(omap2_disp_get_output_dev (vout->vid),
+				&(vout->fbuf.fmt.width),
&(vout->fbuf.fmt.height));
+
+		}
+
+		switch (f->type) {
+		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		{
+			struct v4l2_window *win =3D &f->fmt.win;
+
+
+			err =3D omap24xxvout_new_window (&vout->crop,
&vout->win,
+				&vout->fbuf, win);
+			return err;
+		}
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			int bpp;
+			/*
+			 * don't allow to change img for the linked
layer
+			 */
+			if (vout->vid =3D=3D vout_linked)
+				return -EINVAL;
+
+			/* change to samller size is OK */
+			bpp =3D try_format (&f->fmt.pix);
+			f->fmt.pix.sizeimage =3D f->fmt.pix.width *
f->fmt.pix.height *bpp;
+
+			/* try & set the new output format */
+			vout->bpp =3D bpp;
+			vout->pix =3D f->fmt.pix;
+			vout->vrfb_bpp =3D 1;
+			/* If YUYV then vrfb bpp is 2, for others its
1*/
+			if (V4L2_PIX_FMT_YUYV =3D=3D vout->pix.pixelformat
+				|| V4L2_PIX_FMT_UYVY =3D=3D
vout->pix.pixelformat)
+				vout->vrfb_bpp =3D 2;
+
+			/* set default crop and win */
+			omap24xxvout_new_format (&vout->pix,
&vout->fbuf, &vout->crop,
+				&vout->win);
+
+			return 0;
+		}
+
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_CROPCAP:
+	{
+		struct v4l2_cropcap *cropcap =3D (struct v4l2_cropcap *)
arg;
+		enum v4l2_buf_type type =3D cropcap->type;
+
+		memset (cropcap, 0, sizeof (*cropcap));
+		cropcap->type =3D type;
+		switch (type) {
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			struct v4l2_pix_format *pix =3D &vout->pix;
+			cropcap->bounds.width =3D pix->width & ~1;
+			cropcap->bounds.height =3D pix->height & ~1;
+			omap24xxvout_default_crop (&vout->pix,
&vout->fbuf,
+					 &cropcap->defrect);
+			cropcap->pixelaspect.numerator =3D 1;
+			cropcap->pixelaspect.denominator =3D 1;
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_G_CROP:
+	{
+		struct v4l2_crop *crop =3D (struct v4l2_crop *) arg;
+
+		switch (crop->type) {
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			crop->c =3D vout->crop;
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_S_CROP:
+	{
+		struct v4l2_crop *crop =3D (struct v4l2_crop *) arg;
+		if (vout->streaming)
+			return -EBUSY;
+
+		/* get the framebuffer parameters */
+		if (vout->rotation =3D=3D 90 || vout->rotation =3D=3D 270) {
+			omap2_disp_get_panel_size
(omap2_disp_get_output_dev (vout->vid),
+
&(vout->fbuf.fmt.height),&(vout->fbuf.fmt.width));
+		}
+		else{
+			omap2_disp_get_panel_size
(omap2_disp_get_output_dev (vout->vid),
+				&(vout->fbuf.fmt.width),
&(vout->fbuf.fmt.height));
+
+		}
+
+		switch (crop->type) {
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			err =3D
+			omap24xxvout_new_crop (&vout->pix, &vout->crop,
&vout->win,
+				&vout->fbuf, &crop->c);
+			return err;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_REQBUFS:
+	{
+		struct v4l2_requestbuffers *req =3D (struct
v4l2_requestbuffers *) arg;
+		struct videobuf_queue *q =3D &fh->vbq;
+		unsigned int phy_addr, virt_addr;
+		unsigned int count, i;
+
+		/* don't allow to buffer request for the linked layer */
+		if (vout->vid =3D=3D vout_linked)
+			return -EINVAL;
+
+		if (req->count > VIDEO_MAX_FRAME)
+			req->count =3D VIDEO_MAX_FRAME;
+
+		/* we allow req->count =3D=3D 0 */
+		if ((req->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) ||
(req->count < 0))
+			return -EINVAL;
+
+		if (req->memory !=3D V4L2_MEMORY_MMAP)
+			return -EINVAL;
+
+		if (vout->streaming)
+			return -EBUSY;
+
+		/* reuse old buffers */
+		if (vout->buffer_allocated && vout->buffer_size >=3D
vout->pix.sizeimage) {
+			if (req->count) {
+				req->count =3D vout->buffer_allocated;
+				return 0;
+			}
+		}
+
+		/*
+		 * We allow re-request as long as old buffers are not
mmaped.
+		 * We will need to free old buffers first.
+		 */
+
+		/* either no buffer allocated or too small */
+		if (vout->buffer_allocated) {
+			if (vout->mmap_count)
+				return -EBUSY;
+			down (&q->lock);
+			for (i =3D 0; i < vout->buffer_allocated; i++) {
+
+				dma_free_coherent(NULL,
vout->buffer_size,
+					(void *)
q->bufs[i]->dma.vmalloc,
+					q->bufs[i]->dma.bus_addr);
+				q->bufs[i] =3D NULL;
+			}
+			vout->buffer_allocated =3D 0;
+			vout->buffer_size =3D 0;
+			up (&q->lock);
+			videobuf_mmap_free(q);
+		}
+		/* user intends to free buffer */
+		if (!req->count)
+			return 0;
+
+		down (&q->lock);
+		count =3D req->count;
+		while (PAGE_ALIGN(vout->pix.sizeimage) * count >
render_mem)
+			count--;
+
+		vout->buffer_size =3D PAGE_ALIGN(vout->pix.sizeimage);
+		for (i =3D 0; i < count; i++) {
+			virt_addr =3D
+			(unsigned int)dma_alloc_coherent(NULL,
+				vout->buffer_size,
+				(dma_addr_t *) & phy_addr,
+				GFP_KERNEL | GFP_DMA);
+
+			if (!virt_addr)
+				break;
+			memset((void *) virt_addr, 0,
vout->buffer_size);
+
+			DPRINTK("REQBUFS: buffer %d: virt=3D0x%x,
phy=3D0x%x, size=3D0x%x\n",
+				i, virt_addr, phy_addr,
vout->buffer_size);
+
+			q->bufs[i] =3D videobuf_alloc (q->msize);
+			if (q->bufs[i] =3D=3D NULL) {
+				dma_free_coherent(NULL,
vout->buffer_size,
+					(void *) virt_addr,
+					(dma_addr_t) phy_addr);
+				break;
+			}
+			q->bufs[i]->i =3D i;
+			q->bufs[i]->input =3D UNSET;
+			q->bufs[i]->memory =3D req->memory;
+			q->bufs[i]->bsize =3D vout->buffer_size;
+			q->bufs[i]->boff =3D vout->buffer_size * i;
+			q->bufs[i]->dma.vmalloc =3D (void *) (virt_addr);
+			q->bufs[i]->dma.bus_addr =3D phy_addr;
+			q->bufs[i]->state =3D STATE_PREPARED;
+
+			vout->buf_virt_addr[i] =3D (unsigned long)
q->bufs[i]->dma.vmalloc;
+			vout->buf_phy_addr[i] =3D
q->bufs[i]->dma.bus_addr;
+
+			vout->buffer_allocated++;
+		}
+		vout->buf_memory_type =3D req->memory;
+
+		/* return -ENOMEM if we are not able to allocate a
single buffer
+		 * we have to seperate the case which user requests 0
buffer which
+		 * means user wants to free the already allocated
buffers
+		 */
+
+		if (vout->buffer_allocated =3D=3D 0 && req->count !=3D 0) {
+			up (&q->lock);
+			vout->buffer_size =3D 0;
+			return -ENOMEM;
+		}
+		req->count =3D vout->buffer_allocated;
+		up (&q->lock);
+		return 0;
+	}
+	case VIDIOC_QUERYBUF:
+		return videobuf_querybuf (&fh->vbq, arg);
+
+	case VIDIOC_QBUF:
+	{
+		struct v4l2_buffer *buffer =3D (struct v4l2_buffer *) arg;
+		struct videobuf_queue *q =3D &fh->vbq;
+		struct omap24xxvout_device *dest;
+		int dest_frame_index =3D 0, src_element_index =3D 0;
+		int dest_element_index =3D 0, src_frame_index =3D 0;
+		int elem_count =3D 0, frame_count =3D 0, pixsize =3D
2,mir_rot_deg =3D 0;
+
+		/* don't allow to queue buffer for the linked layer */
+		if (vout->vid =3D=3D vout_linked)
+			return -EINVAL;
+
+		if (buffer->index >=3D vout->buffer_allocated)
+			return -EINVAL;
+
+		if (vout->rotation >=3D 0
+			&& vout->vrfb_dma_tx.req_status =3D=3D
DMA_CHAN_NOT_ALLOTED)
+			return -EINVAL;
+
+		DPRINTK ("queuing buffer %d ...\n", buffer->index);
+
+		if (!vout->streaming)
+			return -EINVAL;
+
+		down (&q->lock);
+
+		/*
+		 * If rotation is enabled then copy the image data from
the
+		 * MMAPPED area to SMS area
+		 */
+
+		if (vout->rotation >=3D 0) {
+			pixsize =3D vout->bpp * vout->vrfb_bpp;
+			/*
+			 * DMA transfer in double index mode
+			 */
+
+			/* Frame index */
+			dest_frame_index =3D
+				((MAX_PIXELS_PER_LINE * pixsize) -
(vout->pix.width * vout->bpp)) + 1;
+
+			/* Source and destination parameters */
+			src_element_index =3D 0;
+			src_frame_index =3D 0;
+			dest_element_index =3D 1;
+
+			/* Number of elements per frame */
+			elem_count =3D vout->pix.width * vout->bpp;
+			frame_count =3D vout->pix.height;
+			vout->vrfb_dma_tx.tx_status =3D 0;
+			omap_set_dma_transfer_params
(vout->vrfb_dma_tx.dma_ch,
+				OMAP_DMA_DATA_TYPE_S8,elem_count,
frame_count,
+
OMAP_DMA_SYNC_ELEMENT,vout->vrfb_dma_tx.dev_id, 0x0);
+
+			omap_set_dma_src_params
(vout->vrfb_dma_tx.dma_ch,
+
OMAP_DMA_AMODE_POST_INC,q->bufs[buffer->index]->dma.bus_addr,
+				src_element_index, src_frame_index);
+
+			if (vout->mirror =3D=3D 1) {
+				mir_rot_deg =3D (vout->rotation =3D=3D
90)?(270/90):
+						(vout->rotation =3D=3D
270)?(90/90):
+							(vout->rotation
=3D=3D 180)?(0/90):(180/90);
+
+				omap_set_dma_dest_params
(vout->vrfb_dma_tx.dma_ch,OMAP_DMA_AMODE_DOUBLE_IDX,
+
vout->sms_rot_phy[mir_rot_deg],dest_element_index, dest_frame_index);
+			}
+			else{ /* No Mirroring */
+				omap_set_dma_dest_params
(vout->vrfb_dma_tx.dma_ch,OMAP_DMA_AMODE_DOUBLE_IDX,
+
vout->sms_rot_phy[vout->rotation/90],dest_element_index,
dest_frame_index);
+			}
+			omap_start_dma (vout->vrfb_dma_tx.dma_ch);
+			interruptible_sleep_on_timeout
(&vout->vrfb_dma_tx.wait,
+						VRFB_TX_TIMEOUT);
+
+			if (vout->vrfb_dma_tx.tx_status =3D=3D 0) {
+				omap_stop_dma
(vout->vrfb_dma_tx.dma_ch);
+				up (&q->lock);
+				return -EINVAL;
+			}
+			if (vout->mirror =3D=3D 1) {
+				mir_rot_deg =3D (vout->rotation =3D=3D 90)?
270:
+						(vout->rotation =3D=3D 270)?
90:
+							(vout->rotation
=3D=3D 180)? 0:180;
+				omap2_disp_start_vlayer
(vout->vid,&vout->pix, &vout->crop,
+						vout->sms_rot_phy[0],
mir_rot_deg, vout->mirror);
+			}
+			else{
+				omap2_disp_start_vlayer
(vout->vid,&vout->pix,&vout->crop,
+				vout->sms_rot_phy[0], vout->rotation,
vout->mirror);
+			}
+		}/*if rotation */
+		else{
+			omap2_disp_start_vlayer (vout->vid, &vout->pix,
&vout->crop,
+
q->bufs[buffer->index]->dma.bus_addr,vout->rotation, vout->mirror);
+		}
+
+		up (&q->lock);
+		/* start slave layer if V1 and V2 are linked */
+		if (vout_linked !=3D -1) {
+			dest =3D (vout_linked =3D=3D OMAP2_VIDEO1) ?
saved_v1out : saved_v2out;
+			if (dest->streaming) {
+				if (dest->rotation >=3D 0) {
+					/* if rotation and mirroring */
+					if (dest->mirror =3D=3D 1) {
+						mir_rot_deg =3D
(dest->rotation =3D=3D 90)? 270:
+							(dest->rotation
=3D=3D 270)? 90:
+
(dest->rotation =3D=3D 180)? 0:180;
+
+
omap2_disp_start_vlayer(dest->vid,&dest->pix,
+						&dest->crop,
vout->sms_rot_phy[0], mir_rot_deg,
+						dest->mirror);
+					}
+					/* if no mirroring but rotation
*/
+					else{
+
omap2_disp_start_vlayer(dest->vid,&dest->pix,
+
&dest->crop,vout->sms_rot_phy[0],
+
dest->rotation,dest->mirror);
+					}
+				}
+				else {
+					omap2_disp_start_vlayer (dest->
vid, &dest->pix, &dest-> crop,
+
q->bufs[buffer->index]->dma.bus_addr, dest->rotation,
+					dest->mirror);
+				}		/* if no rotation and
mirroring */
+			}
+		}
+		return 0;
+	}
+	case VIDIOC_DQBUF:
+	{
+		/* don't allow to dequeue buffer for the linked layer */
+		if (vout->vid =3D=3D vout_linked)
+			return -EINVAL;
+		return 0;
+	}
+	case VIDIOC_STREAMON:
+	{
+		if (vout->streaming)
+			return -EBUSY;
+		/*
+		 * If rotation mode is selected then allocate a
+		 *  dummy or hidden buffer to map the SMS virtual space
+		 */
+		if (vout->vid !=3D vout_linked) {
+			if (vout->rotation >=3D 0) {
+
+				/* Align the image size with respect to
tile size */
+				u32 image_width =3D 0, image_height =3D 0;
+
+				image_width =3D vout->pix.width /
TILE_SIZE;
+				if (vout->pix.width % TILE_SIZE)
+					image_width++;
+				image_width =3D image_width * TILE_SIZE;
+
+				image_height =3D vout->pix.height /
TILE_SIZE;
+				if (vout->pix.height % TILE_SIZE)
+					image_height++;
+				image_height =3D image_height * TILE_SIZE;
+
+				/* Required to free */
+				vout->tile_aligned_psize =3D image_width *
image_height * vout->bpp * vout->vrfb_bpp;
+
+				/* have to free and re-allocate */
+				if (vout->smsshado_size &&
vout->smsshado_size < vout->tile_aligned_psize) {
+					dma_free_coherent(NULL,
vout->smsshado_size,
+						(void
*)vout->smsshado_virt_addr,
+
(dma_addr_t)vout->smsshado_phy_addr);
+					vout->smsshado_size =3D 0;
+					vout->smsshado_virt_addr =3D 0;
+				}
+
+				/* Allocate the actual physical space
for VRFB */
+				/*
+				 * The allocation is rounded to tile
size as we are
+				 * taking care of the offset while
reading the data
+				 * and also we will always fill the 0
degree space with
+				 * the image data and read the data
requested space (rotation degree)
+				 */
+				if (!vout->smsshado_virt_addr)
+				vout->smsshado_virt_addr =3D (unsigned
int)
+					dma_alloc_coherent(NULL,
PAGE_ALIGN(vout->tile_aligned_psize),
+						(dma_addr_t *)
&vout->smsshado_phy_addr, GFP_KERNEL | GFP_DMA);
+
+				if (!vout->smsshado_virt_addr)
+					return -ENOMEM;
+
+				vout->smsshado_size =3D
PAGE_ALIGN(vout->tile_aligned_psize);
+				memset((void *)
vout->smsshado_virt_addr, 0, vout->smsshado_size);
+
+				if (vout->rotation =3D=3D 90 ||
vout->rotation =3D=3D 270) {
+					omap2_disp_set_vrfb (vout->vid,
vout->smsshado_phy_addr,
+						vout->pix.height,
vout->pix.width, vout->bpp * vout->vrfb_bpp);
+				}
+				else{
+					omap2_disp_set_vrfb (vout->vid,
vout->smsshado_phy_addr,
+						vout->pix.width,
vout->pix.height, vout->bpp * vout->vrfb_bpp);
+				}
+			}
+		}
+
+		/* set flag here. Next QBUF will start DMA */
+		vout->streaming =3D fh;
+
+		/* DMA will be started by QBUF */
+		omap2_disp_config_vlayer (vout->vid, &vout->pix,
&vout->crop,
+				  &vout->win, vout->rotation,
vout->mirror);
+		return 0;
+	}
+
+	case VIDIOC_STREAMOFF:
+	{
+		/*
+		 * only allow the file handler that started streaming to
+		 * stop streaming
+		 */
+
+		if (vout->streaming =3D=3D fh) {
+			omap2_disp_disable_layer (vout->vid);
+			vout->streaming =3D NULL;
+
+			/* stop the slave layer */
+			if (vout_linked !=3D -1 && vout_linked !=3D
vout->vid) {
+				omap2_disp_disable_layer ((vout->vid =3D=3D
OMAP2_VIDEO1)
+					  ? OMAP2_VIDEO2 :
OMAP2_VIDEO1);
+			}
+			return 0;
+		}
+		else
+			return -EINVAL;
+	}
+
+
+	case VIDIOC_S_OMAP2_LINK:
+	{
+		int *link =3D arg;
+
+		spin_lock (&vout_link_lock);
+
+		if ((*link =3D=3D 0) && (vout_linked =3D=3D vout->vid))
+			vout_linked =3D -1;
+
+		if ((*link =3D=3D 1) && (vout_linked =3D=3D -1 || vout_linked =3D=3D
vout->vid)) {
+			vout_linked =3D vout->vid;
+
+			if (vout_linked =3D=3D OMAP2_VIDEO2) {
+				/* sync V2 to V1 for img and crop */
+				omap24xxvout_sync (saved_v2out,
saved_v1out);
+			}
+			else{
+				/* sync V1 to V2 */
+				omap24xxvout_sync (saved_v1out,
saved_v2out);
+			}
+		}
+
+		spin_unlock (&vout_link_lock);
+		return 0;
+	}
+	case VIDIOC_G_OMAP2_LINK:
+	{
+		int *link =3D arg;
+
+		spin_lock (&vout_link_lock);
+		if (vout_linked =3D=3D vout->vid) *link =3D 1;
+		else *link =3D 0;
+		spin_unlock (&vout_link_lock);
+		return 0;
+	}
+	case VIDIOC_S_OMAP2_MIRROR:
+	{
+		int *mirror =3D arg;
+		if ((*mirror =3D=3D 0) && (vout->mirror =3D=3D 1)) {
+			vout->mirror =3D 0;
+			return 0;
+		}
+		else if ((*mirror =3D=3D 1) && (vout->mirror =3D=3D 0)) {
+			vout->mirror =3D 1;
+			return 0;
+		}
+		return -EINVAL;
+	}
+	case VIDIOC_G_OMAP2_MIRROR:
+	{
+		int *mirror =3D arg;
+		*mirror =3D vout->mirror;
+		return 0;
+	}
+
+	case VIDIOC_S_OMAP2_ROTATION:
+	{
+		int *rotation =3D arg;
+
+		if ((*rotation =3D=3D 0) || (*rotation =3D=3D 90) || (*rotation
=3D=3D 180)
+			|| (*rotation =3D=3D 270) || (*rotation =3D=3D -1)) {
+			vout->rotation =3D (*rotation =3D=3D
90)?270:(*rotation =3D=3D 270)?90:*rotation;
+			rotation_support =3D vout->rotation;
+			return 0;
+		}
+		else
+			return -EINVAL;
+	}
+
+	case VIDIOC_G_OMAP2_ROTATION:
+	{
+		int *rotation =3D arg;
+		*rotation =3D (vout->rotation =3D=3D 90)?270:(vout->rotation
=3D=3D 270)?90:vout->rotation;
+		return 0;
+	}
+	case VIDIOC_S_OMAP2_COLORKEY:
+	{
+		struct omap24xxvout_colorkey *colorkey =3D
+		(struct omap24xxvout_colorkey *) arg;
+
+		if ((colorkey->output_dev !=3D OMAP2_OUTPUT_LCD &&
+			colorkey->output_dev !=3D OMAP2_OUTPUT_TV) ||
+			(colorkey->key_type !=3D OMAP2_GFX_DESTINATION
+			&& colorkey->key_type !=3D OMAP2_VIDEO_SOURCE))
+			return -EINVAL;
+
+		omap2_disp_set_colorkey (colorkey->output_dev,
colorkey->key_type,
+			colorkey->key_val);
+		return 0;
+
+	}
+	case VIDIOC_G_OMAP2_COLORKEY:
+	{
+		struct omap24xxvout_colorkey *colorkey =3D
+		(struct omap24xxvout_colorkey *) arg;
+
+		if (colorkey->output_dev !=3D OMAP2_OUTPUT_LCD
+			&& colorkey->output_dev !=3D OMAP2_OUTPUT_TV)
+		return -EINVAL;
+		omap2_disp_get_colorkey (colorkey->output_dev,
&colorkey->key_type,
+				 &colorkey->key_val);
+		return 0;
+
+	}
+	case VIDIOC_S_OMAP2_BGCOLOR:
+	{
+		struct omap24xxvout_bgcolor *bgcolor =3D
+		(struct omap24xxvout_bgcolor *) arg;
+
+		if (bgcolor->output_dev !=3D OMAP2_OUTPUT_LCD
+			&& bgcolor->output_dev !=3D OMAP2_OUTPUT_TV)
+			return -EINVAL;
+
+		omap2_disp_set_bg_color (bgcolor->output_dev,
bgcolor->color);
+		return 0;
+	}
+	case VIDIOC_G_OMAP2_BGCOLOR:
+	{
+		struct omap24xxvout_bgcolor *bgcolor =3D
+			(struct omap24xxvout_bgcolor *) arg;
+
+		if (bgcolor->output_dev !=3D OMAP2_OUTPUT_LCD
+			&& bgcolor->output_dev !=3D OMAP2_OUTPUT_TV)
+		return -EINVAL;
+
+		omap2_disp_get_bg_color (bgcolor->output_dev,
&bgcolor->color);
+		return 0;
+	}
+	case VIDIOC_OMAP2_COLORKEY_ENABLE:
+	{
+		int *output_dev =3D arg;
+
+		if (*output_dev !=3D OMAP2_OUTPUT_LCD && *output_dev !=3D
OMAP2_OUTPUT_TV)
+		return -EINVAL;
+
+		omap2_disp_enable_colorkey (*output_dev);
+		return 0;
+	}
+
+	case VIDIOC_OMAP2_COLORKEY_DISABLE:
+	{
+		int *output_dev =3D arg;
+
+		if (*output_dev !=3D OMAP2_OUTPUT_LCD && *output_dev !=3D
OMAP2_OUTPUT_TV)
+			return -EINVAL;
+		omap2_disp_disable_colorkey (*output_dev);
+		return 0;
+	}
+
+	case VIDIOC_S_OMAP2_COLORCONV:
+	{
+		int v;
+		struct omap24xxvout_colconv *ccmtx =3D
+			(struct omap24xxvout_colconv *) arg;
+
+		if (vout->vid =3D=3D OMAP2_VIDEO1) v =3D0;
+		else v =3D1;
+
+		current_colorconv_values[v][0][0]=3Dccmtx->RY;
+		current_colorconv_values[v][0][1]=3Dccmtx->RCr;
+		current_colorconv_values[v][0][2]=3Dccmtx->RCb;
+		current_colorconv_values[v][1][0]=3Dccmtx->GY;
+		current_colorconv_values[v][1][1]=3Dccmtx->GCr;
+		current_colorconv_values[v][1][2]=3Dccmtx->GCb;
+		current_colorconv_values[v][2][0]=3Dccmtx->BY;
+		current_colorconv_values[v][2][1]=3Dccmtx->BCr;
+		current_colorconv_values[v][2][2]=3Dccmtx->BCb;
+		omap2_disp_set_colorconv(vout->vid, &vout->pix);
+		return 0;
+	}
+
+	case VIDIOC_G_OMAP2_COLORCONV:
+	{
+		int v;
+		struct omap24xxvout_colconv *ccmtx =3D
+			(struct omap24xxvout_colconv *) arg;
+
+		if (vout->vid =3D=3D OMAP2_VIDEO1) v =3D0;
+		else v =3D1;
+
+		ccmtx->RY =3D current_colorconv_values[v][0][0];
+		ccmtx->RCr=3D current_colorconv_values[v][0][1];
+		ccmtx->RCb=3D current_colorconv_values[v][0][2];
+		ccmtx->GY =3D current_colorconv_values[v][1][0];
+		ccmtx->GCr=3D current_colorconv_values[v][1][1];
+		ccmtx->GCb=3D current_colorconv_values[v][1][2];
+		ccmtx->BY =3D current_colorconv_values[v][2][0];
+		ccmtx->BCr=3D current_colorconv_values[v][2][1];
+		ccmtx->BCb=3D current_colorconv_values[v][2][2];
+
+		return 0;
+	}
+
+	case VIDIOC_S_OMAP2_DEFCOLORCONV:
+	{
+		omap2_disp_set_default_colorconv(vout->vid, &vout->pix);
+		return 0;
+	}
+
+	default:
+		/* unrecognized ioctl */
+		return -ENOIOCTLCMD;
+
+	}				/* switch */
+
+	return 0;
+}
+
+/*
------------------------------------------------------------------------
-- */
+
+/*
+ *  file operations
+ */
+
+#ifdef DEBUG_ALLOW_WRITE
+
+static ssize_t
+omap24xxvout_write (struct file *file, const char *data, size_t count,
+			loff_t * ppos)
+{
+	struct omap24xxvout_fh *fh =3D file->private_data;
+	struct omap24xxvout_device *vout =3D fh->vout;
+
+	omap24xxvout_suspend_lockout (vout, file);
+	if ((*ppos) >=3D vout->pix.sizeimage)
+		return 0;
+	if (count + (*ppos) > vout->pix.sizeimage)
+		count =3D vout->pix.sizeimage - (*ppos);
+	if (copy_from_user
+		((void *) (vout->framebuffer_base + (*ppos)), data,
count)) {
+		printk ("error in copying data");
+	}
+	*ppos +=3D count;
+
+	#if 1
+		if (*ppos =3D=3D vout->pix.sizeimage)
+		mdelay (5000);
+	#endif
+	return count;
+}
+
+#endif
+
+static void
+omap24xxvout_vm_open (struct vm_area_struct *vma)
+{
+	struct omap24xxvout_device *vout =3D vma->vm_private_data;
+	DPRINTK ("vm_open [vma=3D%08lx-%08lx]\n", vma->vm_start,
vma->vm_end);
+	vout->mmap_count++;
+}
+
+static void
+omap24xxvout_vm_close (struct vm_area_struct *vma)
+{
+	struct omap24xxvout_device *vout =3D vma->vm_private_data;
+	DPRINTK ("vm_close [vma=3D%08lx-%08lx]\n", vma->vm_start,
vma->vm_end);
+	vout->mmap_count--;
+}
+
+static struct vm_operations_struct omap24xxvout_vm_ops =3D {
+	.open	=3D omap24xxvout_vm_open,
+	.close	=3D omap24xxvout_vm_close,
+};
+
+static int
+omap24xxvout_mmap (struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxvout_fh *fh =3D file->private_data;
+	struct omap24xxvout_device *vout =3D fh->vout;
+	struct videobuf_queue *q =3D &fh->vbq;
+	int size, i;
+
+	DPRINTK ("pgoff=3D0x%x, start=3D0x%x, end=3D0x%x\n", vma->vm_pgoff,
+		vma->vm_start,	vma->vm_end);
+
+	size =3D vma->vm_end - vma->vm_start;
+
+	down (&q->lock);
+
+	/* look for the buffer to map */
+	for (i =3D 0; i < VIDEO_MAX_FRAME; i++) {
+		if (NULL =3D=3D q->bufs[i])	continue;
+		if (V4L2_MEMORY_MMAP !=3D q->bufs[i]->memory)
+			continue;
+		if (q->bufs[i]->boff =3D=3D (vma->vm_pgoff << PAGE_SHIFT))
+			break;
+	}
+
+	if (VIDEO_MAX_FRAME =3D=3D i) {
+		DPRINTK ("offset invalid [offset=3D0x%lx]\n",
+			(vma->vm_pgoff << PAGE_SHIFT));
+		up (&q->lock);
+		return -EINVAL;
+	}
+
+	vma->vm_flags |=3D VM_RESERVED;
+	vma->vm_page_prot =3D pgprot_writecombine (vma->vm_page_prot);
+	vma->vm_ops =3D &omap24xxvout_vm_ops;
+	vma->vm_private_data =3D (void *) vout;
+
+	if (remap_pfn_range(vma, vma->vm_start,
+		q->bufs[i]->dma.bus_addr>>PAGE_SHIFT, size,
vma->vm_page_prot)) {
+		up (&q->lock);
+		return -EAGAIN;
+	}
+	vma->vm_flags &=3D ~VM_IO; /* using shared anonymous pages */
+
+	up (&q->lock);
+	vout->mmap_count++;
+	return 0;
+}
+
+static int
+omap24xxvout_ioctl (struct inode *inode, struct file *file, unsigned
int cmd,
+			unsigned long arg)
+{
+	struct omap24xxvout_fh *fh =3D file->private_data;
+	struct omap24xxvout_device *vout =3D fh->vout;
+
+	omap24xxvout_suspend_lockout (vout, file);
+	return video_usercopy (inode, file, cmd, arg,
omap24xxvout_do_ioctl);
+}
+
+static int
+omap24xxvout_release (struct inode *inode, struct file *file)
+{
+	struct omap24xxvout_fh *fh =3D file->private_data;
+	struct omap24xxvout_device *vout;
+	struct videobuf_queue *q;
+
+	DPRINTK ("entering\n");
+
+	if (fh =3D=3D 0)
+		return 0;
+	if ((vout =3D fh->vout) =3D=3D 0)
+		return 0;
+	q =3D &fh->vbq;
+
+	omap24xxvout_suspend_lockout (vout, file);
+
+	/*
+	 * Check if the hidden buffer transfer is happening with DMA
+	 * if yes then stop it
+	 */
+
+	if (vout->rotation !=3D -1) {
+		if (vout->vrfb_dma_tx.tx_status =3D=3D 0) {
+
+			/*
+			 * DMA will be stopped once here and again after
wakeup to
+			 * avoid race conditions due to time taken to
wakeup the
+			 * sleeping process
+			 */
+
+			omap_stop_dma (vout->vrfb_dma_tx.dma_ch);
+			wake_up_interruptible(&vout->vrfb_dma_tx.wait);
+		}
+	}
+
+	omap2_disp_disable_layer (vout->vid);
+
+	if ((vout_linked !=3D -1) && (vout->vid !=3D vout_linked))
+	omap2_disp_disable_layer ((vout->vid =3D=3D
+					OMAP2_VIDEO1) ? OMAP2_VIDEO2 :
OMAP2_VIDEO1);
+
+#ifdef DEBUG_ALLOW_WRITE
+	if (vout->framebuffer_base) {
+
+		dma_free_coherent(NULL, vout->framebuffer_size,
+					(void *) vout->framebuffer_base,
+					vout->framebuffer_base_phys);
+		vout->framebuffer_base =3D 0;
+	}
+	vout->framebuffer_base_phys =3D 0;
+#endif
+
+	if (vout->streaming =3D=3D fh) vout->streaming =3D NULL;
+
+	if (vout->mmap_count !=3D 0) {
+		vout->mmap_count =3D 0;
+		printk("mmap count is not zero!\n");
+	}
+
+	omap2_disp_release_layer (vout->vid);
+	omap2_disp_put_dss ();
+	vout->opened -=3D 1;
+	file->private_data =3D NULL;
+
+	if (vout->buffer_allocated)
+		videobuf_mmap_free(q);
+
+	kfree (fh);
+
+	/* need to remove the link when the either slave or master is
gone */
+	spin_lock (&vout_link_lock);
+	if (vout_linked !=3D -1) {
+		vout_linked =3D -1;
+	}
+	spin_unlock (&vout_link_lock);
+
+	return 0;
+}
+
+/* define this to allow videobuf_mmap_free to work */
+static void dummy_vbq_release(struct videobuf_queue *q, struct
videobuf_buffer *vb)
+{
+}
+static int
+omap24xxvout_open (struct inode *inode, struct file *file)
+{
+	int minor =3D MINOR (file->f_dentry->d_inode->i_rdev);
+	struct omap24xxvout_device *vout =3D NULL;
+	struct omap24xxvout_fh *fh;
+	struct videobuf_queue *q;
+	int i;
+
+	DPRINTK ("entering\n");
+
+	if (saved_v1out && saved_v1out->vfd && (saved_v1out->vfd->minor
=3D=3D minor)) {
+		vout =3D saved_v1out;
+	}
+
+	if (vout =3D=3D NULL) {
+		if (saved_v2out && saved_v2out->vfd
+			&& (saved_v2out->vfd->minor =3D=3D minor)) {
+		vout =3D saved_v2out;
+		}
+	}
+
+	if (vout =3D=3D NULL)
+		return -ENODEV;
+
+	/* for now, we only support single open */
+	if (vout->opened)
+		return -EBUSY;
+
+	vout->opened +=3D 1;
+	if (!omap2_disp_request_layer (vout->vid)) {
+		vout->opened -=3D 1;
+		return -ENODEV;
+	}
+
+	omap2_disp_get_dss ();
+	omap24xxvout_suspend_lockout (vout, file);
+	/* allocate per-filehandle data */
+	fh =3D kmalloc (sizeof (*fh), GFP_KERNEL);
+	if (NULL =3D=3D fh) {
+		omap2_disp_release_layer (vout->vid);
+		omap2_disp_put_dss ();
+		vout->opened -=3D 1;
+		return -ENOMEM;
+	}
+
+	file->private_data =3D fh;
+	fh->vout =3D vout;
+	fh->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT;
+
+#ifdef DEBUG_ALLOW_WRITE
+	vout->framebuffer_size =3D VGA_HEIGHT * VGA_HEIGHT * 2;
+	vout->framebuffer_base =3D
dma_alloc_coherent(NULL,vout->framebuffer_size,
+			(dma_addr_t *) & vout->	framebuffer_base_phys,
+			GFP_KERNEL | GFP_DMA);
+
+	if (!vout->framebuffer_base) {
+		kfree (fh);
+		omap2_disp_release_layer (vout->vid);
+		omap2_disp_put_dss ();
+		vout->opened -=3D 1;
+		return -ENOMEM;
+	}
+	memset ((void *) vout->framebuffer_base, 0,
vout->framebuffer_size);
+		omap2_disp_config_vlayer (vout->vid, &vout->pix,
&vout->crop, &vout->win,
+		vout->rotation, vout->mirror);
+	omap2_disp_start_vlayer (vout->vid, &vout->pix, &vout->crop,
+		vout->framebuffer_base_phys, vout->rotation,
+		vout->mirror);
+#endif
+
+	q =3D &fh->vbq;
+	dummy_vbq_ops.buf_release =3D dummy_vbq_release;
+	videobuf_queue_init (q, &dummy_vbq_ops, NULL, &vout->vbq_lock,
+		fh->type, V4L2_FIELD_NONE, sizeof (struct
videobuf_buffer), fh);
+
+	/* restore info for mmap */
+	for (i =3D 0; i < vout->buffer_allocated; i++) {
+		q->bufs[i] =3D videobuf_alloc (q->msize);
+		if (q->bufs[i] =3D=3D NULL) {
+			dma_free_coherent(NULL, vout->buffer_size,
+					(void *) vout->buf_virt_addr[i],
+					(dma_addr_t)
vout->buf_phy_addr[i]);
+			/* we have to give up some old buffers */
+			vout->buffer_allocated =3D i;
+			break;
+		}
+		q->bufs[i]->i =3D i;
+		q->bufs[i]->input =3D UNSET;
+		q->bufs[i]->memory =3D vout->buf_memory_type;
+		q->bufs[i]->bsize =3D vout->buffer_size;
+		q->bufs[i]->boff =3D vout->buffer_size * i;
+		q->bufs[i]->dma.vmalloc =3D (void *)
vout->buf_virt_addr[i];
+		q->bufs[i]->dma.bus_addr =3D vout->buf_phy_addr[i];
+		q->bufs[i]->state =3D STATE_PREPARED;
+	}
+
+	return 0;
+}
+
+static struct file_operations omap24xxvout_fops =3D {
+	.owner	=3D THIS_MODULE,
+	.llseek	=3D no_llseek,
+#ifdef DEBUG_ALLOW_WRITE
+	.write	=3D omap24xxvout_write,
+#endif
+	.ioctl	=3D omap24xxvout_ioctl,
+	.mmap	=3D omap24xxvout_mmap,
+	.open	=3D omap24xxvout_open,
+	.release	=3D omap24xxvout_release,
+};
+
+/*
------------------------------------------------------------------------
-- */
+#ifdef CONFIG_PM
+static int
+omap24xxvout_suspend (struct omap_dev *dev, u32 state)
+{
+	struct omap24xxvout_device *vout =3D omap_get_drvdata (dev);
+
+	/* lock-out applications during suspend */
+	if (vout->suspended =3D=3D 1) return 0;
+	if (vout->opened) {
+		/* stall vid DMA */
+		if (vout->streaming) {
+			omap2_disp_disable_layer (vout->vid);
+			/*
+			 * Check if the hidden buffer transfer is
happening with DMA
+			 * if yes then stop it
+			 */
+
+			if (vout->rotation !=3D -1) {
+				if (vout->vrfb_dma_tx.tx_status =3D=3D 0) {
+					/*
+					 * DMA will be stopped once here
and again after wakeup to
+					 * avoid race conditions due to
time taken to wakeup the
+				 	 * sleeping process
+				 	 */
+					omap_stop_dma
(vout->vrfb_dma_tx.dma_ch);
+					wake_up_interruptible
(&vout->vrfb_dma_tx.wait);
+				}
+			}
+		}
+		vout->suspended =3D 1;
+		omap2_disp_put_dss ();
+	}
+	return 0;
+}
+
+static int
+omap24xxvout_resume (struct omap_dev *dev)
+{
+	struct omap24xxvout_device *vout =3D omap_get_drvdata (dev);
+	if (vout->suspended =3D=3D 0) return 0;
+	if (vout->opened)
+	{
+		omap2_disp_get_dss ();
+
+		/* resume vid DMA */
+		if (vout->streaming)
+			omap2_disp_enable_layer (vout->vid);
+
+		/* wake up applications waiting on suspend queue */
+		vout->suspended =3D 0;
+		wake_up (&vout->suspend_wq);
+	}
+	return 0;
+}
+
+
+#ifdef CONFIG_DPM
+
+static struct constraints omap24xxvout_constraints =3D {
+	.count	=3D 2,
+	.param =3D {
+		{DPM_MD_V, OMAP24XX_V_MIN, OMAP24XX_V_MAX},
+		{DPM_MD_SLEEP_MODE, PM_SUSPEND_STANDBY, PM_SUSPEND_MEM},
+	},
+};
+
+static int
+omap24xxvout_scale (int vid, struct notifier_block *op, unsigned long
level)
+{
+	struct omap24xxvout_device *vout;
+	vout =3D (vid =3D=3D OMAP2_VIDEO1) ? saved_v1out : saved_v2out;
+	if (!vout->opened)
+		return 0;
+	switch (level) {
+	case SCALE_PRECHANGE:
+		if (vout->streaming) {
+			omap2_disp_disable_layer (vout->vid);
+			if (vout->rotation !=3D -1) {
+				if (vout->vrfb_dma_tx.tx_status =3D=3D 0) {
+					omap_stop_dma
(vout->vrfb_dma_tx.dma_ch);
+				}
+			}
+		}
+	break;
+	case SCALE_POSTCHANGE:
+		if (vout->streaming) {
+			omap2_disp_enable_layer (vout->vid);
+			if (vout->rotation !=3D -1) {
+				if (vout->vrfb_dma_tx.tx_status =3D=3D 0) {
+					omap_start_dma
(vout->vrfb_dma_tx.dma_ch);
+				}
+			}
+		}
+	break;
+	}
+	return 0;
+}
+
+static int
+omap24xxv1out_scale (struct notifier_block *op, unsigned long level,
void *ptr)
+{
+	return omap24xxvout_scale (OMAP2_VIDEO1, op, level);
+}
+
+static int
+omap24xxv2out_scale (struct notifier_block *op, unsigned long level,
void *ptr)
+{
+	return omap24xxvout_scale (OMAP2_VIDEO2, op, level);
+}
+
+static struct notifier_block omap24xxv1out_pre_scale =3D {
+	.notifier_call	=3D omap24xxv1out_scale,
+};
+
+static struct notifier_block omap24xxv1out_post_scale =3D {
+	.notifier_call	=3D omap24xxv1out_scale,
+};
+
+static struct notifier_block omap24xxv2out_pre_scale =3D {
+	.notifier_call	=3D omap24xxv2out_scale,
+};
+
+static struct notifier_block omap24xxv2out_post_scale =3D {
+	.notifier_call	=3D omap24xxv2out_scale,
+};
+
+#endif
+#endif /* PM */
+
+static int
+omap24xxvout_probe (struct omap_dev *dev)
+{
+	return 0;
+}
+
+static struct omap_dev omap24xxv1out_dev =3D {
+	.name	=3D V1OUT_NAME,
+	.devid	=3D OMAP24xx_V1OUT_DEVID,
+	.busid	=3D OMAP_BUS_L3,
+	.dev =3D {
+#ifdef CONFIG_DPM
+		.constraints	=3D &omap24xxvout_constraints,
+#endif
+	},
+};
+
+static struct omap_dev omap24xxv2out_dev =3D {
+	.name	=3D V2OUT_NAME,
+	.devid	=3D OMAP24xx_V2OUT_DEVID,
+	.busid	=3D OMAP_BUS_L3,
+	.dev =3D {
+#ifdef CONFIG_DPM
+		.constraints	=3D &omap24xxvout_constraints,
+#endif
+	},
+};
+
+static struct omap_driver omap24xxv1out_driver =3D {
+	.drv =3D {
+		.name =3D V1OUT_NAME
+	},
+	.devid		=3D OMAP24xx_V1OUT_DEVID,
+	.busid		=3D OMAP_BUS_L3,
+	.clocks		=3D 0,
+	.probe		=3D omap24xxvout_probe,
+#ifdef CONFIG_PM
+	.suspend	=3D omap24xxvout_suspend,
+	.resume		=3D omap24xxvout_resume,
+#endif
+};
+
+static struct omap_driver omap24xxv2out_driver =3D {
+	.drv =3D {
+		.name =3D V2OUT_NAME
+	},
+	.devid		=3D OMAP24xx_V2OUT_DEVID,
+	.busid		=3D OMAP_BUS_L3,
+	.clocks		=3D 0,
+	.probe		=3D omap24xxvout_probe,
+#ifdef CONFIG_PM
+	.suspend	=3D omap24xxvout_suspend,
+	.resume		=3D omap24xxvout_resume,
+#endif
+};
+
+/*
------------------------------------------------------------------------
-- */
+
+static void
+cleanup_vout_device (int vid)
+{
+	struct video_device *vfd;
+	struct omap24xxvout_device *vout;
+
+	vout =3D (vid =3D=3D OMAP2_VIDEO1) ? saved_v1out : saved_v2out;
+	if (!vout)
+		return;
+	vfd =3D vout->vfd;
+
+	if (vfd) {
+		if (vfd->minor =3D=3D -1) {
+			/*
+			 * The device was never registered, so release
the
+			 * video_device struct directly.
+			 */
+			video_device_release (vfd);
+		}
+		else{
+			/*
+			 * The unregister function will release the
video_device
+			 * struct as well as unregistering it.
+			 */
+			video_unregister_device (vfd);
+		}
+	}
+
+	if (vout->rotation !=3D -1) {
+		release_mem_region (vout->sms_rot_phy[3], VRF_SIZE);
+		release_mem_region (vout->sms_rot_phy[2], VRF_SIZE);
+		release_mem_region (vout->sms_rot_phy[1], VRF_SIZE);
+		release_mem_region (vout->sms_rot_phy[0], VRF_SIZE);
+	}
+
+	if (vout->vrfb_dma_tx.req_status =3D=3D DMA_CHAN_ALLOTED) {
+		vout->vrfb_dma_tx.req_status =3D DMA_CHAN_NOT_ALLOTED;
+		omap_free_dma (vout->vrfb_dma_tx.dma_ch);
+	}
+
+	omap_device_unregister ((vid =3D=3D	OMAP2_VIDEO1) ?
&omap24xxv1out_dev :
+		&omap24xxv2out_dev);
+	omap_driver_unregister ((vid =3D=3D OMAP2_VIDEO1) ?
&omap24xxv1out_driver :
+		&omap24xxv2out_driver);
+
+#ifdef CONFIG_DPM
+	if (vid =3D=3D OMAP2_VIDEO1) {
+
dpm_unregister_scale(&omap24xxv1out_pre_scale,SCALE_PRECHANGE);
+
dpm_unregister_scale(&omap24xxv1out_post_scale,SCALE_POSTCHANGE);
+	}
+	else{
+
dpm_unregister_scale(&omap24xxv2out_pre_scale,SCALE_PRECHANGE);
+
dpm_unregister_scale(&omap24xxv2out_pre_scale,SCALE_POSTCHANGE);
+	}
+#endif
+
+	kfree (vout);
+
+	if (vid =3D=3D OMAP2_VIDEO1)
+		saved_v1out =3D NULL;
+	else
+		saved_v2out =3D NULL;
+}
+
+static struct omap24xxvout_device *
+init_vout_device (int vid)
+{
+	int r;
+	struct omap24xxvout_device *vout;
+	struct video_device *vfd;
+	struct v4l2_pix_format *pix;
+	struct omap_driver *this_driver;
+	struct omap_dev *this_dev;
+
+	vout =3D kmalloc (sizeof (struct omap24xxvout_device),
GFP_KERNEL);
+	if (!vout) {
+		printk (KERN_ERR VOUT_NAME ": could not allocate
memory\n");
+		return NULL;
+	}
+
+	memset (vout, 0, sizeof (struct omap24xxvout_device));
+	vout->vid =3D vid;
+	vout->rotation =3D rotation_support;
+
+	/* set the default pix */
+	pix =3D &vout->pix;
+	pix->width =3D QQVGA_WIDTH;
+	pix->height =3D QQVGA_HEIGHT;
+
+	pix->pixelformat =3D V4L2_PIX_FMT_RGB565;
+	pix->field =3D V4L2_FIELD_NONE;
+	pix->bytesperline =3D pix->width * 2;
+	pix->sizeimage =3D pix->bytesperline * pix->height;
+	pix->priv =3D 0;
+	pix->colorspace =3D V4L2_COLORSPACE_JPEG;
+
+	vout->bpp =3D RGB565_BPP;
+	vout->vrfb_bpp =3D 1;
+
+	/* get the screen parameters */
+	omap2_disp_get_panel_size (omap2_disp_get_output_dev
(vout->vid),
+		&(vout->fbuf.fmt.width),&(vout->fbuf.fmt.height));
+
+	/* set default crop and win */
+	omap24xxvout_new_format (pix, &vout->fbuf, &vout->crop,
&vout->win);
+
+	/* initialize the video_device struct */
+	vfd =3D vout->vfd =3D video_device_alloc ();
+	if (!vfd) {
+		printk (KERN_ERR VOUT_NAME": could not allocate video
device struct\n");
+		kfree (vout);
+		return NULL;
+	}
+	vfd->release =3D video_device_release;
+
+	strncpy (vfd->name, VOUT_NAME, sizeof (vfd->name));
+	vfd->type =3D VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
+	/* need to register for a VID_HARDWARE_* ID in videodev.h */
+	vfd->hardware =3D 0;
+	vfd->fops =3D &omap24xxvout_fops;
+	video_set_drvdata (vfd, vout);
+	vfd->minor =3D -1;
+
+	/* SMS memory starts from 0x70000000 - 256 MB region */
+	vout->sms_rot_phy[0] =3D (vid =3D=3D OMAP2_VIDEO1) ? 0x74000000 :
0x78000000;
+	vout->sms_rot_phy[1] =3D (vid =3D=3D OMAP2_VIDEO1) ? 0x75000000 :
0x79000000;
+	vout->sms_rot_phy[2] =3D (vid =3D=3D OMAP2_VIDEO1) ? 0x76000000 :
0x7A000000;
+	vout->sms_rot_phy[3] =3D (vid =3D=3D OMAP2_VIDEO1) ? 0x77000000 :
0x7B000000;
+
+	/* let's request memory region for them */
+	/* request the mem region for the SMS space */
+	if (!request_mem_region (vout->sms_rot_phy[0], VRF_SIZE,
vfd->name)) {
+		printk (KERN_ERR VOUT_NAME": cannot reserve sms I/O
region - 0 \n");
+		goto init_error;
+	}
+	if (!request_mem_region (vout->sms_rot_phy[1], VRF_SIZE,
vfd->name)) {
+		printk (KERN_ERR VOUT_NAME ": cannot reserve sms I/O
region - 1\n");
+		goto rotation_sms_free_0;
+	}
+	if (!request_mem_region (vout->sms_rot_phy[2], VRF_SIZE,
vfd->name)) {
+		printk (KERN_ERR VOUT_NAME ": cannot reserve sms I/O
region - 2\n");
+		goto rotation_sms_free_90;
+	}
+	if (!request_mem_region (vout->sms_rot_phy[3], VRF_SIZE,
vfd->name)) {
+		printk (KERN_ERR VOUT_NAME ": cannot reserve sms I/O
region - 3\n");
+		goto rotation_sms_free_180;
+		/* free them in reverse order - otherewise you will free
+			extra stuff and get caught */
+	}
+
+	vout->suspended =3D 0;
+	init_waitqueue_head (&vout->suspend_wq);
+
+	if (video_register_device (vfd, VFL_TYPE_GRABBER, vid) < 0) {
+		printk (KERN_ERR VOUT_NAME": could not register Video
for Linux device\n");
+		vfd->minor =3D -1;
+		if (vout->rotation !=3D -1)
+			goto rotation_sms_free_270;
+		else
+			goto init_error;
+	}
+
+	this_driver =3D (vid =3D=3D OMAP2_VIDEO1) ? &omap24xxv1out_driver :
&omap24xxv2out_driver;
+	this_dev =3D (vid =3D=3D OMAP2_VIDEO1) ? &omap24xxv1out_dev :
&omap24xxv2out_dev;
+	if (omap_driver_register (this_driver) !=3D 0) {
+		printk (KERN_ERR VOUT_NAME": could not register Video
driver\n");
+		cleanup_vout_device (vid);
+		return NULL;
+	}
+	if (omap_device_register (this_dev) !=3D 0) {
+		printk (KERN_ERR VOUT_NAME": could not register Video
device\n");
+		cleanup_vout_device (vid);
+		return NULL;
+	}
+	/* set driver specific data to use in power mgmt functions */
+	omap_set_drvdata (this_dev, vout);
+
+#ifdef CONFIG_DPM
+	/* Scaling is enabled only when DPM is enabled */
+	if (vid =3D=3D OMAP2_VIDEO1) {
+
dpm_register_scale(&omap24xxv1out_pre_scale,SCALE_PRECHANGE);
+
dpm_register_scale(&omap24xxv1out_post_scale,SCALE_POSTCHANGE);
+	}
+	else{
+
dpm_register_scale(&omap24xxv2out_pre_scale,SCALE_PRECHANGE);
+
dpm_register_scale(&omap24xxv2out_post_scale,SCALE_POSTCHANGE);
+	}
+#endif
+
+	/*
+	 * Request and Initialize DMA, for DMA based VRFB transfer
+	 */
+	vout->vrfb_dma_tx.dev_id =3D OMAP_DMA_NO_DEVICE;
+	vout->vrfb_dma_tx.dma_ch =3D -1;
+	vout->vrfb_dma_tx.req_status =3D DMA_CHAN_ALLOTED;
+	r =3D omap_request_dma (vout->vrfb_dma_tx.dev_id,
+		"VRFB DMA TX", vrfb_dma_tx_callback,(void *)
&vout->vrfb_dma_tx,
+			&vout->vrfb_dma_tx.dma_ch);
+	if (r)
+		vout->vrfb_dma_tx.req_status =3D DMA_CHAN_NOT_ALLOTED;
+	init_waitqueue_head (&vout->vrfb_dma_tx.wait);
+
+	/*if rotation support */
+	printk (KERN_INFO VOUT_NAME ": registered device video%d
[v4l2]\n",
+		vfd->minor);
+	return vout;
+
+rotation_sms_free_270:
+	release_mem_region (vout->sms_rot_phy[3], VRF_SIZE);
+rotation_sms_free_180:
+	release_mem_region (vout->sms_rot_phy[2], VRF_SIZE);
+rotation_sms_free_90:
+	release_mem_region (vout->sms_rot_phy[1], VRF_SIZE);
+rotation_sms_free_0:
+	release_mem_region (vout->sms_rot_phy[0], VRF_SIZE);
+
+init_error:
+	video_device_release (vfd);
+	kfree (vout);
+	return NULL;
+}
+
+static int __init
+omap24xxvout_init (void)
+{
+	saved_v1out =3D init_vout_device (OMAP2_VIDEO1);
+	if (saved_v1out =3D=3D NULL)
+		return -ENODEV;
+	omap2_disp_save_initstate(OMAP2_VIDEO1);
+
+	saved_v2out =3D init_vout_device (OMAP2_VIDEO2);
+	if (saved_v2out =3D=3D NULL) {
+		cleanup_vout_device (OMAP2_VIDEO1);
+		return -ENODEV;
+	}
+	omap2_disp_save_initstate(OMAP2_VIDEO2);
+
+	vout_linked =3D -1;
+	spin_lock_init (&vout_link_lock);
+	return 0;
+}
+
+static void
+omap24xxvout_cleanup (void)
+{
+	cleanup_vout_device (OMAP2_VIDEO1);
+	cleanup_vout_device (OMAP2_VIDEO2);
+}
+
+#ifndef MODULE
+/*
+ *	omap24xxvout_setup - process command line options
+ *	@options: string of options
+ *
+ *	NOTE: This function is a __setup and __init function.
+ *
+ *	Returns zero.
+ */
+int __init
+omap24xxvout_setup (char *options)
+{
+	char *this_opt;
+	int i;
+
+	if (!options || !*options)return 0;
+
+	DPRINTK ("Options \"%s\"\n", options);
+	i =3D strlen (VOUT_NAME);
+	if (!strncmp (options, VOUT_NAME, i) && options[i] =3D=3D ':') {
+		this_opt =3D options + i + 1;
+		if (!this_opt || !*this_opt)
+			return 0;
+
+		if (!strncmp (this_opt, "rotation=3D", 9)) {
+			int deg =3D simple_strtoul (this_opt + 9, NULL,
0);
+			switch (deg) {
+			case 0:
+			case 90:
+			case 180:
+			case 270:
+				rotation_support =3D (deg =3D=3D 90)?270:(deg
=3D=3D 270)?90:deg;
+			break;
+			default:
+				rotation_support =3D -1;
+			break;
+			}
+			printk (KERN_INFO VOUT_NAME ": Rotation %s\n",
+			(rotation_support =3D=3D -1) ? "none (supported:
\"rotation=3D[-1|0|90|180|270]\")" :
+			this_opt + 9);
+		}
+		else
+			printk (KERN_INFO VOUT_NAME ": Invalid parameter
\"%s\" "
+			"(supported: \"rotation=3D[-1|0|90|180|270]\")\n",
this_opt);
+			return 0;
+	}
+
+	/*
+	 * If we get here no fb was specified.
+	 * We consider the argument to be a global video mode option.
+	 */
+	global_mode_option =3D options;
+	return 0;
+}
+
+__setup ("videoout=3D", omap24xxvout_setup);
+#endif
+
+MODULE_AUTHOR ("Texas Instruments.");
+MODULE_DESCRIPTION ("OMAP24xx Video for Linux Video out driver");
+MODULE_LICENSE ("GPL");
+MODULE_PARM (render_mem, "i");
+MODULE_PARM_DESC (render_mem,
+		  "Maximum rendering memory size (default 1.2MB)");
+
+module_init (omap24xxvout_init);
+module_exit (omap24xxvout_cleanup);
