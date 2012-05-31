From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/2] arm: omap3: am35x: Convert emac to hwmod & disable hlt when open
Date: Thu, 31 May 2012 11:57:50 -0700
Message-ID: <8762bc18lt.fsf@ti.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:59488 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755859Ab2EaS5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 14:57:51 -0400
Received: by pbcwz7 with SMTP id wz7so2900589pbc.16
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 11:57:50 -0700 (PDT)
In-Reply-To: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Tue, 15 May 2012 11:14:00 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>, hvaibhav@ti.com, vaibhav.bedia@ti.comhvaibhav@ti.com
Cc: paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> These patches convert the davinci emac support for the am35x SoC
> to use hwmod and add enable_hlt()/disable_hlt() calls to the
> pm_runtime hooks for that driver.
>
> I have converted the davinci_emac driver to use pm_runtime but I
> can't formally submit it yet since it requires some changes on the
> mach-davinci side that haven't happened yet.  I will send it as an
> RFC in a reply to this thread.

I haven't seen any patches for the davinci runtime PM support, so I
thought I would do a quick patch to show how easy it is to use some
generic PM core code to manage clocks in runtime PM.

The patch below implments this on davinci but has only been boot tested
on my ancient dm6446 EVM.  Combined with Mark's RFC patch to convert
davinci_emac to runtime PM, it was working fine on dm6446 to enable the
emac clocks.

Kevin

>From 7a90e650ad8542b7f85076b58703e94bdc058562 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 31 May 2012 09:59:53 -0700
Subject: [PATCH] ARM: davinci: add runtime PM support for clock management

Add runtime PM core support to davinci by using the pm_clk
infrastructure of the PM core.

When runtime PM is enabled, the davinci runtime PM implementation will
use the pm_clk layer to enable/disable clocks on demand.  When runtime
PM is disabled, the pm_clk core will automatically enable clocks when
the driver is bound and disable clocks when the driver is unbound.

Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Sekhar Nori <nsekhar@ti.com
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies on v3.4

 arch/arm/mach-davinci/Makefile    |    1 +
 arch/arm/mach-davinci/pm_domain.c |   70 +++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm/mach-davinci/pm_domain.c

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 2db78bd..2227eff 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_MACH_OMAPL138_HAWKBOARD)	+= board-omapl138-hawk.o
 obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_SUSPEND)			+= pm.o sleep.o
+obj-$(CONFIG_HAVE_CLK)			+= pm_domain.o
diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
new file mode 100644
index 0000000..f34258f
--- /dev/null
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -0,0 +1,70 @@
+/*
+ * Runtime PM support code for DaVinci
+ *
+ * Author: Kevin Hilman
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_clock.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#ifdef CONFIG_PM_RUNTIME
+static int davinci_pm_runtime_suspend(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_generic_runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_clk_suspend(dev);
+	if (ret) {
+		pm_generic_runtime_resume(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int davinci_pm_runtime_resume(struct device *dev)
+{
+	dev_dbg(dev, "%s\n", __func__);
+	dump_stack();
+
+	pm_clk_resume(dev);
+	return pm_generic_runtime_resume(dev);
+}
+#endif
+
+static struct dev_pm_domain davinci_pm_domain = {
+	.ops = {
+		SET_RUNTIME_PM_OPS(davinci_pm_runtime_suspend,
+				   davinci_pm_runtime_resume, NULL)
+		USE_PLATFORM_PM_SLEEP_OPS
+	},
+};
+
+static struct pm_clk_notifier_block platform_bus_notifier = {
+	.pm_domain = &davinci_pm_domain,
+};
+
+static int __init davinci_pm_runtime_init(void)
+{
+	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
+
+	return 0;
+}
+core_initcall(davinci_pm_runtime_init);
-- 
1.7.9.2

