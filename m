From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 09/19] net: ethernet: ti: ale: fix mcast super setting
Date: Tue, 23 Apr 2019 16:09:00 +0300
Message-ID: <1556024950-20752-10-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Use correct define ALE_SUPER for ALE Multicast Address Table Entry
Supervisory Packet (SUPER) bit setting instead of ALE_BLOCKED. No issues
were observed till now as it have never been set, but it's going to be used
by new CPSW switch driver.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 3ef5257c9bc7..7ac0c5ae0c92 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -355,7 +355,7 @@ int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 	cpsw_ale_set_vlan_entry_type(ale_entry, flags, vid);
 
 	cpsw_ale_set_addr(ale_entry, addr);
-	cpsw_ale_set_super(ale_entry, (flags & ALE_BLOCKED) ? 1 : 0);
+	cpsw_ale_set_super(ale_entry, (flags & ALE_SUPER) ? 1 : 0);
 	cpsw_ale_set_mcast_state(ale_entry, mcast_state);
 
 	mask = cpsw_ale_get_port_mask(ale_entry,
-- 
2.17.1
