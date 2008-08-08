From: "chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 2/2]  McBSP preamble patch for 34xx support,
Date: Fri, 8 Aug 2008 11:36:49 +0530 (IST)
Message-ID: <34251.192.168.10.89.1218175609.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34320 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbYHHGGz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2008 02:06:55 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7866o6h012720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 01:06:55 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7866k3J024873
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 01:06:48 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

this patch modifies the read write function to do
16/32 bit read write depending on CPU.

Regards,
Chandra Shekhar

Signed-off-by: Chandra Shekhar< x0044955@ti.com>
---
 arch/arm/mach-omap1/mcbsp.c       |    1 +
 arch/arm/mach-omap2/mcbsp.c       |    3 +++
 arch/arm/plat-omap/mcbsp.c        |   24 +++++++++++++++++++++++-
 include/asm-arm/arch-omap/mcbsp.h |    5 +----
 4 files changed, 28 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap1/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/mcbsp.c	2008-08-07
16:40:14.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap1/mcbsp.c	2008-08-07 16:46:30.000000000 +0530
@@ -248,6 +248,7 @@
 								GFP_KERNEL);
 	if (!mcbsp_ptr)
 		return -ENOMEM;
+	mcbsp_32_bit_ops = 0;

 	if (cpu_is_omap730())
 		omap_mcbsp_register_board_cfg(omap730_mcbsp_pdata,
Index: linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/mcbsp.c	2008-08-07
16:41:17.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c	2008-08-07 16:50:53.000000000 +0530
@@ -232,6 +232,7 @@

 	if (cpu_is_omap24xx())
 		omap_mcbsp_count = OMAP24XX_MCBSP_PDATA_SZ;
+
 	if (cpu_is_omap34xx())
 		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;

@@ -246,6 +247,8 @@
 	if (cpu_is_omap34xx())
 		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
 						OMAP34XX_MCBSP_PDATA_SZ);
+	if (!cpu_is_omap2420())
+		mcbsp_32_bit_ops = 1;

 	return omap_mcbsp_init();
 }
Index: linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2008-08-07
16:39:51.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2008-08-07 16:45:00.000000000 +0530
@@ -29,9 +29,31 @@

 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
+int mcbsp_32_bit_ops;
+
+void omap_mcbsp_write(u32 io_base, u16 reg, u32 val)
+{
+	if (!mcbsp_32_bit_ops)
+		__raw_writew((u16)val, io_base + reg);
+	else
+		__raw_writel(val, io_base + reg);
+}
+
+int omap_mcbsp_read(u32 io_base, u16 reg)
+{
+	if (!mcbsp_32_bit_ops)
+		return __raw_readw(io_base + reg);
+	else
+		return __raw_readl(io_base + reg);
+}
+
+#define OMAP_MCBSP_READ(base, reg) \
+			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(base, reg, val) \
+			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)

 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
-#define id_to_mcbsp_ptr(id)			mcbsp_ptr[id];
+#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];

 static void omap_mcbsp_dump_reg(u8 id)
 {
Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-08-07
16:41:17.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-08-07
16:45:00.000000000 +0530
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
@@ -369,6 +365,7 @@
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
+extern int mcbsp_32_bit_ops;

 int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,


