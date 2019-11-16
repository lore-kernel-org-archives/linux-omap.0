From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 066/150] net: ethernet: ti: cpsw: unsync mcast entries while switch promisc mode
Date: Sat, 16 Nov 2019 10:46:04 -0500
Message-ID: <20191116154729.9573-66-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

[ Upstream commit 9737cc99dd14b5b8b9d267618a6061feade8ea68 ]

After flushing all mcast entries from the table, the ones contained in
mc list of ndev are not restored when promisc mode is toggled off,
because they are considered as synched with ALE, thus, in order to
restore them after promisc mode - reset syncing info. This fix
touches only switch mode devices, including single port boards
like Beagle Bone.

Fixes: commit 5da1948969bc
("net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 8cb44eabc2835..a44838aac97de 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -601,6 +601,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 
 			/* Clear all mcast from ALE */
 			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
+			__dev_mc_unsync(ndev, NULL);
 
 			/* Flood All Unicast Packets to Host port */
 			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
-- 
2.20.1
