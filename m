From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/13] omap: Add new interface omap_get_die_id
Date: Thu, 08 Jul 2010 16:55:06 +0300
Message-ID: <20100708135506.26276.73243.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60624 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab0GHNzK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:55:10 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Kan-Ru Chen <kanru@0xlab.org>

From: Kan-Ru Chen <kanru@0xlab.org>

Allow DIE id to be get and used by others.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |   10 ++++++++++
 arch/arm/mach-omap2/include/mach/id.h |   22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/id.h

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index ccaa1ed..d079ccf 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -25,6 +25,8 @@
 #include <plat/control.h>
 #include <plat/cpu.h>
 
+#include <mach/id.h>
+
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
@@ -102,6 +104,14 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
+void omap_get_die_id(struct omap_die_id *odi)
+{
+	odi->id_0 = read_tap_reg(OMAP_TAP_DIE_ID_0);
+	odi->id_1 = read_tap_reg(OMAP_TAP_DIE_ID_1);
+	odi->id_2 = read_tap_reg(OMAP_TAP_DIE_ID_2);
+	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
+}
+
 static void __init omap24xx_check_revision(void)
 {
 	int i, j;
diff --git a/arch/arm/mach-omap2/include/mach/id.h b/arch/arm/mach-omap2/include/mach/id.h
new file mode 100644
index 0000000..02ed3aa
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/id.h
@@ -0,0 +1,22 @@
+/*
+ * OMAP2 CPU identification code
+ *
+ * Copyright (C) 2010 Kan-Ru Chen <kanru@0xlab.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef OMAP2_ARCH_ID_H
+#define OMAP2_ARCH_ID_H
+
+struct omap_die_id {
+	u32 id_0;
+	u32 id_1;
+	u32 id_2;
+	u32 id_3;
+};
+
+void omap_get_die_id(struct omap_die_id *odi);
+
+#endif

