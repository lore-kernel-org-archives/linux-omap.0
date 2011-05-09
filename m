From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH 1/4] OMAP: DSS: Adding a header file for picodlp data
Date: Mon,  9 May 2011 20:48:36 +0530
Message-ID: <1304954319-8386-2-git-send-email-mayur@ti.com>
References: <1304954319-8386-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41243 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765Ab1EIOur (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 May 2011 10:50:47 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p49EolwG016278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 May 2011 09:50:47 -0500
In-Reply-To: <1304954319-8386-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mayuresh Janorkar <mayur@ti.com>

picodlp is a TI projector supported by OMAP
picodlp is interfaced with host processor using pwrgood and emu_done pins.
In programming sequence it is required to send high to pwrgood to low
wait for a fraction of seconds and then wait for emu_done signal to go low.
picodlp would be ready to send/ receive i2c commands 500 mili-seconds after
emu_done goes low.

A new header file has been added for panel data and
picodlp_panel_data struct has been introduced

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
Changes since v2:
	Changed gpio names to emu_done_gpio and pwrgood_gpio

Changes since v1: Nil

 arch/arm/plat-omap/include/plat/panel-picodlp.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/panel-picodlp.h

diff --git a/arch/arm/plat-omap/include/plat/panel-picodlp.h b/arch/arm/plat-omap/include/plat/panel-picodlp.h
new file mode 100644
index 0000000..333f7d6
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/panel-picodlp.h
@@ -0,0 +1,23 @@
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
+	int emu_done_gpio;
+	int pwrgood_gpio;
+};
+#endif /* __ARCH_ARM_PLAT_PANEL_PICODLP_H */
-- 
1.7.1

