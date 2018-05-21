From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 1/5] ti: ethernet: cpdma: Use correct format for genpool_*
Date: Mon, 21 May 2018 11:45:51 -0700
Message-ID: <20180521184555.21555-2-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>, Bhumika Goyal <bhumirks@gmail.com>, =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>, Richard Cochran <richardcochran@gmail.com>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, "open list:TI ETHERNET SWITCH DRIVER CPSW" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Now that we can compile davinci_cpdma.c on 64-bit hosts, we can see that
the format used for printing a size_t type is incorrect, use %zd
accordingly.

Fixes: aeec3021043b ("net: ethernet: ti: cpdma: remove used_desc counter")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 31ae04117f0a..9ec49213de5e 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -191,7 +191,7 @@ static void cpdma_desc_pool_destroy(struct cpdma_ctlr *ctlr)
 		return;
 
 	WARN(gen_pool_size(pool->gen_pool) != gen_pool_avail(pool->gen_pool),
-	     "cpdma_desc_pool size %d != avail %d",
+	     "cpdma_desc_pool size %zd != avail %zd",
 	     gen_pool_size(pool->gen_pool),
 	     gen_pool_avail(pool->gen_pool));
 	if (pool->cpumap)
-- 
2.14.1
