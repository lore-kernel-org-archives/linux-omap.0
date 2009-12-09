From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v7 3/5] OMAP: McBSP: Introduce caching in register write operations
Date: Wed, 9 Dec 2009 21:31:20 +0100
Message-ID: <200912092131.21517.jkrzyszt@tis.icnet.pl>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:38912 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083AbZLIUbK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 15:31:10 -0500
In-Reply-To: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

Determine cache size required per McBSP port at init time, based on processor
type running on.
Allocate space for storing cached copies of McBSP register values at port
request.
Modify omap_msbcp_write() function to update the cache with every register
write operation.
Modify omap_mcbsp_read() to support reading from cache or hardware.
Update MCBSP_READ() macro for modified omap_mcbsp_read() function API.
Introduce a new macro that reads from the cache.

Applies on top of patch 2 from this series:
[PATCH v7 2/5] OMAP: McBSP: Modify macros/functions API for easy cache access

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
Compile-tested with: omap_perseus2_730_defconfig, omap_generic_1610_defconfig,
omap_generic_2420_defconfig, omap_2430sdp_defconfig, omap_3430sdp_defconfig,
omap_4430sdp_defconfig with CONFIG_OMAP_MCBSP=y selected.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Changes since v3:
- replace cache table with cache pointer inside omap_mcbsp structure,
- determine cache size at runtime, allocate dynamically when port requested,
- get rid of ifdef...else by placing processor dependent snippets of new code 
  correctly in respective source files.

 arch/arm/mach-omap1/mcbsp.c             |   16 ++++++++++---
 arch/arm/mach-omap2/mcbsp.c             |   20 +++++++++++++---
 arch/arm/plat-omap/include/plat/mcbsp.h |    3 +-
 arch/arm/plat-omap/mcbsp.c              |   39 ++++++++++++++++++++++++--------
 4 files changed, 61 insertions(+), 17 deletions(-)

diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c git/arch/arm/mach-omap1/mcbsp.c
--- git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-02 15:48:37.000000000 +0100
+++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-09 15:35:14.000000000 +0100
@@ -99,9 +99,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP7XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap7xx_mcbsp_pdata)
+#define OMAP7XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
 #else
 #define omap7xx_mcbsp_pdata		NULL
 #define OMAP7XX_MCBSP_PDATA_SZ		0
+#define OMAP7XX_MCBSP_REG_NUM		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -132,9 +134,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP15XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap15xx_mcbsp_pdata)
+#define OMAP15XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
 #else
 #define omap15xx_mcbsp_pdata		NULL
 #define OMAP15XX_MCBSP_PDATA_SZ		0
+#define OMAP15XX_MCBSP_REG_NUM		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP16XX
@@ -165,19 +169,25 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP16XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap16xx_mcbsp_pdata)
+#define OMAP16XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
 #else
 #define omap16xx_mcbsp_pdata		NULL
 #define OMAP16XX_MCBSP_PDATA_SZ		0
+#define OMAP16XX_MCBSP_REG_NUM		0
 #endif
 
 int __init omap1_mcbsp_init(void)
 {
-	if (cpu_is_omap7xx())
+	if (cpu_is_omap7xx()) {
 		omap_mcbsp_count = OMAP7XX_MCBSP_PDATA_SZ;
-	if (cpu_is_omap15xx())
+		omap_mcbsp_cache_size = OMAP7XX_MCBSP_REG_NUM * sizeof(u16);
+	} else if (cpu_is_omap15xx()) {
 		omap_mcbsp_count = OMAP15XX_MCBSP_PDATA_SZ;
-	if (cpu_is_omap16xx())
+		omap_mcbsp_cache_size = OMAP15XX_MCBSP_REG_NUM * sizeof(u16);
+	} else if (cpu_is_omap16xx()) {
 		omap_mcbsp_count = OMAP16XX_MCBSP_PDATA_SZ;
+		omap_mcbsp_cache_size = OMAP16XX_MCBSP_REG_NUM * sizeof(u16);
+	}
 
 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
diff -upr git.orig/arch/arm/mach-omap2/mcbsp.c git/arch/arm/mach-omap2/mcbsp.c
--- git.orig/arch/arm/mach-omap2/mcbsp.c	2009-12-02 15:48:38.000000000 +0100
+++ git/arch/arm/mach-omap2/mcbsp.c	2009-12-09 15:35:14.000000000 +0100
@@ -65,9 +65,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
+#define OMAP2420_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
 #else
 #define omap2420_mcbsp_pdata		NULL
 #define OMAP2420_MCBSP_PDATA_SZ		0
+#define OMAP2420_MCBSP_REG_NUM		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
@@ -114,9 +116,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
+#define OMAP2430_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
 #else
 #define omap2430_mcbsp_pdata		NULL
 #define OMAP2430_MCBSP_PDATA_SZ		0
+#define OMAP2430_MCBSP_REG_NUM		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
@@ -168,9 +172,11 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
+#define OMAP34XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
 #else
 #define omap34xx_mcbsp_pdata		NULL
 #define OMAP34XX_MCBSP_PDATA_SZ		0
+#define OMAP34XX_MCBSP_REG_NUM		0
 #endif
 
 static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
@@ -208,17 +214,23 @@ static struct omap_mcbsp_platform_data o
 	},
 };
 #define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
+#define OMAP44XX_MCBSP_REG_NUM		(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
 
 static int __init omap2_mcbsp_init(void)
 {
-	if (cpu_is_omap2420())
+	if (cpu_is_omap2420()) {
 		omap_mcbsp_count = OMAP2420_MCBSP_PDATA_SZ;
-	if (cpu_is_omap2430())
+		omap_mcbsp_cache_size = OMAP2420_MCBSP_REG_NUM * sizeof(u16);
+	} else if (cpu_is_omap2430()) {
 		omap_mcbsp_count = OMAP2430_MCBSP_PDATA_SZ;
-	if (cpu_is_omap34xx())
+		omap_mcbsp_cache_size = OMAP2430_MCBSP_REG_NUM * sizeof(u32);
+	} else if (cpu_is_omap34xx()) {
 		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
-	if (cpu_is_omap44xx())
+		omap_mcbsp_cache_size = OMAP34XX_MCBSP_REG_NUM * sizeof(u32);
+	} else if (cpu_is_omap44xx()) {
 		omap_mcbsp_count = OMAP44XX_MCBSP_PDATA_SZ;
+		omap_mcbsp_cache_size = OMAP44XX_MCBSP_REG_NUM * sizeof(u32);
+	}
 
 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
diff -upr git.orig/arch/arm/plat-omap/include/plat/mcbsp.h git/arch/arm/plat-omap/include/plat/mcbsp.h
--- git.orig/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-02 15:48:51.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-09 15:35:14.000000000 +0100
@@ -415,9 +415,10 @@ struct omap_mcbsp {
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
+	void *reg_cache;
 };
 extern struct omap_mcbsp **mcbsp_ptr;
-extern int omap_mcbsp_count;
+extern int omap_mcbsp_count, omap_mcbsp_cache_size;
 
 int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mcbsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-09 15:34:57.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-09 15:35:14.000000000 +0100
@@ -28,28 +28,42 @@
 #include <plat/mcbsp.h>
 
 struct omap_mcbsp **mcbsp_ptr;
-int omap_mcbsp_count;
+int omap_mcbsp_count, omap_mcbsp_cache_size;
 
 void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
+	if (cpu_class_is_omap1()) {
+		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] = (u16)val;
 		__raw_writew((u16)val, mcbsp->io_base + reg);
-	else
+	} else if (cpu_is_omap2420()) {
+		((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)] = (u16)val;
+		__raw_writew((u16)val, mcbsp->io_base + reg);
+	} else {
+		((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)] = val;
 		__raw_writel(val, mcbsp->io_base + reg);
+	}
 }
 
-int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg)
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 {
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		return __raw_readw(mcbsp->io_base + reg);
-	else
-		return __raw_readl(mcbsp->io_base + reg);
+	if (cpu_class_is_omap1()) {
+		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+				((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
+	} else if (cpu_is_omap2420()) {
+		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+				((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+	} else {
+		return !from_cache ? __raw_readl(mcbsp->io_base + reg) :
+				((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+	}
 }
 
 #define MCBSP_READ(mcbsp, reg) \
-		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg)
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
 #define MCBSP_WRITE(mcbsp, reg, val) \
 		omap_mcbsp_write(mcbsp, OMAP_MCBSP_REG_##reg, val)
+#define MCBSP_READ_CACHE(mcbsp, reg) \
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 1)
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
@@ -391,6 +405,10 @@ int omap_mcbsp_request(unsigned int id)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
+	mcbsp->reg_cache = kzalloc(omap_mcbsp_cache_size, GFP_KERNEL);
+	if (!mcbsp->reg_cache)
+		return -ENOMEM;
+
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
@@ -481,6 +499,9 @@ void omap_mcbsp_free(unsigned int id)
 
 	mcbsp->free = 1;
 	spin_unlock(&mcbsp->lock);
+
+	kfree(mcbsp->reg_cache);
+	mcbsp->reg_cache = NULL;
 }
 EXPORT_SYMBOL(omap_mcbsp_free);
 
