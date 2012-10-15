From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 2/4] MMC: omap_hsmmc: add DT property for max bus frequency
Date: Mon, 15 Oct 2012 21:35:06 +0530
Message-ID: <1350317108-10657-2-git-send-email-svenkatr@ti.com>
References: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Venkatraman S <svenkatr@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-omap@vger.kernel.org

From: Daniel Mack <zonque@gmail.com>

Maximum bus frequency can be limited by external circuitry like level
shifters etc. Allow passing this value from DT.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 01eeeae..a33ab74 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1674,7 +1674,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 {
 	struct omap_mmc_platform_data *pdata;
 	struct device_node *np = dev->of_node;
-	u32 bus_width;
+	u32 bus_width, max_freq;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -1701,6 +1701,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,needs-special-reset", NULL))
 		pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
 
+	if (!of_property_read_u32(np, "max-frequency", &max_freq))
+		pdata->max_freq = max_freq;
+
 	return pdata;
 }
 #else
-- 
1.7.11.1.25.g0e18bef

