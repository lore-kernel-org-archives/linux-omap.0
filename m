From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpdma: rate is not changed - correct case
Date: Wed,  6 Dec 2017 16:41:18 +0200
Message-ID: <1512571278-13196-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

If rate is the same as set it's correct case.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net-next/master

 drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index e4d6edf..dbe9167 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -841,7 +841,7 @@ int cpdma_chan_set_rate(struct cpdma_chan *ch, u32 rate)
 		return -EINVAL;
 
 	if (ch->rate == rate)
-		return rate;
+		return 0;
 
 	ctlr = ch->ctlr;
 	spin_lock_irqsave(&ctlr->lock, flags);
-- 
2.7.4
