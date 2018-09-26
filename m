From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ti: fix return type of ndo_start_xmit
 function
Date: Wed, 26 Sep 2018 15:36:46 -0500
Message-ID: <b24fa149-40b3-57fd-ccb0-78a10c97b825@ti.com>
References: <20180926090951.25544-1-yuehaibing@huawei.com>
 <20180926.101733.2070254569725987062.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926.101733.2070254569725987062.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, yuehaibing@huawei.com
Cc: f.fainelli@gmail.com, w-kwok2@ti.com, m-karicheri2@ti.com, lukas@wunner.de, bgolaszewski@baylibre.com, ivan.khoronzhuk@linaro.org, dan.carpenter@oracle.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi All,

On 09/26/2018 12:17 PM, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Wed, 26 Sep 2018 17:09:51 +0800
> 
>> @@ -1290,7 +1291,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   			dev_warn(netcp->ndev_dev, "padding failed (%d), packet dropped\n",
>>   				 ret);
>>   			tx_stats->tx_dropped++;
>> -			return ret;
>> +			return NETDEV_TX_BUSY;
>>   		}
>>   		skb->len = NETCP_MIN_PACKET_SIZE;
>>   	}
>> @@ -1298,7 +1299,6 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	desc = netcp_tx_map_skb(skb, netcp);
>>   	if (unlikely(!desc)) {
>>   		netif_stop_subqueue(ndev, subqueue);
>> -		ret = -ENOBUFS;
>>   		goto drop;
>>   	}
>>   
>> @@ -1319,7 +1319,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	if (desc)
>>   		netcp_free_tx_desc_chain(netcp, desc, sizeof(*desc));
>>   	dev_kfree_skb(skb);
>> -	return ret;
>> +	return NETDEV_TX_BUSY;
>>   }
> 
> These conversions are not correct.
> 
> If the driver frees the SKB you must not return NETDEV_TX_BUSY.
> 
> NETDEV_TX_BUSY tells the caller that the driver could not process the
> packet and that it should reqeueu up the SKB and try again later when
> there is more TX queue room.
> 

Sry, but I still do not understand the reason for these changes (as I asked already [1])
May be there are some patches on the fly or long term decisions were made in this area.

According to the code include/linux/netdevice.h the .ndo_start_xmit() can return 3 type of values
1) enum netdev_tx, expected to be used by regular netdev drivers, but
2) "error while transmitting (rc < 0)" is also acceptable values
3) NET_XMIT_SUCCESS/DROP/CN (qdisc ->enqueue() return codes) for Virtual network devices 

So, are there plans to move NET_XMIT_XXX in enum? 
or any patches to change include/linux/netdevice.h "Transmit return codes:" section?

Not sure, that blindly following coccinelle recommendations is a good
choice in this particular case.

[1] https://lkml.org/lkml/2018/9/20/881

-- 
regards,
-grygorii
