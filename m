From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 7/7] omap: voltage: add a stub header file for external/regulator use
Date: Mon, 29 Aug 2011 11:10:49 -0700
Message-ID: <1314641449-5089-8-git-send-email-khilman@ti.com>
References: <1314641449-5089-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36177 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754516Ab1H2SKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:10:34 -0400
Received: by mail-pz0-f46.google.com with SMTP id 32so9962208pzk.5
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:10:33 -0700 (PDT)
In-Reply-To: <1314641449-5089-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Needed as some of the voltage layer functionality is accessed from the
SMPS regulator driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/voltage.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h

diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
new file mode 100644
index 0000000..0a6a482
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -0,0 +1,20 @@
+/*
+ * OMAP Voltage Management Routines
+ *
+ * Copyright (C) 2011, Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_OMAP_VOLTAGE_H
+#define __ARCH_ARM_OMAP_VOLTAGE_H
+
+struct voltagedomain;
+
+struct voltagedomain *voltdm_lookup(const char *name);
+int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
+unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
+
+#endif
-- 
1.7.6

