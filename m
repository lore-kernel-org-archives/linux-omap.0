From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] mfd: twl4030: add twl4030_bci platform_data back
Date: Fri,  1 Oct 2010 13:17:50 +0300
Message-ID: <1285928270-9302-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48427 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0JAKR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 06:17:57 -0400
Received: by eyb6 with SMTP id 6so1180833eyb.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 03:17:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Grazvydas Ignotas <notasas@gmail.com>

Now that we have twl4030 charger driver, add back it's platform_data
(which was removed by f7ea2dc59ed46dcd0f1cfaccda02211f4507207b
as unused).

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
Well the driver is still in battery.git and linux-next, but I'm
pretty sure it will reach Linus.

 drivers/mfd/twl-core.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index b0f2c00..2f5258f 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -115,6 +115,12 @@
 #define twl_has_codec()	false
 #endif
 
+#if defined(CONFIG_CHARGER_TWL4030) || defined(CONFIG_CHARGER_TWL4030_MODULE)
+#define twl_has_bci()	true
+#else
+#define twl_has_bci()	false
+#endif
+
 /* Triton Core internal information (BEGIN) */
 
 /* Last - for index max*/
@@ -826,6 +832,17 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
+	if (twl_has_bci() && pdata->bci &&
+			!(features & (TPS_SUBSET | TWL5031))) {
+		child = add_child(3, "twl4030_bci",
+				pdata->bci, sizeof(*pdata->bci), false,
+				/* irq0 = CHG_PRES, irq1 = BCI */
+				pdata->irq_base + BCI_PRES_INTR_OFFSET,
+				pdata->irq_base + BCI_INTR_OFFSET);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
 	return 0;
 }
 
-- 
1.6.3.3

