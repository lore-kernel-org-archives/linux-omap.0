From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 07/11] mmc: sdhci-omap: Disable data timeout interrupt during erase
Date: Mon, 6 Jan 2020 16:31:29 +0530
Message-ID: <20200106110133.13791-8-faiz_abbas@ti.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106110133.13791-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, tony@atomide.com, faiz_abbas@ti.com
List-Id: linux-omap@vger.kernel.org

Disable data timeout interrupt during an erase operation

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
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
