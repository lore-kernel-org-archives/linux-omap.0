From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 26/36] ARM: OMAP2+: gpmc-smc91x: Get rid of retime() from
 omap_smc91x_platform_data
Date: Wed, 11 Jun 2014 11:56:31 +0300
Message-ID: <1402477001-31132-27-git-send-email-rogerq@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1402477001-31132-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-mtd@lists.infradead.org, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The retime() function is not provided by board files so get rid of
it from omap_smc91x_platform_data().

Instead change it to smc91c96_get_device_timing() to get the device
timings.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |  8 ++++--
 arch/arm/mach-omap2/gpmc-smc91x.c   | 55 ++++++++++++++-----------------------
 arch/arm/mach-omap2/gpmc-smc91x.h   |  1 -
 3 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d95d0ef..b781090 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -411,8 +411,12 @@ static int __init omap3430_i2c_init(void)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs		= 3,
-	.flags		= GPMC_MUX_ADD_DATA | GPMC_TIMINGS_SMC91C96 |
-				IORESOURCE_IRQ_LOWLEVEL,
+	/*
+	 * Don't use GPMC_TIMINGS_SMC91C96 flag here as generic
+	 * timing doesn't seem to have worked.
+	 * Leave bootloader timing intact.
+	 */
+	.flags		= GPMC_MUX_ADD_DATA | IORESOURCE_IRQ_LOWLEVEL,
 };
 
 static void __init board_smc91x_init(void)
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 61a0635..7f5d84a 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -59,10 +59,8 @@ static struct gpmc_settings smc91x_settings = {
  * http://www.smsc.com/main/catalog/lan91c96.html
  * REVISIT: Level shifters can add at least to the access latency.
  */
-static int smc91c96_gpmc_retime(void)
+static void smc91c96_get_device_timing(struct gpmc_device_timings *dev_t)
 {
-	struct gpmc_timings t;
-	struct gpmc_device_timings dev_t;
 	const int t3 = 10;	/* Figure 12.2 read and 12.4 write */
 	const int t4_r = 20;	/* Figure 12.2 read */
 	const int t4_w = 5;	/* Figure 12.4 write */
@@ -72,33 +70,19 @@ static int smc91c96_gpmc_retime(void)
 	const int t8 = 5;	/* Figure 12.4 write */
 	const int t20 = 185;	/* Figure 12.2 read and 12.4 write */
 
-	/*
-	 * FIXME: Calculate the address and data bus muxed timings.
-	 * Note that at least adv_rd_off needs to be changed according
-	 * to omap3430 TRM Figure 11-11. Are the sdp boards using the
-	 * FPGA in between smc91x and omap as the timings are different
-	 * from above?
-	 */
-	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
-		return 0;
-
-	memset(&dev_t, 0, sizeof(dev_t));
-
-	dev_t.t_oeasu = t3 * 1000;
-	dev_t.t_oe = t5 * 1000;
-	dev_t.t_cez_r = t4_r * 1000;
-	dev_t.t_oez = t6 * 1000;
-	dev_t.t_rd_cycle = (t20 - t3) * 1000;
+	memset(dev_t, 0, sizeof(*dev_t));
 
-	dev_t.t_weasu = t3 * 1000;
-	dev_t.t_wpl = t7 * 1000;
-	dev_t.t_wph = t8 * 1000;
-	dev_t.t_cez_w = t4_w * 1000;
-	dev_t.t_wr_cycle = (t20 - t3) * 1000;
+	dev_t->t_oeasu = t3 * 1000;
+	dev_t->t_oe = t5 * 1000;
+	dev_t->t_cez_r = t4_r * 1000;
+	dev_t->t_oez = t6 * 1000;
+	dev_t->t_rd_cycle = (t20 - t3) * 1000;
 
-	gpmc_calc_timings(&t, &smc91x_settings, &dev_t);
-
-	return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
+	dev_t->t_weasu = t3 * 1000;
+	dev_t->t_wpl = t7 * 1000;
+	dev_t->t_wph = t8 * 1000;
+	dev_t->t_cez_w = t4_w * 1000;
+	dev_t->t_wr_cycle = (t20 - t3) * 1000;
 }
 
 /*
@@ -110,12 +94,10 @@ void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 {
 	unsigned long cs_mem_base;
 	int ret;
+	struct gpmc_device_timings dev_t;
 
 	gpmc_cfg = board_data;
 
-	if (gpmc_cfg->flags & GPMC_TIMINGS_SMC91C96)
-		gpmc_cfg->retime = smc91c96_gpmc_retime;
-
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
 		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
 		return;
@@ -137,10 +119,15 @@ void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 	if (ret < 0)
 		goto free1;
 
-	if (gpmc_cfg->retime) {
-		ret = gpmc_cfg->retime();
-		if (ret != 0)
+	if (gpmc_cfg->flags & GPMC_TIMINGS_SMC91C96) {
+		struct gpmc_timings gpmc_t;
+
+		smc91c96_get_device_timing(&dev_t);
+		gpmc_calc_timings(&gpmc_t, &smc91x_settings, &dev_t);
+		if (gpmc_cs_set_timings(gpmc_cfg->cs, &gpmc_t)) {
+			pr_err("%s: failed to set GPMC timings\n", __func__);
 			goto free1;
+		}
 	}
 
 	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "SMC91X irq") < 0)
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.h b/arch/arm/mach-omap2/gpmc-smc91x.h
index b64fbee..1da09a0 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.h
+++ b/arch/arm/mach-omap2/gpmc-smc91x.h
@@ -22,7 +22,6 @@ struct omap_smc91x_platform_data {
 	int	gpio_reset;
 	int	wait_pin;	/* Optional GPMC_CONFIG1_WAITPINSELECT */
 	u32	flags;
-	int	(*retime)(void);
 };
 
 #if defined(CONFIG_SMC91X) || \
-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
