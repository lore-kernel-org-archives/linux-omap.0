From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/6] ARM: OMAP AM33xx: voltagedomain: Add voltage domain
 data
Date: Sun, 10 Jun 2012 19:20:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206101916480.20674@utopia.booyaka.com>
References: <20120521184053.22565.90037.stgit@dusk> <20120521184156.22565.87926.stgit@dusk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51067 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2FKBUS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 21:20:18 -0400
In-Reply-To: <20120521184156.22565.87926.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Vaibhav, Afzal, Tony,

On Mon, 21 May 2012, Paul Walmsley wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Currently dummy voltage domain data is being created
> in order to succeed boot process, nothing has been done
> w.r.t actual hardware (voltage control).
> 
> Also, hook up the AM33XX voltage domain to OMAP framework.

I had to update this patch again for v3.5 to account for the lack of 
am33xx_init_early().  So now this patch has to add it (updated patch 
below). 

But it seems to me that I must be missing something.  Are we missing a 
prerequisite patch for this series from mainline?  Or is this some 
casualty of kicking out the board file?

If the latter, how do we make sure that am33xx_init_early() is called at 
the right time?

Once we get this sorted out, I'll send the pull request.

Branch on git://git.pwsan.com/linux-2.6 in 'am33xx_prcm_devel_3.6'


- Paul

>From 127240db05c0d381a50712a320439c5679fb22da Mon Sep 17 00:00:00 2001
From: Vaibhav Hiremath <hvaibhav@ti.com>
Date: Sun, 10 Jun 2012 18:56:14 -0600
Subject: [PATCH] ARM: OMAP AM33xx: voltagedomain: Add voltage domain data

Currently dummy voltage domain data is being created
in order to succeed boot process, nothing has been done
w.r.t actual hardware (voltage control).

Also, hook up the AM33XX voltage domain to OMAP framework.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: updated for 3.5]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/common.h                  |    1 +
 arch/arm/mach-omap2/io.c                      |   13 +++++++-
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 +++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..6a3aef6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)                += voltagedomains33xx_data.o
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index be9dfd1..dad91e2 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -128,6 +128,7 @@ void omap3430_init_early(void);
 void omap35xx_init_early(void);
 void omap3630_init_early(void);
 void omap3_init_early(void);	/* Do not use this one */
+void am33xx_init_early(void);
 void am35xx_init_early(void);
 void ti81xx_init_early(void);
 void omap4430_init_early(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8d014ba..37ecc71 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -381,11 +381,22 @@ void __init omap2430_init_late(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_AM33XX
+void __init am33xx_init_early(void)
+{
+	omap2_set_globals_am33xx();
+	omap3xxx_check_revision();
+	ti81xx_check_features();
+	omap_common_init_early();
+	am33xx_voltagedomains_init();
+}
+#endif
+
 /*
  * Currently only board-omap3beagle.c should call this because of the
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
  */
-#ifdef CONFIG_ARCH_OMAP3
+#ifdef CONFIG_SOC_OMAP3430
 void __init omap3_init_early(void)
 {
 	omap2_set_globals_3xxx();
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
index 0000000..965458d
--- /dev/null
+++ b/arch/arm/mach-omap2/voltagedomains33xx_data.c
@@ -0,0 +1,43 @@
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
+};
+
+static struct voltagedomain am33xx_voltdm_core = {
+	.name		= "core",
+};
+
+static struct voltagedomain am33xx_voltdm_rtc = {
+	.name		= "rtc",
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
1.7.10


