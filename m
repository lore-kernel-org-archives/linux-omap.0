From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 9/9] arch: arm: fixed typos
Date: Sat, 16 Oct 2010 11:00:05 +0200
Message-ID: <1287219606-20759-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48617 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab0JPJA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Oct 2010 05:00:29 -0400
Received: by wwj40 with SMTP id 40so1955037wwj.1
        for <linux-omap@vger.kernel.org>; Sat, 16 Oct 2010 02:00:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Leo Chen <leochen@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, Sergio Aguirre <saaguirre@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Maciej Sosnowski <maciej.sosnowski@intel.com>, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.c>

Intialize, configuation, wakup, Managment, addres

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-bcmring/csp/chipc/chipcHw.c    |    2 +-
 arch/arm/mach-bcmring/csp/tmr/tmrHw.c        |    2 +-
 arch/arm/mach-bcmring/dma.c                  |    2 +-
 arch/arm/mach-omap2/hsmmc.h                  |    2 +-
 arch/arm/mach-omap2/pm34xx.c                 |    2 +-
 arch/arm/mach-omap2/serial.c                 |    2 +-
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h |    2 +-
 arch/arm/mach-u300/include/mach/coh901318.h  |    2 +-
 arch/arm/plat-omap/mcbsp.c                   |    4 ++--
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-bcmring/csp/chipc/chipcHw.c b/arch/arm/mach-bcmring/csp/chipc/chipcHw.c
index b3a61d8..96273ff 100644
--- a/arch/arm/mach-bcmring/csp/chipc/chipcHw.c
+++ b/arch/arm/mach-bcmring/csp/chipc/chipcHw.c
@@ -757,7 +757,7 @@ static int chipcHw_divide(int num, int denom)
 		t = t << 1;
 	}
 
-	/* Intialize the result */
+	/* Initialize the result */
 	r = 0;
 
 	do {
diff --git a/arch/arm/mach-bcmring/csp/tmr/tmrHw.c b/arch/arm/mach-bcmring/csp/tmr/tmrHw.c
index 5c1c9a0..16225e4 100644
--- a/arch/arm/mach-bcmring/csp/tmr/tmrHw.c
+++ b/arch/arm/mach-bcmring/csp/tmr/tmrHw.c
@@ -558,7 +558,7 @@ static int tmrHw_divide(int num, int denom)
 		t = t << 1;
 	}
 
-	/* Intialize the result */
+	/* Initialize the result */
 	r = 0;
 
 	do {
diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index 29c0a91..9105d16 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -671,7 +671,7 @@ static int ConfigChannel(DMA_Handle_t handle)
 
 /****************************************************************************/
 /**
-*   Intializes all of the data structures associated with the DMA.
+*   Initializes all of the data structures associated with the DMA.
 *   @return
 *       >= 0    - Initialization was successfull.
 *
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 1fe6f01..0f8a2e6 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -23,7 +23,7 @@ struct omap2_hsmmc_info {
 	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 	int	ocr_mask;	/* temporary HACK */
-	/* Remux (pad configuation) when powering on/off */
+	/* Remux (pad configuration) when powering on/off */
 	void (*remux)(struct device *dev, int slot, int power_on);
 	/* init some special card */
 	void (*init_card)(struct mmc_card *card);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7b03426..abe2eb8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -899,7 +899,7 @@ static void __init prcm_setup_regs(void)
 			     OMAP3430_GR_MOD,
 			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
 
-	/* setup wakup source */
+	/* setup wakeup source */
 	prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
 			  OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
 			  WKUP_MOD, PM_WKEN);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 566e991..ff79b9d 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -818,7 +818,7 @@ void __init omap_serial_init_port(int port)
 }
 
 /**
- * omap_serial_init() - intialize all supported serial ports
+ * omap_serial_init() - initialize all supported serial ports
  *
  * Initializes all available UARTs as serial ports. Platforms
  * can call this function when they want to have default behaviour
diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
index e91d63c..b8aa447 100644
--- a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
@@ -47,7 +47,7 @@
 #define PCMD(x)		__REG(0x40F50110 + ((x) << 2))
 
 /*
- * Slave Power Managment Unit
+ * Slave Power Management Unit
  */
 #define ASCR		__REG(0x40f40000)	/* Application Subsystem Power Status/Configuration */
 #define ARSR		__REG(0x40f40004)	/* Application Subsystem Reset Status */
diff --git a/arch/arm/mach-u300/include/mach/coh901318.h b/arch/arm/mach-u300/include/mach/coh901318.h
index 193da2d..2013d2b 100644
--- a/arch/arm/mach-u300/include/mach/coh901318.h
+++ b/arch/arm/mach-u300/include/mach/coh901318.h
@@ -24,7 +24,7 @@
  * @src_addr: transfer source address
  * @dst_addr: transfer destination address
  * @link_addr:  physical address to next lli
- * @virt_link_addr: virtual addres of next lli (only used by pool_free)
+ * @virt_link_addr: virtual address of next lli (only used by pool_free)
  * @phy_this: physical address of current lli (only used by pool_free)
  */
 struct coh901318_lli {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0c8612f..376259b 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -650,7 +650,7 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
 	/*
-	 * Enable wakup behavior, smart idle and all wakeups
+	 * Enable wakeup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
 	 */
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
@@ -674,7 +674,7 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 {
 	/*
-	 * Disable wakup behavior, smart idle and all wakeups
+	 * Disable wakeup behavior, smart idle and all wakeups
 	 */
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		u16 syscon;
-- 
1.7.3.1.181.g784b8

