From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 10/20] net: ethernet: ti: ale: use define for host port in cpsw_ale_set_allmulti()
Date: Fri, 26 Apr 2019 20:12:32 +0300
Message-ID: <1556298762-8632-11-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Use ALE_PORT_HOST define for host port in cpsw_ale_set_allmulti() instead
of constants.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 17c59fa2561d..67dc769441ce 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -491,9 +491,9 @@ void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
 			cpsw_ale_get_vlan_unreg_mcast(ale_entry,
 						      ale->vlan_field_bits);
 		if (allmulti)
-			unreg_mcast |= 1;
+			unreg_mcast |= ALE_PORT_HOST;
 		else
-			unreg_mcast &= ~1;
+			unreg_mcast &= ~ALE_PORT_HOST;
 		cpsw_ale_set_vlan_unreg_mcast(ale_entry, unreg_mcast,
 					      ale->vlan_field_bits);
 		cpsw_ale_write(ale, idx, ale_entry);
-- 
2.17.1
