From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 06/13] ARM: OMAP2+: gpmc: CS configuration helper
Date: Fri, 22 Jun 2012 18:27:05 +0530
Message-ID: <89feb2034c7b94bf7a7aeaa0cca45f69cb2f5e2a.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60333 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659Ab2FVNMY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:24 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Helper for configuring given CS based on flags.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   39 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    5 ++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index e427ff4..8f596ce 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -972,6 +972,45 @@ static __devinit int gpmc_setup_cs_mem(struct gpmc_cs_data *cs,
 	return 0;
 }
 
+static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
+{
+	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+	l &= ~(GPMC_CONFIG1_MUXADDDATA |
+		GPMC_CONFIG1_WRITETYPE_SYNC |
+		GPMC_CONFIG1_WRITEMULTIPLE_SUPP |
+		GPMC_CONFIG1_READTYPE_SYNC |
+		GPMC_CONFIG1_READMULTIPLE_SUPP |
+		GPMC_CONFIG1_WRAPBURST_SUPP |
+		GPMC_CONFIG1_DEVICETYPE(~0) |
+		GPMC_CONFIG1_DEVICESIZE(~0) |
+		GPMC_CONFIG1_PAGE_LEN(~0));
+
+	/* device type & size bits are cleared above, implying NOR & 8 bit,
+	 * only other options possible are NAND & 16 bit respectively,
+	 * configure if user asked for it, else default is already setup
+	 * users has been provided with NOR & 8 bit macros, nothing to be
+	 * done here as already it has been setup above
+	 */
+	l |= conf & GPMC_CONFIG1_DEVICETYPE_NAND;
+	l |= conf & GPMC_CONFIG1_DEVICESIZE_16;
+
+	if (conf & GPMC_CONFIG1_PAGE_LEN_8)
+		l |= GPMC_CONFIG1_PAGE_LEN_8;
+	else if (conf & GPMC_CONFIG1_PAGE_LEN_16)
+		l |= GPMC_CONFIG1_PAGE_LEN_16;
+
+	conf &= (GPMC_CONFIG1_MUXADDDATA |
+			GPMC_CONFIG1_WRITETYPE_SYNC |
+			GPMC_CONFIG1_WRITEMULTIPLE_SUPP |
+			GPMC_CONFIG1_READTYPE_SYNC |
+			GPMC_CONFIG1_READMULTIPLE_SUPP |
+			GPMC_CONFIG1_WRAPBURST_SUPP);
+	l |= conf;
+
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
+}
+
 static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
 						struct resource *res)
 {
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 157753ab..7187445 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -57,14 +57,19 @@
 #define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
 #define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
 #define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
+#define	GPMC_CONFIG1_PAGE_LEN_4		GPMC_CONFIG1_PAGE_LEN(0)
+#define	GPMC_CONFIG1_PAGE_LEN_8		GPMC_CONFIG1_PAGE_LEN(1)
+#define	GPMC_CONFIG1_PAGE_LEN_16	GPMC_CONFIG1_PAGE_LEN(2)
 #define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
 #define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
 #define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
 #define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
 #define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
+#define	GPMC_CONFIG1_DEVICESIZE_8	GPMC_CONFIG1_DEVICESIZE(0)
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
+#define	GPMC_CONFIG1_DEVICETYPE_NAND	GPMC_CONFIG1_DEVICETYPE(2)
 #define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
 #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
-- 
1.7.10.2

