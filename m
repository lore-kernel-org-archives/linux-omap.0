From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: Implement sysfs entry to set wdt3 timeout
Date: Wed, 11 Nov 2009 00:57:41 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6A218FB@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34990 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbZKKG5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 01:57:37 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAB6vhIf007561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:57:43 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nAB6vgS5016623
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:57:42 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAB6vgHP013788
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:57:42 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From c4d13985d498633b56b9e87165361c8511f37fa5 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 11 Nov 2009 00:38:27 -0600
Subject: [PATCH] DSPBRIDGE: Implement sysfs entry to set wdt3 timeout

This patch implements new sysfs entry to change on runtime
the value of the wdt3 timeout (timeout is in sec):

echo <timeout value> > /sys/devices/platform/C6410/wdt3_timeout

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    5 +-
 drivers/dsp/bridge/rmgr/drv_interface.c         |   49 +++++++++++++++++++++++
 drivers/dsp/bridge/wmd/io_sm.c                  |    8 ++++
 3 files changed, 60 insertions(+), 2 deletions(-)
 mode change 100755 => 100644 drivers/dsp/bridge/rmgr/drv_interface.c

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index f85e364..60471b6 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -109,8 +109,9 @@ enum SHM_DESCTYPE {
 	SHM_CURROPP = 0,
 	SHM_OPPINFO = 1,
 	SHM_GETOPP = 2,		/* Get DSP requested OPP info */
-	SHM_WDTOVF = 3,		/* Set the WDT overflow time */
-	SHM_WDTCLOCKS = 4	/* Set/unset F/I WDT clocks flag */
+	SHM_GETWDTOVF,		/* Set the WDT overflow time */
+	SHM_WDTOVF,			/* Set the WDT overflow time */
+	SHM_WDTCLOCKS		/* Set/unset F/I WDT clocks flag */
 } ;
 
 /* Structure in shared between DSP and PC for communication.*/
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
old mode 100755
new mode 100644
index e9cd647..0319573
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -65,6 +65,9 @@
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
 #include <_tiomap.h>
+#ifdef CONFIG_BRIDGE_WDT3
+#include <dspbridge/io_sm.h>
+#endif
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/gt.h>
@@ -753,12 +756,58 @@ func_end:
 }
 
 static DEVICE_ATTR(wdt3_enable, S_IWUSR | S_IRUGO, wdt3_show, wdt3_store);
+
+static ssize_t wdt3_timeout_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	u32 wdt3_to;
+	struct DEV_OBJECT *dev_object;
+	struct IO_MGR *io_mgr;
+
+	dev_object = DEV_GetFirst();
+	if (!dev_object)
+		return 0;
+	DEV_GetIOMgr(dev_object, &io_mgr);
+	if (!io_mgr)
+		return 0;
+
+	if (DSP_FAILED(IO_SHMsetting(io_mgr, SHM_GETWDTOVF, &wdt3_to)))
+		return 0;
+
+	return sprintf(buf, "%u\n", wdt3_to);
+}
+
+static ssize_t wdt3_timeout_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t n)
+{
+	u32 wdt3_to;
+	struct DEV_OBJECT *dev_object;
+	struct IO_MGR *io_mgr;
+
+	if (sscanf(buf, "%u", &wdt3_to) != 1)
+		return -EINVAL;
+
+	dev_object = DEV_GetFirst();
+	if (!dev_object)
+		goto func_end;
+	DEV_GetIOMgr(dev_object, &io_mgr);
+	if (!io_mgr)
+		goto func_end;
+
+	IO_SHMsetting(io_mgr, SHM_WDTOVF, (void *)wdt3_to);
+func_end:
+	return n;
+}
+
+static DEVICE_ATTR(wdt3_timeout, S_IWUSR | S_IRUGO, wdt3_timeout_show,
+			wdt3_timeout_store);
 #endif
 
 static struct attribute *attrs[] = {
 	&dev_attr_drv_state.attr,
 #ifdef CONFIG_BRIDGE_WDT3
 	&dev_attr_wdt3_enable.attr,
+	&dev_attr_wdt3_timeout.attr,
 #endif
 	NULL,
 };
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 588074c..b17cc8b 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1815,6 +1815,14 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
 #endif
 	switch (desc) {
 #ifdef CONFIG_BRIDGE_WDT3
+	case SHM_GETWDTOVF:
+		/* Update the shared memory with WDT timeout */
+		if (pArgs && hIOMgr->pSharedMem &&
+					(int)hIOMgr->pSharedMem != -1)
+			*(u32 *)pArgs = hIOMgr->pSharedMem->wdt_overflow;
+		else
+			return DSP_EPOINTER;
+		break;
 	case SHM_WDTOVF:
 		/* Update the shared memory with WDT timeout */
 		if (hIOMgr->pSharedMem && (int)hIOMgr->pSharedMem != -1)
-- 
1.6.0.4

