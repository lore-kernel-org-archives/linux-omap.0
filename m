From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dmaengine: edma: fix build without CONFIG_OF
Date: Tue, 03 Nov 2015 15:00:57 +0100
Message-ID: <17811472.bY8CqmdEVy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

During the edma rework, a build error was introduced for the
case that CONFIG_OF is disabled:

drivers/built-in.o: In function `edma_tc_set_pm_state':
:(.text+0x43bf0): undefined reference to `of_find_device_by_node'

As the edma_tc_set_pm_state() function does nothing in case
we are running without OF, this adds an IS_ENABLED() check
that turns the function into an empty stub then and avoids the
link error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ca304fa9bb76 ("ARM/dmaengine: edma: Public API to use private struct pointer")
---
Found on ARM randconfig builds with today's linux-next

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 31722d436a42..16713a93da10 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1560,7 +1560,7 @@ static void edma_tc_set_pm_state(struct edma_tc *tc, bool enable)
 	struct platform_device *tc_pdev;
 	int ret;
 
-	if (!tc)
+	if (!IS_ENABLED(CONFIG_OF) || !tc)
 		return;
 
 	tc_pdev = of_find_device_by_node(tc->node);
