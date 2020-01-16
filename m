From: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 09/10] mmc: sdhci-omap: Add am335x and am437x specific compatibles
Date: Thu, 16 Jan 2020 16:21:53 +0530
Message-ID: <20200116105154.7685-10-faiz_abbas@ti.com>
References: <20200116105154.7685-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116105154.7685-1-faiz_abbas-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, faiz_abbas-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add support for new compatible for TI's am335x and am437x devices.

Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-omap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 1f05c8e98d62..5433c9e6ac10 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -898,6 +898,14 @@ static const struct sdhci_omap_data k2g_data = {
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
@@ -906,6 +914,8 @@ static const struct sdhci_omap_data dra7_data = {
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
