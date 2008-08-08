From: "chandra shekhar" <x0044955@ti.com>
Subject: [ Resending PATCH 2/2]  McBSP preamble patch for 34xx support
Date: Fri, 8 Aug 2008 12:50:18 +0530 (IST)
Message-ID: <54896.192.168.10.89.1218180018.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:58060 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbYHHHUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2008 03:20:24 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m787KJGM008870
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 02:20:24 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m787KFwp007670
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 02:20:17 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Resending Patch after fixing tony's comments.

this patch modifies the read write function to do
16/32 bit read write depending on CPU.

Regards,
Chandra Shekhar


Signed-off-by: Chandra Shekhar< x0044955@ti.com>

---
 arch/arm/plat-omap/mcbsp.c        |   23 ++++++++++++++++++++++-
 include/asm-arm/arch-omap/mcbsp.h |    4 ----
 2 files changed, 22 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2008-08-07
16:39:51.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2008-08-08 12:37:11.000000000 +0530
@@ -30,8 +30,29 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;

+void omap_mcbsp_write(u32 io_base, u16 reg, u32 val)
+{
+	if (cpu_class_is_omap1() || cpu_is_omap2420())
+		__raw_writew((u16)val, io_base + reg);
+	else
+		__raw_writel(val, io_base + reg);
+}
+
+int omap_mcbsp_read(u32 io_base, u16 reg)
+{
+	if (cpu_class_is_omap1() || cpu_is_omap2420())
+		return __raw_readw(io_base + reg);
+	else
+		return __raw_readl(io_base + reg);
+}
+
+#define OMAP_MCBSP_READ(base, reg) \
+			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(base, reg, val) \
+			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
+
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
-#define id_to_mcbsp_ptr(id)			mcbsp_ptr[id];
+#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];

 static void omap_mcbsp_dump_reg(u8 id)
 {
Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-08-07
16:41:17.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-08-08
12:02:38.000000000 +0530
@@ -139,10 +139,6 @@

 #endif

-#define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) +
OMAP_MCBSP_REG_##reg)
-
-
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
 #define RRDY			0x0002


