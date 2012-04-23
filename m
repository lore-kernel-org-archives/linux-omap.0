From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] staging: tidspbridge: fix build errors for OMAP2_L4_IO_ADDRESS
Date: Mon, 23 Apr 2012 17:34:14 +0300
Message-ID: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49334 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755269Ab2DWOen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 10:34:43 -0400
Received: by lahj13 with SMTP id j13so9181396lah.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 07:34:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'

The proper fix will come later.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/include/dspbridge/dbdefs.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h b/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h
index c8f4645..f9a0d16 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h
@@ -28,6 +28,14 @@
 #define PG_ALIGN_LOW(addr, pg_size) ((addr) & PG_MASK(pg_size))
 #define PG_ALIGN_HIGH(addr, pg_size) (((addr)+(pg_size)-1) & PG_MASK(pg_size))
 
+/*
+ * NOTE: Please update to use ioremap + read/write
+ */
+
+#define OMAP2_L4_IO_OFFSET	0xb2000000
+#define IOMEM(x)		((void __force __iomem *)(x))
+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET)
+
 /* API return value and calling convention */
 #define DBAPI                       int
 
-- 
1.7.10

