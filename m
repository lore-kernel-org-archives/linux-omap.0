From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 3/6] net: ethernet: ti: cpsw: add MQPRIO Qdisc
 offload
Date: Tue, 12 Jun 2018 18:36:58 +0200
Message-ID: <20180612163658.GC12251@lunn.ch>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-4-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611133047.4818-4-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, vinicius.gomes@intel.com, henrik@austad.us, jesus.sanchez-palencia@intel.com, ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com, francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 11, 2018 at 04:30:44PM +0300, Ivan Khoronzhuk wrote:
> That's possible to offload vlan to tc priority mapping with
> assumption sk_prio == L2 prio.
> 
> Example:
> $ ethtool -L eth0 rx 1 tx 4
> 
> $ qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
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
> Here, 100:1 is txq0, 100:2 is txq1, 100:3 is txq2, 100:4 is txq3
> txq0 belongs to tc0, txq1 to tc1, txq2 and txq3 to tc2
> The offload part only maps L2 prio to classes of traffic, but not
> to transmit queues, so to direct traffic to traffic class vlan has
> to be created with appropriate egress map.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 82 ++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 406537d74ec1..fd967d2bce5d 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -39,6 +39,7 @@
>  #include <linux/sys_soc.h>
>  
>  #include <linux/pinctrl/consumer.h>
> +#include <net/pkt_cls.h>
>  
>  #include "cpsw.h"
>  #include "cpsw_ale.h"
> @@ -153,6 +154,8 @@ do {								\
>  #define IRQ_NUM			2
>  #define CPSW_MAX_QUEUES		8
>  #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
> +#define CPSW_TC_NUM			4
> +#define CPSW_FIFO_SHAPERS_NUM		(CPSW_TC_NUM - 1)
>  
>  #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
>  #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
> @@ -453,6 +456,7 @@ struct cpsw_priv {
>  	u8				mac_addr[ETH_ALEN];
>  	bool				rx_pause;
>  	bool				tx_pause;
> +	bool				mqprio_hw;
>  	u32 emac_port;
>  	struct cpsw_common *cpsw;
>  };
> @@ -1577,6 +1581,14 @@ static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_common *cpsw)
>  	soft_reset_slave(slave);
>  }
>  
> +static int cpsw_tc_to_fifo(int tc, int num_tc)
> +{
> +	if (tc == num_tc - 1)
> +		return 0;
> +
> +	return CPSW_FIFO_SHAPERS_NUM - tc;
> +}
> +
>  static int cpsw_ndo_open(struct net_device *ndev)
>  {
>  	struct cpsw_priv *priv = netdev_priv(ndev);
> @@ -2190,6 +2202,75 @@ static int cpsw_ndo_set_tx_maxrate(struct net_device *ndev, int queue, u32 rate)
>  	return ret;
>  }
>  
> +static int cpsw_set_tc(struct net_device *ndev, void *type_data)
> +{

Hi Ivan

Maybe this is not the best of names. What if you add support for
another TC qdisc? So you have another case in the switch statement
below?

Maybe call it cpsw_set_mqprio?

> +static int cpsw_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			     void *type_data)
> +{
> +	switch (type) {
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return cpsw_set_tc(ndev, type_data);
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

  Andrew
  
