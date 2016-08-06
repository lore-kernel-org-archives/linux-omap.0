From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 03/14] net: ethernet: ti: cpsw: remove priv from cpsw_get_slave_port() parameters list
Date: Sat,  6 Aug 2016 13:48:33 +0300
Message-ID: <1470480524-6851-4-git-send-email-ivan.khoronzhuk@linaro.org>
References: <1470480524-6851-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1470480524-6851-1-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, mugunthanvnm@ti.com, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dlide@ti.com, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

There is no need in priv here.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 85ee9f5..30e1ddb 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -525,7 +525,7 @@ static const struct cpsw_stats cpsw_gstrings_stats[] = {
 		if (priv->data.dual_emac) {				\
 			struct cpsw_slave *slave = priv->slaves +	\
 						priv->emac_port;	\
-			int slave_port = cpsw_get_slave_port(priv,	\
+			int slave_port = cpsw_get_slave_port(		\
 						slave->slave_num);	\
 			cpsw_ale_add_mcast(priv->ale, addr,		\
 				1 << slave_port | ALE_PORT_HOST,	\
@@ -537,7 +537,7 @@ static const struct cpsw_stats cpsw_gstrings_stats[] = {
 		}							\
 	} while (0)
 
-static inline int cpsw_get_slave_port(struct cpsw_priv *priv, u32 slave_num)
+static inline int cpsw_get_slave_port(u32 slave_num)
 {
 	return slave_num + 1;
 }
@@ -849,7 +849,7 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 	if (!phy)
 		return;
 
-	slave_port = cpsw_get_slave_port(priv, slave->slave_num);
+	slave_port = cpsw_get_slave_port(slave->slave_num);
 
 	if (phy->link) {
 		mac_control = priv->data.mac_control;
@@ -1120,7 +1120,7 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 
 	slave->mac_control = 0;	/* no link yet */
 
-	slave_port = cpsw_get_slave_port(priv, slave->slave_num);
+	slave_port = cpsw_get_slave_port(slave->slave_num);
 
 	if (priv->data.dual_emac)
 		cpsw_add_dual_emac_def_ale_entries(priv, slave, slave_port);
@@ -1222,7 +1222,7 @@ static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_priv *priv)
 {
 	u32 slave_port;
 
-	slave_port = cpsw_get_slave_port(priv, slave->slave_num);
+	slave_port = cpsw_get_slave_port(slave->slave_num);
 
 	if (!slave->phy)
 		return;
-- 
1.9.1
