From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 1/4] net: ethernet: ti: cpts: correct debug for expired txq skb
Date: Mon, 12 Nov 2018 16:00:20 +0200
Message-ID: <20181112140023.12407-2-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The msgtype and seqid that is smth that belongs to event for
comparison but not for staled txq skb.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index b96b93c686bf..dac4c528a1ff 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -119,9 +119,7 @@ static bool cpts_match_tx_ts(struct cpts *cpts, struct cpts_event *event)
 
 		if (time_after(jiffies, skb_cb->tmo)) {
 			/* timeout any expired skbs over 1s */
-			dev_dbg(cpts->dev,
-				"expiring tx timestamp mtype %u seqid %04x\n",
-				mtype, seqid);
+			dev_dbg(cpts->dev, "expiring tx timestamp from txq\n");
 			__skb_unlink(skb, &cpts->txq);
 			dev_consume_skb_any(skb);
 		}
-- 
2.17.1
