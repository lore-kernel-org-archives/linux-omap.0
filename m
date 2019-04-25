From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH v3 net-next 07/11] net: ethernet: ti: cpsw: introduce
 cpsw switch driver based on switchdev
Date: Fri, 26 Apr 2019 01:44:59 +0200
Message-ID: <20190425234459.GB4041@lunn.ch>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-8-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556144667-27997-8-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>
List-Id: linux-omap@vger.kernel.org

> +#include <linux/of_net.h>
> +#include <linux/of_device.h>
> +#include <linux/if_vlan.h>
> +#include <linux/kmemleak.h>

Interesting

> +
> +static int debug_level;
> +module_param(debug_level, int, 0);
> +MODULE_PARM_DESC(debug_level, "cpsw debug level (NETIF_MSG bits)");

One of my usual moans. Module parameters are bad. You have
.set_msglevel and .get_msglevel so you can probably remove this.

> +static int ale_ageout = CPSW_ALE_AGEOUT_DEFAULT;
> +static int rx_packet_max = CPSW_MAX_PACKET_SIZE;
> +static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
> +
> +struct cpsw_switchdev_event_work {
> +	struct work_struct work;
> +	struct switchdev_notifier_fdb_info fdb_info;
> +	struct cpsw_priv *priv;
> +	unsigned long event;
> +};
> +
> +static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
> +{
> +	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
> +	bool enable_uni = false;
> +	int i;
> +
> +	if (cpsw->br_members)
> +		return;
> +
> +	/* Enabling promiscuous mode for one interface will be
> +	 * common for both the interface as the interface shares
> +	 * the same hardware resource.
> +	 */
> +	for (i = 0; i < cpsw->data.slaves; i++)
> +		if (cpsw->slaves[i].ndev &&
> +		    (cpsw->slaves[i].ndev->flags & IFF_PROMISC))
> +			enable_uni = true;
> +
> +	if (!enable && enable_uni) {
> +		enable = enable_uni;
> +		dev_err(cpsw->dev, "promiscuity not disabled as the other interface is still in promiscuity mode\n");

dev_err seems a bit heavy for this. I don't think a warning is needed
at all. Yes, you receiver more traffic than you would expect, but
linux should just throw it away and there should not be a problem.

> +	}
> +
> +	if (enable) {
> +		/* Enable unknown unicast, reg/unreg mcast */
> +		cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
> +				     ALE_P0_UNI_FLOOD, 1);
> +
> +		dev_dbg(cpsw->dev, "promiscuity enabled\n");
> +	} else {
> +		/* Disable unknown unicast */
> +		cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
> +				     ALE_P0_UNI_FLOOD, 0);
> +		dev_dbg(cpsw->dev, "promiscuity disabled\n");
> +	}
> +}
> +

> +static void cpsw_rx_handler(void *token, int len, int status)
> +{
> +	struct sk_buff *skb = token;
> +	struct cpsw_common *cpsw;
> +	struct net_device *ndev;
> +	struct sk_buff *new_skb;
> +	struct cpsw_priv *priv;
> +	struct cpdma_chan *ch;
> +	int ret = 0, port;
> +
> +	ndev = skb->dev;
> +	cpsw = ndev_to_cpsw(ndev);
> +
> +	port = CPDMA_RX_SOURCE_PORT(status);
> +	if (port) {
> +		ndev = cpsw->slaves[--port].ndev;
> +		skb->dev = ndev;
> +	}
> +
> +	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
> +		/* In dual emac mode check for all interfaces */
> +		if (cpsw->usage_count && status >= 0) {
> +			/* The packet received is for the interface which
> +			 * is already down and the other interface is up
> +			 * and running, instead of freeing which results
> +			 * in reducing of the number of rx descriptor in
> +			 * DMA engine, requeue skb back to cpdma.
> +			 */
> +			new_skb = skb;
> +			goto requeue;
> +		}
> +
> +		/* the interface is going down, skbs are purged */
> +		dev_kfree_skb_any(skb);
> +		return;
> +	}
> +
> +	priv = netdev_priv(ndev);
> +	if (cpsw->br_members)
> +		skb->offload_fwd_mark = 1;
> +
> +	new_skb = netdev_alloc_skb_ip_align(ndev, cpsw->rx_packet_max);
> +	if (new_skb) {
> +		skb_copy_queue_mapping(new_skb, skb);
> +		skb_put(skb, len);
> +		if (status & CPDMA_RX_VLAN_ENCAP)
> +			cpsw_rx_vlan_encap(skb);
> +		if (priv->rx_ts_enabled)
> +			cpts_rx_timestamp(cpsw->cpts, skb);
> +		skb->protocol = eth_type_trans(skb, ndev);
> +		netif_receive_skb(skb);
> +		ndev->stats.rx_bytes += len;
> +		ndev->stats.rx_packets++;
> +		kmemleak_not_leak(new_skb);

It would be good to add some comments here. Maybe new_skb is not the
best of names? If i understand correctly, it is a buffer that will
refill the slot in the DMA channel made by the packet just received?
But this code looks complicated because you are maxing refill with
received packet processing. It might be more readable if you could
separate these two out.

And cpsw is the only network driver which uses
kmemleak_not_leak(new_skb). Since it is unique, it would be good to
comment why it is needed.

> +	} else {
> +		ndev->stats.rx_dropped++;
> +		new_skb = skb;
> +	}
> +
> +requeue:
> +	if (netif_dormant(ndev)) {
> +		dev_kfree_skb_any(new_skb);
> +		return;
> +	}
> +
> +	ch = cpsw->rxv[skb_get_queue_mapping(new_skb)].ch;
> +	ret = cpdma_chan_submit(ch, new_skb, new_skb->data,
> +				skb_tailroom(new_skb), 0);
> +	if (WARN_ON(ret < 0))
> +		dev_kfree_skb_any(new_skb);
> +}
> +

> +static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
> +				    __be16 proto, u16 vid)
> +{
> +	struct cpsw_priv *priv = netdev_priv(ndev);
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	int ret, i;
> +
> +	if (cpsw->bridge_mask)
> +		dev_warn(cpsw->dev, ".ndo_vlan_rx_add_vid called in switch mode\n");
> +
> +	if (vid == cpsw->data.default_vlan)
> +		return 0;
> +
> +	ret = pm_runtime_get_sync(cpsw->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(cpsw->dev);
> +		return ret;
> +	}
> +
> +	/* In dual EMAC, reserved VLAN id should not be used for
> +	 * creating VLAN interfaces as this can break the dual
> +	 * EMAC port separation
> +	 */
> +	if (!cpsw->br_members)
> +		for (i = 0; i < cpsw->data.slaves; i++) {
> +			if (cpsw->slaves[i].ndev &&
> +			    vid == cpsw->slaves[i].port_vlan) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +		}
> +
> +	dev_info(priv->dev, "Adding vlanid %d to vlan filter\n", vid);

dev_dbg?

> +	ret = cpsw_add_vlan_ale_entry(priv, vid);
> +err:
> +	pm_runtime_put(cpsw->dev);
> +	return ret;
> +}
> +
> +static void cpsw_init_stp_ale_entry(struct cpsw_common *cpsw)
> +{
> +	char stpa[] = {0x01, 0x80, 0xc2, 0x0, 0x0, 0x0};

It seems like there should be a global for this. How are BDPU built?

> +
> +	cpsw_ale_add_mcast(cpsw->ale, stpa,
> +			   ALE_PORT_HOST, ALE_SUPER, 0,
> +			   ALE_MCAST_BLOCK_LEARN_FWD);
> +}
> +
> +static void cpsw_adjust_link(struct net_device *ndev)
> +{
> +	struct cpsw_priv *priv = netdev_priv(ndev);
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	struct cpsw_slave *slave;
> +	struct phy_device *phy;
> +	bool link = false;
> +	u32 mac_control = 0;
> +
> +	slave = &cpsw->slaves[priv->emac_port - 1];
> +	phy = slave->phy;

Hurray, a phydev per port, not the odd things the old driver does :-)


> +
> +	if (!phy)
> +		return;
> +
> +	if (phy->link) {
> +		mac_control = CPSW_SL_CTL_GMII_EN;
> +
> +		if (phy->speed == 1000)
> +			mac_control |= CPSW_SL_CTL_GIG;
> +		if (phy->duplex)
> +			mac_control |= CPSW_SL_CTL_FULLDUPLEX;
> +
> +		/* set speed_in input in case RMII mode is used in 100Mbps */
> +		if (phy->speed == 100)
> +			mac_control |= CPSW_SL_CTL_IFCTL_A;
> +		/* in band mode only works in 10Mbps RGMII mode */
> +		else if ((phy->speed == 10) && phy_interface_is_rgmii(phy))
> +			mac_control |= CPSW_SL_CTL_EXT_EN; /* In Band mode */
> +
> +		if (priv->rx_pause)
> +			mac_control |= CPSW_SL_CTL_RX_FLOW_EN;
> +
> +		if (priv->tx_pause)
> +			mac_control |= CPSW_SL_CTL_TX_FLOW_EN;
> +
> +		if (mac_control != slave->mac_control)
> +			cpsw_sl_ctl_set(slave->mac_sl, mac_control);
> +
> +		/* enable forwarding */
> +		cpsw_ale_control_set(cpsw->ale, priv->emac_port,
> +				     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
> +
> +		link = true;
> +
> +		/* TODO:
> +		 * if (priv->shp_cfg_speed &&
> +		 *   priv->shp_cfg_speed != slave->phy->speed &&
> +		 *   !cpsw_shp_is_off(priv))
> +		 *	dev_warn(priv->dev,
> +		 *	 "Speed was changed, CBS shaper speeds are changed!");
> +		 */
> +	} else {
> +		mac_control = 0;
> +		/* disable forwarding */
> +		cpsw_ale_control_set(cpsw->ale, priv->emac_port,
> +				     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
> +
> +		cpsw_sl_wait_for_idle(slave->mac_sl, 100);
> +
> +		cpsw_sl_ctl_reset(slave->mac_sl);
> +	}
> +
> +	if (mac_control != slave->mac_control)
> +		phy_print_status(phy);
> +
> +	slave->mac_control = mac_control;
> +
> +	if (link) {

Why not phy->link?

> +		if (cpsw_need_resplit(cpsw))
> +			cpsw_split_res(cpsw);
> +
> +		if (netif_running(ndev))
> +			netif_tx_wake_all_queues(ndev);
> +	} else {
> +		netif_tx_stop_all_queues(ndev);
> +	}

netif_tx_stop_all_queues() and netif_tx_wake_all_queues() are pretty
unusual in adjust_link(). In fact, i don't remember seeing them used
here. It would be good to comment why they are needed.

> +}
> +
> +static int cpsw_set_pauseparam(struct net_device *ndev,
> +			       struct ethtool_pauseparam *pause)
> +{
> +	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
> +	struct cpsw_priv *priv = netdev_priv(ndev);
> +
> +	priv->rx_pause = pause->rx_pause ? true : false;
> +	priv->tx_pause = pause->tx_pause ? true : false;
> +
> +	return phy_restart_aneg(cpsw->slaves[priv->emac_port - 1].phy);

This looks wrong. You need to tell the PHY about the new pause
settings before restarting.

> +}
> +
> +static int cpsw_probe_dt(struct cpsw_common *cpsw)
> +{
> +	struct device_node *node = cpsw->dev->of_node, *tmp_node, *port_np;
> +	struct cpsw_platform_data *data = &cpsw->data;
> +	struct device *dev = cpsw->dev;
> +	int ret;
> +	u32 prop;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	tmp_node = of_get_child_by_name(node, "ports");
> +	if (!tmp_node)
> +		return -ENOENT;
> +	data->slaves = of_get_child_count(tmp_node);
> +	if (data->slaves < CPSW_SLAVE_PORTS_NUM)
> +		return -ENOENT;

So it is O.K. to have more than CPSW_SLAVE_PORTS_NUM slaves?

> +	of_node_put(tmp_node);
> +
> +	data->active_slave = 0;
> +	data->channels = CPSW_MAX_QUEUES;
> +	data->ale_entries = CPSW_ALE_NUM_ENTRIES;
> +	data->dual_emac = 1;
> +	data->bd_ram_size = CPSW_BD_RAM_SIZE;
> +	data->mac_control = 0;
> +
> +	data->slave_data = devm_kcalloc(dev, CPSW_SLAVE_PORTS_NUM,
> +					sizeof(struct cpsw_slave_data),
> +					GFP_KERNEL);
> +	if (!data->slave_data)
> +		return -ENOMEM;
> +
> +	/* Populate all the child nodes here...
> +	 */
> +	ret = devm_of_platform_populate(dev);
> +	/* We do not want to force this, as in some cases may not have child */
> +	if (ret)
> +		dev_warn(dev, "Doesn't have any child node\n");
> +
> +	tmp_node = of_get_child_by_name(node, "ports");

You have done this once before? Why do it again?

> +	if (!tmp_node)
> +		return -ENOENT;
> +

> +static int cpsw_create_ports(struct cpsw_common *cpsw)
> +{
> +	struct cpsw_platform_data *data = &cpsw->data;
> +	struct device *dev = cpsw->dev;
> +	struct net_device *ndev, *napi_ndev = NULL;
> +	struct cpsw_priv *priv;
> +	int ret = 0, i = 0;
> +
> +	for (i = 0; i < cpsw->data.slaves; i++) {
> +		struct cpsw_slave_data *slave_data = &data->slave_data[i];
> +
> +		if (slave_data->disabled)
> +			continue;
> +
> +		ndev = devm_alloc_etherdev_mqs(dev, sizeof(struct cpsw_priv),
> +					       CPSW_MAX_QUEUES,
> +					       CPSW_MAX_QUEUES);
> +		if (!ndev) {
> +			dev_err(dev, "error allocating net_device\n");
> +			return -ENOMEM;
> +		}
> +
> +		priv = netdev_priv(ndev);
> +		priv->cpsw = cpsw;
> +		priv->ndev = ndev;
> +		priv->dev  = dev;
> +		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
> +		priv->emac_port = i + 1;
> +
> +		if (is_valid_ether_addr(slave_data->mac_addr)) {
> +			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
> +			dev_info(cpsw->dev, "cpsw: Detected MACID = %pM\n",
> +				 priv->mac_addr);
> +		} else {
> +			eth_random_addr(slave_data->mac_addr);
> +			dev_info(cpsw->dev, "cpsw: Random MACID = %pM\n",
> +				 priv->mac_addr);
> +		}
> +		ether_addr_copy(ndev->dev_addr, slave_data->mac_addr);
> +		ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
> +
> +		cpsw->slaves[i].ndev = ndev;
> +
> +		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
> +				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_NETNS_LOCAL;
> +
> +		ndev->netdev_ops = &cpsw_netdev_ops;
> +		ndev->ethtool_ops = &cpsw_ethtool_ops;
> +		SET_NETDEV_DEV(ndev, dev);
> +
> +		if (!napi_ndev) {
> +			netif_napi_add(ndev, &cpsw->napi_rx,
> +				       cpsw->quirk_irq ?
> +				       cpsw_rx_poll : cpsw_rx_mq_poll,
> +				       CPSW_POLL_WEIGHT);
> +			netif_tx_napi_add(ndev, &cpsw->napi_tx,
> +					  cpsw->quirk_irq ?
> +					  cpsw_tx_poll : cpsw_tx_mq_poll,
> +					  CPSW_POLL_WEIGHT);
> +		}

I don't know much about NAPI. Does this mean the two slaves are
sharing one NAPI instance?

> +
> +		/* register the network device */
> +		ret = register_netdev(ndev);
> +		if (ret) {
> +			dev_err(dev, "cpsw: err registering net device%d\n", i);
> +			cpsw->slaves[i].ndev = NULL;
> +			return ret;
> +		}
> +		napi_ndev = ndev;
> +	}
> +
> +	return ret;
> +}

  Andrew
