From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2 2/2] arm: omap: gpmc-smsc911x: minor style fixes
Date: Tue, 26 Apr 2011 19:25:56 +0300
Message-ID: <1303835156-14516-1-git-send-email-grinberg@compulab.co.il>
References: <4DB6E937.7090904@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DB6E937.7090904@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tim Nordell <tim.nordell@logicpd.com>, Nishanth Menon <nm@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

replace "printk(KERN_ERR" by "pr_err("
and fix needlessly multi-lined #ifdef

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2:	added pr_fmt so the pr_*() calls would be cleaner (thanks Nishanth)
	Nishanth, this time it does not affect the n-o-l,
	but it is indeed cleaner


 arch/arm/mach-omap2/gpmc-smsc911x.c             |   14 +++++++-------
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    3 +--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index d30293a..e09374a 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -10,6 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -55,7 +56,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 	gpmc_cfg = board_data;
 
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smsc911x\n");
+		pr_err("Failed to request GPMC mem region\n");
 		return;
 	}
 
@@ -63,8 +64,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 	gpmc_smsc911x_resources[0].end = cs_mem_base + 0xff;
 
 	if (gpio_request(gpmc_cfg->gpio_irq, "smsc911x irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
-				gpmc_cfg->gpio_irq);
+		pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio_irq);
 		goto free1;
 	}
 
@@ -74,8 +74,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 	if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
 		ret = gpio_request(gpmc_cfg->gpio_reset, "smsc911x reset");
 		if (ret) {
-			printk(KERN_ERR "Failed to request GPIO%d for smsc911x reset\n",
-					gpmc_cfg->gpio_reset);
+			pr_err("Failed to request reset GPIO%d\n",
+			       gpmc_cfg->gpio_reset);
 			goto free2;
 		}
 
@@ -92,7 +92,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
 		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
 	if (!pdev) {
-		printk(KERN_ERR "Unable to register smsc911x device\n");
+		pr_err("Unable to register platform device\n");
 		gpio_free(gpmc_cfg->gpio_reset);
 		goto free2;
 	}
@@ -104,5 +104,5 @@ free2:
 free1:
 	gpmc_cs_free(gpmc_cfg->cs);
 
-	printk(KERN_ERR "Could not initialize smsc911x\n");
+	pr_err("Could not initialize smsc911x device\n");
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
index d3f1579..ea6c9c8 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -21,8 +21,7 @@ struct omap_smsc911x_platform_data {
 	u32	flags;
 };
 
-#if defined(CONFIG_SMSC911X) || \
-	defined(CONFIG_SMSC911X_MODULE)
+#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
 
-- 
1.7.3.4
