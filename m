From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 59/59] omap: namespace cleanup to arch/arm/plat-omap/include/mach/io.h
Date: Wed, 12 Nov 2008 00:57:18 +0200
Message-ID: <1226444238-14614-60-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
 <1226444238-14614-42-git-send-email-me@felipebalbi.com>
 <1226444238-14614-43-git-send-email-me@felipebalbi.com>
 <1226444238-14614-44-git-send-email-me@felipebalbi.com>
 <1226444238-14614-45-git-send-email-me@felipebalbi.com>
 <1226444238-14614-46-git-send-email-me@felipebalbi.com>
 <1226444238-14614-47-git-send-email-me@felipebalbi.com>
 <1226444238-14614-48-git-send-email-me@felipebalbi.com>
 <1226444238-14614-49-git-send-email-me@felipebalbi.com>
 <1226444238-14614-50-git-send-email-me@felipebalbi.com>
 <1226444238-14614-51-git-send-email-me@felipebalbi.com>
 <1226444238-14614-52-git-send-email-me@felipebalbi.com>
 <1226444238-14614-53-git-send-email-me@felipebalbi.com>
 <1226444238-14614-54-git-send-email-me@felipebalbi.com>
 <1226444238-14614-55-git-send-email-me@felipebalbi.com>
 <1226444238-14614-56-git-send-email-me@felipebalbi.com>
 <1226444238-14614-57-git-send-email-me@felipebalbi.com>
 <1226444238-14614-58-git-send-email-me@felipebalbi.com>
 <1226444238-14614-59-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56641 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYKKXFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:24 -0500
In-Reply-To: <1226444238-14614-59-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/mach/io.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index ea55267..041fa30 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -170,23 +170,6 @@
 #else
 #define IOMEM(x)		((void __force __iomem *)(x))
 
-/*
- * Functions to access the OMAP IO region
- *
- * NOTE: - Use omap_read/write[bwl] for physical register addresses
- *	 - Use __raw_read/write[bwl]() for virtual register addresses
- *	 - Use IO_ADDRESS(phys_addr) to convert registers to virtual addresses
- *	 - DO NOT use hardcoded virtual addresses to allow changing the
- *	   IO address space again if needed
- */
-#define omap_readb(a)		__raw_readb(IO_ADDRESS(a))
-#define omap_readw(a)		__raw_readw(IO_ADDRESS(a))
-#define omap_readl(a)		__raw_readl(IO_ADDRESS(a))
-
-#define omap_writeb(v,a)	__raw_writeb(v, IO_ADDRESS(a))
-#define omap_writew(v,a)	__raw_writew(v, IO_ADDRESS(a))
-#define omap_writel(v,a)	__raw_writel(v, IO_ADDRESS(a))
-
 struct omap_sdrc_params;
 
 extern void omap1_map_common_io(void);
-- 
1.6.0.2.307.gc427

