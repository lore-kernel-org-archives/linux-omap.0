From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 2/8] staging: tidspbridge: remove unused header
Date: Tue, 31 Jan 2012 00:12:18 +0100
Message-ID: <0015295b5c3789dbe01f4840700e46095f1354cc.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

No functional changes.

The header file drv_interface.h was only used locally, hence there's no=
 need
to have it.

Also the only prototyped functions were the file_operations callbacks, =
then
this commit moves them up to avoid prototyping too.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |  313 +++++++++++---=
--------
 drivers/staging/tidspbridge/rmgr/drv_interface.h |   28 --
 2 files changed, 155 insertions(+), 186 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/rmgr/drv_interface.h

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 85f6e8e..5ea753c 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -48,9 +48,6 @@
 /*  ----------------------------------- Resource Manager */
 #include <dspbridge/pwr.h>
=20
-/*  ----------------------------------- This */
-#include <drv_interface.h>
-
 #include <dspbridge/resourcecleanup.h>
 #include <dspbridge/chnl.h>
 #include <dspbridge/proc.h>
@@ -133,6 +130,161 @@ MODULE_VERSION(DSPBRIDGE_VERSION);
=20
 static char *driver_name =3D DRIVER_NAME;
=20
+/*
+ * This function is called when an application opens handle to the
+ * bridge driver.
+ */
+static int bridge_open(struct inode *ip, struct file *filp)
+{
+	int status =3D 0;
+	struct process_context *pr_ctxt =3D NULL;
+
+	/*
+	 * Allocate a new process context and insert it into global
+	 * process context list.
+	 */
+
+#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
+	if (recover) {
+		if (filp->f_flags & O_NONBLOCK ||
+			wait_for_completion_interruptible(&bridge_open_comp))
+			return -EBUSY;
+	}
+#endif
+	pr_ctxt =3D kzalloc(sizeof(struct process_context), GFP_KERNEL);
+	if (pr_ctxt) {
+		pr_ctxt->res_state =3D PROC_RES_ALLOCATED;
+		spin_lock_init(&pr_ctxt->dmm_map_lock);
+		INIT_LIST_HEAD(&pr_ctxt->dmm_map_list);
+		spin_lock_init(&pr_ctxt->dmm_rsv_lock);
+		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
+
+		pr_ctxt->node_id =3D kzalloc(sizeof(struct idr), GFP_KERNEL);
+		if (pr_ctxt->node_id) {
+			idr_init(pr_ctxt->node_id);
+		} else {
+			status =3D -ENOMEM;
+			goto err;
+		}
+
+		pr_ctxt->stream_id =3D kzalloc(sizeof(struct idr), GFP_KERNEL);
+		if (pr_ctxt->stream_id)
+			idr_init(pr_ctxt->stream_id);
+		else
+			status =3D -ENOMEM;
+	} else {
+		status =3D -ENOMEM;
+	}
+err:
+	filp->private_data =3D pr_ctxt;
+#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
+	if (!status)
+		atomic_inc(&bridge_cref);
+#endif
+	return status;
+}
+
+/*
+ * This function is called when an application closes handle to the br=
idge
+ * driver.
+ */
+static int bridge_release(struct inode *ip, struct file *filp)
+{
+	int status =3D 0;
+	struct process_context *pr_ctxt;
+
+	if (!filp->private_data) {
+		status =3D -EIO;
+		goto err;
+	}
+
+	pr_ctxt =3D filp->private_data;
+	flush_signals(current);
+	drv_remove_all_resources(pr_ctxt);
+	proc_detach(pr_ctxt);
+	kfree(pr_ctxt);
+
+	filp->private_data =3D NULL;
+
+err:
+#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
+	if (!atomic_dec_return(&bridge_cref))
+		complete(&bridge_comp);
+#endif
+	return status;
+}
+
+/* This function provides IO interface to the bridge driver. */
+static long bridge_ioctl(struct file *filp, unsigned int code,
+			 unsigned long args)
+{
+	int status;
+	u32 retval =3D 0;
+	union trapped_args buf_in;
+
+	DBC_REQUIRE(filp !=3D NULL);
+#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
+	if (recover) {
+		status =3D -EIO;
+		goto err;
+	}
+#endif
+#ifdef CONFIG_PM
+	status =3D omap34_xxbridge_suspend_lockout(&bridge_suspend_data, filp=
);
+	if (status !=3D 0)
+		return status;
+#endif
+
+	if (!filp->private_data) {
+		status =3D -EIO;
+		goto err;
+	}
+
+	status =3D copy_from_user(&buf_in, (union trapped_args *)args,
+				sizeof(union trapped_args));
+
+	if (!status) {
+		status =3D api_call_dev_ioctl(code, &buf_in, &retval,
+					     filp->private_data);
+
+		if (!status) {
+			status =3D retval;
+		} else {
+			dev_dbg(bridge, "%s: IOCTL Failed, code: 0x%x "
+				"status 0x%x\n", __func__, code, status);
+			status =3D -1;
+		}
+
+	}
+
+err:
+	return status;
+}
+
+/* This function maps kernel space memory to user space memory. */
+static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	u32 offset =3D vma->vm_pgoff << PAGE_SHIFT;
+	u32 status;
+
+	DBC_ASSERT(vma->vm_start < vma->vm_end);
+
+	vma->vm_flags |=3D VM_RESERVED | VM_IO;
+	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
+
+	dev_dbg(bridge, "%s: vm filp %p offset %x start %lx end %lx page_prot=
 "
+		"%lx flags %lx\n", __func__, filp, offset,
+		vma->vm_start, vma->vm_end, vma->vm_page_prot, vma->vm_flags);
+
+	status =3D remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				 vma->vm_end - vma->vm_start,
+				 vma->vm_page_prot);
+	if (status !=3D 0)
+		status =3D -EAGAIN;
+
+	return status;
+}
+
 static const struct file_operations bridge_fops =3D {
 	.open =3D bridge_open,
 	.release =3D bridge_release,
@@ -477,161 +629,6 @@ static void __exit bridge_exit(void)
 	platform_driver_unregister(&bridge_driver);
 }
=20
-/*
- * This function is called when an application opens handle to the
- * bridge driver.
- */
-static int bridge_open(struct inode *ip, struct file *filp)
-{
-	int status =3D 0;
-	struct process_context *pr_ctxt =3D NULL;
-
-	/*
-	 * Allocate a new process context and insert it into global
-	 * process context list.
-	 */
-
-#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
-	if (recover) {
-		if (filp->f_flags & O_NONBLOCK ||
-			wait_for_completion_interruptible(&bridge_open_comp))
-			return -EBUSY;
-	}
-#endif
-	pr_ctxt =3D kzalloc(sizeof(struct process_context), GFP_KERNEL);
-	if (pr_ctxt) {
-		pr_ctxt->res_state =3D PROC_RES_ALLOCATED;
-		spin_lock_init(&pr_ctxt->dmm_map_lock);
-		INIT_LIST_HEAD(&pr_ctxt->dmm_map_list);
-		spin_lock_init(&pr_ctxt->dmm_rsv_lock);
-		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
-
-		pr_ctxt->node_id =3D kzalloc(sizeof(struct idr), GFP_KERNEL);
-		if (pr_ctxt->node_id) {
-			idr_init(pr_ctxt->node_id);
-		} else {
-			status =3D -ENOMEM;
-			goto err;
-		}
-
-		pr_ctxt->stream_id =3D kzalloc(sizeof(struct idr), GFP_KERNEL);
-		if (pr_ctxt->stream_id)
-			idr_init(pr_ctxt->stream_id);
-		else
-			status =3D -ENOMEM;
-	} else {
-		status =3D -ENOMEM;
-	}
-err:
-	filp->private_data =3D pr_ctxt;
-#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
-	if (!status)
-		atomic_inc(&bridge_cref);
-#endif
-	return status;
-}
-
-/*
- * This function is called when an application closes handle to the br=
idge
- * driver.
- */
-static int bridge_release(struct inode *ip, struct file *filp)
-{
-	int status =3D 0;
-	struct process_context *pr_ctxt;
-
-	if (!filp->private_data) {
-		status =3D -EIO;
-		goto err;
-	}
-
-	pr_ctxt =3D filp->private_data;
-	flush_signals(current);
-	drv_remove_all_resources(pr_ctxt);
-	proc_detach(pr_ctxt);
-	kfree(pr_ctxt);
-
-	filp->private_data =3D NULL;
-
-err:
-#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
-	if (!atomic_dec_return(&bridge_cref))
-		complete(&bridge_comp);
-#endif
-	return status;
-}
-
-/* This function provides IO interface to the bridge driver. */
-static long bridge_ioctl(struct file *filp, unsigned int code,
-			 unsigned long args)
-{
-	int status;
-	u32 retval =3D 0;
-	union trapped_args buf_in;
-
-	DBC_REQUIRE(filp !=3D NULL);
-#ifdef CONFIG_TIDSPBRIDGE_RECOVERY
-	if (recover) {
-		status =3D -EIO;
-		goto err;
-	}
-#endif
-#ifdef CONFIG_PM
-	status =3D omap34_xxbridge_suspend_lockout(&bridge_suspend_data, filp=
);
-	if (status !=3D 0)
-		return status;
-#endif
-
-	if (!filp->private_data) {
-		status =3D -EIO;
-		goto err;
-	}
-
-	status =3D copy_from_user(&buf_in, (union trapped_args *)args,
-				sizeof(union trapped_args));
-
-	if (!status) {
-		status =3D api_call_dev_ioctl(code, &buf_in, &retval,
-					     filp->private_data);
-
-		if (!status) {
-			status =3D retval;
-		} else {
-			dev_dbg(bridge, "%s: IOCTL Failed, code: 0x%x "
-				"status 0x%x\n", __func__, code, status);
-			status =3D -1;
-		}
-
-	}
-
-err:
-	return status;
-}
-
-/* This function maps kernel space memory to user space memory. */
-static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	u32 offset =3D vma->vm_pgoff << PAGE_SHIFT;
-	u32 status;
-
-	DBC_ASSERT(vma->vm_start < vma->vm_end);
-
-	vma->vm_flags |=3D VM_RESERVED | VM_IO;
-	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
-
-	dev_dbg(bridge, "%s: vm filp %p offset %x start %lx end %lx page_prot=
 "
-		"%lx flags %lx\n", __func__, filp, offset,
-		vma->vm_start, vma->vm_end, vma->vm_page_prot, vma->vm_flags);
-
-	status =3D remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-				 vma->vm_end - vma->vm_start,
-				 vma->vm_page_prot);
-	if (status !=3D 0)
-		status =3D -EAGAIN;
-
-	return status;
-}
-
 /* To remove all process resources before removing the process from th=
e
  * process context list */
 int drv_remove_all_resources(void *process_ctxt)
diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.h b/drivers=
/staging/tidspbridge/rmgr/drv_interface.h
deleted file mode 100644
index ab07060..0000000
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * drv_interface.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-#ifndef	_DRV_INTERFACE_H_
-#define _DRV_INTERFACE_H_
-
-/* Prototypes for all functions in this bridge */
-static int __init bridge_init(void);	/* Initialize bridge */
-static void __exit bridge_exit(void);	/* Opposite of initialize */
-static int bridge_open(struct inode *ip, struct file *filp);	/* Open *=
/
-static int bridge_release(struct inode *ip, struct file *filp);	/* Rel=
ease */
-static long bridge_ioctl(struct file *filp, unsigned int code,
-				unsigned long args);
-static int bridge_mmap(struct file *filp, struct vm_area_struct *vma);
-#endif /* ifndef _DRV_INTERFACE_H_ */
--=20
1.7.8.3
