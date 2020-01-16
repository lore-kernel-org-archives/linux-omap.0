From: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 10/10] mmc: sdhci-omap: Add special reset capability
Date: Thu, 16 Jan 2020 16:21:54 +0530
Message-ID: <20200116105154.7685-11-faiz_abbas@ti.com>
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

Some omap controllers need software to monitor a 0->1->0 for software
reset. Add a SDHCI_OMAP_SPECIAL_RESET flag to indicate this.

Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-omap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 5433c9e6ac10..882053151a47 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -86,6 +86,7 @@
 
 /* sdhci-omap controller flags */
 #define SDHCI_OMAP_REQUIRE_IODELAY	BIT(0)
+#define SDHCI_OMAP_SPECIAL_RESET	BIT(1)
 
 struct sdhci_omap_data {
 	u32 offset;
@@ -779,15 +780,35 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_omap_start_clock(omap_host);
 }
 
+#define MMC_TIMEOUT_US		20000		/* 20000 micro Sec */
 static void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long limit = MMC_TIMEOUT_US;
+	unsigned long i = 0;
 
 	/* Don't reset data lines during tuning operation */
 	if (omap_host->is_tuning)
 		mask &= ~SDHCI_RESET_DATA;
 
+	if (omap_host->flags & SDHCI_OMAP_SPECIAL_RESET) {
+		sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+		while ((!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)) &&
+		       (i++ < limit))
+			udelay(1);
+		i = 0;
+		while ((sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) &&
+		       (i++ < limit))
+			udelay(1);
+
+		if (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)
+			dev_err(mmc_dev(host->mmc),
+				"Timeout waiting on controller reset in %s\n",
+				__func__);
+		return;
+	}
+
 	sdhci_reset(host, mask);
 }
 
@@ -900,10 +921,12 @@ static const struct sdhci_omap_data k2g_data = {
 
 static const struct sdhci_omap_data am335_data = {
 	.offset = 0x200,
+	.flags = SDHCI_OMAP_SPECIAL_RESET,
 };
 
 static const struct sdhci_omap_data am437_data = {
 	.offset = 0x200,
+	.flags = SDHCI_OMAP_SPECIAL_RESET,
 };
 
 static const struct sdhci_omap_data dra7_data = {
-- 
2.19.2
