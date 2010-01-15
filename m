From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 01/10] DSPBRIDGE: trivial license fix in tramp and tramp_table_c6000
Date: Fri, 15 Jan 2010 15:28:32 -0600
Message-ID: <1263590921-24357-2-git-send-email-omar.ramirez@ti.com>
References: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758283Ab0AOVS5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 16:18:57 -0500
In-Reply-To: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Seems that these files had a licensing mismatch, changing to
GPL2.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/dynload/tramp.c             |   18 +++++++++++++-----
 drivers/dsp/bridge/dynload/tramp_table_c6000.c |   18 +++++++++++++-----
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/dynload/tramp.c b/drivers/dsp/bridge/dynload/tramp.c
index 8c725c7..c2fe02d 100644
--- a/drivers/dsp/bridge/dynload/tramp.c
+++ b/drivers/dsp/bridge/dynload/tramp.c
@@ -1,11 +1,19 @@
 /*
- *  Copyright 2009 by Texas Instruments Incorporated.
- *  All rights reserved. Property of Texas Instruments Incorporated.
- *  Restricted rights to use, duplicate or disclose this code are
- *  granted through contract.
+ * tramp.c
  *
- *  @(#) DSP/BIOS Bridge
+ * DSP-BIOS Bridge driver support functions for TI OMAP processors.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
+
 #include "header.h"
 
 #if TMS32060
diff --git a/drivers/dsp/bridge/dynload/tramp_table_c6000.c b/drivers/dsp/bridge/dynload/tramp_table_c6000.c
index 1a7d974..acda513 100644
--- a/drivers/dsp/bridge/dynload/tramp_table_c6000.c
+++ b/drivers/dsp/bridge/dynload/tramp_table_c6000.c
@@ -1,11 +1,19 @@
 /*
- *  Copyright 2009 by Texas Instruments Incorporated.
- *  All rights reserved. Property of Texas Instruments Incorporated.
- *  Restricted rights to use, duplicate or disclose this code are
- *  granted through contract.
+ * tramp_table_c6000.c
  *
- *  @(#) DSP/BIOS Bridge
+ * DSP-BIOS Bridge driver support functions for TI OMAP processors.
+ *
+ * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
+
 #include "dload_internal.h"
 
 /*  These are defined in coff.h, but may not be available on all platforms
-- 
1.6.2.4

