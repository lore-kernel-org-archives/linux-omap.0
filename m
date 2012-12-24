From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] ARM: OMAP: 32k counter: resolve sparse warnings
Date: Sun, 23 Dec 2012 18:24:58 -0700
Message-ID: <20121224012456.13698.41839.stgit@dusk.lan>
References: <20121224012304.13698.43551.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57202 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab2LXB1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 20:27:25 -0500
In-Reply-To: <20121224012304.13698.43551.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Commit 1fe97c8f6a1de67a5f56e029a818903d5bed8017 ("ARM: OMAP: Make OMAP
clocksource source selection using kernel param") results in a new warning
from sparse:

arch/arm/plat-omap/counter_32k.c:86:12: warning: symbol 'omap_init_clocksource_32k' was not declared. Should it be static?

Fix by adding a temporary header file, needed until the 32k counter
code is moved to drivers/.
arch/arm/plat-omap/include/plat/counter-32k.h can't be added due to
ARM CONFIG_ARCH_MULTIPLATFORM restrictions on the use of the "plat/"
include path shortcut.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/counter_32k.c |    2 ++
 arch/arm/plat-omap/counter_32k.h |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm/plat-omap/counter_32k.h

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index f3771cd..1d129d3 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -22,6 +22,8 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
+#include "counter_32k.h"
+
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
 #define OMAP2_32KSYNCNT_REV_OFF		0x0
 #define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
diff --git a/arch/arm/plat-omap/counter_32k.h b/arch/arm/plat-omap/counter_32k.h
new file mode 100644
index 0000000..4366ce5
--- /dev/null
+++ b/arch/arm/plat-omap/counter_32k.h
@@ -0,0 +1,20 @@
+/*
+ * OMAP 32k counter function prototypes
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX Needed until the OMAP 32k counter code is moved to somewhere under
+ * drivers/.
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_COUNTER_32K_H
+#define __ARCH_ARM_PLAT_OMAP_COUNTER_32K_H
+
+#include <linux/kernel.h>
+
+extern int omap_init_clocksource_32k(void __iomem *vbase);
+
+#endif


