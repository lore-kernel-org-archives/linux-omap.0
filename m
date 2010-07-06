From: Kan-Ru Chen <kanru@0xlab.org>
Subject: [PATCHv2 1/3] omap: Add new interface omap_get_die_id
Date: Tue,  6 Jul 2010 09:10:02 +0800
Message-ID: <1278378604-15802-2-git-send-email-kanru@0xlab.org>
References: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:60680 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0GFBPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 21:15:41 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1OVwl0-0006lT-KU
	for linux-omap@vger.kernel.org; Tue, 06 Jul 2010 01:15:32 +0000
In-Reply-To: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Kan-Ru Chen <kanru@0xlab.org>, Tony Lindgren <tony@atomide.com>

Allow DIE id to be get and used by others.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
---
 arch/arm/mach-omap2/id.c              |   10 ++++++++++
 arch/arm/mach-omap2/include/mach/id.h |   22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/id.h

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..80bd1cd 100644
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
 void __init omap24xx_check_revision(void)
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
-- 
1.7.1

