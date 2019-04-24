From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next 11/19] net: ethernet: ti: cpsw: fix allmulti cfg
 in dual_mac mode
Date: Wed, 24 Apr 2019 14:00:19 +0300
Message-ID: <20190424110017.GA4373@khorivan>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 23, 2019 at 04:09:02PM +0300, Grygorii Strashko wrote:
>Now CPSW ALE will set/clean Host port bit in Unregistered Multicast Flood
>Mask (UNREG_MCAST_FLOOD_MASK) for every VLAN without checking if this port
>belongs to VLAN or not when ALLMULTI mode flag is set for nedev. This is
>working in non dual_mac mode, but in dual_mac - it causes
>enabling/disabling ALLMULTI flag for both ports.
>
>Hence fix it by adding additional parameter to cpsw_ale_set_allmulti() to
>specify ALE port number for which ALLMULTI has to be enabled and check if
>port belongs to VLAN before modifying UNREG_MCAST_FLOOD_MASK.
>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
> drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++++++--
> drivers/net/ethernet/ti/cpsw_ale.h |  2 +-
> 3 files changed, 20 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>index fe3d145846d2..c497992f01f7 100644
>--- a/drivers/net/ethernet/ti/cpsw.c
>+++ b/drivers/net/ethernet/ti/cpsw.c
>@@ -793,12 +793,17 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
>
> static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
> {
>-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
>+	struct cpsw_priv *priv = netdev_priv(ndev);
>+	struct cpsw_common *cpsw = priv->cpsw;
>+	int slave_port = -1;
>+
>+	if (cpsw->data.dual_emac)
>+		slave_port = priv->emac_port + 1;
>
> 	if (ndev->flags & IFF_PROMISC) {
> 		/* Enable promiscuous mode */
> 		cpsw_set_promiscious(ndev, true);
>-		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI);
>+		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, slave_port);
> 		return;
> 	} else {
> 		/* Disable promiscuous mode */
>@@ -806,7 +811,8 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
> 	}
>
> 	/* Restore allmulti on vlans if necessary */
>-	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
>+	cpsw_ale_set_allmulti(cpsw->ale,
>+			      ndev->flags & IFF_ALLMULTI, slave_port);
>
> 	/* add/remove mcast address either for real netdev or for vlan */
> 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
>diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>index 83ccb422dddd..f7369982ae33 100644
>--- a/drivers/net/ethernet/ti/cpsw_ale.c
>+++ b/drivers/net/ethernet/ti/cpsw_ale.c
>@@ -468,11 +468,11 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
> 	return 0;
> }
>
>-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
>+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port)
> {
> 	u32 ale_entry[ALE_ENTRY_WORDS];
>-	int type, idx;
> 	int unreg_mcast = 0;
>+	int type, idx;
>
> 	/* Only bother doing the work if the setting is actually changing */
> 	if (ale->allmulti == allmulti)
>@@ -482,10 +482,18 @@ void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
> 	ale->allmulti = allmulti;
Should ale->allmulti be removed? as "set" is per port now.

>
> 	for (idx = 0; idx < ale->params.ale_entries; idx++) {
>+		int vlan_members;
>+
> 		cpsw_ale_read(ale, idx, ale_entry);
> 		type = cpsw_ale_get_entry_type(ale_entry);
> 		if (type != ALE_TYPE_VLAN)
> 			continue;
>+		vlan_members =
>+			cpsw_ale_get_vlan_member_list(ale_entry,
>+						      ale->vlan_field_bits);
>+
>+		if (port != -1 && !(vlan_members & BIT(port)))
>+			continue;
>
> 		unreg_mcast =
> 			cpsw_ale_get_vlan_unreg_mcast(ale_entry,
>diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
>index 4777d626fac8..8a0d25950dc1 100644
>--- a/drivers/net/ethernet/ti/cpsw_ale.h
>+++ b/drivers/net/ethernet/ti/cpsw_ale.h
>@@ -109,7 +109,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
> int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
> 			int reg_mcast, int unreg_mcast);
> int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port);
>-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti);
>+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port);
>
> int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control);
> int cpsw_ale_control_set(struct cpsw_ale *ale, int port,
>-- 
>2.17.1
>

-- 
Regards,
Ivan Khoronzhuk
