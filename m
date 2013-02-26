From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 09/14] ARM: OMAP2+: Don't configure of chip-select options in gpmc_cs_configure()
Date: Tue, 26 Feb 2013 11:30:36 -0600
Message-ID: <1361899842-30303-10-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36744 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab3BZRbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Feb 2013 12:31:17 -0500
In-Reply-To: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Jon Hunter <jon-hunter@ti.com>

With the addition of the gpmc_cs_program_settings(), we no longer need
or use gpmc_cs_configure() to configure some of the GPMC chip-select
options. So rename the function to gpmc_configure() and remove code that
modifies options in the CONFIG1 register.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |    2 +-
 arch/arm/mach-omap2/gpmc.c      |   45 ++++++---------------------------------
 arch/arm/mach-omap2/gpmc.h      |    2 +-
 3 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 4bdfea2..a4c8537 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -153,7 +153,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		if (IS_ERR_VALUE(err))
 			goto out_free_cs;
 
-		err = gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_WP, 0);
+		err = gpmc_configure(GPMC_CONFIG_WP, 0);
 		if (IS_ERR_VALUE(err))
 			goto out_free_cs;
 	}
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index fb8dfd2..7cf3d98 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -564,16 +564,14 @@ void gpmc_cs_free(int cs)
 EXPORT_SYMBOL(gpmc_cs_free);
 
 /**
- * gpmc_cs_configure - write request to configure gpmc
- * @cs: chip select number
+ * gpmc_configure - write request to configure gpmc
  * @cmd: command type
  * @wval: value to write
  * @return status of the operation
  */
-int gpmc_cs_configure(int cs, int cmd, int wval)
+int gpmc_configure(int cmd, int wval)
 {
-	int err = 0;
-	u32 regval = 0;
+	u32 regval;
 
 	switch (cmd) {
 	case GPMC_ENABLE_IRQ:
@@ -593,43 +591,14 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
 		gpmc_write_reg(GPMC_CONFIG, regval);
 		break;
 
-	case GPMC_CONFIG_RDY_BSY:
-		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-		if (wval)
-			regval |= WR_RD_PIN_MONITORING;
-		else
-			regval &= ~WR_RD_PIN_MONITORING;
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
-		break;
-
-	case GPMC_CONFIG_DEV_SIZE:
-		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-
-		/* clear 2 target bits */
-		regval &= ~GPMC_CONFIG1_DEVICESIZE(3);
-
-		/* set the proper value */
-		regval |= GPMC_CONFIG1_DEVICESIZE(wval);
-
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
-		break;
-
-	case GPMC_CONFIG_DEV_TYPE:
-		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-		regval |= GPMC_CONFIG1_DEVICETYPE(wval);
-		if (wval == GPMC_DEVICETYPE_NOR)
-			regval |= GPMC_CONFIG1_MUXADDDATA;
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
-		break;
-
 	default:
-		printk(KERN_ERR "gpmc_configure_cs: Not supported\n");
-		err = -EINVAL;
+		pr_err("%s: command not supported\n", __func__);
+		return -EINVAL;
 	}
 
-	return err;
+	return 0;
 }
-EXPORT_SYMBOL(gpmc_cs_configure);
+EXPORT_SYMBOL(gpmc_configure);
 
 void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 {
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index 638f94a..d73fda0 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -229,6 +229,6 @@ extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
-extern int gpmc_cs_configure(int cs, int cmd, int wval);
+extern int gpmc_configure(int cmd, int wval);
 
 #endif
-- 
1.7.10.4

