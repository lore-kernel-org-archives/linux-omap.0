From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 2/4] net: ethernet: ti: cpts: purge staled skbs from txq
Date: Mon, 12 Nov 2018 16:00:21 +0200
Message-ID: <20181112140023.12407-3-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The overflow event is running with 1 jiffy in case if txq is not
empty, but it can be emptied completely only if next tx event
consumes skb or deletes staled skb from the txq. In case of staled
skb, that can happen for some unpredictable reason (the ts event was
lost or timed out), the overflow event can be generated quite long
time consuming CPU w/o reason before next tx event happens. To avoid
it, purge txq before increasing overflow event rate.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpts.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index dac4c528a1ff..63232b35024e 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -86,6 +86,25 @@ static int cpts_purge_events(struct cpts *cpts)
 	return removed ? 0 : -1;
 }
 
+static void cpts_purge_txq(struct cpts *cpts)
+{
+	struct cpts_skb_cb_data *skb_cb;
+	struct sk_buff *skb, *tmp;
+	int removed = 0;
+
+	skb_queue_walk_safe(&cpts->txq, skb, tmp) {
+		skb_cb = (struct cpts_skb_cb_data *)skb->cb;
+		if (time_after(jiffies, skb_cb->tmo)) {
+			__skb_unlink(skb, &cpts->txq);
+			dev_consume_skb_any(skb);
+			++removed;
+		}
+	}
+
+	if (removed)
+		dev_dbg(cpts->dev, "txq cleaned up %d\n", removed);
+}
+
 static bool cpts_match_tx_ts(struct cpts *cpts, struct cpts_event *event)
 {
 	struct sk_buff *skb, *tmp;
@@ -292,8 +311,11 @@ static long cpts_overflow_check(struct ptp_clock_info *ptp)
 	spin_lock_irqsave(&cpts->lock, flags);
 	ts = ns_to_timespec64(timecounter_read(&cpts->tc));
 
-	if (!skb_queue_empty(&cpts->txq))
-		delay = CPTS_SKB_TX_WORK_TIMEOUT;
+	if (!skb_queue_empty(&cpts->txq)) {
+		cpts_purge_txq(cpts);
+		if (!skb_queue_empty(&cpts->txq))
+			delay = CPTS_SKB_TX_WORK_TIMEOUT;
+	}
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
 	pr_debug("cpts overflow check at %lld.%09ld\n",
-- 
2.17.1
