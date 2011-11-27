From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 3/3] drivers/misc: introduce face detection module driver(fdif)
Date: Sun, 27 Nov 2011 11:40:24 +0800
Message-ID: <CACVXFVOh=_wAmQB1fm88RTbwoJxCo5w57-TpiH8zx5V-CC_TqA@mail.gmail.com>
References: <1322281904-14526-1-git-send-email-tom.leiming@gmail.com>
	<1322281904-14526-4-git-send-email-tom.leiming@gmail.com>
	<4ED1652A.8080701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53769 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1K0DkZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Nov 2011 22:40:25 -0500
In-Reply-To: <4ED1652A.8080701@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sylwester Nawrocki <snjw23@gmail.com>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-media <linux-media@vger.kernel.org>
Cc: tony@atomide.com, arnd@arndb.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi guys,

Thanks for your comment.

On Sun, Nov 27, 2011 at 6:16 AM, Sylwester Nawrocki <snjw23@gmail.com> =
wrote:
> Cc: LMML
>
> On 11/26/2011 05:31 AM, tom.leiming@gmail.com wrote:
>> From: Ming Lei <ming.lei@canonical.com>
>>
>> One face detection IP[1] is integared inside OMAP4 SoC, so
>> introduce this driver to make face detection function work
>> on OMAP4 SoC.
>
> Face detection IP is of course not specific to OMAP, I've seen it in =
other SoCs
> already and integrated with the video capture pipeline.

Yes, the driver is platform independent, so at least it can support
the same IP on different platforms.

>
> And it clearly belongs to the media subsystem, there is already an in=
frastructure
> there that don't need to be re-invented, like buffer management and v=
arious IO
> method support.
>
> I think there is not much needed on top of that to support FD. We hav=
e already
> various mem-to-mem devices in V4L2, like video or image encoders or v=
ideo
> post-processors.

I have thought about the FD implementation on v4l2 core, but still not
very clear
how to do it. I will study v4l2 further to figure out how to do it.

Now below are the basic requirements from FD:

- FD on video stream or pictures from external files
- FD on video stream or pictures from video device
(such as camera)
- the input video format may be different for different FD IP
- one method is required to start or stop FD
- one method is required to report the detection results to user space

Any suggestions on how to implement FD on v4l2?

thanks,
--
Ming Lei

>
>>
>> This driver is platform independent, so in theory can
>> be used to drive same IP module on other platforms.
>>
>> [1], ch9 of OMAP4 TRM
>>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> =A0drivers/misc/Kconfig =A0| =A0 =A07 +
>> =A0drivers/misc/Makefile | =A0 =A01 +
>> =A0drivers/misc/fdif.c =A0 | =A0874 ++++++++++++++++++++++++++++++++=
+++++++++++++++++
>> =A0include/linux/fdif.h =A0| =A0 67 ++++
>> =A0include/linux/major.h | =A0 =A01 +
>> =A05 files changed, 950 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/misc/fdif.c
>> =A0create mode 100644 include/linux/fdif.h
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 5664696..884d8c7 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -500,6 +500,13 @@ config USB_SWITCH_FSA9480
>> =A0 =A0 =A0 =A0 stereo and mono audio, video, microphone and UART da=
ta to use
>> =A0 =A0 =A0 =A0 a common connector port.
>>
>> +config FDIF
>> + =A0 =A0 tristate "Face Detection module"
>> + =A0 =A0 help
>> + =A0 =A0 =A0 The FDIF is a face detection module, which can be inte=
grated into
>> + =A0 =A0 =A0 SoCs to detect the location of human beings' face in o=
ne image. At
>> + =A0 =A0 =A0 least now, TI OMAP4 has the module inside.
>> +
>> =A0source "drivers/misc/c2port/Kconfig"
>> =A0source "drivers/misc/eeprom/Kconfig"
>> =A0source "drivers/misc/cb710/Kconfig"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index b26495a..0ed85ef 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -47,4 +47,5 @@ obj-$(CONFIG_AB8500_PWM) =A0 =A0+=3D ab8500-pwm.o
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D lis3lv02d/
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D carma/
>> =A0obj-$(CONFIG_USB_SWITCH_FSA9480) +=3D fsa9480.o
>> +obj-$(CONFIG_FDIF) =A0 =A0 =A0 =A0 =A0 +=3D fdif.o
>> =A0obj-$(CONFIG_ALTERA_STAPL) =A0 +=3Daltera-stapl/
>> diff --git a/drivers/misc/fdif.c b/drivers/misc/fdif.c
>> new file mode 100644
>> index 0000000..84a7049
>> --- /dev/null
>> +++ b/drivers/misc/fdif.c
>> @@ -0,0 +1,874 @@
>> +/*
>> + * =A0 =A0 =A0fdif.c =A0-- =A0face detection module driver
>> + *
>> + * =A0 =A0 =A0Copyright (C) 2011 =A0Ming Lei (ming.lei@canonical.co=
m)
>> + *
>> + * =A0 =A0 =A0This program is free software; you can redistribute i=
t and/or modify
>> + * =A0 =A0 =A0it under the terms of the GNU General Public License =
as published by
>> + * =A0 =A0 =A0the Free Software Foundation; either version 2 of the=
 License, or
>> + * =A0 =A0 =A0(at your option) any later version.
>> + *
>> + * =A0 =A0 =A0This program is distributed in the hope that it will =
be useful,
>> + * =A0 =A0 =A0but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of
>> + * =A0 =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =
=A0See the
>> + * =A0 =A0 =A0GNU General Public License for more details.
>> + *
>> + * =A0 =A0 =A0You should have received a copy of the GNU General Pu=
blic License
>> + * =A0 =A0 =A0along with this program; if not, write to the Free So=
ftware
>> + * =A0 =A0 =A0Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, =
USA.
>> + *
>> + */
>> +
>> +/******************************************************************=
***********/
>> +
>> +#include <linux/init.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +#include <linux/signal.h>
>> +#include <linux/wait.h>
>> +#include <linux/poll.h>
>> +#include <linux/module.h>
>> +#include <linux/major.h>
>> +#include <linux/cdev.h>
>> +#include <linux/mman.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/delay.h>
>> +#include <linux/user_namespace.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/fdif.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/io.h>
>> +
>> +#undef =A0 =A0 =A0 DEBUG
>> +
>> +#define FDIF_DEV =A0 =A0 MKDEV(FDIF_MAJOR, 0)
>> +#define FDIF_MAX_MINORS =A0 =A0 =A08
>> +
>> +#define =A0 =A0 =A0WORK_MEM_SIZE =A0 (52*1024)
>> +
>> +#define =A0 =A0 =A0FACE_SIZE_20_PIXELS =A0 =A0 0
>> +#define =A0 =A0 =A0FACE_SIZE_25_PIXELS =A0 =A0 1
>> +#define =A0 =A0 =A0FACE_SIZE_32_PIXELS =A0 =A0 2
>> +#define =A0 =A0 =A0FACE_SIZE_40_PIXELS =A0 =A0 3
>> +
>> +#define FACE_DIR_UP =A0 =A0 =A0 =A0 =A00
>> +#define FACE_DIR_RIGHT =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
>> +#define FACE_DIR_LIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> +
>> +/* 9.5 FDIF Register Manua of TI OMAP4 TRM */
>> +#define FDIF_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
>> +#define FDIF_HWINFO =A0 =A0 =A0 =A0 =A00x4
>> +#define FDIF_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x10
>> +#define SOFTRESET =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#define FDIF_IRQSTATUS_RAW_j (0x24 + 2*0x10)
>> +#define FDIF_IRQSTATUS_j =A0 =A0 (0x28 + 2*0x10)
>> +#define FDIF_IRQENABLE_SET_j (0x2c + 2*0x10)
>> +#define FDIF_IRQENABLE_CLR_j (0x30 + 2*0x10)
>> +#define FINISH_IRQ =A0 =A0 =A0 =A0 =A0 (1 << 8)
>> +#define ERR_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#define FDIF_PICADDR =A0 =A0 =A0 =A0 0x60
>> +#define FDIF_CTRL =A0 =A0 =A0 =A0 =A0 =A00x64
>> +#define CTRL_MAX_TAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0A
>> +
>> +#define FDIF_WKADDR =A0 =A0 =A0 =A0 =A00x68
>> +#define FD_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x80
>> +#define CTRL_FINISH =A0 =A0 =A0 =A0 =A0(1 << 2)
>> +#define CTRL_RUN =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
>> +#define CTRL_SRST =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +
>> +#define FD_DNUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x84
>> +#define FD_DCOND =A0 =A0 =A0 =A0 =A0 =A0 0x88
>> +#define FD_STARTX =A0 =A0 =A0 =A0 =A0 =A00x8c
>> +#define FD_STARTY =A0 =A0 =A0 =A0 =A0 =A00x90
>> +#define FD_SIZEX =A0 =A0 =A0 =A0 =A0 =A0 0x94
>> +#define FD_SIZEY =A0 =A0 =A0 =A0 =A0 =A0 0x98
>> +#define FD_LHIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x9c
>> +#define FD_CENTERX_i =A0 =A0 =A0 =A0 0x160
>> +#define FD_CENTERY_i =A0 =A0 =A0 =A0 0x164
>> +#define FD_CONFSIZE_i =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x168
>> +#define FD_ANGLE_i =A0 =A0 =A0 =A0 =A0 0x16c
>> +
>> +static irqreturn_t handle_detection(int irq, void *__fdif);
>> +
>> +struct fdif {
>> + =A0 =A0 struct platform_device =A0*pdev;
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0mutex;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 open_count;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
>> + =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0pict_dma;
>> + =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0work_dma;
>> +
>> + =A0 =A0 /* wake up if a face detection completed */
>> + =A0 =A0 wait_queue_head_t =A0 =A0 =A0 wait;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_idx;
>> +
>> + =A0 =A0 /*setting*/
>> + =A0 =A0 struct fdif_setting =A0 =A0 s;
>> +
>> + =A0 =A0 /*face detection result*/
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 face_cnt;
>> + =A0 =A0 struct fdif_result =A0 =A0 =A0faces[MAX_FACE_COUNT];
>> +};
>> +
>> +static struct class =A0*fdif_class;
>> +
>> +/*only support one fdif device now*/
>> +static struct fdif =A0 *g_fdif;
>> +
>> +static inline void fdif_writel(void __iomem *base, u32 reg, u32 val=
)
>> +{
>> + =A0 =A0 __raw_writel(val, base + reg);
>> +}
>> +
>> +static inline u32 fdif_readl(void __iomem *base, u32 reg)
>> +{
>> + =A0 =A0 return __raw_readl(base + reg);
>> +}
>> +
>> +#ifdef DEBUG
>> +static void dump_fdif_setting(struct fdif *fdif, const char *func)
>> +{
>> + =A0 =A0 printk("%s: %s\n", func, __func__);
>> + =A0 =A0 printk("picture addr:%8p, work mem addr:%8p\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.pict_addr, fdif->s=
=2Ework_mem_addr);
>> + =A0 =A0 printk("face size=3D%2d, face dir=3D%2d, lhit=3D%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.min_face_size, fdi=
f->s.face_dir,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.lhit);
>> + =A0 =A0 printk("startx =3D%4d starty=3D%4d sizex=3D%4d sizey=3D%4d=
\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.startx, fdif->s.st=
arty,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.sizex, fdif->s.siz=
ey);
>> +}
>> +
>> +static void dump_fdif_results(struct fdif *fdif, const char *func)
>> +{
>> + =A0 =A0 int idx;
>> +
>> + =A0 =A0 printk("%s: %s\n", func, __func__);
>> +
>> + =A0 =A0 printk("found %d faces\n", fdif->face_cnt);
>> + =A0 =A0 for(idx=3D0; idx < fdif->face_cnt; idx++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct fdif_result *fr =3D &fdif->faces[id=
x];
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(" =A0 =A0 =A0 =A0No.%d x=3D%3d y=3D=
%2d sz=3D%2d ang=3D%3d conf=3D%2d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx, fr->c=
enterx, fr->centery,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fr->size, =
fr->angle, fr->confidence);
>> + =A0 =A0 }
>> +}
>> +
>> +static void dump_fdif_regs(struct fdif *fdif, const char *func)
>> +{
>> + =A0 =A0 printk("%s:%s\n", __func__, func);
>> + =A0 =A0 printk("FDIF_CTRL=3D%08x FDIF_SYSCONFIG=3D%08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_CTRL),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_SYSCONFIG));
>> + =A0 =A0 printk("FDIF_IRQSTATUS_RAW_j=3D%08x FDIF_IRQSTATUS_j=3D%08=
x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_IRQSTATUS_RAW_j),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_IRQSTATUS_j));
>> + =A0 =A0 printk("FDIF_PICADDR=3D%08x FDIF_WKADDR=3D%08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_PICADDR),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_WKADDR));
>> + =A0 =A0 printk("FD_CTRL=3D%04x\n", fdif_readl(fdif->base, FD_CTRL)=
);
>> +}
>> +
>> +#else
>> +static inline void dump_fdif_setting(struct fdif *fdif, const char =
*func)
>> +{
>> +}
>> +static inline void dump_fdif_results(struct fdif *fdif, const char =
*func)
>> +{
>> +}
>> +static inline void dump_fdif_regs(struct fdif *fdif, const char *fu=
nc)
>> +{
>> +}
>> +#endif
>> +
>> +static void free_buffer(struct fdif *fdif)
>> +{
>> + =A0 =A0 int order;
>> +
>> + =A0 =A0 order =3D get_order(PICT_SIZE_X * PICT_SIZE_Y);
>> + =A0 =A0 free_pages((unsigned long)fdif->s.pict_addr, order);
>> +
>> + =A0 =A0 order =3D get_order(WORK_MEM_SIZE);
>> + =A0 =A0 free_pages((unsigned long)fdif->s.work_mem_addr, order);
>> +}
>> +
>> +static int allocate_buffer(struct fdif *fdif)
>> +{
>> + =A0 =A0 struct device *dev =3D &fdif->pdev->dev;
>> + =A0 =A0 int order, ret;
>> +
>> + =A0 =A0 order =3D get_order(PICT_SIZE_X * PICT_SIZE_Y);
>> + =A0 =A0 fdif->s.pict_addr =3D (void *)__get_free_pages(GFP_KERNEL,=
 order);
>> + =A0 =A0 if (!fdif->s.pict_addr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "fdif pict buffer allocation(=
%d) failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 order);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 order =3D get_order(WORK_MEM_SIZE);
>> + =A0 =A0 fdif->s.work_mem_addr =3D (void *)__get_free_pages(GFP_KER=
NEL, order);
>> + =A0 =A0 if (!fdif->s.work_mem_addr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "fdif buffer allocation(%d) f=
ailed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 order);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_mem;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +
>> +err_mem:
>> + =A0 =A0 free_buffer(fdif);
>> +err_out:
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int fdif_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct device =A0 *dev =3D &pdev->dev;
>> + =A0 =A0 struct fdif *fdif;
>> + =A0 =A0 struct resource *res;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 fdif =3D kzalloc(sizeof(*fdif), GFP_KERNEL);
>> + =A0 =A0 if (!fdif) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory allocation failed\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto end_probe;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "fdif get resource failed\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_iomap;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 fdif->base =3D ioremap(res->start, resource_size(res));
>> + =A0 =A0 if (!fdif->base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "fdif ioremap failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_iomap;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 fdif->irq =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 if (fdif->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "fdif get irq failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_get_irq;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D request_irq(fdif->irq, handle_detection, 0, "fdif"=
, fdif);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_get_irq;
>> +
>> + =A0 =A0 init_waitqueue_head(&fdif->wait);
>> + =A0 =A0 mutex_init(&fdif->mutex);
>> +
>> + =A0 =A0 pm_suspend_ignore_children(dev, true);
>> + =A0 =A0 fdif->dev =3D device_create(fdif_class, dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MKDEV(FDIF_MAJOR, 0),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, "fdif");
>> + =A0 =A0 if (!fdif->dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_device_create;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 fdif->pdev =3D pdev;
>> + =A0 =A0 platform_set_drvdata(pdev, fdif);
>> +
>> + =A0 =A0 pm_runtime_get_sync(dev);
>> + =A0 =A0 dev_info(dev, "fdif version=3D%8x hwinfo=3D%08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_REVISION),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif_readl(fdif->base, FDI=
=46_HWINFO));
>> + =A0 =A0 pm_runtime_put(dev);
>> +
>> + =A0 =A0 g_fdif =3D fdif;
>> + =A0 =A0 return 0;
>> +
>> +err_device_create:
>> + =A0 =A0 free_irq(fdif->irq, fdif);
>> +err_get_irq:
>> + =A0 =A0 iounmap(fdif->base);
>> +err_iomap:
>> + =A0 =A0 kfree(fdif);
>> +end_probe:
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int fdif_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct fdif *fdif =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 device_destroy(fdif_class, MKDEV(FDIF_MAJOR, 0));
>> + =A0 =A0 free_irq(fdif->irq, fdif);
>> + =A0 =A0 iounmap(fdif->base);
>> + =A0 =A0 kfree(fdif);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int fdif_suspend(struct platform_device *pdev, pm_message_t =
msg)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int fdif_resume(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_device_id fdif_device_ids[] =3D {
>> + =A0 =A0 {.name =3D "fdif"},
>> + =A0 =A0 {},
>> +};
>> +
>> +struct platform_driver fdif_driver =3D {
>> + =A0 =A0 .probe =3D =A0 =A0 =A0 =A0fdif_probe,
>> + =A0 =A0 .remove =3D =A0 =A0 =A0 fdif_remove,
>> + =A0 =A0 .suspend =3D =A0 =A0 =A0fdif_suspend,
>> + =A0 =A0 .resume =3D =A0 =A0 =A0 fdif_resume,
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0=3D =A0 =A0 =A0 =A0"fdif",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
>> + =A0 =A0 },
>> + =A0 =A0 .id_table =3D =A0 =A0 fdif_device_ids,
>> +};
>> +
>> +static void install_default_setting(struct fdif *fdif)
>> +{
>> + =A0 =A0 fdif->s.min_face_size =A0 =3D FACE_SIZE_25_PIXELS;
>> + =A0 =A0 fdif->s.face_dir =A0 =A0 =A0 =A0=3D FACE_DIR_UP;
>> + =A0 =A0 fdif->s.startx =A0 =A0 =A0 =A0 =A0=3D 0;
>> + =A0 =A0 fdif->s.starty =A0 =A0 =A0 =A0 =A0=3D 0;
>> + =A0 =A0 fdif->s.sizex =A0 =A0 =A0 =A0 =A0 =3D 0x140;
>> + =A0 =A0 fdif->s.sizey =A0 =A0 =A0 =A0 =A0 =3D 0xf0;
>> + =A0 =A0 fdif->s.lhit =A0 =A0 =A0 =A0 =A0 =A0=3D 0x5;
>> +}
>> +
>> +static void commit_image_setting(struct fdif *fdif)
>> +{
>> + =A0 =A0 unsigned long conf;
>> + =A0 =A0 struct device *dev =3D &fdif->pdev->dev;
>> +
>> + =A0 =A0 fdif->pict_dma =3D dma_map_single(dev, fdif->s.pict_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PICT_SIZE_=
X*PICT_SIZE_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEV=
ICE);
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_PICADDR, fdif->pict_dma);
>> +
>> + =A0 =A0 conf =3D (fdif->s.min_face_size & 0x3) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((fdif->s.face_dir & 0x3) << 2);
>> + =A0 =A0 fdif_writel(fdif->base, FD_DCOND, conf);
>> +
>> + =A0 =A0 fdif_writel(fdif->base, FD_STARTX, fdif->s.startx);
>> + =A0 =A0 fdif_writel(fdif->base, FD_STARTY, fdif->s.starty);
>> + =A0 =A0 fdif_writel(fdif->base, FD_SIZEX, fdif->s.sizex);
>> + =A0 =A0 fdif_writel(fdif->base, FD_SIZEY, fdif->s.sizey);
>> + =A0 =A0 fdif_writel(fdif->base, FD_LHIT, fdif->s.lhit);
>> +}
>> +
>> +static void start_detect(struct fdif *fdif)
>> +{
>> + =A0 =A0 unsigned long conf;
>> +
>> + =A0 =A0 dump_fdif_setting(fdif, __func__);
>> + =A0 =A0 dump_fdif_regs(fdif, __func__);
>> +
>> + =A0 =A0 fdif->face_cnt =3D -1;
>> + =A0 =A0 commit_image_setting(fdif);
>> +
>> + =A0 =A0 /*enable finish irq*/
>> + =A0 =A0 conf =3D FINISH_IRQ;
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_IRQENABLE_SET_j, conf);
>> +
>> + =A0 =A0 /*set RUN flag*/
>> + =A0 =A0 conf =3D CTRL_RUN;
>> + =A0 =A0 fdif_writel(fdif->base, FD_CTRL, conf);
>> +}
>> +
>> +static void stop_detect(struct fdif *fdif)
>> +{
>> + =A0 =A0 unsigned long conf;
>> + =A0 =A0 struct device *dev =3D &fdif->pdev->dev;
>> +
>> + =A0 =A0 dma_unmap_single(dev, fdif->pict_dma,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PICT_SIZE_=
X*PICT_SIZE_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEV=
ICE);
>> + =A0 =A0 /*disable finish irq*/
>> + =A0 =A0 conf =3D FINISH_IRQ;
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_IRQENABLE_CLR_j, conf);
>> +
>> + =A0 =A0 /*mark FINISH flag*/
>> + =A0 =A0 conf =3D CTRL_FINISH;
>> + =A0 =A0 fdif_writel(fdif->base, FD_CTRL, conf);
>> +}
>> +
>> +/*softreset fdif*/
>> +static int softreset_fdif(struct fdif *fdif)
>> +{
>> + =A0 =A0 unsigned long conf;
>> + =A0 =A0 int to =3D 0;
>> +
>> + =A0 =A0 conf =3D fdif_readl(fdif->base, FDIF_SYSCONFIG);
>> + =A0 =A0 conf |=3D SOFTRESET;
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_SYSCONFIG, conf);
>> +
>> + =A0 =A0 while ((conf & SOFTRESET) && to++ < 2000) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 conf =3D fdif_readl(fdif->base, FDIF_SYSCO=
NFIG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(2);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (to =3D=3D 2000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: reset failed\n", __fu=
nc__);
>> +
>> + =A0 =A0 return to =3D=3D 2000;
>> +}
>> +
>> +static int read_faces(struct fdif *fdif)
>> +{
>> + =A0 =A0 int cnt;
>> + =A0 =A0 int idx =3D 0;
>> +
>> + =A0 =A0 cnt =3D fdif_readl(fdif->base, FD_DNUM) & 0x3f;
>> +
>> + =A0 =A0 fdif->face_cnt =3D cnt;
>> + =A0 =A0 fdif->read_idx =3D 0;
>> +
>> + =A0 =A0 while(idx < cnt) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct fdif_result *fr =3D &fdif->faces[id=
x];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 fr->centerx =3D fdif_readl(fdif->base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_CENTERX=
_i + idx * 0x10) & 0x1ff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fr->centery =3D fdif_readl(fdif->base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_CENTERY=
_i + idx * 0x10) & 0xff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fr->angle =3D fdif_readl(fdif->base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_ANGLE_i=
 + idx * 0x10) & 0x1ff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fr->size =3D fdif_readl(fdif->base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_CONFSIZ=
E_i + idx * 0x10);
>> + =A0 =A0 =A0 =A0 =A0 =A0 fr->confidence =3D (fr->size >> 8) & 0xf;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fr->size =3D fr->size & 0xff;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 idx++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 stop_detect(fdif);
>> + =A0 =A0 dump_fdif_results(fdif, __func__);
>> + =A0 =A0 wake_up(&fdif->wait);
>> +
>> + =A0 =A0 return fdif->face_cnt;
>> +}
>> +
>> +static irqreturn_t handle_detection(int irq, void *__fdif)
>> +{
>> + =A0 =A0 unsigned long irqsts;
>> + =A0 =A0 struct fdif *fdif =3D __fdif;
>> +
>> + =A0 =A0 dump_fdif_regs(fdif, __func__);
>> +
>> + =A0 =A0 /*clear irq status*/
>> + =A0 =A0 irqsts =3D fdif_readl(fdif->base, FDIF_IRQSTATUS_j);
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_IRQSTATUS_j, irqsts);
>> +
>> + =A0 =A0 if (irqsts & FINISH_IRQ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 read_faces(fdif);
>> + =A0 =A0 } else if (irqsts & ERR_IRQ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&fdif->pdev->dev, "err irq!");
>> + =A0 =A0 =A0 =A0 =A0 =A0 softreset_fdif(fdif);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&fdif->pdev->dev, "spurious irq!")=
;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static void fdif_global_init(struct fdif *fdif)
>> +{
>> + =A0 =A0 unsigned long conf;
>> + =A0 =A0 struct device *dev =3D &fdif->pdev->dev;
>> +
>> + =A0 =A0 /*softreset fdif*/
>> + =A0 =A0 softreset_fdif(fdif);
>> +
>> + =A0 =A0 /*set max tags*/
>> + =A0 =A0 conf =3D fdif_readl(fdif->base, FDIF_CTRL);
>> + =A0 =A0 conf &=3D ~0x1e;
>> + =A0 =A0 conf |=3D (CTRL_MAX_TAGS << 1);
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_CTRL, conf);
>> +
>> + =A0 =A0 /*enable error irq*/
>> + =A0 =A0 conf =3D ERR_IRQ;
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_IRQENABLE_SET_j, conf);
>> +
>> + =A0 =A0 fdif->work_dma =3D dma_map_single(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.wo=
rk_mem_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WORK_MEM_S=
IZE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEV=
ICE);
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_WKADDR, fdif->work_dma);
>> +}
>> +
>> +static void fdif_global_deinit(struct fdif *fdif)
>> +{
>> + =A0 =A0 unsigned long conf;
>> + =A0 =A0 struct device *dev =3D &fdif->pdev->dev;
>> +
>> + =A0 =A0 /*enable error irq*/
>> + =A0 =A0 conf =3D ERR_IRQ;
>> + =A0 =A0 fdif_writel(fdif->base, FDIF_IRQENABLE_CLR_j, conf);
>> +
>> + =A0 =A0 dma_unmap_single(dev, fdif->work_dma,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WORK_MEM_SIZE, DMA_TO_DEVI=
CE);
>> +}
>> +
>> +/*
>> + * file operations
>> + */
>> +static int fdif_open(struct inode *inode, struct file *file)
>> +{
>> + =A0 =A0 struct fdif *fdif =3D g_fdif;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (iminor(inode) || !fdif) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk("fdif: device is not correct!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_lock(&fdif->mutex);
>> +
>> + =A0 =A0 if (!fdif->open_count++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D allocate_buffer(fdif);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_mem;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 install_default_setting(fdif);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&fdif->pdev->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 fdif_global_init(fdif);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 file->private_data =3D fdif;
>> + =A0 =A0 goto err_out;
>> +
>> +err_mem:
>> + =A0 =A0 free_buffer(fdif);
>> +err_out:
>> + =A0 =A0 mutex_unlock(&fdif->mutex);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int fdif_release(struct inode *inode, struct file *file)
>> +{
>> + =A0 =A0 struct fdif *fdif =3D file->private_data;
>> +
>> + =A0 =A0 if (!fdif)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 mutex_lock(&fdif->mutex);
>> +
>> + =A0 =A0 if (!--fdif->open_count) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 stop_detect(fdif);
>> + =A0 =A0 =A0 =A0 =A0 =A0 fdif_global_deinit(fdif);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&fdif->pdev->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_buffer(fdif);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_unlock(&fdif->mutex);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static ssize_t fdif_read(struct file *file, char __user *buf, size_=
t nbytes,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0loff_t *ppos)
>> +{
>> + =A0 =A0 struct fdif *fdif =3D file->private_data;
>> + =A0 =A0 ssize_t ret =3D 0;
>> + =A0 =A0 unsigned len;
>> + =A0 =A0 loff_t pos =3D *ppos;
>> + =A0 =A0 int size;
>> +
>> + =A0 =A0 /*not support unaligned read*/
>> + =A0 =A0 if ((long)pos % sizeof(struct fdif_result))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> +
>> + =A0 =A0 /*wait for completation of current detection*/
>> + =A0 =A0 wait_event_interruptible(fdif->wait, fdif->face_cnt !=3D -=
1);
>> +
>> + =A0 =A0 mutex_lock(&fdif->mutex);
>> + =A0 =A0 if (fdif->face_cnt =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ERESTARTSYS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (fdif->read_idx < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (fdif->face_cnt <=3D fdif->read_idx)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> +
>> + =A0 =A0 size =3D (fdif->face_cnt - fdif->read_idx) *
>> + =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct fdif_result);
>> + =A0 =A0 if (pos < size) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D size - pos;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (len > nbytes)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D nbytes;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 len -=3D len % sizeof(struct fdif_result);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (copy_to_user(buf, &fdif->faces[fdif->r=
ead_idx], len)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 fdif->read_idx +=3D len / sizeof(struct fd=
if_result);
>> + =A0 =A0 =A0 =A0 =A0 =A0 *ppos +=3D len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret +=3D len;
>> + =A0 =A0 }
>> +err:
>> + =A0 =A0 mutex_unlock(&fdif->mutex);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +#ifdef DEBUG
>> +static void print_cmd(int cmd, void __user *p)
>> +{
>> + =A0 =A0 char buf[64];
>> + =A0 =A0 int arg, l =3D 63;
>> +
>> + =A0 =A0 switch (cmd) {
>> + =A0 =A0 case FDIF_START:
>> + =A0 =A0 =A0 =A0 =A0 =A0 strcpy(buf, "START");
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_GET_FACE_CNT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 strcpy(buf, "GET_CNT");
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_STOP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 strcpy(buf, "STOP");
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_RESET:
>> + =A0 =A0 =A0 =A0 =A0 =A0 strcpy(buf, "RESET");
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_GET_SETTING:
>> + =A0 =A0 =A0 =A0 =A0 =A0 strcpy(buf, "GET_SETTING");
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_MIN_FACE_SIZE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D sprintf(buf, "SET_MIN_FACE_SIZE: %d"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (get_user(arg,(unsigned in=
t __user *)p) ? : arg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_STARTXY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D sprintf(buf, "SET_STARTXY: %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (get_user(arg,(unsigned in=
t __user *)p) ? : arg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_SIZEXY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D sprintf(buf, "SET_SIZEXY: %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (get_user(arg,(unsigned in=
t __user *)p) ? : arg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_FACE_DIR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D sprintf(buf, "SET_FACE_DIR: %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (get_user(arg,(unsigned in=
t __user *)p) ? : arg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_LHIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D sprintf(buf, "SET_LHIT: %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (get_user(arg,(unsigned in=
t __user *)p) ? : arg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 strcpy(buf, "????");
>> + =A0 =A0 }
>> +
>> + =A0 =A0 buf[l] =3D '\0';
>> +
>> + =A0 =A0 printk("%s: %s\n", __func__, buf);
>> +}
>> +#else
>> +static inline void print_cmd(int cmd, void __user *p)
>> +{
>> +}
>> +#endif
>> +
>> +static long fdif_ioctl(struct file *file, unsigned int cmd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long arg)
>> +{
>> + =A0 =A0 struct fdif *fdif =3D file->private_data;
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 int val;
>> +
>> + =A0 =A0 if (!(file->f_mode & FMODE_WRITE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> +
>> + =A0 =A0 print_cmd(cmd, (void __user *)arg);
>> +
>> + =A0 =A0 mutex_lock(&fdif->mutex);
>> + =A0 =A0 switch (cmd) {
>> + =A0 =A0 case FDIF_START:
>> + =A0 =A0 =A0 =A0 =A0 =A0 start_detect(fdif);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_GET_FACE_CNT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (put_user(fdif->face_cnt, (u32 __user *=
)arg))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_STOP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 stop_detect(fdif);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_RESET:
>> + =A0 =A0 =A0 =A0 =A0 =A0 softreset_fdif(fdif);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_GET_SETTING:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D (copy_to_user((void __user *)arg, =
&fdif->s,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(str=
uct fdif_setting)) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -EFAULT : =
0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_MIN_FACE_SIZE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D get_user(val, (int __user *)arg) ?=
 -EFAULT : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.min_face_size =3D =
val;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_STARTXY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D get_user(val, (int __user *)arg) ?=
 -EFAULT : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.startx =3D val & 0=
xffff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.starty =3D (val >>=
 16) & 0xffff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_SIZEXY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D get_user(val, (int __user *)arg) ?=
 -EFAULT : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.sizex =3D val & 0x=
ffff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.sizey =3D (val >> =
16) & 0xffff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_FACE_DIR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D get_user(val, (int __user *)arg) ?=
 -EFAULT : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.face_dir =3D val;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case FDIF_SET_LHIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D get_user(val, (int __user *)arg) ?=
 -EFAULT : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdif->s.lhit =3D val;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
>> + =A0 =A0 }
>> + =A0 =A0 mutex_unlock(&fdif->mutex);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int fdif_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> + =A0 =A0 struct fdif *fdif =3D file->private_data;
>> + =A0 =A0 unsigned long off;
>> + =A0 =A0 unsigned long start;
>> + =A0 =A0 u32 len;
>> +
>> + =A0 =A0 if (!fdif)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 off =3D vma->vm_pgoff << PAGE_SHIFT;
>> +
>> + =A0 =A0 mutex_lock(&fdif->mutex);
>> + =A0 =A0 start =3D virt_to_phys(fdif->s.pict_addr);
>> + =A0 =A0 len =3D PAGE_ALIGN((start & ~PAGE_MASK) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PICT_SIZE_X * PICT_SIZE_Y)=
;
>> + =A0 =A0 if (off >=3D len) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&fdif->mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 mutex_unlock(&fdif->mutex);
>> +
>> + =A0 =A0 start &=3D PAGE_MASK;
>> + =A0 =A0 if ((vma->vm_end - vma->vm_start + off) > len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 off +=3D start;
>> +
>> + =A0 =A0 vma->vm_pgoff =3D off >> PAGE_SHIFT;
>> + =A0 =A0 vma->vm_flags |=3D VM_IO | VM_RESERVED;
>> + =A0 =A0 vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
>> +
>> + =A0 =A0 if (remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vma->vm_end - v=
ma->vm_start, vma->vm_page_prot))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static unsigned int fdif_poll(struct file *file,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pol=
l_table_struct *wait)
>> +{
>> + =A0 =A0 struct fdif *fdif =3D file->private_data;
>> + =A0 =A0 unsigned int mask =3D 0;
>> +
>> + =A0 =A0 poll_wait(file, &fdif->wait, wait);
>> + =A0 =A0 if (file->f_mode & FMODE_WRITE && fdif->face_cnt !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask |=3D POLLOUT | POLLWRNORM;
>> + =A0 =A0 return mask;
>> +}
>> +
>> +const struct file_operations fdif_file_operations =3D {
>> + =A0 =A0 .owner =3D =A0 =A0 =A0 =A0 =A0THIS_MODULE,
>> + =A0 =A0 .read =3D =A0 =A0 =A0 =A0 =A0 fdif_read,
>> + =A0 =A0 .poll =3D =A0 =A0 =A0 =A0 =A0 fdif_poll,
>> + =A0 =A0 .unlocked_ioctl =3D fdif_ioctl,
>> + =A0 =A0 .mmap =3D =A0 =A0 =A0 =A0 =A0 fdif_mmap,
>> + =A0 =A0 .open =3D =A0 =A0 =A0 =A0 =A0 fdif_open,
>> + =A0 =A0 .release =3D =A0 =A0 =A0 =A0fdif_release,
>> +};
>> +
>> +static int __init fdif_init(void)
>> +{
>> + =A0 =A0 int retval;
>> +
>> + =A0 =A0 fdif_class =3D class_create(THIS_MODULE, "fdif");
>> + =A0 =A0 if (IS_ERR(fdif_class)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to creat fdif clas=
s\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 retval =3D platform_driver_register(&fdif_driver);
>> + =A0 =A0 if (retval) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register fdif d=
river\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_driver_register;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if ((retval =3D register_chrdev(FDIF_MAJOR, "fdif",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &fdif_file=
_operations))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to get fdif device=
 major %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FDIF_MAJOR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_chr;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +
>> +err_chr:
>> + =A0 =A0 platform_driver_unregister(&fdif_driver);
>> +err_driver_register:
>> + =A0 =A0 class_destroy(fdif_class);
>> +out:
>> + =A0 =A0 return retval;
>> +}
>> +
>> +static void fdif_cleanup(void)
>> +{
>> + =A0 =A0 unregister_chrdev(FDIF_MAJOR, "fdif");
>> + =A0 =A0 platform_driver_unregister(&fdif_driver);
>> + =A0 =A0 class_destroy(fdif_class);
>> +}
>> +
>> +module_init(fdif_init);
>> +module_exit(fdif_cleanup);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:fdif");
>> +MODULE_AUTHOR("Ming Lei <ming.lei@canonical.com>");
>> diff --git a/include/linux/fdif.h b/include/linux/fdif.h
>> new file mode 100644
>> index 0000000..c0494c2
>> --- /dev/null
>> +++ b/include/linux/fdif.h
>> @@ -0,0 +1,67 @@
>> +/******************************************************************=
***********/
>> +
>> +/*
>> + * =A0 fdif.h =A0--- =A0 =A0 face detection header file
>> + *
>> + * =A0 Copyright (C) 2011
>> + * =A0 =A0 =A0 =A0 =A0Ming Lei (ming.lei@canonical.com)
>> + *
>> + * =A0 This program is free software; you can redistribute it and/o=
r modify
>> + * =A0 it under the terms of the GNU General Public License as publ=
ished by
>> + * =A0 the Free Software Foundation; either version 2 of the Licens=
e, or
>> + * =A0 (at your option) any later version.
>> + *
>> + * =A0 This program is distributed in the hope that it will be usef=
ul,
>> + * =A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of
>> + * =A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See =
the
>> + * =A0 GNU General Public License for more details.
>> + *
>> + * =A0 You should have received a copy of the GNU General Public Li=
cense
>> + * =A0 along with this program; if not, write to the Free Software
>> + * =A0 Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + *
>> + */
>> +
>> +/******************************************************************=
***********/
>> +
>> +#ifndef _LINUX_FDIF_H
>> +#define _LINUX_FDIF_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/magic.h>
>> +
>> +#define MAX_FACE_COUNT =A035
>> +#define PICT_SIZE_X =A0 =A0 320
>> +#define PICT_SIZE_Y =A0 =A0 240
>> +
>> +struct fdif_setting {
>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pict_addr;
>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*work_mem_addr=
;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_face_size;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 face_dir;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 startx, starty=
;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizex, sizey;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lhit;
>> +};
>> +
>> +struct fdif_result {
>> + =A0 =A0 unsigned short centerx;
>> + =A0 =A0 unsigned short centery;
>> + =A0 =A0 unsigned short angle;
>> + =A0 =A0 unsigned short size;
>> + =A0 =A0 unsigned short confidence;
>> +};
>> +
>> +#define FDIF_START =A0 =A0 =A0 =A0 =A0 _IOR('F', 0x24, unsigned int=
)
>> +#define FDIF_GET_FACE_CNT =A0 =A0_IOR('F', 0x25, unsigned int)
>> +#define FDIF_STOP =A0 =A0 =A0 =A0 =A0 =A0_IOR('F', 0x26, unsigned i=
nt)
>> +#define FDIF_RESET =A0 =A0 =A0 =A0 =A0 _IOR('F', 0x27, unsigned int=
)
>> +
>> +#define FDIF_GET_SETTING =A0 =A0 _IOR('F', 0x28, struct fdif_settin=
g)
>> +#define FDIF_SET_MIN_FACE_SIZE =A0 =A0 =A0 _IOR('F', 0x2a, unsigned=
 int)
>> +#define FDIF_SET_STARTXY =A0 =A0 _IOR('F', 0x2b, unsigned int)
>> +#define FDIF_SET_SIZEXY =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOR('F', 0x2c, =
unsigned int)
>> +#define FDIF_SET_FACE_DIR =A0 =A0_IOR('F', 0x2d, unsigned int)
>> +#define FDIF_SET_LHIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOR('F', 0x2e=
, unsigned int)
>> +
>> +#endif /* _LINUX_FDIF_H */
>> diff --git a/include/linux/major.h b/include/linux/major.h
>> index 6a8ca98..57d1c98 100644
>> --- a/include/linux/major.h
>> +++ b/include/linux/major.h
>> @@ -174,4 +174,5 @@
>> =A0#define BLOCK_EXT_MAJOR =A0 =A0 =A0 =A0 =A0 =A0 =A0259
>> =A0#define SCSI_OSD_MAJOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 260 =A0 =A0 /*=
 open-osd's OSD scsi device */
>>
>> +#define FDIF_MAJOR =A0 =A0 =A0 =A0 =A0 261
>> =A0#endif
>



--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
