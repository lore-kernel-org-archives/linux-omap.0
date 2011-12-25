From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 1/2] arm:omap:am33xx: Add voltage domain data
Date: Sun, 25 Dec 2011 14:30:27 +0530
Message-ID: <1324803628-16790-2-git-send-email-hvaibhav@ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab1LYJAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Dec 2011 04:00:46 -0500
In-Reply-To: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>

Currently dummy voltage domain data is being created
in order to succeed boot process, nothing has been done
w.r.t actual hardware (voltage control).

Also, hook up the AM33XX voltage domain to OMAP framework.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Makefile                  |    2 +
 arch/arm/mach-omap2/io.c                      |    1 +
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   46 +++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 74ae499..8d90f9f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -99,6 +99,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common) \
 					   voltagedomains2xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(voltagedomain-common) \
+					   voltagedomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5c180de..d50cbd7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -472,6 +472,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_am33xx();
 	omap_common_init_early();
+	am33xx_voltagedomains_init();
 	omap3xxx_clk_init();
 }
 #endif
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
index 0000000..78fbf39
--- /dev/null
+++ b/arch/arm/mach-omap2/voltagedomains33xx_data.c
@@ -0,0 +1,46 @@
+/*
+ * AM33XX voltage domain data
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "voltage.h"
+
+static struct voltagedomain am33xx_voltdm_mpu = {
+	.name		= "mpu",
+	.scalable	= false,
+};
+
+static struct voltagedomain am33xx_voltdm_core = {
+	.name		= "core",
+	.scalable	= false,
+};
+
+static struct voltagedomain am33xx_voltdm_rtc = {
+	.name		= "rtc",
+	.scalable	= false,
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

