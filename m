From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH] omap: remoteproc: set bootaddr support
Date: Wed, 15 Aug 2012 10:25:48 -0500
Message-ID: <1345044348-19898-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53796 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064Ab2HOP0C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 11:26:02 -0400
Received: by obbup19 with SMTP id up19so2511966obb.12
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 08:26:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ohad@wizery.com
Cc: Juan Gutierrez <jgutierrez@ti.com>, Suman Anna <s-anna@ti.com>

Some remote processors (like Omap4's DSP) need to explicitly
set a boot address from which they start executing code when
taken out of reset.

Support for this has been added to remoteproc code through
a set_bootaddr function in the platform data which, if needed,
must be set according to the backend rproc.

For omap4's dsp we can use the next control funtion:

  .set_bootaddr  = omap_ctrl_write_dsp_boot_addr

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/include/plat/remoteproc.h |    2 ++
 drivers/remoteproc/omap_remoteproc.c         |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/remoteproc.h b/arch/arm/plat-omap/include/plat/remoteproc.h
index b10eac8..3c1c644 100644
--- a/arch/arm/plat-omap/include/plat/remoteproc.h
+++ b/arch/arm/plat-omap/include/plat/remoteproc.h
@@ -30,6 +30,7 @@ struct platform_device;
  * @ops: start/stop rproc handlers
  * @device_enable: omap-specific handler for enabling a device
  * @device_shutdown: omap-specific handler for shutting down a device
+ * @set_bootaddr: omap-specific handler for setting the rproc boot address
  */
 struct omap_rproc_pdata {
 	const char *name;
@@ -40,6 +41,7 @@ struct omap_rproc_pdata {
 	const struct rproc_ops *ops;
 	int (*device_enable) (struct platform_device *pdev);
 	int (*device_shutdown) (struct platform_device *pdev);
+	void(*set_bootaddr)(u32);
 };
 
 #if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index a1f7ac1..a0c168c 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -116,6 +116,9 @@ static int omap_rproc_start(struct rproc *rproc)
 	struct omap_rproc_pdata *pdata = pdev->dev.platform_data;
 	int ret;
 
+	if (pdata->set_bootaddr)
+		pdata->set_bootaddr(rproc->bootaddr);
+
 	oproc->nb.notifier_call = omap_rproc_mbox_callback;
 
 	/* every omap rproc is assigned a mailbox instance for messaging */
-- 
1.7.1

