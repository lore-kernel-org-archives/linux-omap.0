From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v2 1/7] OMAP: DSS: Adding a header file for picodlp panel data
Date: Mon,  2 May 2011 20:22:45 +0530
Message-ID: <1304347971-1504-2-git-send-email-mayur@ti.com>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56068 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759779Ab1EBOjh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 May 2011 10:39:37 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p42EdbrG025882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 May 2011 09:39:37 -0500
In-Reply-To: <1304347971-1504-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mayuresh Janorkar <mayur@ti.com>

picodlp is a TI projector panel supported by OMAP
picodlp makes use of i2c interface for transferring commands to the panel
panel data is required for identifying i2c_adapter id and dlp GPIOs

A new header file has been added for panel data and
picodlp_panel_data struct has been introduced

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
Changes since v1: Nil

 arch/arm/plat-omap/include/plat/panel-picodlp.h |   25 +++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/panel-picodlp.h

diff --git a/arch/arm/plat-omap/include/plat/panel-picodlp.h b/arch/arm/plat-omap/include/plat/panel-picodlp.h
new file mode 100644
index 0000000..89ac4b9
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/panel-picodlp.h
@@ -0,0 +1,25 @@
+/*
+ * panel data for picodlp panel
+ *
+ * Copyright (C) 2011 Texas Instruments
+ *
+ * Author: Mayuresh Janorkar <mayur@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ARM_PLAT_PANEL_PICODLP_H
+#define __ARCH_ARM_PLAT_PANEL_PICODLP_H
+/**
+ * struct : picodlp panel data
+ * picodlp_adapter_id:	i2c_adapter number for picodlp
+ */
+struct picodlp_panel_data {
+	int picodlp_adapter_id;
+	int phy_reset_gpio;
+	int ready_reset_gpio;
+	int park_gpio;
+	int display_sel_gpio;
+};
+#endif /* __ARCH_ARM_PLAT_PANEL_PICODLP_H */
-- 
1.7.1

