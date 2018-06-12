From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next 4/6] net: ethernet: ti: cpsw: add CBS Qdisc
 offload
Date: Tue, 12 Jun 2018 13:18:56 +0300
Message-ID: <20180612101856.GA29936@apalos>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-5-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611133047.4818-5-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, vinicius.gomes@intel.com, henrik@austad.us, jesus.sanchez-palencia@intel.com, p-varis@ti.com, spatton@ti.com, francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 11, 2018 at 04:30:45PM +0300, Ivan Khoronzhuk wrote:
> The cpsw has up to 4 FIFOs per port and upper 3 FIFOs can feed rate
> limited queue with shaping. In order to set and enable shaping for
> those 3 FIFOs queues the network device with CBS qdisc attached is
> needed. The CBS configuration is added for dual-emac/single port mode
> only, but potentially can be used in switch mode also, based on
> switchdev for instance.
> 
> Despite the FIFO shapers can work w/o cpdma level shapers the base
> usage must be in combine with cpdma level shapers as described in TRM,
> that are set as maximum rates for interface queues with sysfs.
> 
> One of the possible configuration with txq shapers and CBS shapers:
> 
>                       Configured with echo RATE >
>                   /sys/class/net/eth0/queues/tx-0/tx_maxrate
>              /---------------------------------------------------
>             /
>            /            cpdma level shapers
>         +----+ +----+ +----+ +----+ +----+ +----+ +----+ +----+
>         | c7 | | c6 | | c5 | | c4 | | c3 | | c2 | | c1 | | c0 |
>         \    / \    / \    / \    / \    / \    / \    / \    /
>          \  /   \  /   \  /   \  /   \  /   \  /   \  /   \  /
>           \/     \/     \/     \/     \/     \/     \/     \/
> +---------|------|------|------|-------------------------------------+
> |    +----+      |      |  +---+                                     |
> |    |      +----+      |  |                                         |
> |    v      v           v  v                                         |
> | +----+ +----+ +----+ +----+ p        p+----+ +----+ +----+ +----+  |
> | |    | |    | |    | |    | o        o|    | |    | |    | |    |  |
> | | f3 | | f2 | | f1 | | f0 | r  CPSW  r| f3 | | f2 | | f1 | | f0 |  |
> | |    | |    | |    | |    | t        t|    | |    | |    | |    |  |
> | \    / \    / \    / \    / 0        1\    / \    / \    / \    /  |
> |  \  X   \  /   \  /   \  /             \  /   \  /   \  /   \  /   |
> |   \/ \   \/     \/     \/               \/     \/     \/     \/    |
> +-------\------------------------------------------------------------+
>          \
>           \ FIFO shaper, set with CBS offload added in this patch,
>            \ FIFO0 cannot be rate limited
>             ------------------------------------------------------
> 
> CBS shaper configuration is supposed to be used with root MQPRIO Qdisc
> offload allowing to add sk_prio->tc->txq maps that direct traffic to
> appropriate tx queue and maps L2 priority to FIFO shaper.
> 
> The CBS shaper is intended to be used for AVB where L2 priority
> (pcp field) is used to differentiate class of traffic. So additionally
> vlan needs to be created with appropriate egress sk_prio->l2 prio map.
> 
> If CBS has several tx queues assigned to it, the sum of their
> bandwidth has not overlap bandwidth set for CBS. It's recomended the
> CBS bandwidth to be a little bit more.
> 
> The CBS shaper is configured with CBS qdisc offload interface using tc
> tool from iproute2 packet.
> 
> For instance:
> 
> $ tc qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
> map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@1 2@2 hw 1
> 
> $ tc -g class show dev eth0
> +---(100:ffe2) mqprio
> |    +---(100:3) mqprio
> |    +---(100:4) mqprio
> |    
> +---(100:ffe1) mqprio
> |    +---(100:2) mqprio
> |    
> +---(100:ffe0) mqprio
>      +---(100:1) mqprio
> 
> $ tc qdisc add dev eth0 parent 100:1 cbs locredit -1440 \
> hicredit 60 sendslope -960000 idleslope 40000 offload 1
> 
> $ tc qdisc add dev eth0 parent 100:2 cbs locredit -1470 \
> hicredit 62 sendslope -980000 idleslope 20000 offload 1
> 
> The above code set CBS shapers for tc0 and tc1, for that txq0 and
> txq1 is used. Pay attention, the real set bandwidth can differ a bit
> due to discreteness of configuration parameters.
> 
> Here parameters like locredit, hicredit and sendslope are ignored
> internally and are supposed to be set with assumption that maximum
> frame size for frame - 1500.
> 
> It's supposed that interface speed is not changed while reconnection,
> not always is true, so inform user in case speed of interface was
> changed, as it can impact on dependent shapers configuration.
> 
> For more examples see Documentation.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 221 +++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index fd967d2bce5d..87a5586c5ea5 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -46,6 +46,8 @@
>  #include "cpts.h"
>  #include "davinci_cpdma.h"
>  
> +#include <net/pkt_sched.h>
> +
>  #define CPSW_DEBUG	(NETIF_MSG_HW		| NETIF_MSG_WOL		| \
>  			 NETIF_MSG_DRV		| NETIF_MSG_LINK	| \
>  			 NETIF_MSG_IFUP		| NETIF_MSG_INTR	| \
> @@ -154,8 +156,12 @@ do {								\
>  #define IRQ_NUM			2
>  #define CPSW_MAX_QUEUES		8
>  #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
> +#define CPSW_FIFO_QUEUE_TYPE_SHIFT	16
> +#define CPSW_FIFO_SHAPE_EN_SHIFT	16
> +#define CPSW_FIFO_RATE_EN_SHIFT		20
>  #define CPSW_TC_NUM			4
>  #define CPSW_FIFO_SHAPERS_NUM		(CPSW_TC_NUM - 1)
> +#define CPSW_PCT_MASK			0x7f
>  
>  #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
>  #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
> @@ -457,6 +463,8 @@ struct cpsw_priv {
>  	bool				rx_pause;
>  	bool				tx_pause;
>  	bool				mqprio_hw;
> +	int				fifo_bw[CPSW_TC_NUM];
> +	int				shp_cfg_speed;
>  	u32 emac_port;
>  	struct cpsw_common *cpsw;
>  };
> @@ -1081,6 +1089,38 @@ static void cpsw_set_slave_mac(struct cpsw_slave *slave,
>  	slave_write(slave, mac_lo(priv->mac_addr), SA_LO);
>  }
>  
> +static bool cpsw_shp_is_off(struct cpsw_priv *priv)
> +{
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	struct cpsw_slave *slave;
> +	u32 shift, mask, val;
> +
> +	val = readl_relaxed(&cpsw->regs->ptype);
> +
> +	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
> +	shift = CPSW_FIFO_SHAPE_EN_SHIFT + 3 * slave->slave_num;
> +	mask = 7 << shift;
> +	val = val & mask;
> +
> +	return !val;
> +}
> +
> +static void cpsw_fifo_shp_on(struct cpsw_priv *priv, int fifo, int on)
> +{
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	struct cpsw_slave *slave;
> +	u32 shift, mask, val;
> +
> +	val = readl_relaxed(&cpsw->regs->ptype);
> +
> +	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
> +	shift = CPSW_FIFO_SHAPE_EN_SHIFT + 3 * slave->slave_num;
> +	mask = (1 << --fifo) << shift;
> +	val = on ? val | mask : val & ~mask;
> +
> +	writel_relaxed(val, &cpsw->regs->ptype);
> +}
> +
>  static void _cpsw_adjust_link(struct cpsw_slave *slave,
>  			      struct cpsw_priv *priv, bool *link)
>  {
> @@ -1120,6 +1160,12 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
>  			mac_control |= BIT(4);
>  
>  		*link = true;
> +
> +		if (priv->shp_cfg_speed &&
> +		    priv->shp_cfg_speed != slave->phy->speed &&
> +		    !cpsw_shp_is_off(priv))
> +			dev_warn(priv->dev,
> +				 "Speed was changed, CBS sahper speeds are changed!");
>  	} else {
>  		mac_control = 0;
>  		/* disable forwarding */
> @@ -1589,6 +1635,178 @@ static int cpsw_tc_to_fifo(int tc, int num_tc)
>  	return CPSW_FIFO_SHAPERS_NUM - tc;
>  }
>  
> +static int cpsw_set_fifo_bw(struct cpsw_priv *priv, int fifo, int bw)
> +{
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	u32 val = 0, send_pct, shift;
> +	struct cpsw_slave *slave;
> +	int pct = 0, i;
> +
> +	if (bw > priv->shp_cfg_speed * 1000)
> +		goto err;
> +
> +	/* shaping has to stay enabled for highest fifos linearly
> +	 * and fifo bw no more then interface can allow
> +	 */
> +	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
> +	send_pct = slave_read(slave, SEND_PERCENT);
> +	for (i = CPSW_FIFO_SHAPERS_NUM; i > 0; i--) {
> +		if (!bw) {
> +			if (i >= fifo || !priv->fifo_bw[i])
> +				continue;
> +
> +			dev_warn(priv->dev, "Prev FIFO%d is shaped", i);
> +			continue;
> +		}
> +
> +		if (!priv->fifo_bw[i] && i > fifo) {
> +			dev_err(priv->dev, "Upper FIFO%d is not shaped", i);
> +			return -EINVAL;
> +		}
> +
> +		shift = (i - 1) * 8;
> +		if (i == fifo) {
> +			send_pct &= ~(CPSW_PCT_MASK << shift);
> +			val = DIV_ROUND_UP(bw, priv->shp_cfg_speed * 10);
> +			if (!val)
> +				val = 1;
> +
> +			send_pct |= val << shift;
> +			pct += val;
> +			continue;
> +		}
> +
> +		if (priv->fifo_bw[i])
> +			pct += (send_pct >> shift) & CPSW_PCT_MASK;
> +	}
> +
> +	if (pct >= 100)
> +		goto err;
> +
> +	slave_write(slave, send_pct, SEND_PERCENT);
> +	priv->fifo_bw[fifo] = bw;
> +
> +	dev_warn(priv->dev, "set FIFO%d bw = %d\n", fifo,
> +		 DIV_ROUND_CLOSEST(val * priv->shp_cfg_speed, 100));
> +
> +	return 0;
> +err:
> +	dev_err(priv->dev, "Bandwidth doesn't fit in tc configuration");
> +	return -EINVAL;
> +}
> +
> +static int cpsw_set_fifo_rlimit(struct cpsw_priv *priv, int fifo, int bw)
> +{
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	struct cpsw_slave *slave;
> +	u32 tx_in_ctl_rg, val;
> +	int ret;
> +
> +	ret = cpsw_set_fifo_bw(priv, fifo, bw);
> +	if (ret)
> +		return ret;
> +
> +	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
> +	tx_in_ctl_rg = cpsw->version == CPSW_VERSION_1 ?
> +		       CPSW1_TX_IN_CTL : CPSW2_TX_IN_CTL;
> +
> +	if (!bw)
> +		cpsw_fifo_shp_on(priv, fifo, bw);
> +
> +	val = slave_read(slave, tx_in_ctl_rg);
> +	if (cpsw_shp_is_off(priv)) {
> +		/* disable FIFOs rate limited queues */
> +		val &= ~(0xf << CPSW_FIFO_RATE_EN_SHIFT);
> +
> +		/* set type of FIFO queues to normal priority mode */
> +		val &= ~(3 << CPSW_FIFO_QUEUE_TYPE_SHIFT);
> +
> +		/* set type of FIFO queues to be rate limited */
> +		if (bw)
> +			val |= 2 << CPSW_FIFO_QUEUE_TYPE_SHIFT;
> +		else
> +			priv->shp_cfg_speed = 0;
> +	}
> +
> +	/* toggle a FIFO rate limited queue */
> +	if (bw)
> +		val |= BIT(fifo + CPSW_FIFO_RATE_EN_SHIFT);
> +	else
> +		val &= ~BIT(fifo + CPSW_FIFO_RATE_EN_SHIFT);
> +	slave_write(slave, val, tx_in_ctl_rg);
> +
> +	/* FIFO transmit shape enable */
> +	cpsw_fifo_shp_on(priv, fifo, bw);
> +	return 0;
> +}
> +
> +/* Defaults:
> + * class A - prio 3
> + * class B - prio 2
> + * shaping for class A should be set first
> + */
> +static int cpsw_set_cbs(struct net_device *ndev,
> +			struct tc_cbs_qopt_offload *qopt)
> +{
> +	struct cpsw_priv *priv = netdev_priv(ndev);
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	struct cpsw_slave *slave;
> +	int prev_speed = 0;
> +	int tc, ret, fifo;
> +	u32 bw = 0;
> +
> +	tc = netdev_txq_to_tc(priv->ndev, qopt->queue);
> +
> +	/* enable channels in backward order, as highest FIFOs must be rate
> +	 * limited first and for compliance with CPDMA rate limited channels
> +	 * that also used in bacward order. FIFO0 cannot be rate limited.
> +	 */
> +	fifo = cpsw_tc_to_fifo(tc, ndev->num_tc);
> +	if (!fifo) {
> +		dev_err(priv->dev, "Last tc%d can't be rate limited", tc);
> +		return -EINVAL;
> +	}
> +
> +	/* do nothing, it's disabled anyway */
> +	if (!qopt->enable && !priv->fifo_bw[fifo])
> +		return 0;
> +
> +	/* shapers can be set if link speed is known */
> +	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
> +	if (slave->phy && slave->phy->link) {
> +		if (priv->shp_cfg_speed &&
> +		    priv->shp_cfg_speed != slave->phy->speed)
> +			prev_speed = priv->shp_cfg_speed;
> +
> +		priv->shp_cfg_speed = slave->phy->speed;
> +	}
> +
> +	if (!priv->shp_cfg_speed) {
> +		dev_err(priv->dev, "Link speed is not known");
> +		return -1;
> +	}
> +
> +	ret = pm_runtime_get_sync(cpsw->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(cpsw->dev);
> +		return ret;
> +	}
> +
> +	bw = qopt->enable ? qopt->idleslope : 0;
> +	ret = cpsw_set_fifo_rlimit(priv, fifo, bw);
> +	if (ret) {
> +		priv->shp_cfg_speed = prev_speed;
> +		prev_speed = 0;
> +	}
> +
> +	if (bw && prev_speed)
> +		dev_warn(priv->dev,
> +			 "Speed was changed, CBS sahper speeds are changed!");
> +
> +	pm_runtime_put_sync(cpsw->dev);
> +	return ret;
> +}
> +
>  static int cpsw_ndo_open(struct net_device *ndev)
>  {
>  	struct cpsw_priv *priv = netdev_priv(ndev);
> @@ -2263,6 +2481,9 @@ static int cpsw_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  			     void *type_data)
>  {
>  	switch (type) {
> +	case TC_SETUP_QDISC_CBS:
> +		return cpsw_set_cbs(ndev, type_data);
> +
>  	case TC_SETUP_QDISC_MQPRIO:
>  		return cpsw_set_tc(ndev, type_data);
>  
> -- 
> 2.17.1
> 

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
