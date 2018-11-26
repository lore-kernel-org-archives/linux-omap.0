From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0
 configuration in dual_mac modey
Date: Mon, 26 Nov 2018 18:26:47 +0200
Message-ID: <20181126162644.GA23230@khorivan>
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181125234626.28474-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>dual mac mode wich are used to configure pvids for each external ports.
>But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>ext. ports. As result, it's imposible to use priority tagged packets in
>dual mac mode.
>
>Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>mac mode functionality and, this way, make it possible to use priority
>tagged packet in dual mac mode.
So, now it's enabled to be added via regular ndo.
I have similar change in mind, but was going to send it after
mcast/ucast, and - enabling same vlans patch...

2 things stopped me to add this:

1) Moving it to be enabled via regular call is Ok, but in dual mac mode
it causes overlaps, at least while vid deletion. So decided to wait till
same vlans series is applied.

2) Wanted implement somehow similar handling for single port boards
in one patch, not only for dual mac mode. This part was not clear and
not verified completely...

So, if it's needed now, maybe better at this moment only remove
untag field? and remove vlan0 later, once other vlan changes applied.

Say:

cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
		  ALE_ALL_PORTS, 0, ALE_ALL_PORTS, 0);

instead of:
cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
		  ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);

>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> drivers/net/ethernet/ti/cpsw.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>index 15d563c..4f3a159 100644
>--- a/drivers/net/ethernet/ti/cpsw.c
>+++ b/drivers/net/ethernet/ti/cpsw.c
>@@ -2036,9 +2036,6 @@ static int cpsw_ndo_open(struct net_device *ndev)
> 	/* Add default VLAN */
> 	if (!cpsw->data.dual_emac)
> 		cpsw_add_default_vlan(priv);
>-	else
>-		cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>-				  ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
>
> 	/* initialize shared resources for every ndev */
> 	if (!cpsw->usage_count) {
>@@ -2490,7 +2487,7 @@ static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
> 	struct cpsw_common *cpsw = priv->cpsw;
> 	int ret;
>
>-	if (vid == cpsw->data.default_vlan)
>+	if (!cpsw->data.dual_emac && vid == cpsw->data.default_vlan)
> 		return 0;
>
> 	ret = pm_runtime_get_sync(cpsw->dev);
>@@ -2528,7 +2525,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
> 	struct cpsw_common *cpsw = priv->cpsw;
> 	int ret;
>
>-	if (vid == cpsw->data.default_vlan)
>+	if (!cpsw->data.dual_emac && vid == cpsw->data.default_vlan)
> 		return 0;
>
> 	ret = pm_runtime_get_sync(cpsw->dev);
>-- 
>2.10.5
>

-- 
Regards,
Ivan Khoronzhuk
