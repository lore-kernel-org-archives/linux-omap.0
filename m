From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw read/write
Date: Tue, 21 Sep 2010 15:31:19 +0530
Message-ID: <1285063280-4057-10-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47490 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757390Ab0IUKCO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 06:02:14 -0400
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org

Following sparse warnings exists due to use of writel/w and readl/w functions.

This patch fixes the sparse warnings by converting readl/w functions usage into
__raw_readl/__raw_readw functions.

arch/arm/mach-omap2/board-omap3evm.c:77:12: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/board-omap3evm.c:77:12: originally declared here

arch/arm/mach-omap2/gpmc-onenand.c:49:8: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/gpmc-onenand.c:49:8: originally declared here
arch/arm/mach-omap2/gpmc-onenand.c:89:8: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/gpmc-onenand.c:89:8: originally declared here
arch/arm/mach-omap2/gpmc-onenand.c:101:8: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/gpmc-onenand.c:101:8: originally declared here
arch/arm/mach-omap2/gpmc-onenand.c:151:9: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/gpmc-onenand.c:151:9: originally declared here

arch/arm/plat-omap/dmtimer.c:295:10: warning: symbol '__v' shadows an earlier one
arch/arm/plat-omap/dmtimer.c:295:10: originally declared here
arch/arm/plat-omap/dmtimer.c:298:9: warning: symbol '__v' shadows an earlier one
arch/arm/plat-omap/dmtimer.c:298:9: originally declared here
arch/arm/plat-omap/dmtimer.c:311:10: warning: symbol '__v' shadows an earlier one
arch/arm/plat-omap/dmtimer.c:311:10: originally declared here

drivers/mtd/nand/omap2.c:484:15: warning: symbol '__v' shadows an earlier one
drivers/mtd/nand/omap2.c:484:15: originally declared here

drivers/mtd/onenand/omap2.c:86:9: warning: symbol '__v' shadows an earlier one
drivers/mtd/onenand/omap2.c:86:9: originally declared here

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mtd@lists.infradead.org
---
 arch/arm/mach-omap2/board-omap3evm.c |    2 +-
 arch/arm/mach-omap2/gpmc-onenand.c   |    8 ++++----
 arch/arm/plat-omap/dmtimer.c         |    6 +++---
 drivers/mtd/nand/omap2.c             |    2 +-
 drivers/mtd/onenand/omap2.c          |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 892b740..738d832 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -74,7 +74,7 @@ static void __init omap3_evm_get_revision(void)
 	ioaddr = ioremap_nocache(OMAP3EVM_ETHR_START, SZ_1K);
 	if (!ioaddr)
 		return;
-	smsc_id = readl(ioaddr + OMAP3EVM_ETHR_ID_REV) & 0xFFFF0000;
+	smsc_id = __raw_readl(ioaddr + OMAP3EVM_ETHR_ID_REV) & 0xFFFF0000;
 	iounmap(ioaddr);
 
 	switch (smsc_id) {
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 7bb6922..128bbef 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -46,7 +46,7 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	const int t_wph = 30;
 
 	/* Ensure sync read and sync write are disabled */
-	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg = __raw_readw(onenand_base + ONENAND_REG_SYS_CFG1);
 	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
 	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
 
@@ -86,7 +86,7 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 		return err;
 
 	/* Ensure sync read and sync write are disabled */
-	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg = __raw_readw(onenand_base + ONENAND_REG_SYS_CFG1);
 	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
 	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
 
@@ -98,7 +98,7 @@ static void set_onenand_cfg(void __iomem *onenand_base, int latency,
 {
 	u32 reg;
 
-	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg = __raw_readw(onenand_base + ONENAND_REG_SYS_CFG1);
 	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
 		ONENAND_SYS_CFG1_BL_16;
@@ -148,7 +148,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		err = omap2_onenand_set_async_mode(cs, onenand_base);
 		if (err)
 			return err;
-		reg = readw(onenand_base + ONENAND_REG_VERSION_ID);
+		reg = __raw_readw(onenand_base + ONENAND_REG_VERSION_ID);
 		switch ((reg >> 4) & 0xf) {
 		case 0:
 			freq = 40;
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 44bafda..c2920db 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -292,10 +292,10 @@ static spinlock_t dm_timer_lock;
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
 	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+		while (__raw_readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
 				& (reg >> WPSHIFT))
 			cpu_relax();
-	return readl(timer->io_base + (reg & 0xff));
+	return __raw_readl(timer->io_base + (reg & 0xff));
 }
 
 /*
@@ -308,7 +308,7 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
 {
 	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+		while (__raw_readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
 				& (reg >> WPSHIFT))
 			cpu_relax();
 	writel(value, timer->io_base + (reg & 0xff));
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 439e80d..23d2810 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -481,7 +481,7 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 
 	len >>= 1;
 	while (len--) {
-		if (*p++ != cpu_to_le16(readw(info->nand.IO_ADDR_R)))
+		if (*p++ != cpu_to_le16(__raw_readw(info->nand.IO_ADDR_R)))
 			return -EFAULT;
 	}
 
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 9f322f1..300fd7c 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -83,7 +83,7 @@ static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
 
 static inline unsigned short read_reg(struct omap2_onenand *c, int reg)
 {
-	return readw(c->onenand.base + reg);
+	return __raw_readw(c->onenand.base + reg);
 }
 
 static inline void write_reg(struct omap2_onenand *c, unsigned short value,
-- 
1.7.0.4

