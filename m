From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 166/177] net: ethernet: ti: ale: clean ale tbl on init and intf restart
Date: Tue, 10 Dec 2019 16:32:10 -0500
Message-ID: <20191210213221.11921-166-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 7fe579dfb90fcdf0c7722f33c772d5f0d1bc7cb6 ]

Clean CPSW ALE on init and intf restart (up/down) to avoid reading obsolete
or garbage entries from ALE table.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 5766225a4ce11..c245629a38c76 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -793,6 +793,7 @@ EXPORT_SYMBOL_GPL(cpsw_ale_start);
 void cpsw_ale_stop(struct cpsw_ale *ale)
 {
 	del_timer_sync(&ale->timer);
+	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
 	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_stop);
@@ -877,6 +878,7 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 					ALE_UNKNOWNVLAN_FORCE_UNTAG_EGRESS;
 	}
 
+	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
 	return ale;
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_create);
-- 
2.20.1
