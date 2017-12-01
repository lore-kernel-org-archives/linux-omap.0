From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 07/11] net: ethernet: ti: ale: disable ale from stop()
Date: Thu, 30 Nov 2017 18:21:16 -0600
Message-ID: <20171201002120.13483-8-grygorii.strashko@ti.com>
References: <20171201002120.13483-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201002120.13483-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

ALE is enabled from cpsw_ale_start() now, but disabled only from
cpsw_ale_destroy() which introduces inconsitance as cpsw_ale_start() is
called when netif[s] is opened, but cpsw_ale_destroy() is called when
driver is removed. Hence, move ALE disabling in cpsw_ale_stop().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index fca5c29..5eaaf88 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -870,6 +870,7 @@ EXPORT_SYMBOL_GPL(cpsw_ale_start);
 void cpsw_ale_stop(struct cpsw_ale *ale)
 {
 	del_timer_sync(&ale->timer);
+	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_stop);
 
@@ -892,7 +893,6 @@ int cpsw_ale_destroy(struct cpsw_ale *ale)
 {
 	if (!ale)
 		return -EINVAL;
-	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
 	kfree(ale);
 	return 0;
 }
-- 
2.10.5
