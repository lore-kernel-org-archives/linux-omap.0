From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][RFT][PATCH 3/4 v5b] OMAP: McBSP: Introduce caching in register write operations
Date: Sat, 5 Dec 2009 14:47:39 +0100
Message-ID: <200912051447.41777.jkrzyszt@tis.icnet.pl>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <4B19074B.1000606@tis.icnet.pl> <20091204191745.GH24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49279 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZLENrc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Dec 2009 08:47:32 -0500
In-Reply-To: <20091204191745.GH24013@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Reserve static space for storing cached copies of McBSP register values.
Split omap_mcbsp_read()/omap_mcbsp_write() into separate functions for OMAP1
and OMAP2/3/4, move them from plat-omap to mach-omap1 / mach-omap2 to be able
to access the static cache.
Modify omap_msbcp_write() to update the cache with every register write
operation.
Modify omap_mcbsp_read() to support reading from cache or hardware.
Update MCBSP_READ/MCBSP_WRITE macros for modified function APIs.
Introduce a new macro that reads from the cache.

Applies on top of patch 2 from this series:
[PATCH v3 2/4] OMAP: McBSP: Prepare register read/write macros API for caching

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
Compile-tested with omap_generic_2420_defconfig, omap_3430sdp_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---

Tony,

Since I was not sure what your primary concern was, I've prepared two
alternative versions of patch 3/4.
Please take this one as a base for further discussion if your primary concern
was storage class for the cache.
Otherwise, have a look at the other one (v5a), since this one has even more
ifdefs than before.

Thanks,
Janusz

diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c git/arch/arm/mach-omap1/mcbsp.c
--- git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-02 15:48:37.000000000 +0100
+++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-05 06:42:35.000000000 +0100
@@ -200,3 +200,26 @@ int __init omap1_mcbsp_init(void)
 }
 
 arch_initcall(omap1_mcbsp_init);
+
+/* if adding more, put larger first */
+#if defined(CONFIG_ARCH_OMAP16XX)
+static u16 omap_mcbsp_cache[OMAP16XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
+#elif defined(CONFIG_ARCH_OMAP15XX)
+static u16 omap_mcbsp_cache[OMAP15XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
+#elif defined(CONFIG_ARCH_OMAP7XX)
+static u16 omap_mcbsp_cache[OMAP7XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
+#else
+#define omap_mcbsp_cache	NULL
+#endif
+
+void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
+{
+	omap_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] = (u16)val;
+	__raw_writew((u16)val, mcbsp->io_base + reg);
+}
+
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
+{
+	return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+			omap_mcbsp_cache[mcbsp->id][reg / sizeof(u16)];
+}
diff -upr git.orig/arch/arm/mach-omap2/mcbsp.c git/arch/arm/mach-omap2/mcbsp.c
--- git.orig/arch/arm/mach-omap2/mcbsp.c	2009-12-02 15:48:38.000000000 +0100
+++ git/arch/arm/mach-omap2/mcbsp.c	2009-12-05 06:42:35.000000000 +0100
@@ -241,3 +241,40 @@ static int __init omap2_mcbsp_init(void)
 	return omap_mcbsp_init();
 }
 arch_initcall(omap2_mcbsp_init);
+
+/* if adding more, put larger first */
+#if defined(CONFIG_ARCH_OMAP34XX)
+static u32 omap_mcbsp_cache[OMAP34XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
+#elif defined(CONFIG_ARCH_OMAP2430)
+static u32 omap_mcbsp_cache[OMAP2430_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
+#elif defined(CONFIG_ARCH_OMAP44XX)
+static u32 omap_mcbsp_cache[OMAP44XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
+#elif defined(CONFIG_ARCH_OMAP2420)
+static u16 omap_mcbsp_cache[OMAP2420_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
+#else
+#define omap_mcbsp_cache	NULL
+#endif
+
+void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
+{
+	if (cpu_is_omap2420()) {
+		omap_mcbsp_cache[mcbsp->id][reg / sizeof(*omap_mcbsp_cache)] \
+				= (u16)val;
+		__raw_writew((u16)val, mcbsp->io_base + reg);
+	} else {
+		omap_mcbsp_cache[mcbsp->id][reg / sizeof(u32)] = val;
+		__raw_writel(val, mcbsp->io_base + reg);
+	}
+}
+
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
+{
+	if (cpu_is_omap2420()) {
+		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
+				(u16)omap_mcbsp_cache[mcbsp->id][reg /
+					sizeof(*omap_mcbsp_cache)];
+	} else {
+		return !from_cache ? __raw_readl(mcbsp->io_base + reg) :
+			omap_mcbsp_cache[mcbsp->id][reg / sizeof(u32)];
+	}
+}
diff -upr git.orig/arch/arm/plat-omap/include/plat/mcbsp.h git/arch/arm/plat-omap/include/plat/mcbsp.h
--- git.orig/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-02 15:48:51.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-05 06:42:35.000000000 +0100
@@ -92,6 +92,8 @@
 #define OMAP_MCBSP_REG_XCERG	0x3A
 #define OMAP_MCBSP_REG_XCERH	0x3C
 
+#define OMAP_MCBSP_REG_COUNT	(OMAP_MCBSP_REG_XCERH / OMAP_MCBSP_REG_DRR1 + 1)
+
 /* Dummy defines, these are not available on omap1 */
 #define OMAP_MCBSP_REG_XCCR	0x00
 #define OMAP_MCBSP_REG_RCCR	0x00
@@ -148,6 +150,8 @@
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
 
+#define OMAP_MCBSP_REG_COUNT	(OMAP_MCBSP_REG_RCCR / OMAP_MCBSP_REG_DRR1 + 1)
+
 #define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
 #define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
 
@@ -460,3 +464,6 @@ int omap_mcbsp_pollwrite(unsigned int id
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 
 #endif
+
+extern int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache);
+extern void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val);
diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mcbsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-05 06:23:39.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-05 06:42:35.000000000 +0100
@@ -30,26 +30,12 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
 
-void omap_mcbsp_write(void __iomem *io_base, u16 reg, u32 val)
-{
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		__raw_writew((u16)val, io_base + reg);
-	else
-		__raw_writel(val, io_base + reg);
-}
-
-int omap_mcbsp_read(void __iomem *io_base, u16 reg)
-{
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		return __raw_readw(io_base + reg);
-	else
-		return __raw_readl(io_base + reg);
-}
-
 #define MCBSP_READ(mcbsp, reg) \
-		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
 #define MCBSP_WRITE(mcbsp, reg, val) \
-		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
+		omap_mcbsp_write(mcbsp, OMAP_MCBSP_REG_##reg, val)
+#define MCBSP_READ_CACHE(mcbsp, reg) \
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 1)
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
