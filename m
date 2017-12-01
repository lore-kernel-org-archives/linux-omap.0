From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 11/11] net: ethernet: ti: ale: fix port check in cpsw_ale_control_set/get
Date: Thu, 30 Nov 2017 18:21:20 -0600
Message-ID: <20171201002120.13483-12-grygorii.strashko@ti.com>
References: <20171201002120.13483-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201002120.13483-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

ALE ports number includes the Host port and ext Ports, and
ALE ports numbering starts from 0, so correct corresponding port
checks in cpsw_ale_control_set/get().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index e513248..93dc05c 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -723,7 +723,7 @@ int cpsw_ale_control_set(struct cpsw_ale *ale, int port, int control,
 	if (info->port_offset == 0 && info->port_shift == 0)
 		port = 0; /* global, port is a dont care */
 
-	if (port < 0 || port > ale->params.ale_ports)
+	if (port < 0 || port >= ale->params.ale_ports)
 		return -EINVAL;
 
 	mask = BITMASK(info->bits);
@@ -754,7 +754,7 @@ int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control)
 	if (info->port_offset == 0 && info->port_shift == 0)
 		port = 0; /* global, port is a dont care */
 
-	if (port < 0 || port > ale->params.ale_ports)
+	if (port < 0 || port >= ale->params.ale_ports)
 		return -EINVAL;
 
 	offset = info->offset + (port * info->port_offset);
-- 
2.10.5
