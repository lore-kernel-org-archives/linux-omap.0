From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 15/36] ARM: OMAP2+: gpmc: Allow drivers to query GPMC_CLK
 period
Date: Wed, 11 Jun 2014 11:56:20 +0300
Message-ID: <1402477001-31132-16-git-send-email-rogerq@ti.com>
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

GPMC_CLK is the external clock output pin that is used for syncronous
accesses.

Device drivers need to know the fastest possible GPMC_CLK period in order
to calculate the most optimal device timings. Add the function
omap_gpmc_get_clk_period() to allow drivers to get the nearset possible
(equal to or greater than) GPMC_CLK period given the minimum
clock period supported by the attached device.

This is especially needed by the onenand driver as it calculates
device timings on the fly for various onenand speed grades.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc.c              | 38 +++++++++++++++++++++++++++++++++
 include/linux/platform_data/gpmc-omap.h |  8 +++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 90b7686..50ef1a9 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1578,6 +1578,44 @@ int omap_gpmc_retime(int cs, struct gpmc_settings *gpmc_s,
 }
 EXPORT_SYMBOL_GPL(omap_gpmc_retime);
 
+/**
+ * omap_gpmc_get_clk_period - Get the nearest possible (equal to or higer) GPMC
+ *				synchronous clock (GPMC_CLK) period.
+ *
+ * @cs		Chip select number
+ * @min_ps	Minimum synchronous clock period supporded by the device
+ *
+ * Returns the nearest possible GPMC clock period in picoseconds, equal to or
+ * higher than the requested period. 0 in case of error.
+ */
+unsigned long omap_gpmc_get_clk_period(int cs,
+				       unsigned long min_ps)
+{
+	int div;
+	unsigned long clk_ps;
+	struct device *dev = gpmc_dev;
+
+	if (!gpmc_dev)
+		return 0;
+
+	if (cs < 0 || cs >= gpmc_cs_num) {
+		dev_err(dev, "%s: Invalid Chip Select\n", __func__);
+		return cs;
+	}
+
+	div = gpmc_calc_divider(min_ps);
+	if (div < 0) {
+		dev_err(dev, "%s: Can't support requested clock period %lu ps\n",
+			__func__, min_ps);
+		return 0;
+	}
+
+	clk_ps = gpmc_get_fclk_period() * div;
+
+	return clk_ps;
+}
+EXPORT_SYMBOL_GPL(omap_gpmc_get_clk_period);
+
 static struct omap3_gpmc_regs gpmc_context;
 
 void omap3_gpmc_save_context(void)
diff --git a/include/linux/platform_data/gpmc-omap.h b/include/linux/platform_data/gpmc-omap.h
index 0d40c2a..05e4b6f 100644
--- a/include/linux/platform_data/gpmc-omap.h
+++ b/include/linux/platform_data/gpmc-omap.h
@@ -169,6 +169,8 @@ struct gpmc_omap_platform_data {
 #ifdef CONFIG_ARCH_OMAP2PLUS
 int omap_gpmc_retime(int cs, struct gpmc_settings *gpmc_s,
 		     struct gpmc_device_timings *dev_t);
+unsigned long omap_gpmc_get_clk_period(int cs,
+				       unsigned long min_ps);
 #else
 static inline int omap_gpmc_retime(int cs,
 				   struct gpmc_settings *gpmc_s,
@@ -176,6 +178,12 @@ static inline int omap_gpmc_retime(int cs,
 {
 	return 0;
 }
+
+static inline unsigned long omap_gpmc_get_clk_period(int cs,
+						     unsigned long min_ps)
+{
+	return 0;
+}
 #endif /* CONFIG_ARCH_OMAP2PLUS */
 
 #endif /* _GPMC_OMAP_H */
-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
