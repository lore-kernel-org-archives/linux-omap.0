From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 4/6] omap: introduce common remoteproc module
Date: Tue, 27 Jul 2010 20:19:32 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA21F8@dbde02.ent.ti.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
 <1278022994-28476-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36384 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0G0Oti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 10:49:38 -0400
In-Reply-To: <1278022994-28476-5-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ben-cohen, Ohad" <ohadb@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohen
> Sent: Friday, July 02, 2010 3:53 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ben-cohen, Ohad
> Subject: [RFC 4/6] omap: introduce common remoteproc module
>
> From: Ohad Ben-Cohen <ohadb@ti.com>
>
> The OMAP remote processor module decouples
> machine-specific code from TI's IPC
> drivers (e.g. dspbridge and syslink).
>
> While dspbridge calls the remoteproc handlers
> from the kernel, syslink calls them from
> user space. Hence remoteproc supports both
> interfaces.
>
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/remoteproc.h |   75 ++++++
>  arch/arm/plat-omap/remoteproc.c              |  316
> ++++++++++++++++++++++++++
>  2 files changed, 391 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
>  create mode 100644 arch/arm/plat-omap/remoteproc.c
>
> diff --git a/arch/arm/plat-omap/include/plat/remoteproc.h
> b/arch/arm/plat-omap/include/plat/remoteproc.h
> new file mode 100644
> index 0000000..1cedd08
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/remoteproc.h
> @@ -0,0 +1,75 @@
> +/*
> + * OMAP Remote Processor driver
> + *
> + * Copyright (C) 2010 Texas Instruments Inc.
> + *
> + * Written by Ohad Ben-Cohen <ohad@wizery.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be
> useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#ifndef REMOTEPROC_H
> +#define REMOTEPROC_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/cdev.h>
> +
> +#define RPROC_IOC_MAGIC              'P'

[sp] I notice that there is already a conflict with this magic number in
     Documentation/ioctl/ioctl-number.txt.

     Suggest reserving a different code as per the steps mentioned in the
     same file.

> +
> +#define RPROC_IOCSTART               _IOW(RPROC_IOC_MAGIC, 1, int)
> +#define RPROC_IOCSTOP                _IO(RPROC_IOC_MAGIC, 2)
> +#define RPROC_IOCGETSTATE    _IOR(RPROC_IOC_MAGIC, 3, int)
> +
> +#define RPROC_IOC_MAXNR              (3)
> +
> +struct omap_rproc;
> +
> +struct omap_rproc_ops {
> +     int (*start)(struct device *dev, u32 start_addr);
> +     int (*stop)(struct device *dev);
> +     int (*get_state)(struct device *dev);
> +};
> +
> +struct omap_rproc_clk_t {
> +     void *clk_handle;
> +     const char *dev_id;
> +     const char *con_id;
> +};
> +

[sp] Small description of the fields in the structure will help understand the code better.
     I couldn't locate usage of con_id in this patch; not sure what it signifies.
     ...hope it becomes clear in one of the other patches in the series.
     (after one review) The structure is not used anywhere in this file.

> +struct omap_rproc_platform_data {
> +     struct omap_rproc_ops *ops;
> +     char *name;
> +     char *oh_name;
> +};

[sp] same comment here.

> +
> +struct omap_rproc {
> +     struct device *dev;
> +     struct cdev cdev;
> +     atomic_t count;

[sp] I believe this field is for "use-counts". If so, suggest renaming to
     "usecount".

> +     int minor;
> +};
> +
> +struct omap_rproc_start_args {
> +     u32 start_addr;
> +};
> +
> +struct omap_rproc_platform_data *omap3_get_rproc_data(void);
> +int omap3_get_rproc_data_size(void);
> +struct omap_rproc_platform_data *omap4_get_rproc_data(void);
> +int omap4_get_rproc_data_size(void);
[sp] The forward declaration seems to be used for plugging
     device specific data (haven't looked at complet code, so
     it is currently a speculation).

     The contents of this header have so far been device independent.
     Can we look to reorganiza this code such that this header remains
     generic?

> +int omap_get_num_of_remoteproc(void);

[sp] Don't see this being implemented in the "C" file below.
     If this function is expected to be implemented in the omap3/4
     specific file, then I suspect multi-omap will break for compilation.
     Same function will be defined multiple times.

> +
> +#endif /* REMOTEPROC_H */
> diff --git a/arch/arm/plat-omap/remoteproc.c
> b/arch/arm/plat-omap/remoteproc.c
> new file mode 100644
> index 0000000..7a9862e
> --- /dev/null
> +++ b/arch/arm/plat-omap/remoteproc.c
> @@ -0,0 +1,316 @@
> +/*
> + * OMAP Remote Processor driver
> + *
> + * Copyright (C) 2010 Texas Instruments Inc.
> + *
> + * Authors:
> + * Ohad Ben-Cohen <ohad@wizery.com>
> + * Hari Kanigeri <h-kanigeri2@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be
> useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/file.h>
> +#include <linux/poll.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +
> +#include <plat/remoteproc.h>
> +
> +#define OMAP_RPROC_NAME "omap-rproc"

[sp] See my comment in 0/6 about "omap-" prefix in the name.

     BTW, I am reviewing this file from bottom; so comments may not be
     in sequence.

> +
> +static struct class *omap_rproc_class;
> +static dev_t omap_rproc_dev;
> +static atomic_t num_of_rprocs;
> +
> +static inline int rproc_start(struct omap_rproc *rproc,
> const void __user *arg)
> +{
> +     struct omap_rproc_platform_data *pdata;
> +     struct omap_rproc_start_args start_args;
> +
> +     if (!rproc->dev)
> +             return -EINVAL;
> +
> +     pdata = rproc->dev->platform_data;
> +     if (!pdata->ops)
> +             return -EINVAL;
> +
> +     if (copy_from_user(&start_args, arg, sizeof(start_args)))
> +             return -EFAULT;
> +
> +     return pdata->ops->start(rproc->dev, start_args.start_addr);
> +}
> +
> +static inline int rproc_stop(struct omap_rproc *rproc)
> +{
> +     struct omap_rproc_platform_data *pdata;
> +     if (!rproc->dev)
> +             return -EINVAL;
> +
> +     pdata = rproc->dev->platform_data;
> +     if (!pdata->ops)
> +             return -EINVAL;
> +
> +     return pdata->ops->stop(rproc->dev);
> +}
> +
> +static inline int rproc_get_state(struct omap_rproc *rproc)
> +{
> +     struct omap_rproc_platform_data *pdata;
> +     if (!rproc->dev)
> +             return -EINVAL;
> +
> +     pdata = rproc->dev->platform_data;
> +     if (!pdata->ops)
> +             return -EINVAL;
> +
> +     return pdata->ops->get_state(rproc->dev);
> +}
> +
> +static int omap_rproc_open(struct inode *inode, struct file *filp)

[sp] May be nitpicking, but "filp" could simply be "fp" ... more common
     in usage for file pointer.

> +{
> +     unsigned int count, dev_num = iminor(inode);
> +     struct omap_rproc *rproc;
> +     struct omap_rproc_platform_data *pdata;
> +
> +     rproc = container_of(inode->i_cdev, struct omap_rproc, cdev);
> +     if (!rproc->dev)
> +             return -EINVAL;
> +
> +     pdata = rproc->dev->platform_data;
> +
> +     count = atomic_inc_return(&rproc->count);

[sp] Wouldn't atomic_read() be better used here?
     Avoids the need to call atomic_dec() below.

> +     dev_info(rproc->dev, "%s: dev num %d, name %s, count
> %d\n", __func__,
> +                                                     dev_num,
> +                                                     pdata->name,
> +                                                     count);
> +     if (count > 1) {
> +             dev_err(rproc->dev, "%s failed: remoteproc
> already in use\n",
> +
> __func__);
> +             atomic_dec(&rproc->count);
> +             return -EBUSY;
> +     }
> +
> +     filp->private_data = rproc;
> +
> +     return 0;
> +}
> +
> +static int omap_rproc_release(struct inode *inode, struct file *filp)
> +{
> +     struct omap_rproc_platform_data *pdata;
> +     struct omap_rproc *rproc = filp->private_data;
> +     if (!rproc || !rproc->dev)
> +             return -EINVAL;
> +
> +     pdata = rproc->dev->platform_data;
> +
> +     atomic_dec(&rproc->count);
> +
> +     return 0;
> +}
> +
> +static int omap_rproc_ioctl(struct inode *inode, struct file *filp,
> +                                     unsigned int cmd,
> unsigned long arg)
> +{
> +     int rc = 0;
> +     struct omap_rproc *rproc = filp->private_data;
> +
> +     dev_info(rproc->dev, "%s\n", __func__);
> +
> +     if (!rproc)
> +             return -EINVAL;
> +
> +     if (_IOC_TYPE(cmd) != RPROC_IOC_MAGIC)
> +             return -ENOTTY;
> +     if (_IOC_NR(cmd) > RPROC_IOC_MAXNR)
> +             return -ENOTTY;
> +
> +     switch (cmd) {
> +     case RPROC_IOCSTART:
> +             if (!capable(CAP_SYS_ADMIN))
> +                     return -EPERM;
> +             rc = rproc_start(rproc, (const void __user *) arg);
> +             break;
> +     case RPROC_IOCSTOP:
> +             if (!capable(CAP_SYS_ADMIN))
> +                     return -EPERM;
> +             rc = rproc_stop(rproc);
> +             break;
> +     case RPROC_IOCGETSTATE:
> +             rc = rproc_get_state(rproc);
> +             break;
> +
> +     default:
> +             return -ENOTTY;
> +     }
> +
> +     return rc;

[sp] Most of the functions in this file use "ret" as variable for
     return value. Here "rc" seems to out of place... significance
     didn't click to me immediately.

> +}
> +
> +static const struct file_operations omap_rproc_fops = {
> +     .open           =       omap_rproc_open,
> +     .release        =       omap_rproc_release,
> +     .ioctl          =       omap_rproc_ioctl,
> +     .owner          =       THIS_MODULE,
> +};
> +
> +static int omap_rproc_probe(struct platform_device *pdev)

[sp] Shouldn't this be __devinit ?

> +{
> +     int ret = 0, major, minor;
> +     struct device *tmpdev;
> +     struct device *dev = &pdev->dev;
> +     struct omap_rproc_platform_data *pdata = dev->platform_data;
> +     struct omap_rproc *rproc;
> +
> +     if (!pdata || !pdata->name || !pdata->oh_name || !pdata->ops)
> +             return -EINVAL;
> +
> +     dev_info(dev, "%s: adding rproc %s\n", __func__, pdata->name);
> +
> +     rproc = kzalloc(sizeof(struct omap_rproc), GFP_KERNEL);
[sp] any specific reason to not use kmalloc instead?

> +     if (!rproc) {
> +             dev_err(dev, "%s: kzalloc failed\n", __func__);
> +             ret = -ENOMEM;
> +             goto out;
> +     }
> +
> +     platform_set_drvdata(pdev, rproc);
> +     major = MAJOR(omap_rproc_dev);
> +     minor = atomic_read(&num_of_rprocs);
> +     atomic_inc(&num_of_rprocs);
> +
> +     rproc->dev = dev;
> +     rproc->minor = minor;
> +     atomic_set(&rproc->count, 0);
> +     cdev_init(&rproc->cdev, &omap_rproc_fops);

[sp] Character driver under directory "arch/arm/plat-omap" ?
     Shouldn't this driver be elsewhere? In fact, it will
     help make it usable for non-OMAP devices as well.

> +     rproc->cdev.owner = THIS_MODULE;
> +     ret = cdev_add(&rproc->cdev, MKDEV(major, minor), 1);
> +     if (ret) {
> +             dev_err(dev, "%s: cdev_add failed: %d\n",
> __func__, ret);
> +             goto free_rproc;
> +     }
> +
> +     tmpdev = device_create(omap_rproc_class, NULL,
> +                             MKDEV(major, minor),
> +                             NULL,
> +                             OMAP_RPROC_NAME "%d", minor);
> +     if (IS_ERR(tmpdev)) {
> +             ret = PTR_ERR(tmpdev);
> +             dev_err(dev, "%s: device_create failed: %d\n",
> __func__, ret);
> +             goto clean_cdev;
> +     }
> +
> +     dev_info(dev, "%s initialized %s, major: %d, base-minor: %d\n",
> +                     OMAP_RPROC_NAME,
> +                     pdata->name,
> +                     MAJOR(omap_rproc_dev),
> +                     minor);
> +     return 0;
> +
> +clean_cdev:
> +     cdev_del(&rproc->cdev);
> +free_rproc:
> +     kfree(rproc);
> +out:
> +     return ret;
> +}
> +
> +static int __devexit omap_rproc_remove(struct platform_device *pdev)
> +{
> +     int major = MAJOR(omap_rproc_dev);
> +     struct device *dev = &pdev->dev;
> +     struct omap_rproc_platform_data *pdata = dev->platform_data;
> +     struct omap_rproc *rproc = platform_get_drvdata(pdev);
> +
> +     if (!pdata || !rproc)
> +             return -EINVAL;
> +
> +     dev_info(dev, "%s removing %s, major: %d, base-minor: %d\n",
> +                     OMAP_RPROC_NAME,
> +                     pdata->name,
> +                     major,
> +                     rproc->minor);
> +
> +     device_destroy(omap_rproc_class, MKDEV(major, rproc->minor));
> +     cdev_del(&rproc->cdev);
> +
> +     return 0;
> +}
> +
> +static struct platform_driver omap_rproc_driver = {
> +     .probe = omap_rproc_probe,
> +     .remove = __devexit_p(omap_rproc_remove),
> +     .driver = {
> +             .name = OMAP_RPROC_NAME,
> +             .owner = THIS_MODULE,
> +     },
> +};
> +
> +static int __init omap_rproc_init(void)
> +{
> +     int num = omap_get_num_of_remoteproc();
> +     int ret;
> +
> +     ret = alloc_chrdev_region(&omap_rproc_dev, 0, num,
> OMAP_RPROC_NAME);
> +     if (ret) {
> +             pr_err("%s: alloc_chrdev_region failed: %d\n",
> __func__, ret);
> +             goto out;
> +     }
> +
> +     omap_rproc_class = class_create(THIS_MODULE, OMAP_RPROC_NAME);
> +     if (IS_ERR(omap_rproc_class)) {
> +             ret = PTR_ERR(omap_rproc_class);
> +             pr_err("%s: class_create failed: %d\n", __func__, ret);
> +             goto unreg_region;
> +     }
> +
> +     atomic_set(&num_of_rprocs, 0);

[sp] In the beginning of function "num" is expected to contain
     number of remote processors - going by the function name.

     Any specific reason for setting this variable to "0" which
     again seem to signify the same.

     There may be a reason; but it isn't clear here.

> +
> +     ret = platform_driver_register(&omap_rproc_driver);
> +     if (ret) {
> +             pr_err("%s: platform_driver_register failed:
> %d\n", __func__,
> +
>       ret);
> +             goto out;
> +     }
> +
> +     return 0;
> +
> +unreg_region:
> +     unregister_chrdev_region(omap_rproc_dev, num);
> +out:
> +     return ret;
> +}
> +module_init(omap_rproc_init);
> +
> +static void __exit omap_rproc_exit(void)
> +{
> +     int num = omap_get_num_of_remoteproc();

[sp] Why not use variable "num_of_rprocs" instead
     of fetching the value again?

     (after one review cycle) I see that you are using
     this variable to track the num of "open" active
     remote processors - not the total num. Renaming
     the variable appropriately will help.

> +
> +     class_destroy(omap_rproc_class);
> +     unregister_chrdev_region(omap_rproc_dev, num);
> +}
> +module_exit(omap_rproc_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("OMAP Remote Processor driver");
> +MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
> +MODULE_AUTHOR("Hari Kanigeri <h-kanigeri2@ti.com>");
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
