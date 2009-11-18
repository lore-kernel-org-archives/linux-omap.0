From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 6/8] ARM: OMAP3: SDRC: add timing data for Numonyx M65KxxxxAM
Date: Wed, 18 Nov 2009 21:20:38 +0100
Message-ID: <1258575640-8169-7-git-send-email-eballetbo@gmail.com>
References: <1258575640-8169-1-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-2-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-3-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-4-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-5-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-6-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:63735 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447Ab0AMLC5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:02:57 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so323499ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 03:02:56 -0800 (PST)
In-Reply-To: <1258575640-8169-6-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add timing data for the Numonyx M65KxxxxAM SDRAM chip, used on the
IGEP v2 board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h |   51 ++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h

diff --git a/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h b/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
new file mode 100644
index 0000000..cd43529
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
@@ -0,0 +1,51 @@
+/*
+ * SDRC register values for the Numonyx M65KXXXXAM
+ *
+ * Copyright (C) 2009 Integration Software and Electronic Engineering.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_SDRAM_NUMONYX_M65KXXXXAM
+#define __ARCH_ARM_MACH_OMAP2_SDRAM_NUMONYX_M65KXXXXAM
+
+#include <plat/sdrc.h>
+
+/* Numonyx  M65KXXXXAM */
+static struct omap_sdrc_params m65kxxxxam_sdrc_params[] = {
+	[0] = {
+		.rate		= 200000000,
+		.actim_ctrla	= 0xe321d4c6,
+		.actim_ctrlb	= 0x00022328,
+		.rfr_ctrl	= 0x0005e601,
+		.mr		= 0x00000032,
+	},
+	[1] = {
+		.rate		= 166000000,
+		.actim_ctrla	= 0xba9dc485,
+		.actim_ctrlb	= 0x00022321,
+		.rfr_ctrl	= 0x0004dc01,
+		.mr		= 0x00000032,
+	},
+	[2] = {
+		.rate		= 133000000,
+		.actim_ctrla	= 0x9a19b485,
+		.actim_ctrlb	= 0x0002231b,
+		.rfr_ctrl	= 0x0003de01,
+		.mr		= 0x00000032,
+	},
+	[3] = {
+		.rate		= 83000000,
+		.actim_ctrla	= 0x594ca242,
+		.actim_ctrlb	= 0x00022310,
+		.rfr_ctrl	= 0x00025501,
+		.mr		= 0x00000032,
+	},
+	[4] = {
+		.rate			= 0
+	},
+};
+
+#endif
-- 
1.5.4.3

