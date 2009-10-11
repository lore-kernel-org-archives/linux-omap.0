From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v1 1/2] arm: a driver for on-chip ETM and ETB
Date: Mon, 12 Oct 2009 00:07:57 +0200
Message-ID: <63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:46725 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZJKWIf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Oct 2009 18:08:35 -0400
Received: by bwz6 with SMTP id 6so2763408bwz.37
        for <linux-omap@vger.kernel.org>; Sun, 11 Oct 2009 15:07:58 -0700 (PDT)
In-Reply-To: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: Russell King <linux@arm.linux.org.uk>, Juha Leppanen <juha_motorsportcom@luukku.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2009/10/11 Alexander Shishkin <virtuoso@slind.org>:

> This driver implements support for on-chip Embedded Tracing Macrocell=
 and
> Embedded Trace Buffer. It allows to trigger tracing of kernel executi=
on flow
> and exporting trace output to userspace via character device and a sy=
srq
> combo.

Cool, can it at all be interfaced to kernel tracing mechanisms like
ftrace, LTTng...? Or is this entirely orthogonal?

=46irst, these are registered as platform devices, should they not be A=
MBA
devices (i.e. PrimeCells?) I think that's what they are, and they proba=
bly
have device ID:s to be matched in the last words of their 4K pages
do they not?

> (...)
> diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
> new file mode 100644
> index 0000000..3e7b431
> --- /dev/null
> +++ b/arch/arm/kernel/etm.c
> @@ -0,0 +1,588 @@
> +/*
> + * linux/arch/arm/kernel/etm.c
> + *
> + * Driver for ARM's Embedded Trace Macrocell and Embedded Trace Buff=
er.
> + *
> + * Copyright (C) 2009 Nokia Corporation.
> + * Alexander Shishkin
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/sysrq.h>
> +#include <linux/platform_device.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/miscdevice.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mutex.h>
> +#include <asm/hardware/coresight.h>
> +#include <asm/sections.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alexander Shishkin");
> +
> +static struct tracectx tracer;
> +
> +static inline bool trace_isrunning(struct tracectx *t)
> +{
> + =A0 =A0 =A0 return !!(t->flags & TRACER_RUNNING);
> +}
> +
> +static int etm_setup_address_range(struct tracectx *t, int n,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long start, unsigned long end,=
 int exclude, int data)
> +{
> + =A0 =A0 =A0 u32 flags =3D ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT=
_NSONLY | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ETMAAT_NOVALCMP;
> +
> + =A0 =A0 =A0 if (n < 1 || n > t->ncmppairs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* comparators and ranges are numbered starting with 1 =
as opposed
> + =A0 =A0 =A0 =A0* to bits in a word */
> + =A0 =A0 =A0 n--;
> +
> + =A0 =A0 =A0 if (data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D ETMAAT_DLOADSTORE;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D ETMAAT_IEXEC;
> +
> + =A0 =A0 =A0 /* first comparator for the range */
> + =A0 =A0 =A0 etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2));
> + =A0 =A0 =A0 etm_writel(t, start, ETMR_COMP_VAL(n * 2));
> +
> + =A0 =A0 =A0 /* second comparator is right next to it */
> + =A0 =A0 =A0 etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2 + 1));
> + =A0 =A0 =A0 etm_writel(t, end, ETMR_COMP_VAL(n * 2 + 1));
> +
> + =A0 =A0 =A0 flags =3D exclude ? ETMTE_INCLEXCL : 0;
> + =A0 =A0 =A0 etm_writel(t, flags | (1 << n), ETMR_TRACEENCTRL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int trace_start(struct tracectx *t)
> +{
> + =A0 =A0 =A0 u32 v;
> + =A0 =A0 =A0 unsigned long timeout =3D TRACER_TIMEOUT;
> +
> + =A0 =A0 =A0 etb_unlock(t);
> +
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_FORMATTERCTRL);
> + =A0 =A0 =A0 etb_writel(t, 1, ETBR_CTRL);
> +
> + =A0 =A0 =A0 etb_lock(t);
> +
> + =A0 =A0 =A0 /* configure etm */
> + =A0 =A0 =A0 v =3D ETMCTRL_OPTS | ETMCTRL_PROGRAM | ETMCTRL_PORTSIZE=
(t->etm_portsz);
> +
> + =A0 =A0 =A0 if (t->flags & TRACER_CYCLE_ACC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v |=3D ETMCTRL_CYCLEACCURATE;
> +
> + =A0 =A0 =A0 etm_unlock(t);
> +
> + =A0 =A0 =A0 etm_writel(t, v, ETMR_CTRL);
> +
> + =A0 =A0 =A0 while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && =
--timeout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 if (!timeout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(t->dev, "Waiting for progbit to=
 assert timed out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etm_lock(t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 etm_setup_address_range(t, 1, (unsigned long)_stext,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)_etext, =
0, 0);
> + =A0 =A0 =A0 etm_writel(t, 0, ETMR_TRACEENCTRL2);
> + =A0 =A0 =A0 etm_writel(t, 0, ETMR_TRACESSCTRL);
> + =A0 =A0 =A0 etm_writel(t, 0x6f, ETMR_TRACEENEVT);
> +
> + =A0 =A0 =A0 v &=3D ~ETMCTRL_PROGRAM;
> + =A0 =A0 =A0 v |=3D ETMCTRL_PORTSEL;
> +
> + =A0 =A0 =A0 etm_writel(t, v, ETMR_CTRL);
> +
> + =A0 =A0 =A0 timeout =3D TRACER_TIMEOUT;
> + =A0 =A0 =A0 while (etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM && --t=
imeout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 if (!timeout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(t->dev, "Waiting for progbit to=
 deassert timed out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etm_lock(t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 etm_lock(t);
> +
> + =A0 =A0 =A0 t->flags |=3D TRACER_RUNNING;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int trace_stop(struct tracectx *t)
> +{
> + =A0 =A0 =A0 unsigned long timeout =3D TRACER_TIMEOUT;
> +
> + =A0 =A0 =A0 etm_unlock(t);
> +
> + =A0 =A0 =A0 etm_writel(t, 0x440, ETMR_CTRL);
> + =A0 =A0 =A0 while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && =
--timeout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 if (!timeout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(t->dev, "Waiting for progbit to=
 assert timed out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etm_lock(t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 etm_lock(t);
> +
> + =A0 =A0 =A0 etb_unlock(t);
> + =A0 =A0 =A0 etb_writel(t, ETBFF_MANUAL_FLUSH, ETBR_FORMATTERCTRL);
> +
> + =A0 =A0 =A0 timeout =3D TRACER_TIMEOUT;
> + =A0 =A0 =A0 while (etb_readl(t, ETBR_FORMATTERCTRL) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ETBFF_MANUAL_FLUSH && -=
-timeout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 if (!timeout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(t->dev, "Waiting for formatter =
flush to commence "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "timed =
out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etb_lock(t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_CTRL);
> +
> + =A0 =A0 =A0 etb_lock(t);
> +
> + =A0 =A0 =A0 t->flags &=3D ~TRACER_RUNNING;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int etb_getdatalen(struct tracectx *t)
> +{
> + =A0 =A0 =A0 u32 v;
> + =A0 =A0 =A0 int rp, wp;
> +
> + =A0 =A0 =A0 v =3D etb_readl(t, ETBR_STATUS);
> +
> + =A0 =A0 =A0 if (v & 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return t->etb_bufsz;
> +
> + =A0 =A0 =A0 rp =3D etb_readl(t, ETBR_READADDR);
> + =A0 =A0 =A0 wp =3D etb_readl(t, ETBR_WRITEADDR);
> +
> + =A0 =A0 =A0 if (rp > wp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etb_writel(t, 0, ETBR_READADDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etb_writel(t, 0, ETBR_WRITEADDR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return wp - rp;
> +}
> +
> +/* sysrq+v will always stop the running trace and leave it at that *=
/
> +static void etm_dump(void)
> +{
> + =A0 =A0 =A0 struct tracectx *t =3D &tracer;
> + =A0 =A0 =A0 u32 first =3D 0;
> + =A0 =A0 =A0 int length;
> +
> + =A0 =A0 =A0 if (!t->etb_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "No tracing hardware f=
ound\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!mutex_trylock(&t->mutex))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (trace_isrunning(t))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_stop(t);
> +
> + =A0 =A0 =A0 etb_unlock(t);
> +
> + =A0 =A0 =A0 length =3D etb_getdatalen(t);
> +
> + =A0 =A0 =A0 if (length =3D=3D t->etb_bufsz)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 first =3D etb_readl(t, ETBR_WRITEADDR);
> +
> + =A0 =A0 =A0 etb_writel(t, first, ETBR_READADDR);
> +
> + =A0 =A0 =A0 printk(KERN_INFO "Trace buffer contents length: %d\n", =
length);
> + =A0 =A0 =A0 printk(KERN_INFO "--- ETB buffer begin ---\n");
> + =A0 =A0 =A0 for (; length; length--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%08x", cpu_to_be32(etb_readl(t,=
 ETBR_READMEM)));
> + =A0 =A0 =A0 printk(KERN_INFO "\n--- ETB buffer end ---\n");
> +
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_TRIGGERCOUNT);
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_READADDR);
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_WRITEADDR);
> +
> + =A0 =A0 =A0 etb_lock(t);
> +
> + =A0 =A0 =A0 mutex_unlock(&t->mutex);
> +}
> +
> +static void sysrq_etm_dump(int key, struct tty_struct *tty)
> +{
> + =A0 =A0 =A0 dev_dbg(tracer.dev, "Dumping ETB buffer\n");
> + =A0 =A0 =A0 etm_dump();
> +}
> +
> +static struct sysrq_key_op sysrq_etm_op =3D {
> + =A0 =A0 =A0 .handler =3D sysrq_etm_dump,
> + =A0 =A0 =A0 .help_msg =3D "ETM buffer dump",
> + =A0 =A0 =A0 .action_msg =3D "etm",
> +};
> +
> +static int etb_open(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 if (!tracer.etb_regs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 file->private_data =3D &tracer;
> +
> + =A0 =A0 =A0 return nonseekable_open(inode, file);
> +}
> +
> +static ssize_t etb_read(struct file *file, char __user *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t len, loff_t *ppos)
> +{
> + =A0 =A0 =A0 int total, i;
> + =A0 =A0 =A0 long length;
> + =A0 =A0 =A0 struct tracectx *t =3D file->private_data;
> + =A0 =A0 =A0 u32 first =3D 0;
> + =A0 =A0 =A0 u32 *buf;
> +
> + =A0 =A0 =A0 mutex_lock(&t->mutex);
> +
> + =A0 =A0 =A0 if (trace_isrunning(t)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 etb_unlock(t);
> +
> + =A0 =A0 =A0 total =3D etb_getdatalen(t);
> + =A0 =A0 =A0 if (total =3D=3D t->etb_bufsz)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 first =3D etb_readl(t, ETBR_WRITEADDR);
> +
> + =A0 =A0 =A0 etb_writel(t, first, ETBR_READADDR);
> +
> + =A0 =A0 =A0 length =3D min(total * 4, (int)len);
> + =A0 =A0 =A0 buf =3D vmalloc(length);
> +
> + =A0 =A0 =A0 dev_dbg(t->dev, "ETB buffer length: %d\n", total);
> + =A0 =A0 =A0 dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ET=
BR_STATUS));
> + =A0 =A0 =A0 for (i =3D 0; i < length / 4; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D etb_readl(t, ETBR_READMEM);
> +
> + =A0 =A0 =A0 /* the only way to deassert overflow bit in ETB status =
is this */
> + =A0 =A0 =A0 etb_writel(t, 1, ETBR_CTRL);
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_CTRL);
> +
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_WRITEADDR);
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_READADDR);
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_TRIGGERCOUNT);
> +
> + =A0 =A0 =A0 etb_lock(t);
> +
> + =A0 =A0 =A0 length =3D copy_to_user(data, buf, length);
> + =A0 =A0 =A0 vfree(buf);
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&t->mutex);
> +
> + =A0 =A0 =A0 return length;
> +}
> +
> +static int etb_release(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 /* there's nothing to do here, actually */
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct file_operations etb_fops =3D {
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 .read =3D etb_read,
> + =A0 =A0 =A0 .open =3D etb_open,
> + =A0 =A0 =A0 .release =3D etb_release,
> +};
> +
> +static struct miscdevice etb_miscdev =3D {
> + =A0 =A0 =A0 .name =3D "tracebuf",
> + =A0 =A0 =A0 .minor =3D 0,
> + =A0 =A0 =A0 .fops =3D &etb_fops,
> +};
> +
> +static int __devinit etb_drv_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tracectx *t =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (t && t->etb_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "ETB already initia=
lized\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!request_mem_region(res->start, SZ_4K, "etb")) {

request_mem_region(res->start, resource_size(res), "etb")
And I think it is perfectly legal with larger buffers so should
really be like that.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!t) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t =3D &tracer;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, t);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 t->etb_regs =3D ioremap_nocache(res->start, SZ_4K);

ioremap_nocache(res->start, resource_size(res))

> + =A0 =A0 =A0 if (!t->etb_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, SZ_4K);

release_mem_region(res->start. resource_size(res))

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 etb_miscdev.parent =3D &pdev->dev;
> +
> + =A0 =A0 =A0 ret =3D misc_register(&etb_miscdev);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(t->etb_regs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, SZ_4K);

release_mem_region(res->start, resource_size(res))

Note: you're starting to duplicate code here, perhaps you
can move it into the error path below out_foo: labels?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_core_alwon_ck");
> + =A0 =A0 =A0 clk_enable(clk);
> +
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_per_alwon_ck");
> + =A0 =A0 =A0 clk_enable(clk);
> +
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_mpu_alwon_ck");
> + =A0 =A0 =A0 clk_enable(clk);
> +
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_src_ck");
> + =A0 =A0 =A0 clk_enable(clk);

Are these clocks really generic? It looks a lot like OMAP-specific
stuff. Is it possible to hide these behind a single clock inside the
platform? like "etbclock" or so that increase refcount of the others
by 1?

> +
> + =A0 =A0 =A0 etb_unlock(t);
> + =A0 =A0 =A0 t->etb_bufsz =3D etb_readl(t, ETBR_DEPTH);
> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "Size: %x\n", t->etb_bufsz);
> +
> + =A0 =A0 =A0 /* make sure trace capture is disabled */
> + =A0 =A0 =A0 etb_writel(t, 0, ETBR_CTRL);
> + =A0 =A0 =A0 etb_writel(t, 0x1000, ETBR_FORMATTERCTRL);
> + =A0 =A0 =A0 etb_lock(t);
> +
> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "ETB platform driver initialized.\n=
");
> +
> + =A0 =A0 =A0 ret =3D 0;
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct platform_driver etb_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =3D etb_drv_probe,
> + =A0 =A0 =A0 .driver =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0=3D "etb",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +/* use a sysfs file "trace_running" to start/stop tracing */
> +static ssize_t trace_running_show(struct kobject *kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct kobj_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cha=
r *buf)
> +{
> + =A0 =A0 =A0 return sprintf(buf, "%x\n", trace_isrunning(&tracer));
> +}
> +
> +static ssize_t trace_running_store(struct kobject *kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct kobj_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
const char *buf, size_t n)
> +{
> + =A0 =A0 =A0 unsigned int value;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (sscanf(buf, "%u", &value) !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&tracer.mutex);
> + =A0 =A0 =A0 ret =3D value ? trace_start(&tracer) : trace_stop(&trac=
er);
> + =A0 =A0 =A0 mutex_unlock(&tracer.mutex);
> +
> + =A0 =A0 =A0 return ret ? : n;
> +}
> +
> +static struct kobj_attribute trace_running_attr =3D
> + =A0 =A0 =A0 __ATTR(trace_running, 0644, trace_running_show, trace_r=
unning_store);
> +
> +static ssize_t trace_info_show(struct kobject *kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct kobj_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cha=
r *buf)
> +{
> + =A0 =A0 =A0 u32 etb_wa, etb_ra, etb_st, etb_fc, etm_ctrl, etm_st;
> + =A0 =A0 =A0 int datalen;
> +
> + =A0 =A0 =A0 etb_unlock(&tracer);
> + =A0 =A0 =A0 datalen =3D etb_getdatalen(&tracer);
> + =A0 =A0 =A0 etb_wa =3D etb_readl(&tracer, ETBR_WRITEADDR);
> + =A0 =A0 =A0 etb_ra =3D etb_readl(&tracer, ETBR_READADDR);
> + =A0 =A0 =A0 etb_st =3D etb_readl(&tracer, ETBR_STATUS);
> + =A0 =A0 =A0 etb_fc =3D etb_readl(&tracer, ETBR_FORMATTERCTRL);
> + =A0 =A0 =A0 etb_lock(&tracer);
> +
> + =A0 =A0 =A0 etm_unlock(&tracer);
> + =A0 =A0 =A0 etm_ctrl =3D etm_readl(&tracer, ETMR_CTRL);
> + =A0 =A0 =A0 etm_st =3D etm_readl(&tracer, ETMR_STATUS);
> + =A0 =A0 =A0 etm_lock(&tracer);
> +
> + =A0 =A0 =A0 return sprintf(buf, "Trace buffer len: %d\nComparator p=
airs: %d\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ETBR_WRITEADDR:\t%08x\=
n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ETBR_READADDR:\t%08x\n=
"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ETBR_STATUS:\t%08x\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ETBR_FORMATTERCTRL:\t%=
08x\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ETMR_CTRL:\t%08x\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ETMR_STATUS:\t%08x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 datalen,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tracer.ncmppairs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etb_wa,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etb_ra,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etb_st,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etb_fc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etm_ctrl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etm_st
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
> +}
> +
> +static struct kobj_attribute trace_info_attr =3D
> + =A0 =A0 =A0 __ATTR(trace_info, 0444, trace_info_show, NULL);
> +
> +static ssize_t trace_mode_show(struct kobject *kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct kobj_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cha=
r *buf)
> +{
> + =A0 =A0 =A0 return sprintf(buf, "%d %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(tracer.flags & TRACE=
R_CYCLE_ACC),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tracer.etm_portsz);
> +}
> +
> +static ssize_t trace_mode_store(struct kobject *kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct kobj_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
const char *buf, size_t n)
> +{
> + =A0 =A0 =A0 unsigned int cycacc, portsz;
> +
> + =A0 =A0 =A0 if (sscanf(buf, "%u %u", &cycacc, &portsz) !=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&tracer.mutex);
> + =A0 =A0 =A0 if (cycacc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tracer.flags |=3D TRACER_CYCLE_ACC;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tracer.flags &=3D ~TRACER_CYCLE_ACC;
> +
> + =A0 =A0 =A0 tracer.etm_portsz =3D portsz & 0x0f;
> + =A0 =A0 =A0 mutex_unlock(&tracer.mutex);
> +
> + =A0 =A0 =A0 return n;
> +}
> +
> +static struct kobj_attribute trace_mode_attr =3D
> + =A0 =A0 =A0 __ATTR(trace_mode, 0644, trace_mode_show, trace_mode_st=
ore);
> +
> +static int __devinit etm_drv_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tracectx *t =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (t && t->etm_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "ETM already initia=
lized\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!request_mem_region(res->start, SZ_4K, "etm")) {

request_mem_region(res->start, resource_size(res), "etm")

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!t) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t =3D &tracer;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, t);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 t->etm_regs =3D ioremap_nocache(res->start, SZ_4K);

resource_size(res)

> + =A0 =A0 =A0 if (!t->etm_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, SZ_4K);

resource_size(res)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_init(&t->mutex);
> + =A0 =A0 =A0 t->dev =3D &pdev->dev;
> + =A0 =A0 =A0 t->flags =3D TRACER_CYCLE_ACC;
> + =A0 =A0 =A0 t->etm_portsz =3D 1;
> +
> + =A0 =A0 =A0 etm_unlock(t);
> + =A0 =A0 =A0 ret =3D etm_readl(t, CSCR_PRSR);
> +
> + =A0 =A0 =A0 t->ncmppairs =3D etm_readl(t, ETMR_CONFCODE) & 0xf;
> + =A0 =A0 =A0 etm_writel(t, 0x440, ETMR_CTRL);
> + =A0 =A0 =A0 etm_lock(t);
> +
> + =A0 =A0 =A0 ret =3D sysfs_create_file(&pdev->dev.kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &trace_running_attr.att=
r);
> + =A0 =A0 =A0 ret =3D sysfs_create_file(&pdev->dev.kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &trace_info_attr.attr);
> + =A0 =A0 =A0 ret =3D sysfs_create_file(&pdev->dev.kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &trace_mode_attr.attr);
> + =A0 =A0 =A0 dev_dbg(t->dev, "ETM platform driver initialized.\n");
> +
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct platform_driver etm_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =3D etm_drv_probe,
> + =A0 =A0 =A0 .driver =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0=3D "etm",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init etm_init(void)
> +{
> + =A0 =A0 =A0 platform_driver_register(&etb_driver);
> + =A0 =A0 =A0 platform_driver_register(&etm_driver);

You're not checking the return values.

I think this calls for using platform_driver_probe(&etm_driver, etm_drv=
_probe);
and removing the .probe part of the driver and tag the probe functions
as __init as well.

> + =A0 =A0 =A0 register_sysrq_key('v', &sysrq_etm_op);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +module_init(etm_init);
> +
> --
> 1.6.3.3

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
