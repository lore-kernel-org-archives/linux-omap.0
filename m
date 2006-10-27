From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in plat-omap/dsp
Date: Fri, 27 Oct 2006 18:14:43 +0200
Message-ID: <45423073.5090507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050802050505010605050003"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------050802050505010605050003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix various warnings

warning: ignoring return value of 'xxx', declared with
attribute warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------050802050505010605050003
Content-Type: text/plain;
 name="plat_omap_dsp_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plat_omap_dsp_warning_patch.txt"

Index: linux-osk/arch/arm/plat-omap/dsp/dsp_ctl.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_ctl.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_ctl.c
@@ -273,7 +273,9 @@ static int dsp_cfg(void)
 		goto out;
 
 	/* create runtime sysfs entries */
-	device_create_file(omap_dsp->dev, &dev_attr_loadinfo);
+	ret = device_create_file(omap_dsp->dev, &dev_attr_loadinfo);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
 
 out:
 	dsp_mem_disable((void *)dspmem_base);
@@ -1038,9 +1040,17 @@ out:
 
 void __init dsp_ctl_init(void)
 {
-	device_create_file(omap_dsp->dev, &dev_attr_ifver);
-	device_create_file(omap_dsp->dev, &dev_attr_cpustat);
-	device_create_file(omap_dsp->dev, &dev_attr_icrmask);
+	int ret;
+
+	ret = device_create_file(omap_dsp->dev, &dev_attr_ifver);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+	ret = device_create_file(omap_dsp->dev, &dev_attr_cpustat);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+	ret = device_create_file(omap_dsp->dev, &dev_attr_icrmask);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
 }
 
 void dsp_ctl_exit(void)
Index: linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_mem.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -2504,9 +2504,21 @@ int __init dsp_mem_init(void)
 	/* MMU interrupt is not enabled until DSP runs */
 	disable_irq(omap_dsp->mmu_irq);
 
-	device_create_file(omap_dsp->dev, &dev_attr_mmu);
-	device_create_file(omap_dsp->dev, &dev_attr_exmap);
-	device_create_file(omap_dsp->dev, &dev_attr_mempool);
+	ret = device_create_file(omap_dsp->dev, &dev_attr_mmu);
+	if (unlikely(ret != 0)) {
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+		return ret;
+	}
+	ret = device_create_file(omap_dsp->dev, &dev_attr_exmap);
+	if (unlikely(ret != 0)) {
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+		return ret;
+	}
+	ret = device_create_file(omap_dsp->dev, &dev_attr_mempool);
+	if (unlikely(ret != 0)) {
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
Index: linux-osk/arch/arm/plat-omap/dsp/ipbuf.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/ipbuf.c
+++ linux-osk/arch/arm/plat-omap/dsp/ipbuf.c
@@ -117,7 +117,11 @@ int ipbuf_config(u16 ln, u16 lsz, void *
 	       "           %d words * %d lines at 0x%p.\n",
 	       ipbcfg.lsz, ipbcfg.ln, ipbcfg.base);
 
-	device_create_file(omap_dsp->dev, &dev_attr_ipbuf);
+	ret = device_create_file(omap_dsp->dev, &dev_attr_ipbuf);
+	if (unlikely(ret != 0)) {
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+		goto free_out;
+	}
 
 	return ret;
 
Index: linux-osk/arch/arm/plat-omap/dsp/mblog.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/mblog.c
+++ linux-osk/arch/arm/plat-omap/dsp/mblog.c
@@ -260,7 +260,11 @@ static struct device_attribute dev_attr_
 
 void __init mblog_init(void)
 {
-	device_create_file(omap_dsp->dev, &dev_attr_mblog);
+	int ret;
+
+	ret = device_create_file(omap_dsp->dev, &dev_attr_mblog);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
 }
 
 void mblog_exit(void)
Index: linux-osk/arch/arm/plat-omap/dsp/task.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/task.c
+++ linux-osk/arch/arm/plat-omap/dsp/task.c
@@ -1789,6 +1789,8 @@ static void dsptask_dev_release(struct d
 
 static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
 {
+	int ret = 0;
+
 	taskdev[minor] = dev;
 
 	spin_lock_init(&dev->proc_list_lock);
@@ -1815,10 +1817,18 @@ static int taskdev_init(struct taskdev *
 	dev->dev.bus = &dsptask_bus;
 	sprintf(dev->dev.bus_id, "dsptask%d", minor);
 	dev->dev.release = dsptask_dev_release;
-	device_register(&dev->dev);
-	device_create_file(&dev->dev, &dev_attr_devname);
-	device_create_file(&dev->dev, &dev_attr_devstate);
-	device_create_file(&dev->dev, &dev_attr_proc_list);
+	ret = device_register(&dev->dev);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_register failed: %d\n", ret);
+	ret = device_create_file(&dev->dev, &dev_attr_devname);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+	ret = device_create_file(&dev->dev, &dev_attr_devstate);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+	ret = device_create_file(&dev->dev, &dev_attr_proc_list);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
 	class_device_create(dsp_task_class, NULL,
 			    MKDEV(OMAP_DSP_TASK_MAJOR, minor),
 			    NULL, "dsptask%d", minor);
@@ -1826,7 +1836,7 @@ static int taskdev_init(struct taskdev *
 	init_waitqueue_head(&dev->state_wait_q);
 	init_rwsem(&dev->state_sem);
 
-	return 0;
+	return ret;
 }
 
 static void taskdev_delete(unsigned char minor)
@@ -1847,6 +1857,7 @@ static void taskdev_delete(unsigned char
 static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task)
 {
 	u16 ttyp = task->ttyp;
+	int ret = 0;
 
 	dev->fops.read =
 		sndtyp_acv(ttyp) ?
@@ -1883,21 +1894,35 @@ static int taskdev_attach_task(struct ta
 	if (task->map_length)
 		dev->fops.mmap = dsp_task_mmap;
 
-	device_create_file(&dev->dev, &dev_attr_taskname);
-	device_create_file(&dev->dev, &dev_attr_ttyp);
+	ret = device_create_file(&dev->dev, &dev_attr_taskname);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+	ret = device_create_file(&dev->dev, &dev_attr_ttyp);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
 	if (sndtyp_wd(ttyp)) {
-		device_create_file(&dev->dev, &dev_attr_fifosz);
-		device_create_file(&dev->dev, &dev_attr_fifocnt);
+		ret = device_create_file(&dev->dev, &dev_attr_fifosz);
+		if (unlikely(ret != 0))
+			printk(KERN_ERR "device_create_file failed: %d\n", ret);
+		ret = device_create_file(&dev->dev, &dev_attr_fifocnt);
+		if (unlikely(ret != 0))
+			printk(KERN_ERR "device_create_file failed: %d\n", ret);
 	} else
-		device_create_file(&dev->dev, &dev_attr_ipblink);
-	device_create_file(&dev->dev, &dev_attr_wsz);
+		ret = device_create_file(&dev->dev, &dev_attr_ipblink);
+		if (unlikely(ret != 0))
+			printk(KERN_ERR "device_create_file failed: %d\n", ret);
+	ret = device_create_file(&dev->dev, &dev_attr_wsz);
+	if (unlikely(ret != 0))
+		printk(KERN_ERR "device_create_file failed: %d\n", ret);
 	if (task->map_length)
-		device_create_file(&dev->dev, &dev_attr_mmap);
+		ret = device_create_file(&dev->dev, &dev_attr_mmap);
+		if (unlikely(ret != 0))
+			printk(KERN_ERR "device_create_file failed: %d\n", ret);
 
 	dev->task = task;
 	task->dev = dev;
 
-	return 0;
+	return ret;
 }
 
 static void taskdev_detach_task(struct taskdev *dev)
@@ -2989,7 +3014,14 @@ int __init dsp_taskmod_init(void)
 		return retval;
 	}
 
-	bus_register(&dsptask_bus);
+	retval = bus_register(&dsptask_bus);
+	if (retval) {
+		printk(KERN_ERR
+		       "omapdsp: failed to register DSP task bus: %d\n",
+		       retval);
+		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
+		return -EINVAL;
+	}
 	retval = driver_register(&dsptask_driver);
 	if (retval) {
 		printk(KERN_ERR


--------------050802050505010605050003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050802050505010605050003--
