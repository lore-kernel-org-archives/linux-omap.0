From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 01/11] arm:omap:am33xx: Add voltage domain data
Date: Sun, 20 Nov 2011 22:49:05 +0530
Message-ID: <1321809555-13833-2-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37432 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab1KTRTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Nov 2011 12:19:39 -0500
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

Currently dummy voltage domain data is being created
in order to succeed boot process.
Nothing has been done w.r.t actual hardware (voltage control).

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   37 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 16a1b09..a7c43c1 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -156,6 +156,7 @@ int omap_voltage_late_init(void);

 extern void omap2xxx_voltagedomains_init(void);
 extern void omap3xxx_voltagedomains_init(void);
+extern void am33xx_voltagedomains_init(void);
 extern void omap44xx_voltagedomains_init(void);

 struct voltagedomain *voltdm_lookup(const char *name);
diff --git a/arch/arm/mach-omap2/voltagedomains33xx_data.c b/arch/arm/mach-omap2/voltagedomains33xx_data.c
new file mode 100644
index 0000000..f8c817a
--- /dev/null
+++ b/arch/arm/mach-omap2/voltagedomains33xx_data.c
@@ -0,0 +1,37 @@
+/*
+ * AM33XX voltage domain data
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "voltage.h"
+
+static struct voltagedomain am33xx_voltdm_mpu = {
+	.name = "mpu",
+};
+
+static struct voltagedomain am33xx_voltdm_core = {
+	.name = "core",
+};
+
+static struct voltagedomain am33xx_voltdm_rtc = {
+	.name = "rtc",
+};
+
+static struct voltagedomain *voltagedomains_am33xx[] __initdata = {
+	&am33xx_voltdm_mpu,
+	&am33xx_voltdm_core,
+	&am33xx_voltdm_rtc,
+	NULL,
+};
+
+void __init am33xx_voltagedomains_init(void)
+{
+	voltdm_init(voltagedomains_am33xx);
+}
--
1.7.0.4

