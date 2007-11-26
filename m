From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 08/17] PLAT: OMAP: Modifications at devices.c and mmc.h to
 use multislot structures
Date: Mon, 26 Nov 2007 12:01:34 -0400
Message-ID: <474AEDDE.7000902@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Modifications at arch/arm/plat-omap/devices.c and include/asm-arm/arch-omap/mmc.h
to use multislot structures.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 arch/arm/plat-omap/devices.c    |   30 ++++++++++++++++++++++++------
 include/asm-arm/arch-omap/mmc.h |   13 +++++--------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index e04176d..c25070b 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -21,6 +21,7 @@
 
 #include <asm/arch/tc.h>
 #include <asm/arch/board.h>
+#include <asm/arch/mmc.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>
@@ -165,7 +166,7 @@ static inline void omap_init_kp(void) {}
 #endif
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
 
-static struct omap_mmc_conf mmc1_conf;
+static struct omap_mmc_platform_data mmc1_data;
 
 static u64 mmc1_dmamask = 0xffffffff;
 
@@ -186,7 +187,7 @@ static struct platform_device mmc_omap_device1 = {
 	.id		= 1,
 	.dev = {
 		.dma_mask	= &mmc1_dmamask,
-		.platform_data	= &mmc1_conf,
+		.platform_data	= &mmc1_data,
 	},
 	.num_resources	= ARRAY_SIZE(mmc1_resources),
 	.resource	= mmc1_resources,
@@ -194,7 +195,7 @@ static struct platform_device mmc_omap_device1 = {
 
 #ifdef	CONFIG_ARCH_OMAP16XX
 
-static struct omap_mmc_conf mmc2_conf;
+static struct omap_mmc_platform_data mmc2_data;
 
 static u64 mmc2_dmamask = 0xffffffff;
 
@@ -216,7 +217,7 @@ static struct platform_device mmc_omap_device2 = {
 	.id		= 2,
 	.dev = {
 		.dma_mask	= &mmc2_dmamask,
-		.platform_data	= &mmc2_conf,
+		.platform_data	= &mmc2_data,
 	},
 	.num_resources	= ARRAY_SIZE(mmc2_resources),
 	.resource	= mmc2_resources,
@@ -286,7 +287,7 @@ static void __init omap_init_mmc(void)
 			}
 		}
 #endif
-		mmc1_conf = *mmc;
+		mmc1_data.conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
 
@@ -315,12 +316,29 @@ static void __init omap_init_mmc(void)
 		if (cpu_is_omap1710())
 			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
 				     MOD_CONF_CTRL_1);
-		mmc2_conf = *mmc;
+		mmc2_data.conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device2);
 	}
 #endif
 	return;
 }
+
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
+{
+	switch (host) {
+	case 1:
+		mmc1_data = *info;
+		break;
+#ifdef CONFIG_ARCH_OMAP16XX
+	case 2:
+		mmc2_data = *info;
+		break;
+#endif
+	default:
+		BUG();
+	}
+}
+
 #else
 static inline void omap_init_mmc(void) {}
 #endif
diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-omap/mmc.h
index b70e37b..b5d778e 100644
--- a/include/asm-arm/arch-omap/mmc.h
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -15,19 +15,16 @@
 #include <linux/device.h>
 #include <linux/mmc/host.h>
 
+#include <asm/arch/board.h>
+
 #define OMAP_MMC_MAX_SLOTS	2
 
 struct omap_mmc_platform_data {
-	unsigned enabled:1;
+	struct omap_mmc_conf	conf;
+
 	/* number of slots on board */
 	unsigned nr_slots:2;
-	/* nomux means "standard" muxing is wrong on this board, and that
-	 * board-specific code handled it before common init logic.
-	 */
-	unsigned nomux:1;
-	/* 4 wire signaling is optional, and is only used for SD/SDIO and
-	 * MMCv4 */
-	unsigned wire4:1;
+
 	/* set if your board has components or wiring that limits the
 	 * maximum frequency on the MMC bus */
 	unsigned int max_freq;
-- 1.5.3.GIT
