From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v2 7/8] media: video: introduce object detection
 driver module
Date: Wed, 4 Jan 2012 16:13:12 +0800
Message-ID: <CACVXFVPqntLKoyLxY2xeya3mZx_1vh-QQQCp=N2-vC9tooKwOA@mail.gmail.com>
References: <1323871214-25435-1-git-send-email-ming.lei@canonical.com>
 <1323871214-25435-8-git-send-email-ming.lei@canonical.com>
 <4EFCA06C.7050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4EFCA06C.7050307@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sylwester Nawrocki <snjw23@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sylwester,

Thanks for your review.

On Fri, Dec 30, 2011 at 1:16 AM, Sylwester Nawrocki <snjw23@gmail.com> wrot=
e:
> Hi Ming,
>
> On 12/14/2011 03:00 PM, Ming Lei wrote:
>> This patch introduces object detection generic driver.
>>
>> The driver is responsible for all v4l2 stuff, buffer management
>> and other general things, and doesn't touch object detection hardware
>> directly. Several interfaces are exported to low level drivers
>> (such as the coming omap4 FD driver) which will communicate with
>> object detection hw module.
>>
>> So the driver will make driving object detection hw modules more
>> easy.
>> TODO:
>> =A0 =A0 =A0 - implement object detection setting interfaces with v4l2
>> =A0 =A0 =A0 controls or ext controls
>>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> v2:
>> =A0 =A0 =A0 - extend face detection driver to object detection driver
>> =A0 =A0 =A0 - introduce subdevice and media entity
>> =A0 =A0 =A0 - provide support to detect object from media HW
>> ---
>> =A0drivers/media/video/Kconfig =A0 =A0 =A0 | =A0 =A02 +
>> =A0drivers/media/video/Makefile =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/media/video/odif/Kconfig =A0| =A0 =A07 +
>> =A0drivers/media/video/odif/Makefile | =A0 =A01 +
>> =A0drivers/media/video/odif/odif.c =A0 | =A0890 ++++++++++++++++++++++++=
+++++++++++++
>> =A0drivers/media/video/odif/odif.h =A0 | =A0157 +++++++
>> =A06 files changed, 1058 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/media/video/odif/Kconfig
>> =A0create mode 100644 drivers/media/video/odif/Makefile
>> =A0create mode 100644 drivers/media/video/odif/odif.c
>> =A0create mode 100644 drivers/media/video/odif/odif.h
>>
>> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
>> index 5684a00..8740ee9 100644
>> --- a/drivers/media/video/Kconfig
>> +++ b/drivers/media/video/Kconfig
>> @@ -1166,3 +1166,5 @@ config VIDEO_SAMSUNG_S5P_MFC
>> =A0 =A0 =A0 =A0 =A0 MFC 5.1 driver for V4L2.
>>
>> =A0endif # V4L_MEM2MEM_DRIVERS
>> +
>> +source "drivers/media/video/odif/Kconfig"
>> diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
>> index bc797f2..259c8d8 100644
>> --- a/drivers/media/video/Makefile
>> +++ b/drivers/media/video/Makefile
>> @@ -197,6 +197,7 @@ obj-$(CONFIG_VIDEO_IR_I2C) =A0+=3D ir-kbd-i2c.o
>> =A0obj-y =A0 =A0 =A0 =A0+=3D davinci/
>>
>> =A0obj-$(CONFIG_ARCH_OMAP) =A0 =A0 =A0+=3D omap/
>> +obj-$(CONFIG_ODIF) =A0 +=3D odif/
>>
>> =A0ccflags-y +=3D -Idrivers/media/dvb/dvb-core
>> =A0ccflags-y +=3D -Idrivers/media/dvb/frontends
>> diff --git a/drivers/media/video/odif/Kconfig b/drivers/media/video/odif=
/Kconfig
>> new file mode 100644
>> index 0000000..5090bd6
>> --- /dev/null
>> +++ b/drivers/media/video/odif/Kconfig
>> @@ -0,0 +1,7 @@
>> +config ODIF
>> + =A0 =A0 depends on VIDEO_DEV && VIDEO_V4L2
>> + =A0 =A0 select VIDEOBUF2_PAGE
>> + =A0 =A0 tristate "Object Detection module"
>> + =A0 =A0 help
>> + =A0 =A0 =A0 The ODIF is a object detection module, which can be integr=
ated into
>> + =A0 =A0 =A0 some SoCs to detect objects in images or video.
>> diff --git a/drivers/media/video/odif/Makefile b/drivers/media/video/odi=
f/Makefile
>> new file mode 100644
>> index 0000000..a55ff66
>> --- /dev/null
>> +++ b/drivers/media/video/odif/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_ODIF) =A0 =A0 =A0 =A0 =A0 +=3D odif.o
>> diff --git a/drivers/media/video/odif/odif.c b/drivers/media/video/odif/=
odif.c
>> new file mode 100644
>> index 0000000..381ab9d
>> --- /dev/null
>> +++ b/drivers/media/video/odif/odif.c
>> @@ -0,0 +1,890 @@
>> +/*
>> + * =A0 =A0 =A0odif.c =A0-- =A0object detection module driver
>> + *
>> + * =A0 =A0 =A0Copyright (C) 2011 =A0Ming Lei (ming.lei@canonical.com)
>> + *
>> + * =A0 This file is based on drivers/media/video/vivi.c.
>> + *
>> + * =A0 =A0 =A0This program is free software; you can redistribute it an=
d/or modify
>> + * =A0 =A0 =A0it under the terms of the GNU General Public License as p=
ublished by
>> + * =A0 =A0 =A0the Free Software Foundation; either version 2 of the Lic=
ense, or
>> + * =A0 =A0 =A0(at your option) any later version.
>> + *
>> + * =A0 =A0 =A0This program is distributed in the hope that it will be u=
seful,
>> + * =A0 =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warran=
ty of
>> + * =A0 =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0S=
ee the
>> + * =A0 =A0 =A0GNU General Public License for more details.
>> + *
>> + * =A0 =A0 =A0You should have received a copy of the GNU General Public=
 License
>> + * =A0 =A0 =A0along with this program; if not, write to the Free Softwa=
re
>> + * =A0 =A0 =A0Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + *
>> + */
>> +
>> +/**********************************************************************=
*******/
>> +
>> +#include <linux/module.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/signal.h>
>> +#include <linux/wait.h>
>> +#include <linux/poll.h>
>> +#include <linux/mman.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/interrupt.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/io.h>
>> +#include "odif.h"
>> +
>> +#define =A0 =A0 =A0input_from_user(dev) \
>> + =A0 =A0 (dev->input =3D=3D OD_INPUT_FROM_USER_SPACE)
>> +
>> +#define =A0 =A0 =A0DEFAULT_PENDING_RESULT_CNT =A0 =A0 =A08
>> +
>> +static unsigned debug =3D 0;
>> +module_param(debug, uint, 0644);
>> +MODULE_PARM_DESC(debug, "activates debug info");
>> +
>> +static unsigned result_cnt_threshold =3D DEFAULT_PENDING_RESULT_CNT;
>> +module_param(result_cnt_threshold, uint, 0644);
>> +MODULE_PARM_DESC(result_cnt, "max pending result count");
>> +
>> +static LIST_HEAD(odif_devlist);
>> +static unsigned video_nr =3D -1;
>> +
>> +int odif_open(struct file *file)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> +
>> + =A0 =A0 kref_get(&dev->ref);
>> + =A0 =A0 return v4l2_fh_open(file);
>> +}
>
> Individual drivers may need to perform some initialization when
> device node is opened. So I consider taking this possibility away
> from them not a good idea.

OK, it can be handled easily by introducing new callbacks(such as.
.open_detect and .close_detect for close) in struct odif_ops.

>
>> +
>> +static unsigned int
>> +odif_poll(struct file *file, struct poll_table_struct *wait)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 unsigned int mask =3D 0;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 poll_wait(file, &dev->odif_dq.wq, wait);
>> +
>> + =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 if ((file->f_mode & FMODE_READ) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 !list_empty(&dev->odif_dq.complete))
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask |=3D POLLIN | POLLWRNORM;
>> + =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> + =A0 =A0 return mask;
>> +}
>> +
>> +static int odif_close(struct file *file)
>> +{
>> + =A0 =A0 struct video_device =A0*vdev =3D video_devdata(file);
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 dprintk(dev, 1, "close called (dev=3D%s), file %p\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 video_device_node_name(vdev), file);
>> +
>> + =A0 =A0 if (v4l2_fh_is_singular_file(file))
>> + =A0 =A0 =A0 =A0 =A0 =A0 vb2_queue_release(&dev->vbq);
>> +
>> + =A0 =A0 ret =3D v4l2_fh_release(file);
>> + =A0 =A0 kref_put(&dev->ref, odif_release);
>> +
>> + =A0 =A0 return ret;
>> +}
>
> Same comments as for open().

Same above.

>
>> +
>> +static int odif_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 dprintk(dev, 1, "mmap called, vma=3D0x%08lx\n", (unsigned long=
)vma);
>> +
>> + =A0 =A0 if (!input_from_user(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 ret =3D vb2_mmap(&dev->vbq, vma);
>> + =A0 =A0 dprintk(dev, 1, "vma start=3D0x%08lx, size=3D%ld, ret=3D%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)vma->vm_start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)vma->vm_end - (unsigned long)vm=
a->vm_start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static const struct v4l2_file_operations odif_fops =3D {
>> + =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>> + =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D odif_open,
>> + =A0 =A0 .release =A0 =A0 =A0 =A0=3D odif_close,
>> + =A0 =A0 .poll =A0 =A0 =A0 =A0 =A0 =3D odif_poll,
>> + =A0 =A0 .unlocked_ioctl =3D video_ioctl2, /* V4L2 ioctl handler */
>> + =A0 =A0 .mmap =A0 =A0 =A0 =A0 =A0 =3D odif_mmap,
>> +};
>> +
>> +/* ------------------------------------------------------------------
>> + =A0 =A0 IOCTL vidioc handling
>> + =A0 ------------------------------------------------------------------=
*/
>> +static void free_result(struct v4l2_odif_result *result)
>> +{
>> + =A0 =A0 kfree(result);
>> +}
>> +
>> +static int odif_start_detect(struct odif_dev *dev)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 ret =3D dev->ops->start_detect(dev);
>> +
>> + =A0 =A0 dprintk(dev, 1, "returning from %s, ret is %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static void odif_stop_detect(struct odif_dev *dev)
>> +{
>> + =A0 =A0 struct odif_dmaqueue *dma_q =3D &dev->odif_dq;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 /*stop hardware first*/
>> + =A0 =A0 dev->ops->stop_detect(dev);
>> +
>> + =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 /* Release all active buffers */
>> + =A0 =A0 while (!list_empty(&dma_q->active)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct odif_buffer *buf;
>> + =A0 =A0 =A0 =A0 =A0 =A0 buf =3D list_entry(dma_q->active.next, struct =
odif_buffer, list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_del(&buf->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 vb2_buffer_done(&buf->vb, VB2_BUF_STATE_ERROR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dprintk(dev, 2, "[%p/%d] done\n", buf, buf->vb=
.v4l2_buf.index);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Release all complete detect result, so user space __must__ =
read
>> + =A0 =A0 =A0* the results before stream off*/
>> + =A0 =A0 while (!list_empty(&dma_q->complete)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_odif_result *result;
>> + =A0 =A0 =A0 =A0 =A0 =A0 result =3D list_entry(dma_q->complete.next, st=
ruct v4l2_odif_result, list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_del(&result->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_result(result);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dprintk(dev, 2, "[frm_seq:%d] result removed\n=
", result->frm_seq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 }
>> + =A0 =A0 atomic_set(&dma_q->complete_cnt, 0);
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +}
>> +static int vidioc_querycap(struct file *file, void =A0*priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct v4l2_capability *cap)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> +
>> + =A0 =A0 strcpy(cap->driver, "odif");
>> + =A0 =A0 strcpy(cap->card, "odif");
>> + =A0 =A0 strlcpy(cap->bus_info, dev->v4l2_dev.name, sizeof(cap->bus_inf=
o));
>> + =A0 =A0 cap->capabilities =3D dev->ops->capability | V4L2_CAP_OBJ_DETE=
CTION;
>
> The reported capabilities are wrong, please see below.
>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int vidioc_enum_fmt_vid_out(struct file *file, void =A0*priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct v4l2_fmtdesc *f)
>> +{
>> + =A0 =A0 struct odif_fmt *fmt;
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> +
>> + =A0 =A0 if (f->index >=3D dev->ops->fmt_cnt) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>
> Single statement shouldn't have brackets around it.
>
>> +
>> + =A0 =A0 fmt =3D &dev->ops->table[f->index];
>> +
>> + =A0 =A0 strlcpy(f->description, fmt->name, sizeof(f->description));
>> + =A0 =A0 f->pixelformat =3D fmt->fourcc;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int vidioc_g_fmt_vid_out(struct file *file, void *priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct v4l2_format *f)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> +
>> + =A0 =A0 f->fmt.pix.width =A0 =A0 =A0 =A0=3D dev->s.width;
>> + =A0 =A0 f->fmt.pix.height =A0 =A0 =A0 =3D dev->s.height;
>> + =A0 =A0 f->fmt.pix.field =A0 =A0 =A0 =A0=3D dev->s.field;
>> + =A0 =A0 f->fmt.pix.pixelformat =A0=3D dev->s.fmt->fourcc;
>> + =A0 =A0 f->fmt.pix.bytesperline =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 (f->fmt.pix.width * dev->s.fmt->depth) >> 3;
>> + =A0 =A0 f->fmt.pix.sizeimage =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 f->fmt.pix.height * f->fmt.pix.bytesperline;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int vidioc_reqbufs(struct file *file, void *priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_requestbuffers=
 *p)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 if (!input_from_user(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 return vb2_reqbufs(&dev->vbq, p);
>> +}
>> +
>> +static int vidioc_querybuf(struct file *file, void *priv, struct v4l2_b=
uffer *p)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 if (!input_from_user(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 return vb2_querybuf(&dev->vbq, p);
>> +}
>> +
>> +static int vidioc_qbuf(struct file *file, void *priv, struct v4l2_buffe=
r *p)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 if (!input_from_user(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 return vb2_qbuf(&dev->vbq, p);
>> +}
>> +
>> +static int vidioc_dqbuf(struct file *file, void *priv, struct v4l2_buff=
er *p)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 if (!input_from_user(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> +
>> + =A0 =A0 return vb2_dqbuf(&dev->vbq, p, file->f_flags & O_NONBLOCK);
>> +}
>> +
>> +static int vidioc_streamon(struct file *file, void *priv, enum v4l2_buf=
_type i)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 dev->working =3D 1;
>> +
>> + =A0 =A0 if (input_from_user(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return vb2_streamon(&dev->vbq, i);
>> +
>> + =A0 =A0 return odif_start_detect(dev);
>> +}
>> +
>> +static int vidioc_streamoff(struct file *file, void *priv, enum v4l2_bu=
f_type i)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 dev->working =3D 0;
>> +
>> + =A0 =A0 if (input_from_user(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return vb2_streamoff(&dev->vbq, i);
>> +
>> + =A0 =A0 odif_stop_detect(dev);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int vidioc_g_od_count(struct file *file, void *priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct v4l2_od_count *f)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 struct v4l2_odif_result *tmp;
>> + =A0 =A0 int ret =3D -EINVAL;
>> +
>> + =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 list_for_each_entry(tmp, &dev->odif_dq.complete, list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (tmp->frm_seq =3D=3D f->frm_seq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f->obj_cnt =3D tmp->obj_cnt;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int vidioc_g_od_result(struct file *file, void *priv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct v4l2_od_result *f)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D video_drvdata(file);
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 struct v4l2_odif_result *tmp;
>> + =A0 =A0 struct v4l2_odif_result *fr =3D NULL;
>> + =A0 =A0 unsigned int cnt =3D 0;
>> + =A0 =A0 int ret =3D -EINVAL;
>> +
>> + =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 list_for_each_entry(tmp, &dev->odif_dq.complete, list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (tmp->frm_seq =3D=3D f->frm_seq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fr =3D tmp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&tmp->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> + =A0 =A0 if (fr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 cnt =3D min(f->obj_cnt, fr->obj_cnt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cnt)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(f->od, fr->objs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct =
v4l2_od_object) * cnt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 f->obj_cnt =3D cnt;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_result(fr);
>
> Some drivers may be designed so they do not discard the result data
> automatically once it is read by user application. AFAICS this module
> doesn't allow such behaviour.
>
> For instance, it might be required to discard the oldest results data
> when the ring buffer gets filled in.

Looks like no any benefit about keeping the old result data, could you
give some use cases which require the old results need to be kept for
some time?

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&dev->odif_dq.complete_cnt);
>> + =A0 =A0 }
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static const struct v4l2_ioctl_ops odif_ioctl_ops =3D {
>> + =A0 =A0 .vidioc_querycap =A0 =A0 =A0=3D vidioc_querycap,
>> + =A0 =A0 .vidioc_enum_fmt_vid_out =A0=3D vidioc_enum_fmt_vid_out,
>> + =A0 =A0 .vidioc_g_fmt_vid_out =A0 =A0 =3D vidioc_g_fmt_vid_out,
>> + =A0 =A0 .vidioc_reqbufs =A0 =A0 =A0 =3D vidioc_reqbufs,
>> + =A0 =A0 .vidioc_querybuf =A0 =A0 =A0=3D vidioc_querybuf,
>> + =A0 =A0 .vidioc_qbuf =A0 =A0 =A0 =A0 =A0=3D vidioc_qbuf,
>> + =A0 =A0 .vidioc_dqbuf =A0 =A0 =A0 =A0 =3D vidioc_dqbuf,
>> + =A0 =A0 .vidioc_streamon =A0 =A0 =A0=3D vidioc_streamon,
>> + =A0 =A0 .vidioc_streamoff =A0 =A0 =3D vidioc_streamoff,
>> + =A0 =A0 .vidioc_g_od_count =A0 =A0=3D vidioc_g_od_count,
>> + =A0 =A0 .vidioc_g_od_result =A0 =3D vidioc_g_od_result,
>> +};
>> +
>> +static void odif_vdev_release(struct video_device *vdev)
>> +{
>> + =A0 =A0 kfree(vdev->lock);
>> + =A0 =A0 video_device_release(vdev);
>> +}
>> +
>> +static struct video_device odif_template =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "odif",
>> + =A0 =A0 .fops =A0 =A0 =A0 =A0 =A0 =3D &odif_fops,
>> + =A0 =A0 .ioctl_ops =A0 =A0 =A0=3D &odif_ioctl_ops,
>> + =A0 =A0 .release =A0 =A0 =A0 =A0=3D odif_vdev_release,
>> +};
>> +
>> +
>> +/* ------------------------------------------------------------------
>> + =A0 =A0 Videobuf operations
>> + =A0 ------------------------------------------------------------------=
*/
>> +static int queue_setup(struct vb2_queue *vq, const struct v4l2_format *=
fmt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *=
nbuffers, unsigned int *nplanes,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int s=
izes[], void *alloc_ctxs[])
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vq);
>> + =A0 =A0 unsigned long size;
>> +
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +
>> + =A0 =A0 BUG_ON(!dev->s.fmt);
>> + =A0 =A0 size =3D (dev->s.width * dev->s.height * dev->s.fmt->depth) >>=
 3;
>> +
>> + =A0 =A0 if (0 =3D=3D *nbuffers)
>> + =A0 =A0 =A0 =A0 =A0 =A0 *nbuffers =3D 2;
>> + =A0 =A0 *nplanes =3D 1;
>> + =A0 =A0 sizes[0] =3D size;
>> +
>> + =A0 =A0 dprintk(dev, 1, "%s, count=3D%d, size=3D%ld\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 *nbuffers, size);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int buffer_init(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vb->vb2_queue);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* This callback is called once per buffer, after its alloca=
tion.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* Vivi does not allow changing format during streaming, but=
 it is
>> + =A0 =A0 =A0* possible to do so when streaming is paused (i.e. in strea=
moff state).
>> + =A0 =A0 =A0* Buffers however are not freed when going into streamoff a=
nd so
>> + =A0 =A0 =A0* buffer size verification has to be done in buffer_prepare=
, on each
>> + =A0 =A0 =A0* qbuf.
>> + =A0 =A0 =A0* It would be best to move verification code here to buf_in=
it and
>> + =A0 =A0 =A0* s_fmt though.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 dprintk(dev, 1, "%s vaddr=3D%p\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb2_plane_vaddr(vb, 0));
>> +
>> + =A0 =A0 return 0;
>> +}
>
> As I already mentioned this empty callback can be removed. Anyway IMO the
> implementation of the buffer queue operations should be left to individual
> drivers. Having them in generic module doesn't sound flexible enough.

IMO, the buffer queue operations can be shared for use case of
detecting objects from user space images, so it may be kept it in
generic driver.

>
>> +
>> +static int buffer_prepare(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vb->vb2_queue);
>> + =A0 =A0 struct odif_buffer *buf =3D container_of(vb, struct odif_buffe=
r, vb);
>> + =A0 =A0 unsigned long size;
>> +
>> + =A0 =A0 dprintk(dev, 1, "%s, field=3D%d\n", __func__, vb->v4l2_buf.fie=
ld);
>> +
>> + =A0 =A0 BUG_ON(!dev->s.fmt);
>> + =A0 =A0 size =3D (dev->s.width * dev->s.height * dev->s.fmt->depth) >>=
 3;
>> + =A0 =A0 if (vb2_plane_size(vb, 0) < size) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dprintk(dev, 1, "%s data will not fit into pla=
ne (%lu < %lu)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vb2_=
plane_size(vb, 0), size);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 vb2_set_plane_payload(&buf->vb, 0, size);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int buffer_finish(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vb->vb2_queue);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void buffer_cleanup(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vb->vb2_queue);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> +}
>> +
>> +static void buffer_queue(struct vb2_buffer *vb)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vb->vb2_queue);
>> + =A0 =A0 struct odif_buffer *buf =3D container_of(vb, struct odif_buffe=
r, vb);
>> + =A0 =A0 struct odif_dmaqueue *dq =3D &dev->odif_dq;
>> + =A0 =A0 unsigned long flags =3D 0;
>> +
>> + =A0 =A0 dprintk(dev, 1, "%s vaddr:%p\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb2_plane_vaddr(vb, 0));
>> +
>> + =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 list_add_tail(&buf->list, &dq->active);
>> + =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> + =A0 =A0 if (vb->vb2_queue->streaming)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->ops->submit_detect(dev);
>> +}
>> +
>> +static int start_streaming(struct vb2_queue *vq, unsigned int count)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vq);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> + =A0 =A0 return odif_start_detect(dev);
>> +}
>> +
>> +/* abort streaming and wait for last buffer */
>> +static int stop_streaming(struct vb2_queue *vq)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vq);
>> + =A0 =A0 dprintk(dev, 1, "%s\n", __func__);
>> + =A0 =A0 odif_stop_detect(dev);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void odif_lock(struct vb2_queue *vq)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vq);
>> +
>> + =A0 =A0 mutex_lock(&dev->mutex);
>> +}
>> +
>> +static void odif_unlock(struct vb2_queue *vq)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D vb2_get_drv_priv(vq);
>> + =A0 =A0 mutex_unlock(&dev->mutex);
>> +}
>> +static struct vb2_ops odif_video_qops =3D {
>> + =A0 =A0 .queue_setup =A0 =A0 =A0 =A0 =A0 =A0=3D queue_setup,
>> + =A0 =A0 .buf_init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D buffer_init,
>> + =A0 =A0 .buf_prepare =A0 =A0 =A0 =A0 =A0 =A0=3D buffer_prepare,
>> + =A0 =A0 .buf_finish =A0 =A0 =A0 =A0 =A0 =A0 =3D buffer_finish,
>> + =A0 =A0 .buf_cleanup =A0 =A0 =A0 =A0 =A0 =A0=3D buffer_cleanup,
>> + =A0 =A0 .buf_queue =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D buffer_queue,
>> + =A0 =A0 .start_streaming =A0 =A0 =A0 =A0=3D start_streaming,
>> + =A0 =A0 .stop_streaming =A0 =A0 =A0 =A0 =3D stop_streaming,
>> + =A0 =A0 .wait_prepare =A0 =A0 =A0 =A0 =A0 =3D odif_unlock,
>> + =A0 =A0 .wait_finish =A0 =A0 =A0 =A0 =A0 =A0=3D odif_lock,
>
> Not all of these ops will be always needed by every driver. Things would
> be a bit simpler if we had left their implementation to the individual
> drivers.

OK, I will remove some empty ops.

>
>> +};
>> +
>> +/*only store one detection result for one frame*/
>
> Could you do me a favour and in the future add whitespace after each "/*"
> and before =A0"*/" in the comments ? Sorry, I'm getting nervous every time
> I look at something like /*blah blah*/ ;) I also prefer starting comments=
 with
> big letter. Of course these are just my personal preferences;)

Will fix it in v3, :-)

>
>> +void odif_add_detection(struct odif_dev *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_odif_result *v4l2_fr)
>> +{
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 struct v4l2_odif_result *old =3D NULL;
>> + =A0 =A0 struct v4l2_odif_result *tmp;
>> +
>> + =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 list_for_each_entry(tmp, &dev->odif_dq.complete, list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (tmp->frm_seq =3D=3D v4l2_fr->frm_seq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old =3D tmp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&tmp->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 list_add_tail(&v4l2_fr->list, &dev->odif_dq.complete);
>> + =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> + =A0 =A0 if (old)
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_result(old);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_inc(&dev->odif_dq.complete_cnt);
>> +}
>> +EXPORT_SYMBOL_GPL(odif_add_detection);
>> +
>> +struct v4l2_odif_result *odif_allocate_detection(struct odif_dev *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 int cnt)
>> +{
>> + =A0 =A0 struct v4l2_odif_result *result =3D NULL;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 if (atomic_read(&dev->odif_dq.complete_cnt) >=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_cnt_threshold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 result =3D list_entry(dev->odif_dq.complete.ne=
xt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct v4l2_odif_result, list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_del(&result->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&dev->odif_dq.complete_cnt);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!result) =A0 =A0goto allocate_result;
>> +
>> + =A0 =A0 /* reuse the old one if count is matched */
>> + =A0 =A0 if (result->obj_cnt =3D=3D cnt)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 /*free the old result*/
>> + =A0 =A0 free_result(result);
>> +
>> +allocate_result:
>> + =A0 =A0 result =3D kzalloc(sizeof(*result) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cnt * sizeof(struct v4l2_od_ob=
ject), GFP_ATOMIC);
>
> I prefer not allocating memory in interrupt context like this, especially
> as this can be avoided without significant effort and resources waste.

Considered that the allocated space is not very large, maybe it can be allo=
cated
in interrupt context. The count of v4l2_od_object to be allocated is varian=
t,
so it is not easy to reserve buffers during driver init to handle variant b=
uffer
allocation.  Also this can be left for future optimization.

>
>> + =A0 =A0 if (result)
>> + =A0 =A0 =A0 =A0 =A0 =A0 result->obj_cnt =3D cnt;
>> +out:
>> + =A0 =A0 return result;
>> +}
>> +EXPORT_SYMBOL_GPL(odif_allocate_detection);
>> +
>> +struct odif_buffer *odif_pick_up_buffer(struct odif_dev *dev)
>> +{
>> + =A0 =A0 struct odif_buffer *buf =3D NULL;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 WARN_ON(!input_from_user(dev));
>> +
>> + =A0 =A0 spin_lock_irqsave(&dev->lock, flags);
>> + =A0 =A0 if (list_empty(&dev->odif_dq.active))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 buf =3D list_entry(dev->odif_dq.active.next,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct odif_bu=
ffer, list);
>> + =A0 =A0 list_del(&buf->list);
>> +out:
>> + =A0 =A0 spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> + =A0 =A0 return buf;
>> +}
>> +EXPORT_SYMBOL_GPL(odif_pick_up_buffer);
>> +
>> +static struct v4l2_subdev_ops odif_subdev_ops =3D {
>> +};
>> +
>> +static int odif_switch_link(struct odif_dev *dev, int next,
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct media_pad *remote)
>> +{
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (dev->input =3D=3D next)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if (!(dev->ops->capability & V4L2_CAP_VIDEO_OUTPUT) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D=3D OD_INPUT_FROM_USER=
_SPACE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 if (!(dev->ops->capability & V4L2_CAP_VIDEO_CAPTURE) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D=3D OD_INPUT_FROM_MEDI=
A_HW)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(dev->vfd->lock);
>> + =A0 =A0 if (dev->working) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (dev->ops->set_input)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->ops->set_input(dev, next, remote);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> +out:
>> + =A0 =A0 mutex_unlock(dev->vfd->lock);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int odif_entity_link_setup(struct media_entity *entity,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct media_pad *lo=
cal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct media_pad *re=
mote, u32 flags)
>> +{
>> + =A0 =A0 struct v4l2_subdev *sd =3D media_entity_to_v4l2_subdev(entity);
>> + =A0 =A0 struct odif_dev *dev =3D v4l2_get_subdevdata(sd);
>> + =A0 =A0 u32 =A0 =A0type =3D media_entity_type(remote->entity);
>> + =A0 =A0 int ret, next;
>> +
>> + =A0 =A0 /*link user space video to object detection*/
>> + =A0 =A0 if (remote =3D=3D &dev->entity[1].pads[0])
>> + =A0 =A0 =A0 =A0 =A0 =A0 next =3D OD_INPUT_FROM_USER_SPACE;
>> + =A0 =A0 else if (type =3D=3D MEDIA_ENT_T_V4L2_SUBDEV)
>> + =A0 =A0 =A0 =A0 =A0 =A0 next =3D OD_INPUT_FROM_MEDIA_HW;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 next =3D dev->input;
>> +
>> + =A0 =A0 printk("%s:%d next=3D%d\n", __func__, __LINE__, next);
>> + =A0 =A0 ret =3D odif_switch_link(dev, next, remote);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +struct media_entity_operations odif_entity_ops =3D {
>> + =A0 =A0 .link_setup =3D odif_entity_link_setup,
>> +};
>> +
>> +static void odif_cleanup_entities(struct odif_dev *odif)
>> +{
>> +
>> + =A0 =A0 v4l2_device_unregister_subdev(&odif->entity[0].subdev);
>> + =A0 =A0 v4l2_device_unregister_subdev(&odif->entity[1].subdev);
>> +
>> + =A0 =A0 media_entity_cleanup(&odif->entity[0].subdev.entity);
>> + =A0 =A0 media_entity_cleanup(&odif->entity[1].subdev.entity);
>> +}
>> +
>> +static int odif_init_entities(struct odif_dev *odif)
>> +{
>> + =A0 =A0 const u32 flags =3D MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_DYNAMI=
C;
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct odif_entity *entity;
>> + =A0 =A0 struct media_entity *source;
>> + =A0 =A0 struct media_entity *sink;
>> +
>> + =A0 =A0 /*entity[0] is the entity for object detection hw*/
>> + =A0 =A0 entity =3D &odif->entity[0];
>> + =A0 =A0 entity->num_links =3D 2;
>> + =A0 =A0 entity->num_pads =3D 1;
>> + =A0 =A0 entity->pads[0].flags =3D MEDIA_PAD_FL_SINK;
>> +
>> + =A0 =A0 v4l2_subdev_init(&entity->subdev, &odif_subdev_ops);
>> + =A0 =A0 v4l2_set_subdevdata(&entity->subdev, odif);
>> + =A0 =A0 strlcpy(entity->subdev.name, "object detect",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(entity->subdev.name));
>> + =A0 =A0 ret =3D media_entity_init(&entity->subdev.entity,
>> + =A0 =A0 =A0 =A0 =A0 =A0 entity->num_pads, entity->pads, 1);
>> +
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 /*entity[1] is the video entity which sources the user space v=
ideo*/
>> + =A0 =A0 entity =3D &odif->entity[1];
>> + =A0 =A0 entity->num_links =3D 1;
>> + =A0 =A0 entity->num_pads =3D 1;
>> + =A0 =A0 entity->pads[0].flags =3D MEDIA_PAD_FL_SOURCE;
>> +
>> + =A0 =A0 v4l2_subdev_init(&entity->subdev, &odif_subdev_ops);
>> + =A0 =A0 v4l2_set_subdevdata(&entity->subdev, odif);
>> + =A0 =A0 strlcpy(entity->subdev.name, "user space video",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(entity->subdev.name));
>> + =A0 =A0 ret =3D media_entity_init(&entity->subdev.entity,
>> + =A0 =A0 =A0 =A0 =A0 =A0 entity->num_pads, entity->pads, 0);
>> +
>> + =A0 =A0 /* create the default link */
>> + =A0 =A0 source =3D &odif->entity[1].subdev.entity;
>> + =A0 =A0 sink =3D &odif->entity[0].subdev.entity;
>> + =A0 =A0 sink->ops =3D &odif_entity_ops;
>> + =A0 =A0 ret =3D media_entity_create_link(source, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0sink, 0, flags);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 /* init the default hw link*/
>> + =A0 =A0 if (odif->ops->set_input)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D odif->ops->set_input(odif,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OD_INPUT_FROM_USER_SPACE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &odif->entity[1].pads[0]);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 odif->input =3D OD_INPUT_FROM_USER_SPACE;
>> +
>> + =A0 =A0 /* register the two subdevices */
>> + =A0 =A0 ret =3D v4l2_device_register_subdev(&odif->v4l2_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &odif->entity[0].subdev);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 ret =3D v4l2_device_register_subdev(&odif->v4l2_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &odif->entity[1].subdev);
>
> You're creating v4l2 subdevice but not all drivers would require it.
> Also individual drivers will usually manage connections between the media
> entities on their own. So IMHO this module goes a little to far on fixing
> up driver's architecture.
>
> Also what are there two subdevs needed for ?

The two subsevs are used to describe two media entity, one of which
is the object detection hw, and another is the video entity which sources
the user space video. Without the two entities, I don't know how media
controller connects these into framework.

>
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +out:
>> + =A0 =A0 return ret;
>> +}
>> +
>> +void odif_release(struct kref *ref)
>> +{
>> + =A0 =A0 struct odif_dev *dev =3D container_of(ref, struct odif_dev, re=
f);
>> +
>> + =A0 =A0 v4l2_info(&dev->v4l2_dev, "unregistering %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 video_device_node_name(dev->vfd));
>> +
>> + =A0 =A0 list_del(&dev->odif_devlist);
>> +
>> + =A0 =A0 odif_cleanup_entities(dev);
>> + =A0 =A0 video_unregister_device(dev->vfd);
>> + =A0 =A0 v4l2_device_unregister(&dev->v4l2_dev);
>> + =A0 =A0 kfree(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(odif_release);
>> +
>> +int odif_create_instance(struct device *parent, int priv_size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct odif_ops *ops, struct odif_dev **odif_d=
ev)
>> +{
>> + =A0 =A0 struct odif_dev *dev;
>> + =A0 =A0 struct video_device *vfd;
>> + =A0 =A0 struct vb2_queue *q;
>> + =A0 =A0 int ret, len;
>> + =A0 =A0 struct mutex =A0 =A0*vmutex;
>> +
>> + =A0 =A0 dev =3D kzalloc(sizeof(*dev) + priv_size, GFP_KERNEL);
>> + =A0 =A0 if (!dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 kref_init(&dev->ref);
>> + =A0 =A0 dev->ops =3D ops;
>> + =A0 =A0 dev->dev =3D parent;
>> +
>> + =A0 =A0 len =3D snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name=
),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s", "odif");
>> + =A0 =A0 dev->v4l2_dev.name[len] =3D '\0';
>
> There is no need for tricks like that, snprintf() already ensures the str=
ing
> has trailing '\0' appended to it.

Will remove the above line in v3.

>
>> +
>> + =A0 =A0 ret =3D v4l2_device_register(dev->dev, &dev->v4l2_dev);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto free_dev;
>> +
>> + =A0 =A0 /* initialize locks */
>> + =A0 =A0 spin_lock_init(&dev->lock);
>> +
>> + =A0 =A0 /* initialize queue */
>> + =A0 =A0 q =3D &dev->vbq;
>> + =A0 =A0 memset(q, 0, sizeof(dev->vbq));
>> + =A0 =A0 q->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT;
>> + =A0 =A0 q->io_modes =3D VB2_MMAP;
>> + =A0 =A0 q->drv_priv =3D dev;
>> + =A0 =A0 q->buf_struct_size =3D sizeof(struct odif_buffer);
>> + =A0 =A0 q->ops =3D &odif_video_qops;
>> + =A0 =A0 q->mem_ops =3D &vb2_page_memops;
>> +
>> + =A0 =A0 vb2_queue_init(q);
>> +
>> + =A0 =A0 mutex_init(&dev->mutex);
>> +
>> + =A0 =A0 /* init video dma queues */
>> + =A0 =A0 atomic_set(&dev->odif_dq.complete_cnt, 0);
>> + =A0 =A0 INIT_LIST_HEAD(&dev->odif_dq.active);
>> + =A0 =A0 INIT_LIST_HEAD(&dev->odif_dq.complete);
>> + =A0 =A0 init_waitqueue_head(&dev->odif_dq.wq);
>> +
>> + =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 vfd =3D video_device_alloc();
>> + =A0 =A0 if (!vfd)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unreg_dev;
>> +
>> + =A0 =A0 *vfd =3D odif_template;
>> + =A0 =A0 vfd->debug =3D debug;
>> + =A0 =A0 vfd->v4l2_dev =3D &dev->v4l2_dev;
>> + =A0 =A0 set_bit(V4L2_FL_USE_FH_PRIO, &vfd->flags);
>> +
>> + =A0 =A0 vmutex =3D kzalloc(sizeof(struct mutex), GFP_KERNEL);
>> + =A0 =A0 if (!vmutex)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_mutex;
>> +
>> + =A0 =A0 mutex_init(vmutex);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Provide a mutex to v4l2 core. It will be used to protect
>> + =A0 =A0 =A0* all fops and v4l2 ioctls.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 vfd->lock =3D vmutex;
>> +
>> + =A0 =A0 ret =3D video_register_device(vfd, VFL_TYPE_GRABBER, video_nr);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto rel_vdev;
>> +
>> + =A0 =A0 if (video_nr !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 video_nr++;
>> +
>> + =A0 =A0 dev->vfd =3D vfd;
>> + =A0 =A0 video_set_drvdata(vfd, dev);
>> +
>> + =A0 =A0 ret =3D odif_init_entities(dev);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unreg_video;
>> +
>> + =A0 =A0 /* Now that everything is fine, let's add it to device list */
>> + =A0 =A0 list_add_tail(&dev->odif_devlist, &odif_devlist);
>> +
>> + =A0 =A0 v4l2_info(&dev->v4l2_dev, "V4L2 device registered as %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video_device_node_name(vfd));
>> +
>> + =A0 =A0 *odif_dev =3D dev;
>> + =A0 =A0 return 0;
>> +
>> +unreg_video:
>> + =A0 =A0 video_unregister_device(vfd);
>> +rel_vdev:
>> + =A0 =A0 kfree(vmutex);
>> +err_alloc_mutex:
>> + =A0 =A0 video_device_release(vfd);
>> +unreg_dev:
>> + =A0 =A0 v4l2_device_unregister(&dev->v4l2_dev);
>> +free_dev:
>> + =A0 =A0 kfree(dev);
>> +out:
>> + =A0 =A0 pr_err("%s: error, ret=3D%d", __func__, ret);
>> + =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(odif_create_instance);
>> +
>> +static int __init odif_init(void)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void __exit odif_exit(void)
>> +{
>> +}
>> +
>> +module_init(odif_init);
>> +module_exit(odif_exit);
>> +
>> +MODULE_DESCRIPTION("object detection interface function module");
>> +MODULE_AUTHOR("Ming Lei");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/media/video/odif/odif.h b/drivers/media/video/odif/=
odif.h
>> new file mode 100644
>> index 0000000..25c4788
>> --- /dev/null
>> +++ b/drivers/media/video/odif/odif.h
>> @@ -0,0 +1,157 @@
>> +#ifndef _LINUX_MEDIA_ODIF_H
>> +#define _LINUX_MEDIA_ODIF_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/magic.h>
>> +#include <linux/errno.h>
>> +#include <linux/kref.h>
>> +#include <linux/kernel.h>
>> +#include <media/v4l2-common.h>
>> +#include <linux/videodev2.h>
>> +#include <media/media-entity.h>
>> +#include <media/videobuf2-page.h>
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-ioctl.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-fh.h>
>> +#include <media/v4l2-event.h>
>> +
>> +#define MAX_OBJ_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A040
>> +
>> +#define OBJ_DIR_UP =A0 =A0 =A0 =A0 =A0 0
>> +#define OBJ_DIR_RIGHT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define OBJ_DIR_LIFT =A0 =A0 =A0 =A0 2
>> +#define OBJ_DIR_DOWN =A0 =A0 =A0 =A0 3
>> +
>> +
>> +#define =A0 =A0 =A0OD_INPUT_FROM_USER_SPACE =A0 =A0 =A0 =A01
>> +#define =A0 =A0 =A0OD_INPUT_FROM_MEDIA_HW =A0 =A0 =A0 =A0 =A02
>> +
>> +struct odif_fmt {
>> + =A0 =A0 char =A0*name;
>> + =A0 =A0 u32 =A0 fourcc; =A0 =A0 =A0 =A0 =A0/* v4l2 format id */
>> + =A0 =A0 u32 =A0 depth;
>> + =A0 =A0 u32 =A0 width, height;
>> +};
>> +
>> +struct odif_setting {
>> + =A0 =A0 struct odif_fmt =A0 =A0 =A0 =A0 =A0 =A0*fmt;
>> + =A0 =A0 enum v4l2_field =A0 =A0 =A0 =A0 =A0 =A0field;
>> +
>> + =A0 =A0 /* minimize object size to be detected, unit: pixel */
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_obj_size;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 obj_dir;
>> +
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 startx, starty;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizex, sizey;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lhit;
>> +
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 width, height;
>> +};
>> +
>> +/* buffer for one video frame */
>> +struct odif_buffer {
>> + =A0 =A0 /* common v4l buffer stuff -- must be first */
>> + =A0 =A0 struct vb2_buffer =A0 =A0 =A0 vb;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
>> +};
>> +
>> +
>> +struct v4l2_odif_result {
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
>> +
>> + =A0 =A0 /*frame sequence*/
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frm_seq;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 obj_cnt;
>> + =A0 =A0 struct v4l2_od_object =A0 objs[0];
>> +};
>> +
>> +struct odif_dmaqueue {
>> + =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0complete_cnt;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0complete;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0active;
>> + =A0 =A0 wait_queue_head_t =A0 =A0 =A0 wq;
>> +};
>> +
>> +struct odif_entity {
>> + =A0 =A0 /* Media controller-related fields. */
>> + =A0 =A0 struct v4l2_subdev subdev;
>> + =A0 =A0 unsigned int num_pads;
>> + =A0 =A0 unsigned int num_links;
>> +
>> + =A0 =A0 /*only one sink pad*/
>> + =A0 =A0 struct media_pad pads[1];
>> +
>> + =A0 =A0 /* TODO: odif controls */
>> +};
>> +
>> +struct odif_dev {
>> + =A0 =A0 struct kref =A0 =A0 =A0 =A0 =A0 =A0 ref;
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
>> +
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0odif_devlist;
>> + =A0 =A0 struct v4l2_device =A0 =A0 =A0v4l2_dev;
>> + =A0 =A0 struct vb2_queue =A0 =A0 =A0 =A0vbq;
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0mutex;
>> + =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
>> +
>> + =A0 =A0 /* media controller entity*/
>> + =A0 =A0 struct odif_entity =A0 =A0 =A0entity[2];
>> +
>> + =A0 =A0 struct video_device =A0 =A0 *vfd;
>> + =A0 =A0 struct odif_dmaqueue =A0 =A0odif_dq;
>> + =A0 =A0 int =A0 =A0 working;
>> +
>> + =A0 =A0 int =A0 =A0 input;
>> +
>> + =A0 =A0 /* setting */
>> + =A0 =A0 struct odif_setting =A0 =A0 s;
>> +
>> + =A0 =A0 struct odif_ops *ops;
>> +
>> + =A0 =A0 unsigned long =A0 priv[0];
>> +};
>> +
>> +/**
>> + * struct odif_ops - interface between odif and low level hw driver
>> + * @capability: =A0 =A0 =A0extra capability except for V4L2_CAP_OBJ_DET=
ECTION
>> + * =A0 V4L2_CAP_STREAMING: mandatory, start/stop detect is triggered
>> + * =A0 =A0 =A0 =A0 =A0 by streaming on/off
>> + * =A0 V4L2_CAP_VIDEO_OUTPUT: hw can support to detect objects from
>> + * =A0 =A0 =A0 =A0 =A0 user space video input
>> + * =A0 V4L2_CAP_VIDEO_CAPTURE: hw can support to detect objects from
>> + * =A0 =A0 =A0 =A0 =A0 internal bus, this doesn't mean capture is capab=
le
>
> No, we can't be reinterpreting V4L2_CAP_VIDEO_CAPTURE flag this way.
> The information how data can be fed to an object detection module should
> be oxposed at a media device level. The media device driver an object
> detection device belongs to should create proper links that application
> may then activate.
>
> Such interpretation of V4L2_CAP_VIDEO_CAPTURE violates the spec and would
> just confuse applications that query device nodes. Nack.

OK, I will remove V4L2_CAP_VIDEO_CAPTURE here and let media device driver
to handle it.

>> + *
>> + * @table: =A0 supported format table
>> + * @fmt_cnt: supported format count
>> + * @start_detect: =A0 =A0start_detect callback
>> + * @stop_detect: =A0 =A0 stop_detect callback
>> + * @submit_detect: =A0 submit_detect callback
>> + * @set_input: =A0 =A0 =A0 change video input source
>> + */
>> +struct odif_ops {
>> + =A0 =A0 u32 =A0 =A0 capability;
>> + =A0 =A0 struct odif_fmt *table;
>> + =A0 =A0 int fmt_cnt;
>> + =A0 =A0 int (*start_detect)(struct odif_dev *odif);
>> + =A0 =A0 int (*stop_detect)(struct odif_dev *odif);
>> + =A0 =A0 int (*submit_detect)(struct odif_dev *odif);
>> + =A0 =A0 int (*set_input)(struct odif_dev *odif, int next,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct media_pad *remote=
);
>> +};
>> +
>> +#define dprintk(dev, level, fmt, arg...) \
>> + =A0 =A0 v4l2_dbg(level, debug, &dev->v4l2_dev, fmt, ## arg)
>> +
>> +
>> +extern int odif_create_instance(struct device *parent, int priv_size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct odif_ops *ops, struct odif_dev **dev);
>> +extern void odif_release(struct kref *ref);
>> +extern void odif_add_detection(struct odif_dev *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_odif_result *v4l2_fr);
>> +extern struct v4l2_odif_result *odif_allocate_detection(
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct odif_dev *dev, int cnt);
>> +extern struct odif_buffer *odif_pick_up_buffer(struct odif_dev *dev);
>> +
>> +#endif /* _LINUX_MEDIA_ODIF_H */
>
> I suggest you to merge this module with next patch and remove what's
> unnecessary for OMAP4 FDIF. IMHO creating generic object detection
> module doesn't make sense, given the complexity of hardware. We have

IMO, at least now there are some functions which can be implemented
in generic object detection module to avoid duplicated implementation in
object detection hw driver: interfaces with user space, handling object
detection from user space images.  We can let object detect hw driver to
handle the complexity of hardware by defining appropriate callbacks.

> already the required building blocks in v4l2 core, what we need is
> specification of Face Detection interface semantics, which should be
> eventually added to the V4L DocBook.
> The object detection ioctls need to be adjusted to support camera sensors
> with face detection capability, I'll comment on patch 6/8 about this.

Expect your comments on it, :-)

thanks,
--
Ming Lei
