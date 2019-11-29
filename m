From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2] net: ethernet: ti: ale: ensure vlan/mdb deleted when no members
Date: Fri, 29 Nov 2019 19:58:09 +0200
Message-ID: <20191129175809.815-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The recently updated ALE APIs cpsw_ale_del_mcast() and
cpsw_ale_del_vlan_modify() have an issue and will not delete ALE entry even
if VLAN/mcast group has no more members. Hence fix it here and delete ALE
entry if !port_mask.

The issue affected only new cpsw switchdev driver.

Fixes: e85c14370783 ("net: ethernet: ti: ale: modify vlan/mdb api for switchdev")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 929f3d3354e3..ecdbde539eb7 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -384,7 +384,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
-	int mcast_members;
+	int mcast_members = 0;
 	int idx;
 
 	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
@@ -397,11 +397,13 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		mcast_members = cpsw_ale_get_port_mask(ale_entry,
 						       ale->port_mask_bits);
 		mcast_members &= ~port_mask;
+	}
+
+	if (mcast_members)
 		cpsw_ale_set_port_mask(ale_entry, mcast_members,
 				       ale->port_mask_bits);
-	} else {
+	else
 		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
-	}
 
 	cpsw_ale_write(ale, idx, ale_entry);
 	return 0;
@@ -478,6 +480,10 @@ static void cpsw_ale_del_vlan_modify(struct cpsw_ale *ale, u32 *ale_entry,
 	members = cpsw_ale_get_vlan_member_list(ale_entry,
 						ale->vlan_field_bits);
 	members &= ~port_mask;
+	if (!members) {
+		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
+		return;
+	}
 
 	untag = cpsw_ale_get_vlan_untag_force(ale_entry,
 					      ale->vlan_field_bits);
-- 
2.17.1
