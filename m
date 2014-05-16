From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 01/13] ARM: edma: No need to clean the pdata in edma_of_parse_dt()
Date: Fri, 16 May 2014 15:17:08 +0300
Message-ID: <1400242640-9902-2-git-send-email-peter.ujfalusi@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: nsekhar@ti.com, joelf@ti.com, arnd@arndb.de
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

The pdata has been just allocated with devm_kzalloc() in
edma_setup_info_from_dt() and passed to this function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 8452cf246330..01707aae0a2b 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1472,8 +1472,6 @@ static int edma_of_parse_dt(struct device *dev,
 	struct edma_rsv_info *rsv_info;
 	s8 (*queue_tc_map)[2], (*queue_priority_map)[2];
 
-	memset(pdata, 0, sizeof(struct edma_soc_info));
-
 	ret = of_property_read_u32(node, "dma-channels", &value);
 	if (ret < 0)
 		return ret;
-- 
1.9.3

