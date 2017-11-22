From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 03/11] net: ethernet: ti: cpsw: move platform data struct to .c file
Date: Wed, 22 Nov 2017 15:25:49 -0600
Message-ID: <20171122212557.9998-4-grygorii.strashko@ti.com>
References: <20171122212557.9998-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122212557.9998-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

CPSW platform data struct cpsw_platform_data and struct cpsw_slave_data are
used only incide cpsw.c module, so move these definitions there.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 21 +++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.h | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 955ee68..2c50596 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -352,6 +352,27 @@ struct cpsw_hw_stats {
 	u32	rxdmaoverruns;
 };
 
+struct cpsw_slave_data {
+	struct device_node *phy_node;
+	char		phy_id[MII_BUS_ID_SIZE];
+	int		phy_if;
+	u8		mac_addr[ETH_ALEN];
+	u16		dual_emac_res_vlan;	/* Reserved VLAN for DualEMAC */
+};
+
+struct cpsw_platform_data {
+	struct cpsw_slave_data	*slave_data;
+	u32	ss_reg_ofs;	/* Subsystem control register offset */
+	u32	channels;	/* number of cpdma channels (symmetric) */
+	u32	slaves;		/* number of slave cpgmac ports */
+	u32	active_slave; /* time stamping, ethtool and SIOCGMIIPHY slave */
+	u32	ale_entries;	/* ale table size */
+	u32	bd_ram_size;  /*buffer descriptor ram size */
+	u32	mac_control;	/* Mac control register */
+	u16	default_vlan;	/* Def VLAN for ALE lookup in VLAN aware mode*/
+	bool	dual_emac;	/* Enable Dual EMAC mode */
+};
+
 struct cpsw_slave {
 	void __iomem			*regs;
 	struct cpsw_sliver_regs __iomem	*sliver;
diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index 6c3037a..a325f555 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -17,27 +17,6 @@
 #include <linux/if_ether.h>
 #include <linux/phy.h>
 
-struct cpsw_slave_data {
-	struct device_node *phy_node;
-	char		phy_id[MII_BUS_ID_SIZE];
-	int		phy_if;
-	u8		mac_addr[ETH_ALEN];
-	u16		dual_emac_res_vlan;	/* Reserved VLAN for DualEMAC */
-};
-
-struct cpsw_platform_data {
-	struct cpsw_slave_data	*slave_data;
-	u32	ss_reg_ofs;	/* Subsystem control register offset */
-	u32	channels;	/* number of cpdma channels (symmetric) */
-	u32	slaves;		/* number of slave cpgmac ports */
-	u32	active_slave; /* time stamping, ethtool and SIOCGMIIPHY slave */
-	u32	ale_entries;	/* ale table size */
-	u32	bd_ram_size;  /*buffer descriptor ram size */
-	u32	mac_control;	/* Mac control register */
-	u16	default_vlan;	/* Def VLAN for ALE lookup in VLAN aware mode*/
-	bool	dual_emac;	/* Enable Dual EMAC mode */
-};
-
 void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
 int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr);
 
-- 
2.10.5
