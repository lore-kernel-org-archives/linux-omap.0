From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: ti: New directory for Texas Instruments DMA drivers
Date: Wed, 25 Apr 2018 11:45:03 +0300
Message-ID: <20180425084503.15934-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com
Cc: tony@atomide.com, bigeasy@linutronix.de, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, abailon@baylibre.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Collect the Texas Instruments DMA drivers under drivers/dma/ti/

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/Kconfig                           | 31 +---------------
 drivers/dma/Makefile                          |  5 +--
 drivers/dma/ti/Kconfig                        | 37 +++++++++++++++++++
 drivers/dma/ti/Makefile                       |  5 +++
 drivers/dma/{ => ti}/cppi41.c                 |  2 +-
 .../{ti-dma-crossbar.c => ti/dma-crossbar.c}  |  0
 drivers/dma/{ => ti}/edma.c                   |  4 +-
 drivers/dma/{ => ti}/omap-dma.c               |  2 +-
 8 files changed, 49 insertions(+), 37 deletions(-)
 create mode 100644 drivers/dma/ti/Kconfig
 create mode 100644 drivers/dma/ti/Makefile
 rename drivers/dma/{ => ti}/cppi41.c (99%)
 rename drivers/dma/{ti-dma-crossbar.c => ti/dma-crossbar.c} (100%)
 rename drivers/dma/{ => ti}/edma.c (99%)
 rename drivers/dma/{ => ti}/omap-dma.c (99%)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6d61cd023633..ca1680afa20a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -151,13 +151,6 @@ config DMA_JZ4780
 	  If you have a board based on such a SoC and wish to use DMA for
 	  devices which can use the DMA controller, say Y or M here.
 
-config DMA_OMAP
-	tristate "OMAP DMA support"
-	depends on ARCH_OMAP || COMPILE_TEST
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	select TI_DMA_CROSSBAR if (SOC_DRA7XX || COMPILE_TEST)
-
 config DMA_SA11X0
 	tristate "SA-11x0 DMA support"
 	depends on ARCH_SA1100 || COMPILE_TEST
@@ -574,28 +567,6 @@ config TIMB_DMA
 	help
 	  Enable support for the Timberdale FPGA DMA engine.
 
-config TI_CPPI41
-	tristate "CPPI 4.1 DMA support"
-	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX)
-	select DMA_ENGINE
-	help
-	  The Communications Port Programming Interface (CPPI) 4.1 DMA engine
-	  is currently used by the USB driver on AM335x and DA8xx platforms.
-
-config TI_DMA_CROSSBAR
-	bool
-
-config TI_EDMA
-	bool "TI EDMA support"
-	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE || COMPILE_TEST
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	select TI_DMA_CROSSBAR if (ARCH_OMAP || COMPILE_TEST)
-	default n
-	help
-	  Enable support for the TI EDMA controller. This DMA
-	  engine is found on TI DaVinci and AM33xx parts.
-
 config XGENE_DMA
 	tristate "APM X-Gene DMA support"
 	depends on ARCH_XGENE || COMPILE_TEST
@@ -653,6 +624,8 @@ source "drivers/dma/hsu/Kconfig"
 
 source "drivers/dma/sh/Kconfig"
 
+source "drivers/dma/ti/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 0f62a4d49aab..203a99d68315 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -24,7 +24,6 @@ obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
 obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
 obj-$(CONFIG_DMA_JZ4740) += dma-jz4740.o
 obj-$(CONFIG_DMA_JZ4780) += dma-jz4780.o
-obj-$(CONFIG_DMA_OMAP) += omap-dma.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
 obj-$(CONFIG_DMA_SUN4I) += sun4i-dma.o
 obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
@@ -69,13 +68,11 @@ obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
 obj-$(CONFIG_TEGRA210_ADMA) += tegra210-adma.o
 obj-$(CONFIG_TIMB_DMA) += timb_dma.o
-obj-$(CONFIG_TI_CPPI41) += cppi41.o
-obj-$(CONFIG_TI_DMA_CROSSBAR) += ti-dma-crossbar.o
-obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 
 obj-y += mediatek/
 obj-y += qcom/
+obj-y += ti/
 obj-y += xilinx/
diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
new file mode 100644
index 000000000000..e5e74e1361dc
--- /dev/null
+++ b/drivers/dma/ti/Kconfig
@@ -0,0 +1,37 @@
+#
+# Texas Instruments DMA drivers
+#
+
+config TI_CPPI41
+	tristate "Texas Instruments CPPI 4.1 DMA support"
+	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX)
+	select DMA_ENGINE
+	help
+	  The Communications Port Programming Interface (CPPI) 4.1 DMA engine
+	  is currently used by the USB driver on AM335x and DA8xx platforms.
+
+config TI_EDMA
+	tristate "Texas Instruments EDMA support"
+	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select TI_DMA_CROSSBAR if (ARCH_OMAP || COMPILE_TEST)
+	default y
+	help
+	  Enable support for the TI EDMA (Enhanced DMA) controller. This DMA
+	  engine is found on TI DaVinci, AM33xx, AM43xx, DRA7xx and Keystone 2
+	  parts.
+
+config DMA_OMAP
+	tristate "Texas Instruments sDMA (omap-dma) support"
+	depends on ARCH_OMAP || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select TI_DMA_CROSSBAR if (SOC_DRA7XX || COMPILE_TEST)
+	default y
+	help
+	  Enable support for the TI sDMA (System DMA or DMA4) controller. This
+	  DMA engine is found on OMAP and DRA7xx parts.
+
+config TI_DMA_CROSSBAR
+	bool
diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
new file mode 100644
index 000000000000..113e59ec9c32
--- /dev/null
+++ b/drivers/dma/ti/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_TI_CPPI41) += cppi41.o
+obj-$(CONFIG_TI_EDMA) += edma.o
+obj-$(CONFIG_DMA_OMAP) += omap-dma.o
+obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/cppi41.c b/drivers/dma/ti/cppi41.c
similarity index 99%
rename from drivers/dma/cppi41.c
rename to drivers/dma/ti/cppi41.c
index d9bee65a18a4..1497da367710 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -11,7 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/pm_runtime.h>
-#include "dmaengine.h"
+#include "../dmaengine.h"
 
 #define DESC_TYPE	27
 #define DESC_TYPE_HOST	0x10
diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
similarity index 100%
rename from drivers/dma/ti-dma-crossbar.c
rename to drivers/dma/ti/dma-crossbar.c
diff --git a/drivers/dma/edma.c b/drivers/dma/ti/edma.c
similarity index 99%
rename from drivers/dma/edma.c
rename to drivers/dma/ti/edma.c
index 85ea92fcea54..93a5cbf13319 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -33,8 +33,8 @@
 
 #include <linux/platform_data/edma.h>
 
-#include "dmaengine.h"
-#include "virt-dma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
 
 /* Offsets matching "struct edmacc_param" */
 #define PARM_OPT		0x00
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/ti/omap-dma.c
similarity index 99%
rename from drivers/dma/omap-dma.c
rename to drivers/dma/ti/omap-dma.c
index d21c19822feb..b73fb51fbc81 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -21,7 +21,7 @@
 #include <linux/of_dma.h>
 #include <linux/of_device.h>
 
-#include "virt-dma.h"
+#include "../virt-dma.h"
 
 #define OMAP_SDMA_REQUESTS	127
 #define OMAP_SDMA_CHANNELS	32
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
