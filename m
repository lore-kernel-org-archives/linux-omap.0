From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 12/19] net: ethernet: ti: ale: do not auto delete mcast super entries
Date: Tue, 23 Apr 2019 16:09:03 +0300
Message-ID: <1556024950-20752-13-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Do not delete multicast supervisory packet's (SUPER) entries while flushing
multicast addresses from ALE table cpsw_ale_flush_multicast(). Those
entries have to be added/removed only explicitly.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index f7369982ae33..d09768368dbd 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -280,6 +280,9 @@ int cpsw_ale_flush_multicast(struct cpsw_ale *ale, int port_mask, int vid)
 		if (cpsw_ale_get_mcast(ale_entry)) {
 			u8 addr[6];
 
+			if (cpsw_ale_get_super(ale_entry))
+				continue;
+
 			cpsw_ale_get_addr(ale_entry, addr);
 			if (!is_broadcast_ether_addr(addr))
 				cpsw_ale_flush_mcast(ale, ale_entry, port_mask);
-- 
2.17.1
