From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 5/8] DSPGW: Use kfifo APIs instead of homemade ones
Date: Mon, 30 Jul 2007 14:04:02 +0300
Message-ID: <11857934552591-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934533223-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11857934533223-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/dsp/fifo.h |  175 -----------------------------------------
 arch/arm/plat-omap/dsp/task.c |   66 +++++++++------
 2 files changed, 39 insertions(+), 202 deletions(-)
 delete mode 100644 arch/arm/plat-omap/dsp/fifo.h

diff --git a/arch/arm/plat-omap/dsp/fifo.h b/arch/arm/plat-omap/dsp/fifo.h
deleted file mode 100644
index c0dc26c..0000000
--- a/arch/arm/plat-omap/dsp/fifo.h
+++ /dev/null
@@ -1,175 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __PLAT_OMAP_DSP_FIFO_H
-#define __PLAT_OMAP_DSP_FIFO_H
-
-struct fifo_struct {
-	spinlock_t lock;
-	char *buf;
-	size_t sz;
-	size_t cnt;
-	unsigned int wp;
-};
-
-static inline int alloc_fifo(struct fifo_struct *fifo, size_t sz)
-{
-	if ((fifo->buf = kmalloc(sz, GFP_KERNEL)) == NULL) {
-		fifo->sz = 0;
-		return -ENOMEM;
-	}
-	fifo->sz = sz;
-	fifo->cnt = 0;
-	fifo->wp = 0;
-	return 0;
-}
-
-static inline int init_fifo(struct fifo_struct *fifo, size_t sz)
-{
-	spin_lock_init(&fifo->lock);
-	return alloc_fifo(fifo, sz);
-}
-
-static inline void free_fifo(struct fifo_struct *fifo)
-{
-	spin_lock(&fifo->lock);
-	if (fifo->buf == NULL) {
-		spin_unlock(&fifo->lock);
-		return;
-	}
-
-	kfree(fifo->buf);
-	fifo->buf = NULL;
-	fifo->sz = 0;
-	spin_unlock(&fifo->lock);
-}
-
-static inline void flush_fifo(struct fifo_struct *fifo)
-{
-	spin_lock(&fifo->lock);
-	fifo->cnt = 0;
-	fifo->wp = 0;
-	spin_unlock(&fifo->lock);
-}
-
-#define fifo_empty(fifo)	((fifo)->cnt == 0)
-
-static inline int realloc_fifo(struct fifo_struct *fifo, size_t sz)
-{
-	int ret = sz;
-
-	spin_lock(&fifo->lock);
-	if (!fifo_empty(fifo)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	/* free */
-	if (fifo->buf)
-		kfree(fifo->buf);
-
-	/* alloc */
-	ret = alloc_fifo(fifo, sz);
-
-out:
-	spin_unlock(&fifo->lock);
-	return ret;
-}
-
-static inline void write_word_to_fifo(struct fifo_struct *fifo, u16 word)
-{
-	spin_lock(&fifo->lock);
-	*(u16 *)&fifo->buf[fifo->wp] = word;
-	if ((fifo->wp += 2) == fifo->sz)
-		fifo->wp = 0;
-	if ((fifo->cnt += 2) > fifo->sz)
-		fifo->cnt = fifo->sz;
-	spin_unlock(&fifo->lock);
-}
-
-/*
- * (before)
- *
- * [*******----------*************]
- *         ^wp
- *  <---------------------------->  sz = 30
- *  <----->          <----------->  cnt = 20
- *
- * (read: count=16)
- *  <->              <----------->  count = 16
- *                   <----------->  cnt1 = 13
- *                   ^rp
- *
- * (after)
- * [---****-----------------------]
- *         ^wp
- */
-static inline ssize_t copy_to_user_fm_fifo(char *dst, struct fifo_struct *fifo,
-					   size_t count)
-{
-	int rp;
-	ssize_t ret;
-
-	/* fifo size can be zero */
-	if (fifo->sz == 0)
-		return 0;
-
-	spin_lock(&fifo->lock);
-	if (count > fifo->cnt)
-		count = fifo->cnt;
-
-	if ((rp = fifo->wp - fifo->cnt) >= 0) {
-		/* valid area is straight */
-		if (copy_to_user(dst, &fifo->buf[rp], count)) {
-			ret = -EFAULT;
-			goto out;
-		}
-	} else {
-		int cnt1 = -rp;
-		rp += fifo->sz;
-		if (cnt1 >= count) {
-			/* requested area is straight */
-			if (copy_to_user(dst, &fifo->buf[rp], count)) {
-				ret = -EFAULT;
-				goto out;
-			}
-		} else {
-			if (copy_to_user(dst, &fifo->buf[rp], cnt1)) {
-				ret = -EFAULT;
-				goto out;
-			}
-			if (copy_to_user(dst+cnt1, fifo->buf, count-cnt1)) {
-				ret = -EFAULT;
-				goto out;
-			}
-		}
-	}
-	fifo->cnt -= count;
-	ret = count;
-
-out:
-	spin_unlock(&fifo->lock);
-	return ret;
-}
-
-#endif /* __PLAT_OMAP_DSP_FIFO_H */
diff --git a/arch/arm/plat-omap/dsp/task.c b/arch/arm/plat-omap/dsp/task.c
index b43f704..0e2b5c7 100644
--- a/arch/arm/plat-omap/dsp/task.c
+++ b/arch/arm/plat-omap/dsp/task.c
@@ -33,6 +33,7 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/interrupt.h>
+#include <linux/kfifo.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/arch/mailbox.h>
@@ -41,7 +42,6 @@
 #include "dsp_mbcmd.h"
 #include "dsp.h"
 #include "ipbuf.h"
-#include "fifo.h"
 #include "proclist.h"
 
 #define is_aligned(adr,align)	(!((adr)&((align)-1)))
@@ -125,8 +125,9 @@ struct taskdev {
 	/* read stuff */
 	wait_queue_head_t read_wait_q;
 	struct mutex read_mutex;
+	spinlock_t read_lock;
 	union {
-		struct fifo_struct fifo;	/* for active word */
+		struct kfifo *fifo;	/* for active word */
 		struct rcvdt_bk_struct bk;
 	} rcvdt;
 
@@ -356,7 +357,7 @@ static int taskdev_flush_buf(struct taskdev *dev)
 
 	if (sndtyp_wd(ttyp)) {
 		/* word receiving */
-		flush_fifo(&dev->rcvdt.fifo);
+		kfifo_reset(dev->rcvdt.fifo);
 	} else {
 		/* block receiving */
 		struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
@@ -379,7 +380,6 @@ static int taskdev_flush_buf(struct taskdev *dev)
 static int taskdev_set_fifosz(struct taskdev *dev, unsigned long sz)
 {
 	u16 ttyp = dev->task->ttyp;
-	int stat;
 
 	if (!(sndtyp_wd(ttyp) && sndtyp_acv(ttyp))) {
 		printk(KERN_ERR
@@ -393,15 +393,18 @@ static int taskdev_set_fifosz(struct taskdev *dev, unsigned long sz)
 		return -EINVAL;
 	}
 
-	stat = realloc_fifo(&dev->rcvdt.fifo, sz);
-	if (stat == -EBUSY) {
+	if (kfifo_len(dev->rcvdt.fifo)) {
 		printk(KERN_ERR "omapdsp: buffer is not empty!\n");
-		return stat;
-	} else if (stat < 0) {
+		return -EIO;
+	}
+
+	kfifo_free(dev->rcvdt.fifo);
+	dev->rcvdt.fifo = kfifo_alloc(sz, GFP_KERNEL, &dev->read_lock);
+	if (IS_ERR(dev->rcvdt.fifo)) {
 		printk(KERN_ERR
 		       "omapdsp: unable to change receive buffer size. "
 		       "(%ld bytes for %s)\n", sz, dev->name);
-		return stat;
+		return -ENOMEM;
 	}
 
 	return 0;
@@ -670,10 +673,10 @@ static ssize_t dsp_task_read_wd_acv(struct file *file, char __user *buf,
 
 
 	prepare_to_wait(&dev->read_wait_q, &wait, TASK_INTERRUPTIBLE);
-	if (fifo_empty(&dev->rcvdt.fifo))
+	if (kfifo_len(dev->rcvdt.fifo) == 0)
 		schedule();
 	finish_wait(&dev->read_wait_q, &wait);
-	if (fifo_empty(&dev->rcvdt.fifo)) {
+	if (kfifo_len(dev->rcvdt.fifo) == 0) {
 		/* failure */
 		if (signal_pending(current))
 			ret = -EINTR;
@@ -681,7 +684,7 @@ static ssize_t dsp_task_read_wd_acv(struct file *file, char __user *buf,
 	}
 
 
-	ret = copy_to_user_fm_fifo(buf, &dev->rcvdt.fifo, count);
+	ret = kfifo_get_to_user(dev->rcvdt.fifo, buf, count);
 
  up_out:
 	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
@@ -837,14 +840,14 @@ static ssize_t dsp_task_read_wd_psv(struct file *file, char __user *buf,
 
 	mbcompose_send_and_wait(WDREQ, dev->task->tid, 0, &dev->read_wait_q);
 
-	if (fifo_empty(&dev->rcvdt.fifo)) {
+	if (kfifo_len(dev->rcvdt.fifo) == 0) {
 		/* failure */
 		if (signal_pending(current))
 			ret = -EINTR;
 		goto up_out;
 	}
 
-	ret = copy_to_user_fm_fifo(buf, &dev->rcvdt.fifo, count);
+	ret = kfifo_get_to_user(dev->rcvdt.fifo, buf, count);
 
 up_out:
 	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
@@ -1125,7 +1128,7 @@ static unsigned int dsp_task_poll(struct file * file, poll_table * wait)
 	poll_wait(file, &dev->read_wait_q, wait);
 	poll_wait(file, &dev->write_wait_q, wait);
 	if (sndtyp_psv(task->ttyp) ||
-	    (sndtyp_wd(task->ttyp) && !fifo_empty(&dev->rcvdt.fifo)) ||
+	    (sndtyp_wd(task->ttyp) && kfifo_len(dev->rcvdt.fifo)) ||
 	    (sndtyp_bk(task->ttyp) && !ipblink_empty(&dev->rcvdt.bk.link)))
 		mask |= POLLIN | POLLRDNORM;
 	if (dev->wsz)
@@ -1764,7 +1767,7 @@ static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
 	task_dev = device_create(dsp_task_class, NULL,
 				 MKDEV(OMAP_DSP_TASK_MAJOR, minor),
 				 "dsptask%d", (int)minor);
-	
+
 	if (unlikely(IS_ERR(task_dev))) {
 		ret = -EINVAL;
 		goto fail_create_taskclass;
@@ -1815,11 +1818,11 @@ static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task)
 		/* sndtyp_bk */   dsp_task_read_bk_psv;
 	if (sndtyp_wd(ttyp)) {
 		/* word */
-		size_t fifosz;
+		size_t fifosz = sndtyp_psv(ttyp) ? 2:32; /* passive:active */
 
-		fifosz = sndtyp_psv(ttyp) ? 2 :	/* passive */
-			32;	/* active */
-		if (init_fifo(&dev->rcvdt.fifo, fifosz) < 0) {
+		dev->rcvdt.fifo = kfifo_alloc(fifosz, GFP_KERNEL,
+					      &dev->read_lock);
+		if (IS_ERR(dev->rcvdt.fifo)) {
 			printk(KERN_ERR
 			       "omapdsp: unable to allocate receive buffer. "
 			       "(%d bytes for %s)\n", fifosz, dev->name);
@@ -1896,7 +1899,7 @@ static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task)
 	taskdev_flush_buf(dev);
 
 	if (sndtyp_wd(ttyp))
-		free_fifo(&dev->rcvdt.fifo);
+		kfifo_free(dev->rcvdt.fifo);
 
 	dev->task = NULL;
 
@@ -1923,7 +1926,7 @@ static void taskdev_detach_task(struct taskdev *dev)
 	dev->fops.read = NULL;
 	taskdev_flush_buf(dev);
 	if (sndtyp_wd(ttyp))
-		free_fifo(&dev->rcvdt.fifo);
+		kfifo_free(dev->rcvdt.fifo);
 
 	dev->fops.write = NULL;
 	dev->wsz = 0;
@@ -2246,7 +2249,9 @@ long taskdev_state_stale(unsigned char minor)
  */
 void mbox_wdsnd(struct mbcmd *mb)
 {
+	unsigned int n;
 	u8 tid = mb->cmd_l;
+	u16 data = mb->data;
 	struct dsptask *task = dsptask[tid];
 
 	if ((tid >= TASKDEV_MAX) || (task == NULL)) {
@@ -2266,7 +2271,11 @@ void mbox_wdsnd(struct mbcmd *mb)
 		return;
 	}
 
-	write_word_to_fifo(&task->dev->rcvdt.fifo, mb->data);
+	n = kfifo_put(task->dev->rcvdt.fifo, (unsigned char *)&data,
+		      sizeof(data));
+	if (n != sizeof(data))
+		printk(KERN_WARNING "Receive FIFO(%d) is full\n", tid);
+
 	wake_up_interruptible(&task->dev->read_wait_q);
 }
 
@@ -2883,8 +2892,8 @@ static ssize_t ttyp_show(struct device *d, struct device_attribute *attr,
 static ssize_t fifosz_show(struct device *d, struct device_attribute *attr,
 			   char *buf)
 {
-	struct fifo_struct *fifo = &to_taskdev(d)->rcvdt.fifo;
-	return sprintf(buf, "%d\n", fifo->sz);
+	struct kfifo *fifo = to_taskdev(d)->rcvdt.fifo;
+	return sprintf(buf, "%d\n", fifo->size);
 }
 
 static int fifosz_store(struct device *d, struct device_attribute *attr,
@@ -2895,7 +2904,10 @@ static int fifosz_store(struct device *d, struct device_attribute *attr,
 	int ret;
 
 	fifosz = simple_strtol(buf, NULL, 10);
+	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
+		return -ENODEV;
 	ret = taskdev_set_fifosz(dev, fifosz);
+	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
 
 	return (ret < 0) ? ret : strlen(buf);
 }
@@ -2904,8 +2916,8 @@ static int fifosz_store(struct device *d, struct device_attribute *attr,
 static ssize_t fifocnt_show(struct device *d, struct device_attribute *attr,
 			    char *buf)
 {
-	struct fifo_struct *fifo = &to_taskdev(d)->rcvdt.fifo;
-	return sprintf(buf, "%d\n", fifo->cnt);
+	struct kfifo *fifo = to_taskdev(d)->rcvdt.fifo;
+	return sprintf(buf, "%d\n", fifo->size);
 }
 
 /* ipblink */
-- 
1.5.3.rc3.24.g83b3d
