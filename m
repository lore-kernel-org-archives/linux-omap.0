From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v5 05/10] mmc: sdhci: Convert sdhci_set_timeout_irq() to non-static
Date: Thu, 16 Jan 2020 16:21:49 +0530
Message-ID: <20200116105154.7685-6-faiz_abbas@ti.com>
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

Export sdhci_set_timeout_irq() so that it is accessible from platform drivers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4d48129de5e4..37561333fda4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -993,7 +993,7 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
-static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
+void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
 {
 	if (enable)
 		host->ier |= SDHCI_INT_DATA_TIMEOUT;
@@ -1002,6 +1002,7 @@ static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_data_timeout_irq);
 
 static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 3166b3ecef89..928c6f35fcad 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -803,5 +803,6 @@ void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
+void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 
 #endif /* __SDHCI_HW_H */
-- 
2.19.2
