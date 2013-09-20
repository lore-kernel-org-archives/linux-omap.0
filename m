From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Add quirk support for legacy platform data
 init
Date: Fri, 20 Sep 2013 10:38:17 -0700
Message-ID: <20130920173817.2584.55941.stgit@localhost>
References: <20130920173310.2584.24522.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26195 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753042Ab3ITRiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Sep 2013 13:38:19 -0400
In-Reply-To: <20130920173310.2584.24522.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We want to drop the board-*.c files but keep things working.
Let's make it a bit easier to support legacy platform data
init with quirks. This also keeps board-generic.c clean from
board specific hacks.

For now, the quirks table is empty, that is populated
in the later patches.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile        |    2 +-
 arch/arm/mach-omap2/board-generic.c |    1 +
 arch/arm/mach-omap2/common.h        |    2 ++
 arch/arm/mach-omap2/pdata-quirks.c  |   39 +++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/pdata-quirks.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index afb457c..f8d4a1b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -233,7 +233,7 @@ obj-y					+= drm.o
 endif
 
 # Specific board support
-obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
+obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o pdata-quirks.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 39c7838..022b0df 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -56,6 +56,7 @@ static void __init omap_generic_init(void)
 	omap_sdrc_init(NULL, NULL);
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+	pdata_quirks_init();
 
 	/*
 	 * HACK: call display setup code for selected boards to enable omapdss.
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 4a5684b..fd059e0 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -288,6 +288,8 @@ static inline void omap4_cpu_resume(void)
 
 #endif
 
+void pdata_quirks_init(void);
+
 struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
new file mode 100644
index 0000000..e605199
--- /dev/null
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -0,0 +1,39 @@
+/*
+ * Legacy platform_data quirks
+ *
+ * Copyright (C) 2013 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include "common.h"
+#include "common-board-devices.h"
+#include "dss-common.h"
+
+struct pdata_init {
+	const char *compatible;
+	void (*fn)(void);
+};
+
+static struct pdata_init pdata_quirks[] __initdata = {
+	{ /* sentinel */ },
+};
+
+void __init pdata_quirks_init(void)
+{
+	struct pdata_init *quirks = pdata_quirks;
+
+	while (quirks->compatible) {
+		if (of_machine_is_compatible(quirks->compatible)) {
+			if (quirks->fn)
+				quirks->fn();
+			break;
+		}
+		quirks++;
+	}
+}

