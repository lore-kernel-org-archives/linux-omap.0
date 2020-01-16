From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v5 07/10] mmc: sdhci-omap: Disable data timeout interrupt during erase
Date: Thu, 16 Jan 2020 16:21:51 +0530
Message-ID: <20200116105154.7685-8-faiz_abbas@ti.com>
References: <20200116105154.7685-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116105154.7685-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, faiz_abbas@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Disable data timeout interrupt during an erase operation.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-omap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 84d85aa743da..1f05c8e98d62 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -827,6 +828,15 @@ static u32 sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
 	return intmask;
 }
 
+static void sdhci_omap_set_timeout(struct sdhci_host *host,
+				   struct mmc_command *cmd)
+{
+	if (cmd->opcode == MMC_ERASE)
+		sdhci_set_data_timeout_irq(host, false);
+
+	__sdhci_set_timeout(host, cmd);
+}
+
 static struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
@@ -838,6 +848,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.reset = sdhci_omap_reset,
 	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 	.irq = sdhci_omap_irq,
+	.set_timeout = sdhci_omap_set_timeout,
 };
 
 static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
-- 
2.19.2
