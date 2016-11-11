From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2] net: ethernet: ti: davinci_cpdma: free memory while channel destroy
Date: Fri, 11 Nov 2016 14:39:03 +0200
Message-ID: <1478867943-21083-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com, grygorii.strashko@ti.com, netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

While create/destroy channel operation memory is not freed. It was
supposed that memory is freed while driver remove. But a channel
can be created and destroyed many times while changing number of
channels with ethtool.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

---

Based on net-next/master

 drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 05afc05..07fc92d 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -586,7 +586,7 @@ int cpdma_chan_destroy(struct cpdma_chan *chan)
 		cpdma_chan_stop(chan);
 	ctlr->channels[chan->chan_num] = NULL;
 	ctlr->chan_num--;
-
+	devm_kfree(ctlr->dev, chan);
 	cpdma_chan_split_pool(ctlr);
 
 	spin_unlock_irqrestore(&ctlr->lock, flags);
-- 
1.9.1
