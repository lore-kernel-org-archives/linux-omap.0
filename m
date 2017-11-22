From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 08/11] net: ethernet: ti: ale: optimize ale entry mask bits configuartion
Date: Wed, 22 Nov 2017 15:25:54 -0600
Message-ID: <20171122212557.9998-9-grygorii.strashko@ti.com>
References: <20171122212557.9998-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122212557.9998-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The ale->params.ale_ports parameter can be used to deriver values for all
ale entry mask bits: port_mask_bits, port_mask_bits, port_num_bits.
Hence, calculate above values and drop all hardcoded values. For
port_num_bits calcualtion use order_base_2() API.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 322f87c..34f97c1 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -816,9 +816,9 @@ void cpsw_ale_start(struct cpsw_ale *ale)
 		 "ALE Table size %ld\n", ale->params.ale_entries);
 
 	/* set default bits for existing h/w */
-	ale->port_mask_bits = 3;
-	ale->port_num_bits = 2;
-	ale->vlan_field_bits = 3;
+	ale->port_mask_bits = ale->params.ale_ports;
+	ale->port_num_bits = order_base_2(ale->params.ale_ports);
+	ale->vlan_field_bits = ale->params.ale_ports;
 
 	/* Set defaults override for ALE on NetCP NU switch and for version
 	 * 1R3
@@ -847,13 +847,6 @@ void cpsw_ale_start(struct cpsw_ale *ale)
 		ale_controls[ALE_PORT_UNTAGGED_EGRESS].shift = 0;
 		ale_controls[ALE_PORT_UNTAGGED_EGRESS].offset =
 					ALE_UNKNOWNVLAN_FORCE_UNTAG_EGRESS;
-		ale->port_mask_bits = ale->params.ale_ports;
-		ale->port_num_bits = ale->params.ale_ports - 1;
-		ale->vlan_field_bits = ale->params.ale_ports;
-	} else if (ale->version == ALE_VERSION_1R3) {
-		ale->port_mask_bits = ale->params.ale_ports;
-		ale->port_num_bits = 3;
-		ale->vlan_field_bits = ale->params.ale_ports;
 	}
 
 	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 1);
-- 
2.10.5
