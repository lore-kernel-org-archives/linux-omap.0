From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 05/11] net: ethernet: ti: cpsw: fix ale port numbers
Date: Thu, 30 Nov 2017 18:21:14 -0600
Message-ID: <20171201002120.13483-6-grygorii.strashko@ti.com>
References: <20171201002120.13483-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201002120.13483-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

TI OMAP/Sitara SoCs have fixed number of ALE ports 3, which includes Host
port also.

Hence, use fixed value instead of value calcualted from DT, which can be
set by user and might not reflect actual HW configuration.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 2bf0bda..64bdd92 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -88,6 +88,7 @@ do {								\
 #define CPSW_VERSION_4		0x190112
 
 #define HOST_PORT_NUM		0
+#define CPSW_ALE_PORTS_NUM	3
 #define SLIVER_SIZE		0x40
 
 #define CPSW1_HOST_PORT_OFFSET	0x028
@@ -3074,7 +3075,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	ale_params.dev			= &pdev->dev;
 	ale_params.ale_ageout		= ale_ageout;
 	ale_params.ale_entries		= data->ale_entries;
-	ale_params.ale_ports		= data->slaves;
+	ale_params.ale_ports		= CPSW_ALE_PORTS_NUM;
 
 	cpsw->ale = cpsw_ale_create(&ale_params);
 	if (!cpsw->ale) {
-- 
2.10.5
