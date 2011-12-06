From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 6/7] media: video: introduce face detection driver module
Date: Tue, 6 Dec 2011 22:07:24 +0800
Message-ID: <CACVXFVPrAro=3t-wpbR_cVahzcx7SCa2J=s2nyyKfQ6SG-i0VQ@mail.gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>
	<1322838172-11149-7-git-send-email-ming.lei@canonical.com>
	<4EDD3DEE.6060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EDD3DEE.6060506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <snjw23@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Thanks for your review.

On Tue, Dec 6, 2011 at 5:55 AM, Sylwester Nawrocki <snjw23@gmail.com> w=
rote:
> Hi Ming,
>
> (I've pruned the Cc list, leaving just the mailing lists)
>
> On 12/02/2011 04:02 PM, Ming Lei wrote:
>> This patch introduces one driver for face detection purpose.
>>
>> The driver is responsible for all v4l2 stuff, buffer management
>> and other general things, and doesn't touch face detection hardware
>> directly. Several interfaces are exported to low level drivers
>> (such as the coming omap4 FD driver)which will communicate with
>> face detection hw module.
>>
>> So the driver will make driving face detection hw modules more
>> easy.
>
>
> I would hold on for a moment on implementing generic face detection
> module which is based on the V4L2 video device interface. We need to
> first define an API that would be also usable at sub-device interface
> level (http://linuxtv.org/downloads/v4l-dvb-apis/subdev.html).

If we can define a good/stable enough APIs between kernel and user spac=
e,
I think the patches can be merged first. For internal kernel APIs, we s=
hould
allow it to evolve as new hardware comes or new features are to be intr=
oduced.

I understand the API you mentioned here should belong to kernel interna=
l
API, correct me if it is wrong.

> AFAICS OMAP4 FDIF processes only data stored in memory, thus it seems
> reasonable to use the videodev interface for passing data to the kern=
el
> from user space.
>
> But there might be face detection devices that accept data from other
> H/W modules, e.g. transferred through SoC internal data buses between
> image processing pipeline blocks. Thus any new interfaces need to be
> designed with such devices in mind.
>
> Also the face detection hardware block might now have an input DMA
> engine in it, the data could be fed from memory through some other
> subsystem (e.g. resize/colour converter). Then the driver for that
> subsystem would implement a video node.

I think the direct input image or frame data to FD should be from memor=
y
no matter the actual data is from external H/W modules or input DMA bec=
ause
=46D will take lot of time to detect faces in one image or frame and FD=
 can't
have so much memory to cache several images or frames data.

If you have seen this kind of FD hardware design, please let me know.

> I'm for leaving the buffer handling details for individual drivers
> and focusing on a standard interface for applications, i.e. new

I think leaving buffer handling details in generic FD driver or
individual drivers
doesn't matter now, since it don't have effect on interfaces between ke=
rnel
and user space.

> ioctl(s) and controls.
>
>>
>> TODO:
>> =A0 =A0 =A0 - implement FD setting interfaces with v4l2 controls or
>> =A0 =A0 =A0 ext controls
>>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> =A0drivers/media/video/Kconfig =A0 =A0 =A0 | =A0 =A02 +
>> =A0drivers/media/video/Makefile =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/media/video/fdif/Kconfig =A0| =A0 =A07 +
>> =A0drivers/media/video/fdif/Makefile | =A0 =A01 +
>> =A0drivers/media/video/fdif/fdif.c =A0 | =A0645 ++++++++++++++++++++=
+++++++++++++++++
>> =A0drivers/media/video/fdif/fdif.h =A0 | =A0114 +++++++
>> =A06 files changed, 770 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/media/video/fdif/Kconfig
>> =A0create mode 100644 drivers/media/video/fdif/Makefile
>> =A0create mode 100644 drivers/media/video/fdif/fdif.c
>> =A0create mode 100644 drivers/media/video/fdif/fdif.h
>
> [...]
>
>> diff --git a/drivers/media/video/fdif/fdif.h b/drivers/media/video/f=
dif/fdif.h
>> new file mode 100644
>> index 0000000..ae37ab8
>> --- /dev/null
>> +++ b/drivers/media/video/fdif/fdif.h
>> @@ -0,0 +1,114 @@
>> +#ifndef _LINUX_FDIF_H
>> +#define _LINUX_FDIF_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/magic.h>
>> +#include <linux/errno.h>
>> +#include <linux/kref.h>
>> +#include <linux/kernel.h>
>> +#include <linux/videodev2.h>
>> +#include <media/videobuf2-page.h>
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-ioctl.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-fh.h>
>> +#include <media/v4l2-event.h>
>> +#include <media/v4l2-common.h>
>> +
>> +#define MAX_FACE_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 40
>> +
>> +#define =A0 =A0 =A0FACE_SIZE_20_PIXELS =A0 =A0 0
>> +#define =A0 =A0 =A0FACE_SIZE_25_PIXELS =A0 =A0 1
>> +#define =A0 =A0 =A0FACE_SIZE_32_PIXELS =A0 =A0 2
>> +#define =A0 =A0 =A0FACE_SIZE_40_PIXELS =A0 =A0 3
>
> This is still OMAP4 FDIF specific, we need to think about v4l2 contro=
ls
> for this. An ideal would be a menu control type that supports pixel s=
ize
> (width/height), but unfortunately something like this isn't available
> in v4l2 yet.

Yes, it is on TODO list, :-)

>> +
>> +#define FACE_DIR_UP =A0 =A0 =A0 =A0 =A00
>> +#define FACE_DIR_RIGHT =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
>> +#define FACE_DIR_LIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> +
>> +struct fdif_fmt {
>> + =A0 =A0 char =A0*name;
>> + =A0 =A0 u32 =A0 fourcc; =A0 =A0 =A0 =A0 =A0/* v4l2 format id */
>> + =A0 =A0 int =A0 depth;
>> + =A0 =A0 int =A0 width, height;
>
> Could width/height be negative ? I don't think it's the case for pixe=
l
> resolution. The more proper data type would be u32.

Yes, they should be, will fix it in next version.

> Please refer to struct v4l2_pix_format or struct v4l2_rect.
>
>> +};
>> +
>> +struct fdif_setting {
>> + =A0 =A0 struct fdif_fmt =A0 =A0 =A0 =A0 =A0 =A0*fmt;
>> + =A0 =A0 enum v4l2_field =A0 =A0 =A0 =A0 =A0 =A0field;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_face_size;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 face_dir;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 startx, starty=
;
>
> s32
>
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizex, sizey;
>
> u32
>
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lhit;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 width, height;
>
> u32
>
>> +};
>> +
>> +/* buffer for one video frame */
>> +struct fdif_buffer {
>> + =A0 =A0 /* common v4l buffer stuff -- must be first */
>> + =A0 =A0 struct vb2_buffer =A0 =A0 =A0 vb;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
>> +};
>> +
>> +
>> +struct v4l2_fdif_result {
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0face_c=
nt;
>> + =A0 =A0 struct v4l2_fd_detection =A0 =A0 =A0 =A0*faces;
>> +
>> + =A0 =A0 /*v4l2 buffer index*/
>> + =A0 =A0 __u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
index;
>> +};
>> +
>> +struct fdif_dmaqueue {
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0complete;
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0active;
>> + =A0 =A0 wait_queue_head_t =A0 =A0 =A0 wq;
>> +};
>> +
>> +
>> +struct fdif_dev {
>> + =A0 =A0 struct kref =A0 =A0 =A0 =A0 =A0 =A0 ref;
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
>> +
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0fdif_devlist;
>> + =A0 =A0 struct v4l2_device =A0 =A0 =A0v4l2_dev;
>> + =A0 =A0 struct vb2_queue =A0 =A0 =A0 =A0vbq;
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0mutex;
>> + =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
>> +
>> + =A0 =A0 struct video_device =A0 =A0 =A0 =A0*vfd;
>> + =A0 =A0 struct fdif_dmaqueue =A0 =A0fdif_dq;
>> +
>> + =A0 =A0 /*setting*/
>> + =A0 =A0 struct fdif_setting =A0 =A0 s;
>
> yy, please make it more descriptive. e.g.

Sounds reasonable, :-)

>
> =A0 =A0 =A0 =A0struct fdif_config =A0 =A0 =A0config;
>
>> +
>> + =A0 =A0 struct fdif_ops *ops;
>> +
>> + =A0 =A0 unsigned long =A0 priv[0];
>> +};
>> +
> [...]
>
> --
>
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

thanks,
--
Ming Lei
