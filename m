From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Subject: [PATCH] davinci_cpdma: make cpdma_chan_split_pool static
Date: Tue, 15 Oct 2019 17:15:58 +0100
Message-ID: <20191015161558.18506-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The cpdma_chan_split_pool() function is not used outside of
the driver, so make it static to avoid the following sparse
warning:

drivers/net/ethernet/ti/davinci_cpdma.c:725:5: warning: symbol 'cpdma_chan_split_pool' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-omap@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index a65edd2770e6..37ba708ac781 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -722,7 +722,7 @@ static void cpdma_chan_set_descs(struct cpdma_ctlr *ctlr,
  * cpdma_chan_split_pool - Splits ctrl pool between all channels.
  * Has to be called under ctlr lock
  */
-int cpdma_chan_split_pool(struct cpdma_ctlr *ctlr)
+static int cpdma_chan_split_pool(struct cpdma_ctlr *ctlr)
 {
 	int tx_per_ch_desc = 0, rx_per_ch_desc = 0;
 	int free_rx_num = 0, free_tx_num = 0;
-- 
2.23.0
