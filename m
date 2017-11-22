From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 01/11] net: ethernet: ti: cpsw: drop unused var poll from cpsw_update_channels_res
Date: Wed, 22 Nov 2017 15:25:47 -0600
Message-ID: <20171122212557.9998-2-grygorii.strashko@ti.com>
References: <20171122212557.9998-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122212557.9998-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Drop unused variable "poll" from cpsw_update_channels_res().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 0c7c7a1..9235b9e 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2300,7 +2300,6 @@ static int cpsw_check_ch_settings(struct cpsw_common *cpsw,
 
 static int cpsw_update_channels_res(struct cpsw_priv *priv, int ch_num, int rx)
 {
-	int (*poll)(struct napi_struct *, int);
 	struct cpsw_common *cpsw = priv->cpsw;
 	void (*handler)(void *, int, int);
 	struct netdev_queue *queue;
@@ -2311,12 +2310,10 @@ static int cpsw_update_channels_res(struct cpsw_priv *priv, int ch_num, int rx)
 		ch = &cpsw->rx_ch_num;
 		vec = cpsw->rxv;
 		handler = cpsw_rx_handler;
-		poll = cpsw_rx_poll;
 	} else {
 		ch = &cpsw->tx_ch_num;
 		vec = cpsw->txv;
 		handler = cpsw_tx_handler;
-		poll = cpsw_tx_poll;
 	}
 
 	while (*ch < ch_num) {
-- 
2.10.5
