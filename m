From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 11/11] mmc: sdhci-omap: Add am335x and am437x specific compatibles
Date: Mon, 6 Jan 2020 16:31:33 +0530
Message-ID: <20200106110133.13791-12-faiz_abbas@ti.com>
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

Add support for new compatible for TI's am335x and am437x devices.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 34df30edd450..4d7026daa8cd 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -919,6 +919,14 @@ static const struct sdhci_omap_data k2g_data = {
 	.offset = 0x200,
 };
 
+static const struct sdhci_omap_data am335_data = {
+	.offset = 0x200,
+};
+
+static const struct sdhci_omap_data am437_data = {
+	.offset = 0x200,
+};
+
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
 	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
@@ -927,6 +935,8 @@ static const struct sdhci_omap_data dra7_data = {
 static const struct of_device_id omap_sdhci_match[] = {
 	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
 	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
+	{ .compatible = "ti,am335-sdhci", .data = &am335_data },
+	{ .compatible = "ti,am437-sdhci", .data = &am437_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_sdhci_match);
-- 
2.19.2
