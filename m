From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v4 3/3] staging: tidspbridge: fix kernel oops in bridge_io_get_proc_load
Date: Fri,  5 Nov 2010 19:01:50 +0200
Message-ID: <1288976510-25470-4-git-send-email-ionut.nicu@mindbit.ro>
References: <1288976510-25470-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50546 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab0KERCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 13:02:22 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so2321444yxk.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 10:02:22 -0700 (PDT)
In-Reply-To: <1288976510-25470-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

The DSP shared memory area gets initialized only when
a COFF file is loaded.

If bridge_io_get_proc_load is called before loading a base
image into the DSP, the shared_mem member of the io manager
will be NULL, resulting in a kernel oops when it's dereferenced.

Also made some coding style changes to bridge_io_create.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 drivers/staging/tidspbridge/core/io_sm.c |   78 +++++++++++------------------
 1 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/io_sm.c b/drivers/staging/tidspbridge/core/io_sm.c
index de2cc3b..bd407b6 100644
--- a/drivers/staging/tidspbridge/core/io_sm.c
+++ b/drivers/staging/tidspbridge/core/io_sm.c
@@ -164,57 +164,41 @@ int bridge_io_create(struct io_mgr **io_man,
 			    struct dev_object *hdev_obj,
 			    const struct io_attrs *mgr_attrts)
 {
-	int status = 0;
 	struct io_mgr *pio_mgr = NULL;
-	struct shm *shared_mem = NULL;
 	struct bridge_dev_context *hbridge_context = NULL;
 	struct cfg_devnode *dev_node_obj;
 	struct chnl_mgr *hchnl_mgr;
 	u8 dev_type;
 
 	/* Check requirements */
-	if (!io_man || !mgr_attrts || mgr_attrts->word_size == 0) {
-		status = -EFAULT;
-		goto func_end;
-	}
+	if (!io_man || !mgr_attrts || mgr_attrts->word_size == 0)
+		return -EFAULT;
+
+	*io_man = NULL;
+
 	dev_get_chnl_mgr(hdev_obj, &hchnl_mgr);
-	if (!hchnl_mgr || hchnl_mgr->hio_mgr) {
-		status = -EFAULT;
-		goto func_end;
-	}
+	if (!hchnl_mgr || hchnl_mgr->hio_mgr)
+		return -EFAULT;
+
 	/*
 	 * Message manager will be created when a file is loaded, since
 	 * size of message buffer in shared memory is configurable in
 	 * the base image.
 	 */
 	dev_get_bridge_context(hdev_obj, &hbridge_context);
-	if (!hbridge_context) {
-		status = -EFAULT;
-		goto func_end;
-	}
+	if (!hbridge_context)
+		return -EFAULT;
+
 	dev_get_dev_type(hdev_obj, &dev_type);
-	/*
-	 * DSP shared memory area will get set properly when
-	 * a program is loaded. They are unknown until a COFF file is
-	 * loaded. I chose the value -1 because it was less likely to be
-	 * a valid address than 0.
-	 */
-	shared_mem = (struct shm *)-1;
 
 	/* Allocate IO manager object */
 	pio_mgr = kzalloc(sizeof(struct io_mgr), GFP_KERNEL);
-	if (pio_mgr == NULL) {
-		status = -ENOMEM;
-		goto func_end;
-	}
+	if (!pio_mgr)
+		return -ENOMEM;
 
 	/* Initialize chnl_mgr object */
-#if defined(CONFIG_TIDSPBRIDGE_BACKTRACE) || defined(CONFIG_TIDSPBRIDGE_DEBUG)
-	pio_mgr->pmsg = NULL;
-#endif
 	pio_mgr->hchnl_mgr = hchnl_mgr;
 	pio_mgr->word_size = mgr_attrts->word_size;
-	pio_mgr->shared_mem = shared_mem;
 
 	if (dev_type == DSP_UNIT) {
 		/* Create an IO DPC */
@@ -226,29 +210,24 @@ int bridge_io_create(struct io_mgr **io_man,
 
 		spin_lock_init(&pio_mgr->dpc_lock);
 
-		status = dev_get_dev_node(hdev_obj, &dev_node_obj);
+		if (dev_get_dev_node(hdev_obj, &dev_node_obj)) {
+			bridge_io_destroy(pio_mgr);
+			return -EIO;
+		}
 	}
 
-	if (!status) {
-		pio_mgr->hbridge_context = hbridge_context;
-		pio_mgr->shared_irq = mgr_attrts->irq_shared;
-		if (dsp_wdt_init())
-			status = -EPERM;
-	} else {
-		status = -EIO;
-	}
-func_end:
-	if (status) {
-		/* Cleanup */
+	pio_mgr->hbridge_context = hbridge_context;
+	pio_mgr->shared_irq = mgr_attrts->irq_shared;
+	if (dsp_wdt_init()) {
 		bridge_io_destroy(pio_mgr);
-		if (io_man)
-			*io_man = NULL;
-	} else {
-		/* Return IO manager object to caller... */
-		hchnl_mgr->hio_mgr = pio_mgr;
-		*io_man = pio_mgr;
+		return -EPERM;
 	}
-	return status;
+
+	/* Return IO manager object to caller... */
+	hchnl_mgr->hio_mgr = pio_mgr;
+	*io_man = pio_mgr;
+
+	return 0;
 }
 
 /*
@@ -1532,6 +1511,9 @@ int io_sh_msetting(struct io_mgr *hio_mgr, u8 desc, void *pargs)
 int bridge_io_get_proc_load(struct io_mgr *hio_mgr,
 				struct dsp_procloadstat *proc_lstat)
 {
+	if (!hio_mgr->shared_mem)
+		return -EFAULT;
+
 	proc_lstat->curr_load =
 			hio_mgr->shared_mem->load_mon_info.curr_dsp_load;
 	proc_lstat->predicted_load =
-- 
1.7.2.3

