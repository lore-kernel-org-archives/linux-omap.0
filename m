From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/5] ARM: edma: No need to clean the pdata in edma_of_parse_dt()
Date: Tue, 13 May 2014 13:30:28 +0300
Message-ID: <1399977032-26469-2-git-send-email-peter.ujfalusi@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, joelf@ti.com
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

The pdata has been just allocated with devm_kzalloc() in
edma_setup_info_from_dt() and passed to this function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index b9bd42ad2d6e..fade9ada81f8 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1490,8 +1490,6 @@ static int edma_of_parse_dt(struct device *dev,
 	struct edma_rsv_info *rsv_info;
 	s8 (*queue_tc_map)[2], (*queue_priority_map)[2];
 
-	memset(pdata, 0, sizeof(struct edma_soc_info));
-
 	ret = of_property_read_u32(node, "dma-channels", &value);
 	if (ret < 0)
 		return ret;
-- 
1.9.3
