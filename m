From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPGW: Fix build error for device_create()
Date: Tue, 12 Aug 2008 10:11:53 +0300
Message-ID: <1218525113-25414-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32420 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYHLHMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 03:12:14 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7C7C4SM009289
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 10:12:11 +0300
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7C7BrYe027947
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 10:11:53 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Ideally, the contents mamagement should be handled by drv_data instead
of homebrewed array.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/dspgateway/dsp_ctl_core.c |    5 ++---
 drivers/dsp/dspgateway/task.c         |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/dspgateway/dsp_ctl_core.c b/drivers/dsp/dspgateway/dsp_ctl_core.c
index 3c13572..25954bb 100644
--- a/drivers/dsp/dspgateway/dsp_ctl_core.c
+++ b/drivers/dsp/dspgateway/dsp_ctl_core.c
@@ -110,9 +110,8 @@ int __init dsp_ctl_core_init(void)
 	dsp_ctl_class = class_create(THIS_MODULE, "dspctl");
 	for (i = 0; i < ARRAY_SIZE(dev_list); i++) {
 		device_create(dsp_ctl_class, NULL,
-				    MKDEV(OMAP_DSP_CTL_MAJOR,
-					  dev_list[i].minor),
-				    dev_list[i].devname);
+			      MKDEV(OMAP_DSP_CTL_MAJOR, dev_list[i].minor),
+			      NULL, dev_list[i].devname);
 	}
 
 	return 0;
diff --git a/drivers/dsp/dspgateway/task.c b/drivers/dsp/dspgateway/task.c
index 4d7dcdd..ab18934 100644
--- a/drivers/dsp/dspgateway/task.c
+++ b/drivers/dsp/dspgateway/task.c
@@ -1762,7 +1762,7 @@ static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
 		goto fail_create_proclist;
 
 	task_dev = device_create(dsp_task_class, NULL,
-				 MKDEV(OMAP_DSP_TASK_MAJOR, minor),
+				 MKDEV(OMAP_DSP_TASK_MAJOR, minor), NULL,
 				 "dsptask%d", (int)minor);
 
 	if (unlikely(IS_ERR(task_dev))) {
-- 
1.5.5.1.357.g1af8b

