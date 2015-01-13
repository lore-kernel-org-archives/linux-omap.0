From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] ARM: OMAP2+: Fix reboot for 81xx
Date: Tue, 13 Jan 2015 15:13:56 -0800
Message-ID: <1421190837-4692-7-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29291 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752614AbbAMXSB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:18:01 -0500
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

We are missing proper hooks for 81xx for reboot to work.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile         |  1 +
 arch/arm/mach-omap2/common.h         |  8 ++++++++
 arch/arm/mach-omap2/ti81xx-restart.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm/mach-omap2/ti81xx-restart.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5d27dfd..3a6463f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -58,6 +58,7 @@ AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
 # Restart code (OMAP4/5 currently in omap4-common.c)
 obj-$(CONFIG_SOC_OMAP2420)		+= omap2-restart.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap2-restart.o
+obj-$(CONFIG_SOC_TI81XX)		+= ti81xx-restart.o
 obj-$(CONFIG_SOC_AM33XX)		+= am33xx-restart.o
 obj-$(CONFIG_SOC_AM43XX)		+= omap4-restart.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap3-restart.o
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 900ebdd..65b4371 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -164,6 +164,14 @@ static inline void omap3xxx_restart(enum reboot_mode mode, const char *cmd)
 }
 #endif
 
+#ifdef CONFIG_SOC_TI81XX
+void ti81xx_restart(enum reboot_mode mode, const char *cmd);
+#else
+static inline void ti81xx_restart(enum reboot_mode mode, const char *cmd)
+{
+}
+#endif
+
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
 	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
 void omap44xx_restart(enum reboot_mode mode, const char *cmd);
diff --git a/arch/arm/mach-omap2/ti81xx-restart.c b/arch/arm/mach-omap2/ti81xx-restart.c
new file mode 100644
index 0000000..68b29be
--- /dev/null
+++ b/arch/arm/mach-omap2/ti81xx-restart.c
@@ -0,0 +1,31 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/reboot.h>
+
+#include "iomap.h"
+#include "common.h"
+#include "control.h"
+#include "prm3xxx.h"
+
+#define TI81XX_PRM_DEVICE_RSTCTRL	0x00a0
+#define TI81XX_GLOBAL_RST_COLD		BIT(1)
+
+/**
+ * ti81xx_restart - trigger a software restart of the SoC
+ * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
+ * @cmd: passed from the userspace program rebooting the system (if provided)
+ *
+ * Resets the SoC.  For @cmd, see the 'reboot' syscall in
+ * kernel/sys.c.  No return value.
+ */
+void ti81xx_restart(enum reboot_mode mode, const char *cmd)
+{
+	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
+				   TI81XX_PRM_DEVICE_RSTCTRL);
+	while (1);
+}
-- 
2.1.4

