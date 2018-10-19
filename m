From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
Date: Thu, 18 Oct 2018 19:03:06 -0500
Message-ID: <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
> No need now to flush mcast entries in switch mode while toggling to
> promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
> and mcast/vlan ports = ALL_PORTS, the same happening for vlan
> unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
> mode routine by calling set allmulti. I suppose main reason to flush
> them is to use unreg_mcast to receive all to host port. Thus, now, all
> mcast packets are received anyway and no reason to flush mcast entries
> unsafely, as they were synced with __dev_mc_sync() previously and are
> not restored. Another way is to _dev_mc_unsync() them, but no need.

User have possibility to add additional mcast entries or edit existing 
in switch-mode, which is now done using custom tool. So, Host in promisc
mode will not receive packets for mcast address X if port mask for this
addr set to (ALL_PORTS - HOST_PORT). Am I missing smth?

> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> 
> Based on net-next/master
> Tasted on am572x EVM and BBB
> 
>   drivers/net/ethernet/ti/cpsw.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 226be2a56c1f..0e475020a674 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -638,9 +638,6 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>   			} while (time_after(timeout, jiffies));
>   			cpsw_ale_control_set(ale, 0, ALE_AGEOUT, 1);
>   
> -			/* Clear all mcast from ALE */
> -			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
> -
>   			/* Flood All Unicast Packets to Host port */
>   			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
>   			dev_dbg(&ndev->dev, "promiscuity enabled\n");
> 

-- 
regards,
-grygorii
