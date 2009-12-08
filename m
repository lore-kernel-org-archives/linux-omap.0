From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][RFT][PATCH 3/4 v6] OMAP: McBSP: Introduce caching in register write operations
Date: Tue, 8 Dec 2009 17:07:38 +0100
Message-ID: <200912081707.39812.jkrzyszt@tis.icnet.pl>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <20091207210631.GG24013@atomide.com> <20091208093521.3905241c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:48431 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbZLHQHc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 11:07:32 -0500
In-Reply-To: <20091208093521.3905241c.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Allocate space for storing cached copies of McBSP register values.
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
Monday 07 December 2009 22:06:31 Tony Lindgren wrote:
>
> Well if you want to optimize it out further, how about just kzalloc it
> during init? Then you have just one copy that gets set the right size
> depending on what you boot.

Tony,
In v4 of the patch, a single table was actually kzalloced during init as a
part of struct omap_mcbsp for each McBSP port configured. Since you objected
it, and the reason was not quite obvious to me, I submitted two alternate
versions: 5a, with ifdef...else cleanup, maybe still not good enough but
keeping that dynamic allocation, and 5b, using static storage instead, since I
could suspect you may like it better. Now it appears not quite true.

Anyway, sorry for all that long discussion, but it's really important for me
to understand precisely what your concearns, goals and preferences are when
you request changes before I'm able to implement them correctly, ie. in an way
acceptable for you. Otherwise, it all turns into a kind of quiz.

Tuesday 08 December 2009 08:35:21 Jarkko Nikula wrote:
>
> How about declaring the reg_cache as a void pointer in struct
> omap_mcbsp and allocate the cache and its size in omap_mcbsp_request
> according to omap type? Read and write functions would access the
> *reg_cache either as 16-bit or 32-bit table depending on omap.
>
> No ifdefs, no unused cache tables in multi-omap binary and cache tables
> are allocated only for used ports. I don't think there is need to
> preserve cache content over omap_mcbsp_free and new omap_mcbsp_request?

Jarkko,
I think this is the best solution. I had almost already sent a modified
version last night, with two pointers, u16 *omap1_cache and u32 *omap2_cache,
inside omap_mcbsp structre, but now I think that if using casts inside
omap_mcbsp_read()/_write() is not objected by anyone, the version below,
based on your idea, seems the most clean one.

I was not sure about deferring memory allocation until omap_mcbsp_request(),
but if you say it should be ok, I'm all in favour of that.

Note: 2420 handling may look weird, but I just tried to follow exactly what I
was able to learn about it by reading the code: register address spacing
were 32-bit, register read/write operations - 16-bit, since u16 reg_cache
elements.

Thanks,
Janusz

 arch/arm/plat-omap/include/plat/mcbsp.h |    9 ++++++
 arch/arm/plat-omap/mcbsp.c              |   66 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 63 insertions(+), 12 deletions(-)

diff -upr git.orig/arch/arm/plat-omap/include/plat/mcbsp.h git/arch/arm/plat-omap/include/plat/mcbsp.h
--- git.orig/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-02 15:48:51.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-08 14:26:42.000000000 +0100
@@ -157,6 +157,14 @@
 
 #endif
 
+#define OMAP7XX_MCBSP_REG_NUM	(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
+#define OMAP15XX_MCBSP_REG_NUM	(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
+#define OMAP16XX_MCBSP_REG_NUM	(OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1)
+
+#define OMAP24XX_MCBSP_REG_NUM	(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
+#define OMAP34XX_MCBSP_REG_NUM	(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
+#define OMAP44XX_MCBSP_REG_NUM	(OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
+
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
 #define RRDY			0x0002
@@ -415,6 +423,7 @@ struct omap_mcbsp {
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
+	void *reg_cache;
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mcbsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-07 22:43:56.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-08 14:38:38.000000000 +0100
@@ -30,26 +30,40 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
 
-void omap_mcbsp_write(void __iomem *io_base, u16 reg, u32 val)
+void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		__raw_writew((u16)val, io_base + reg);
-	else
-		__raw_writel(val, io_base + reg);
+	if (cpu_class_is_omap1()) {
+		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] = (u16)val;
+		__raw_writew((u16)val, mcbsp->io_base + reg);
+	} else if (cpu_is_omap2420()) {
+		((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)] = (u16)val;
+		__raw_writew((u16)val, mcbsp->io_base + reg);
+	} else {
+		((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)] = val;
+		__raw_writel(val, mcbsp->io_base + reg);
+	}
 }
 
-int omap_mcbsp_read(void __iomem *io_base, u16 reg)
+int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 {
-	if (cpu_class_is_omap1() || cpu_is_omap2420())
-		return __raw_readw(io_base + reg);
-	else
-		return __raw_readl(io_base + reg);
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
-		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
 #define MCBSP_WRITE(mcbsp, reg, val) \
-		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
+		omap_mcbsp_write(mcbsp, OMAP_MCBSP_REG_##reg, val)
+#define MCBSP_READ_CACHE(mcbsp, reg) \
+		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 1)
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
@@ -391,6 +405,31 @@ int omap_mcbsp_request(unsigned int id)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
+	if (cpu_is_omap7xx()) {
+		mcbsp->reg_cache = kzalloc(sizeof(u16) *
+				OMAP7XX_MCBSP_REG_NUM, GFP_KERNEL);
+	} else if (cpu_is_omap15xx()) {
+		mcbsp->reg_cache = kzalloc(sizeof(u16) *
+				OMAP15XX_MCBSP_REG_NUM, GFP_KERNEL);
+	} else if (cpu_is_omap16xx()) {
+		mcbsp->reg_cache = kzalloc(sizeof(u16) *
+				OMAP16XX_MCBSP_REG_NUM, GFP_KERNEL);
+	} else if (cpu_is_omap2420()) {
+		mcbsp->reg_cache = kzalloc(sizeof(u16) *
+				OMAP24XX_MCBSP_REG_NUM, GFP_KERNEL);
+	} else if (cpu_is_omap2430()) {
+		mcbsp->reg_cache = kzalloc(sizeof(u32) *
+				OMAP24XX_MCBSP_REG_NUM, GFP_KERNEL);
+	} else if (cpu_is_omap34xx()) {
+		mcbsp->reg_cache = kzalloc(sizeof(u32) *
+				OMAP34XX_MCBSP_REG_NUM, GFP_KERNEL);
+	} else if (cpu_is_omap44xx()) {
+		mcbsp->reg_cache = kzalloc(sizeof(u32) *
+				OMAP44XX_MCBSP_REG_NUM, GFP_KERNEL);
+	}
+	if (!mcbsp->reg_cache)
+		return -ENOMEM;
+
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
@@ -481,6 +520,9 @@ void omap_mcbsp_free(unsigned int id)
 
 	mcbsp->free = 1;
 	spin_unlock(&mcbsp->lock);
+
+	kfree(mcbsp->reg_cache);
+	mcbsp->reg_cache = NULL;
 }
 EXPORT_SYMBOL(omap_mcbsp_free);
 
