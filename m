From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 02/20] DSPBRIDGE: trivial license fix in tramp and tramp_table_c6000
Date: Mon, 30 Nov 2009 15:54:43 -0600
Message-ID: <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47748 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbZK3Vs6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 16:48:58 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn4iq028728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:04 -0600
In-Reply-To: <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

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

