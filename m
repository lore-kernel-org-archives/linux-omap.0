From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ti: fix return type of ndo_start_xmit
 function
Date: Wed, 26 Sep 2018 10:17:33 -0700 (PDT)
Message-ID: <20180926.101733.2070254569725987062.davem@davemloft.net>
References: <20180926090951.25544-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926090951.25544-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: f.fainelli@gmail.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, lukas@wunner.de, bgolaszewski@baylibre.com, ivan.khoronzhuk@linaro.org, dan.carpenter@oracle.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Sep 2018 17:09:51 +0800

> @@ -1290,7 +1291,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  			dev_warn(netcp->ndev_dev, "padding failed (%d), packet dropped\n",
>  				 ret);
>  			tx_stats->tx_dropped++;
> -			return ret;
> +			return NETDEV_TX_BUSY;
>  		}
>  		skb->len = NETCP_MIN_PACKET_SIZE;
>  	}
> @@ -1298,7 +1299,6 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	desc = netcp_tx_map_skb(skb, netcp);
>  	if (unlikely(!desc)) {
>  		netif_stop_subqueue(ndev, subqueue);
> -		ret = -ENOBUFS;
>  		goto drop;
>  	}
>  
> @@ -1319,7 +1319,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	if (desc)
>  		netcp_free_tx_desc_chain(netcp, desc, sizeof(*desc));
>  	dev_kfree_skb(skb);
> -	return ret;
> +	return NETDEV_TX_BUSY;
>  }

These conversions are not correct.

If the driver frees the SKB you must not return NETDEV_TX_BUSY.

NETDEV_TX_BUSY tells the caller that the driver could not process the
packet and that it should reqeueu up the SKB and try again later when
there is more TX queue room.
