From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2: Camera: Add OMAP2 24xx camera driver.
Date: Thu, 1 Mar 2007 12:56:34 +0530
Message-ID: <5d5443650702282326w79a4a4aexf0f33a804cd975c@mail.gmail.com>
References: <45E5A489.2040108@nokia.com>
	<11726783562347-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11726783562347-git-send-email-sakari.ailus@nokia.com>
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

On 2/28/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
> This is a modified version of the camera driver originally from Montavista.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/media/video/omap/Makefile             |    1 +
>  drivers/media/video/omap/omap24xxcam-core.c   |  202 ++++
>  drivers/media/video/omap/omap24xxcam-dma.c    |  320 +++++++
>  drivers/media/video/omap/omap24xxcam-dma.h    |   65 ++
>  drivers/media/video/omap/omap24xxcam-dmahw.c  |  224 +++++
>  drivers/media/video/omap/omap24xxcam-sensor.c |  226 +++++
>  drivers/media/video/omap/omap24xxcam-sgdma.c  |  298 ++++++
>  drivers/media/video/omap/omap24xxcam-vbq.c    |  370 ++++++++
>  drivers/media/video/omap/omap24xxcam.c        | 1216 > +

First review comments...

> +#include "omap24xxcam.h"
> +
> +/* Program the camera interface xclk for the frequency cam->img.xclk based on
> + * the functional clock frequency cam->img.mclk.  If the specifed cam->img.xclk
> + * frequency is not possible based on the value of cam->img.mclk, then the
> + * closest xclk frequency lower than the specified xclk will be selected.
> + * The actual xclk frequency is returned in cam->img.xclk.  If cam->img.xclk is zero,
> + * then xclk is turned off (stable low value).
> + */
> +
> +void omap24xxcam_core_init(struct omap24xxcam_core *core,
> +                          unsigned long base)
> +{
> +       DBG;
> +
> +       core->base = base;
> +
> +       /* Setting the camera core AUTOIDLE bit causes problems with frame
> +        * synchronization, so we will clear the AUTOIDLE bit instead.
> +        */
> +       //omap24xxcam_reg_out(cam, CC_SYSCONFIG, 0);

DBG should be removed from everywhere.

> +       omap24xxcam_reg_out(core->base, CC_SYSCONFIG, CC_SYSCONFIG_AUTOIDLE);
> +
> +       core->xclk_enabled = 0;
> +}
> +
> +void omap24xxcam_core_exit(const struct omap24xxcam_core *core)
> +{
> +}

Nothing in core_exit ? If yes, then should be removed.

> +
> +void omap24xxcam_core_enable_callback(struct omap24xxcam_device *cam)
> +{
> +       omap24xxcam_core_enable(&cam->core);
> +}
> +/* reset core fifo and dma */
> +/* void omap24xxcam_core_reset(struct omap24xxcam_device *cam) */
> +/* { */
> +/*     omap24xxcam_reg_out(cam, CC_CTRL, CC_CTRL_CC_RST); */
> +/* } */

Remove this commented code if not used.

> +
> +/* Interrupt service routine for camera core interrupts. */
> +void omap24xxcam_core_isr(struct omap24xxcam_core *core)
> +{
> +       unsigned long cc_irqstatus;
> +       const unsigned long cc_irqstatus_err =
> +               CC_IRQSTATUS_FW_ERR_IRQ
> +               | CC_IRQSTATUS_FSC_ERR_IRQ
> +               | CC_IRQSTATUS_SSC_ERR_IRQ
> +               | CC_IRQSTATUS_FIFO_UF_IRQ
> +               | CC_IRQSTATUS_FIFO_OF_IRQ;
> +
> +       DBG;
> +
> +       cc_irqstatus = omap24xxcam_reg_in(core->base, CC_IRQSTATUS);
> +       omap24xxcam_reg_out(core->base, CC_IRQSTATUS, cc_irqstatus);
> +
> +       if (cc_irqstatus & cc_irqstatus_err) {
> +               printk("%s: scheduling camera reset, cc_irqstatus 0x%lx\n",
> +                      __FUNCTION__, cc_irqstatus);
> +               omap24xxcam_camera_reset_schedule(
> +                       container_of(core, struct omap24xxcam_device, core));
> +       } else {
> +               if (cc_irqstatus & 0xffff)
> +                       printk("%s: cc_irqstatus 0x%lx\n",
> +                              __FUNCTION__, cc_irqstatus);
> +       }

Add proper KERN_INFO/KERN_WARN/KERN_ERR etc. as needed.

> diff --git a/drivers/media/video/omap/omap24xxcam-dma.c b/drivers/media/video/omap/omap24xxcam-dma.c
> new file mode 100644
> index 0000000..d10f1c8
> --- /dev/null
> +++ b/drivers/media/video/omap/omap24xxcam-dma.c
> @@ -0,0 +1,320 @@

...

> +#include <asm/semaphore.h>
> +
> +#include "omap24xxcam.h"
> +#include "omap24xxcam-dma.h"
> +
> +/* configuration macros */
> +#define CAM_NAME       "omap24xxcam"
> +#define CONFIG_H4

CONFIG_H4 is not used anywhere.

...

> diff --git a/drivers/media/video/omap/omap24xxcam-dmahw.c b/drivers/media/video/omap/omap24xxcam-dmahw.c
> new file mode 100644
> index 0000000..21d23db
> --- /dev/null
> +++ b/drivers/media/video/omap/omap24xxcam-dmahw.c
> @@ -0,0 +1,224 @@
> +/*
> + * drivers/media/video/omap/omap24xxcam-dma.c

Doesn't match with file name.

> + *
> + * Video-for-Linux (Version 2) camera capture driver for
> + * the OMAP24xx camera controller.
> + *
> + * Author: David Cohen <david.cohen@indt.org.br>
> + * Based on: omap24xxcam.c by Andy Lowe (source@mvista.com)
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2004 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * History:
> + * 2005/nov - David Cohen <david.cohen@indt.org.br>
> + *            Updated the driver for the Linux Device Model and new version of V4L2.
> + */

Why same History is carried too? For History I would suggest GIT
commit comments. This keeps file header clean :)

> +
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/smp_lock.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <linux/videodev.h>
> +#include <linux/pci.h>         /* needed for videobufs */
> +#include <media/video-buf.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/input.h>
> +#include <linux/version.h>
> +
> +#include <asm/io.h>
> +#include <asm/byteorder.h>
> +#include <asm/scatterlist.h>
> +#include <asm/irq.h>
> +#include <asm/semaphore.h>

Do you need all the header files here too? OR just copied from omap24xxcam.c ?

> +
> +#include "omap24xxcam.h"
> +#include "omap24xxcam-dma.h"
> +
> +/* configuration macros */
> +#define CAM_NAME       "omap24xxcam"
> +#define CONFIG_H4

CONFIG_H4 again.

> +
> +/* Ack all interrupt on CSR and IRQSTATUS_L0 */
> +void omap24xxcam_dmahw_ack_all(unsigned long base)
> +{
> +       unsigned long csr;
> +       int i;
> +
> +       for (i = 0; i< 4; ++i) {

Use NUM_CAM_DMACHANNELS?

> +               csr = omap24xxcam_reg_in(base, CAMDMA_CSR(i));
> +               /* ack interrupt in CSR */
> +               omap24xxcam_reg_out(base, CAMDMA_CSR(i), csr);
> +       }
> +       omap24xxcam_reg_out(base, CAMDMA_IRQSTATUS_L0, 0xffffffff);
> +}
> +
> +/* Ack dmach on CSR and IRQSTATUS_L0 */
> +unsigned long omap24xxcam_dmahw_ack_ch(unsigned long base, int dmach)
> +{
> +       unsigned long csr;
> +
> +       csr = omap24xxcam_reg_in(base, CAMDMA_CSR(dmach));
> +       /* ack interrupt in CSR */
> +       omap24xxcam_reg_out(base, CAMDMA_CSR(dmach), csr);
> +       /* ack interrupt in IRQSTATUS */
> +       omap24xxcam_reg_out(base, CAMDMA_IRQSTATUS_L0, (1 << dmach));
> +
> +       return csr;
> +}
> +

...

> diff --git a/drivers/media/video/omap/omap24xxcam-sensor.c b/drivers/media/video/omap/omap24xxcam-sensor.c
> new file mode 100644
> index 0000000..bde7429
> --- /dev/null
> +++ b/drivers/media/video/omap/omap24xxcam-sensor.c
> @@ -0,0 +1,226 @@
> +/*
> + * drivers/media/video/omap/omap24xxcam-dma.c

Again mismatch against filenames. It is better that we avoid putting
filepath in file header.

> + *
> + * Video-for-Linux (Version 2) camera capture driver for
> + * the OMAP24xx camera controller.
> + *
> + * Author: David Cohen <david.cohen@indt.org.br>
> + * Based on: omap24xxcam.c by Andy Lowe (source@mvista.com)
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2004 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * History:
> + * 2005/nov - David Cohen <david.cohen@indt.org.br>
> + *            Updated the driver for the Linux Device Model and new version of V4L2.
> + */
> +
...

> +
> +void omap24xxcam_sensor_reset_work(void * data)
> +{
> +       struct omap24xxcam_device *cam = (struct omap24xxcam_device *)data;

Do we really need such castings?

> +
> +       omap24xxcam_sensor_disable(cam);
> +
> +       omap24xxcam_sensor_enable(cam);
> +}

...

...

> +
> +/* This should be called by the sensor code whenever it's ready */
> +int omap24xxcam_sensor_register(struct omap_camera *oc,
> +                               struct omap_camera_sensor *os)
> +{
> +       struct omap24xxcam_device *cam = oc->priv;
> +       int rval;
> +
> +       /* the device has not been initialised yet */
> +       if (cam == NULL)
> +               return -ENODEV;
> +       if (os == NULL)
> +               return -EINVAL;
> +       if (cam->sensor != NULL)
> +               return -EBUSY;
> +
> +       cam->sensor = os;
> +       rval = omap24xxcam_device_enable(cam);
> +
> +       if (rval)
> +               cam->sensor = NULL;
> +       return rval;
> +}
> +
> +EXPORT_SYMBOL(omap24xxcam_sensor_register);

What registration functionality is done above? I can see only checking
against the sensor initialization and enabling it if not. Please use
proper name.

> +
> +void omap24xxcam_sensor_unregister(struct omap_camera *oc,
> +                                  struct omap_camera_sensor *os)
> +{
> +       struct omap24xxcam_device *cam = oc->priv;
> +
> +       BUG_ON(cam->users != 0);
> +       BUG_ON(cam->sensor == NULL);
> +
> +       cam->sensor = NULL;
> +}
> +
> +EXPORT_SYMBOL(omap24xxcam_sensor_unregister);
> diff --git a/drivers/media/video/omap/omap24xxcam-sgdma.c b/drivers/media/video/omap/omap24xxcam-sgdma.c
> new file mode 100644
> index 0000000..0243a59
> --- /dev/null
> +++ b/drivers/media/video/omap/omap24xxcam-sgdma.c
> @@ -0,0 +1,298 @@
> +/*

...

> +/* Sync scatter-gather DMA by aborting any DMA transfers currently in progress.
> + * Any queued scatter-gather DMA transactions that have not yet been started
> + * will remain queued.  The DMA controller will be idle after this routine
> + * completes.  When the scatter-gather queue is restarted, the next
> + * scatter-gather DMA transfer will begin at the start of a new transaction.
> + */
> +void
> +omap24xxcam_sgdma_sync(struct omap24xxcam_sgdma *sgdma, unsigned long csr)
> +{
> +       unsigned long irqflags;
> +       int sgslot;
> +       struct sgdma_state *sg_state;
> +
> +       DBG;
> +
> +       /* stop any DMA transfers in progress */
> +       omap24xxcam_dma_stop(&sgdma->dma, csr);
> +
> +       spin_lock_irqsave(&sgdma->lock, irqflags);
> +
> +       if (sgdma->free_sgdma < NUM_SG_DMA) {
> +               sgslot = (sgdma->next_sgdma + sgdma->free_sgdma) % NUM_SG_DMA;
> +               sg_state = sgdma->sg_state + sgslot;
> +               if (sg_state->next_sglist != 0) {
> +                       /* This DMA transfer was in progress, so abort it. */
> +                       sgdma_callback_t callback = sg_state->callback;
> +                       void *arg = sg_state->arg;
> +                       sgdma->free_sgdma++;
> +                       if (callback) {
> +                               /* leave interrupts masked */
> +                               spin_unlock(&sgdma->lock);
> +                               (*callback) (sgdma, csr, arg);
> +                               spin_lock(&sgdma->lock);
> +                       }
> +               }
> +       }
> +
> +       spin_unlock_irqrestore(&sgdma->lock, irqflags);
> +}
> +
> +
> +void omap24xxcam_sgdma_init(struct omap24xxcam_sgdma *sgdma, unsigned long base)

I think this lines exceeds 80 column rule.
...

> diff --git a/drivers/media/video/omap/omap24xxcam-vbq.c b/drivers/media/video/omap/omap24xxcam-vbq.c
> new file mode 100644
> index 0000000..f6d8803
> --- /dev/null
> +++ b/drivers/media/video/omap/omap24xxcam-vbq.c
> @@ -0,0 +1,370 @@
> +/*
> + * OMAP 24xx camera high-level DMA (not hardware) and scatter-gather
> + * DMA handling
> + *

...

> diff --git a/drivers/media/video/omap/omap24xxcam.c b/drivers/media/video/omap/omap24xxcam.c
> new file mode 100644
> index 0000000..4f954ed
> --- /dev/null
> +++ b/drivers/media/video/omap/omap24xxcam.c
> @@ -0,0 +1,1216 @@
> +/*
> + * drivers/media/video/omap/omap24xxcam.c
> + *
> + * Video-for-Linux (Version 2) camera capture driver for
> + * the OMAP24xx camera controller.
> + *
> + * Author: Andy Lowe (source@mvista.com)
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2004 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * History:
> + * 2005/nov - David Cohen <david.cohen@indt.org.br>
> + *            Updated the driver for the Linux Device Model and new version of V4L2.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
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
> +#include <linux/i2c.h>
> +#include <linux/videodev2.h>
> +#include <linux/pci.h>         /* needed for videobufs */
> +#include <linux/dma-mapping.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/version.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +
> +#include <media/video-buf.h>
> +#include <media/v4l2-common.h>
> +
> +#include <asm/io.h>
> +#include <asm/byteorder.h>
> +#include <asm/scatterlist.h>
> +#include <asm/irq.h>
> +#include <asm/semaphore.h>
> +#include <asm/processor.h>

Do we need all above header files? like processor.h ? Please check.

> +
> +#include <asm/arch/clock.h>

#include <linux/clk.h> ?

> +
> +#include "omap24xxcam.h"
> +#include "omap24xxcam-dma.h"
> +
> +#include "sensor_if.h"
> +
> +/* configuration macros */
> +
> +//#define DEBUG_CAM
> +#ifdef DEBUG_CAM
> +#define DBG            printk(KERN_INFO CAM_NAME ": %s\n", __FUNCTION__)
> +#define DBG_END        printk(KERN_INFO CAM_NAME ": %s END!\n", __FUNCTION__)
> +#define DBG_MID(x)     printk(KERN_INFO CAM_NAME ": %s - %d\n", __FUNCTION__, x)
> +#else
> +#define DBG
> +#define DBG_END
> +#define DBG_MID(x)
> +#endif

Remove above DBG stuff, something like pr_debug?

> +
> +void omap24xxcam_camera_reset_schedule(struct omap24xxcam_device *cam)
> +{
> +       schedule_work(&cam->camera_reset_work);
> +}
> +
> +static irqreturn_t omap24xxcam_isr(int irq, void *arg, struct pt_regs *regs)
> +{
> +       struct omap24xxcam_device *cam = (struct omap24xxcam_device *)arg;

unnecessary casting.

Ah...How it is ported to 2.6.20? struct pt_regs is still there.

> +
> +static int
> +omap24xxcam_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct omap24xxcam_fh *fh = file->private_data;
> +       int err;
> +
> +       /* let the video-buf mapper check arguments and set-up structures */
> +       err = videobuf_mmap_mapper(&fh->vbq, vma);
> +       if (err)
> +               goto err1;
> +
> +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +       /* do mapping to our allocated buffers */
> +       err = omap24xxcam_mmap_buffers(file, vma);
> +       if (err)
> +               goto err2;
> +
> +       return 0;
> +
> +err2:
> +       if (vma->vm_private_data)
> +               kfree(vma->vm_private_data);
> +err1:
> +
> +       return err;

It is better not to use err1, err2 kind of goto labels. Instead
err_videobuf_mmap and err_omap_mmap. You know the benefits.

> +
> +static void omap24xxcam_clock_put(struct omap24xxcam_device *cam)
> +{
> +       if (cam->img.ick == NULL)
> +               return;

What about img.fck check ?

> +
> +       clk_put(cam->img.ick);
> +       clk_put(cam->img.fck);
> +}

...

> +
> +        */
> +       /* choose an arbitrary xclk frequency */
> +       omap24xxcam_core_xclk_set(&cam->core, 12000000);
> +
> +       omap24xxcam_camera.priv = cam;
> +
> +       if ((rval = omap24xxcam_sensor_init(cam))) {
> +               goto err;
> +       }

No need of { }. Also please use proper goto labels as suggested earlier.

> +
> +       if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
> +               printk(KERN_ERR CAM_NAME
> +                      ": could not register Video for Linux device\n");
> +               vfd->minor = -1;
> +               rval = -EBUSY;
> +               goto err;
> +       }
> +
> +       printk(KERN_INFO CAM_NAME
> +              ": registered device video%d [v4l2]\n", vfd->minor);
> +
> +       return 0;
> +
> +err:
> +       omap24xxcam_device_disable(cam);
> +
> +       return rval;
> +}
> +
> +void omap24xxcam_device_disable(struct omap24xxcam_device *cam)
> +{
> +       omap24xxcam_sensor_exit(cam);
> +
> +       if (cam->vfd) {
> +               if (cam->vfd->minor == -1) {
> +                       /* The device was never registered, so release the
> +                        * video_device struct directly.
> +                        */
> +                       video_device_release(cam->vfd);
> +               } else {
> +                       /* The unregister function will release the video_device
> +                        * struct as well as unregistering it.
> +                        */
> +                       video_unregister_device(cam->vfd);
> +               }
> +               cam->vfd = NULL;
> +       }
> +}
> +
> +static int omap24xxcam_probe(struct platform_device *pdev)
> +{
> +       struct omap24xxcam_device *cam;
> +       DBG;
> +

...

> +
> +       /* install the interrupt service routine */
> +       if (request_irq(INT_24XX_CAM_IRQ, omap24xxcam_isr, IRQF_DISABLED,
> +                       CAM_NAME, cam)) {
> +               printk(KERN_ERR CAM_NAME
> +                      ": could not install interrupt service routine\n");
> +               goto err;
> +       }
> +       cam->irq = INT_24XX_CAM_IRQ;

Please make proper use of platform_data and resources. irq should have
come from device.c registration of platform resource. Please check my
patches.

http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009064.html

> +
> +       /* set driver specific data to use in power management functions */
> +       platform_set_drvdata(pdev, cam);
> +
> +       mutex_init(&cam->mutex);
> +       cam->users = 0;
> +
> +       cam->camera_block_alive = 1;
> +
> +       omap24xxcam_device_enable(cam);
> +
> +       return 0;
> +
> +err:
> +       omap24xxcam_remove(&omap24xxcam_dev);
> +       return -ENODEV;
> +}
> +
> +static int omap24xxcam_remove(struct platform_device *pdev)
> +{
> +       struct omap24xxcam_device *cam = camera_module;

Why not platform_get_drvdata() ?

> +
> +       if (!cam)
> +               return 0;
> +
> +       omap24xxcam_device_disable(cam);
> +
> +       if (cam->irq) {
> +               free_irq(cam->irq, cam);
> +               cam->irq = 0;
> +       }
> +
> +       omap24xxcam_sgdma_exit(&cam->sgdma);
> +       omap24xxcam_core_exit(&cam->core);
> +
> +       omap24xxcam_clock_off(cam);
> +       omap24xxcam_clock_put(cam);
> +
> +       if (cam->mmio_base) {
> +               iounmap((void *)cam->mmio_base);
> +               cam->mmio_base = 0;
> +       }
> +
> +       if (cam->mmio_base_phys) {
> +               release_mem_region(cam->mmio_base_phys,
> +                                  cam->mmio_size);
> +               cam->mmio_base_phys = 0;
> +       }
> +
> +       kfree(cam);
> +       camera_module = NULL;
> +
> +       return 0;
> +}
> +

...

> diff --git a/drivers/media/video/omap/omap24xxcam.h b/drivers/media/video/omap/omap24xxcam.h
> new file mode 100644
> index 0000000..eba5ea6
> --- /dev/null
> +++ b/drivers/media/video/omap/omap24xxcam.h
> @@ -0,0 +1,659 @@
> +/*
> + * drivers/media/video/omap24xxcam.h

Incorrect filepath.

> + *
> + * Video-for-Linux (Version 2) camera capture driver for
> + * the OMAP24xx camera controller.
> + *
> + * Author: Andy Lowe (source@mvista.com)
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2004 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef OMAP24XXCAM_H
> +#define OMAP24XXCAM_H
> +
> +#include "sensor_if.h"
> +
> +//#define DEBUG_CAM
> +
> +#define CAM_NAME       "omap24xxcam"
> +
> +#ifdef DEBUG_CAM
> +#define DBG            printk(KERN_INFO CAM_NAME ": %s\n", __FUNCTION__)
> +#define DBG_END        printk(KERN_INFO CAM_NAME ": %s END!\n", __FUNCTION__)
> +#define DBG_MID(x)     printk(KERN_INFO CAM_NAME ": %s - %d\n", __FUNCTION__, x)
> +#else
> +#define DBG
> +#define DBG_END
> +#define DBG_MID(x)
> +#endif

Remove above DBGs.

-- 
--Trilok Soni
