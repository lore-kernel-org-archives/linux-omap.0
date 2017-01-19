From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 1/5] net: ethernet: ti: cpsw: remove dual check from common res usage function
Date: Thu, 19 Jan 2017 18:58:23 +0200
Message-ID: <1484845107-30331-2-git-send-email-ivan.khoronzhuk@linaro.org>
References: <1484845107-30331-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1484845107-30331-1-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Common res usage is possible only in case an interface is
running. In case of not dual emac here can be only one interface,
so while ndo_open and switch mode, only one interface can be opened,
thus if open is called no any interface is running ... and no common
res are used. So remove check on dual emac, it will simplify
code/understanding and will match the name it's called.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 02b03ee..296ddf2 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1240,9 +1240,6 @@ static int cpsw_common_res_usage_state(struct cpsw_common *cpsw)
 	u32 i;
 	u32 usage_count = 0;
 
-	if (!cpsw->data.dual_emac)
-		return 0;
-
 	for (i = 0; i < cpsw->data.slaves; i++)
 		if (cpsw->slaves[i].open_stat)
 			usage_count++;
-- 
2.7.4
