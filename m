From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] mach-omap2: fix sparse warnings,
	some style issues for OMAP2 builds
Date: Thu, 17 Jul 2008 20:52:39 -0600
Message-ID: <20080718025237.20613.58512.stgit@localhost.localdomain>
References: <20080718024832.20613.30050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42274 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbYGRDNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 23:13:06 -0400
In-Reply-To: <20080718024832.20613.30050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This cleans up remaining sparse warnings for OMAP2 builds and fixes a
few CodingStyle issues.  This involves:

- removing casts where they don't belong,

- adding casts where they should be,

- marking internal functions as static,

- fixing some indentation in board-2430sdp-flash.c.

Patch should cause no change in kernel behavior.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/board-2430sdp-flash.c |   28 ++++++++++++++--------------
 arch/arm/mach-omap2/board-n800-audio.c    |   14 ++++++++------
 arch/arm/mach-omap2/board-n800-camera.c   |    2 ++
 arch/arm/mach-omap2/board-n800.h          |    2 ++
 arch/arm/mach-omap2/clock24xx.c           |    2 +-
 arch/arm/mach-omap2/mailbox.c             |    4 ++--
 arch/arm/mach-omap2/mcbsp.c               |    2 +-
 arch/arm/mach-omap2/mmu.h                 |    4 ++--
 arch/arm/mach-omap2/mux.c                 |    2 +-
 arch/arm/mach-omap2/pm.c                  |    1 +
 arch/arm/mach-omap2/pm.h                  |   12 ++++++------
 include/asm-arm/arch-omap/mailbox.h       |    2 ++
 12 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp-flash.c b/arch/arm/mach-omap2/board-2430sdp-flash.c
index 47aa8bf..aaa8db4 100644
--- a/arch/arm/mach-omap2/board-2430sdp-flash.c
+++ b/arch/arm/mach-omap2/board-2430sdp-flash.c
@@ -125,16 +125,16 @@ static struct platform_device sdp_onenand_device = {
 
 void __init sdp2430_flash_init(void)
 {
-	unsigned long gpmc_base_add, gpmc_cs_base_add;
+	void __iomem *gpmc_base_add, *gpmc_cs_base_add;
 	unsigned char cs = 0;
 
-	gpmc_base_add = OMAP243X_GPMC_VIRT;
+	gpmc_base_add = (__force void __iomem *)OMAP243X_GPMC_VIRT;
 	while (cs < GPMC_CS_NUM) {
 		int ret = 0;
 
 		/* Each GPMC set for a single CS is at offset 0x30 */
-		gpmc_cs_base_add =
-			(gpmc_base_add + GPMC_OFF_CONFIG1_0 + (cs*0x30));
+		gpmc_cs_base_add = (gpmc_base_add + GPMC_OFF_CONFIG1_0 +
+				    (cs*0x30));
 
 		/* xloader/Uboot would have programmed the NAND/oneNAND
 		 * base address for us This is a ugly hack. The proper
@@ -164,22 +164,22 @@ void __init sdp2430_flash_init(void)
 	}
 
 	if (flash_type == NAND) {
-		sdp_nand_data.cs               = cs;
-		sdp_nand_data.gpmc_cs_baseaddr = (void *) gpmc_cs_base_add;
-		sdp_nand_data.gpmc_baseaddr    = (void *) gpmc_base_add;
+		sdp_nand_data.cs	       = cs;
+		sdp_nand_data.gpmc_cs_baseaddr = gpmc_cs_base_add;
+		sdp_nand_data.gpmc_baseaddr    = gpmc_base_add;
 
 		if (platform_device_register(&sdp_nand_device) < 0) {
 			printk(KERN_ERR "Unable to register NAND device\n");
-		return;
-	}
+			return;
+		}
 	}
 
 	if (flash_type == ONENAND) {
-	sdp_onenand_data.cs = cs;
+		sdp_onenand_data.cs = cs;
 
-	if (platform_device_register(&sdp_onenand_device) < 0) {
-		printk(KERN_ERR "Unable to register OneNAND device\n");
-		return;
-	}
+		if (platform_device_register(&sdp_onenand_device) < 0) {
+			printk(KERN_ERR "Unable to register OneNAND device\n");
+			return;
+		}
 	}
 }
diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-omap2/board-n800-audio.c
index bebc4a5..233198e 100644
--- a/arch/arm/mach-omap2/board-n800-audio.c
+++ b/arch/arm/mach-omap2/board-n800-audio.c
@@ -54,11 +54,13 @@ static int eac_mux_disabled = 0;
 static int clkout2_mux_disabled = 0;
 static u32 saved_mux[2];
 
+#define MUX_EAC_IOP2V(x)		(__force void __iomem *)io_p2v(x)
+
 static void n800_enable_eac_mux(void)
 {
 	if (!eac_mux_disabled)
 		return;
-	__raw_writel(saved_mux[1], IO_ADDRESS(0x48000124));
+	__raw_writel(saved_mux[1], MUX_EAC_IOP2V(0x48000124));
 	eac_mux_disabled = 0;
 }
 
@@ -68,8 +70,8 @@ static void n800_disable_eac_mux(void)
 		WARN_ON(eac_mux_disabled);
 		return;
 	}
-	saved_mux[1] = __raw_readl(IO_ADDRESS(0x48000124));
-	__raw_writel(0x1f1f1f1f, IO_ADDRESS(0x48000124));
+	saved_mux[1] = __raw_readl(MUX_EAC_IOP2V(0x48000124));
+	__raw_writel(0x1f1f1f1f, MUX_EAC_IOP2V(0x48000124));
 	eac_mux_disabled = 1;
 }
 
@@ -77,7 +79,7 @@ static void n800_enable_clkout2_mux(void)
 {
 	if (!clkout2_mux_disabled)
 		return;
-	__raw_writel(saved_mux[0], IO_ADDRESS(0x480000e8));
+	__raw_writel(saved_mux[0], MUX_EAC_IOP2V(0x480000e8));
 	clkout2_mux_disabled = 0;
 }
 
@@ -89,10 +91,10 @@ static void n800_disable_clkout2_mux(void)
 		WARN_ON(clkout2_mux_disabled);
 		return;
 	}
-	saved_mux[0] = __raw_readl(IO_ADDRESS(0x480000e8));
+	saved_mux[0] = __raw_readl(MUX_EAC_IOP2V(0x480000e8));
 	l = saved_mux[0] & ~0xff;
 	l |= 0x1f;
-	__raw_writel(l, IO_ADDRESS(0x480000e8));
+	__raw_writel(l, MUX_EAC_IOP2V(0x480000e8));
 	clkout2_mux_disabled = 1;
 }
 
diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
index aafa547..b2c1ce4 100644
--- a/arch/arm/mach-omap2/board-n800-camera.c
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -37,6 +37,8 @@
 #include <../drivers/cbus/retu.h>
 #include <../drivers/media/video/tcm825x.h>
 
+#include "board-n800.h"
+
 #if defined (CONFIG_VIDEO_TCM825X) || defined (CONFIG_VIDEO_TCM825X_MODULE)
 
 #define OMAP24XX_CAMERA_JAM_HACK
diff --git a/arch/arm/mach-omap2/board-n800.h b/arch/arm/mach-omap2/board-n800.h
index 96d2fa3..e71dae4 100644
--- a/arch/arm/mach-omap2/board-n800.h
+++ b/arch/arm/mach-omap2/board-n800.h
@@ -18,4 +18,6 @@ void __init nokia_n800_common_init(void);
 void __init nokia_n800_map_io(void);
 void __init nokia_n800_init_irq(void);
 
+extern const struct tcm825x_platform_data n800_tcm825x_platform_data;
+
 #endif
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 54cc6e1..1c9351c 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -530,7 +530,7 @@ static inline void omap2_clk_check_reg(u32 flags, void __iomem **reg)
 	*reg = (__force void __iomem *)tmp;
 }
 
-void __init omap2_clk_rewrite_base(struct clk *clk)
+static void __init omap2_clk_rewrite_base(struct clk *clk)
 {
 	omap2_clk_check_reg(clk->flags, &clk->clksel_reg);
 	omap2_clk_check_reg(clk->flags, &clk->enable_reg);
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 4799561..ac88d32 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -75,12 +75,12 @@ static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 
 static inline unsigned int mbox_read_reg(unsigned int reg)
 {
-	return __raw_readl(mbox_base + reg);
+	return __raw_readl((void __iomem *)(mbox_base + reg));
 }
 
 static inline void mbox_write_reg(unsigned int val, unsigned int reg)
 {
-	__raw_writel(val, mbox_base + reg);
+	__raw_writel(val, (void __iomem *)(mbox_base + reg));
 }
 
 /* Mailbox H/W preparations */
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 17cf199..2cca1b7 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -185,7 +185,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 #define OMAP34XX_MCBSP_PDATA_SZ		0
 #endif
 
-int __init omap2_mcbsp_init(void)
+static int __init omap2_mcbsp_init(void)
 {
 	int i;
 
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index f45fcca..363eaa1 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -105,13 +105,13 @@ struct omap_mmu_tlb_entry {
 static inline unsigned long
 omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
 {
-	return __raw_readl(mmu->base + reg);
+	return __raw_readl((void __iomem *)(mmu->base + reg));
 }
 
 static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 			       unsigned long val, unsigned long reg)
 {
-	__raw_writel(val, mmu->base + reg);
+	__raw_writel(val, (void __iomem *)(mmu->base + reg));
 }
 
 #endif /* __MACH_OMAP2_MMU_H */
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 5a68fb3..545e092 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -408,7 +408,7 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
 #endif
 
 #ifdef CONFIG_ARCH_OMAP24XX
-int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
+static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 {
 	static DEFINE_SPINLOCK(mux_spin_lock);
 	unsigned long flags;
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index f699826..524b4db 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -28,6 +28,7 @@
 #include <asm/mach/time.h>
 #include <asm/atomic.h>
 
+#include <asm/arch/pm.h>
 #include "pm.h"
 
 unsigned short enable_dyn_sleep;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 31712f4..68c9278 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -32,11 +32,11 @@ extern void pm_init_serial_console(void);
 extern void serial_console_sleep(int enable);
 extern int omap2_pm_debug;
 #else
-#define omap2_read_32k_sync_counter() 0;
-#define serial_console_sleep(enable) do; while(0)
-#define pm_init_serial_console() do; while(0)
-#define omap2_pm_dump(mode,resume,us) do; while(0)
-#define serial_console_fclk_mask(f1,f2)  do; while(0)
-#define omap2_pm_debug 0
+#define omap2_read_32k_sync_counter()		0
+#define serial_console_sleep(enable)		do {} while (0);
+#define pm_init_serial_console()		do {} while (0);
+#define omap2_pm_dump(mode, resume, us)		do {} while (0);
+#define serial_console_fclk_mask(f1, f2)		do {} while (0);
+#define omap2_pm_debug				0
 #endif /* CONFIG_PM_DEBUG */
 #endif
diff --git a/include/asm-arm/arch-omap/mailbox.h b/include/asm-arm/arch-omap/mailbox.h
index 7cbed93..9d3994b 100644
--- a/include/asm-arm/arch-omap/mailbox.h
+++ b/include/asm-arm/arch-omap/mailbox.h
@@ -61,6 +61,8 @@ struct omap_mbox {
 	void			(*err_notify)(void);
 };
 
+extern struct omap_mbox mbox_dsp_info;
+
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg, void *);
 void omap_mbox_init_seq(struct omap_mbox *);
 


