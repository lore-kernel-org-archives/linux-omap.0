From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: unsync mcast entries
 while switch promisc mode
Date: Mon, 22 Oct 2018 13:26:35 -0500
Message-ID: <6ac434fa-858b-8395-91e7-442cf18b33f0@ti.com>
References: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/19/18 3:25 PM, Ivan Khoronzhuk wrote:
> After flushing all mcast entries from the table, the ones contained in
> mc list of ndev are not restored when promisc mode is toggled off,
> because they are considered as synched with ALE, thus, in order to
> restore them after promisc mode - reset syncing info. This fix
> touches only switch mode devices, including single port boards
> like Beagle Bone.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---


So, this is follow up fix for
176b23 net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update
because I can't reproduce it otherwise.

Could you update description and re-send pls.?

> 
> Based on net-nex/master
> and is logical continuation of the
> https://lore.kernel.org/patchwork/patch/1001633/
> 
>   drivers/net/ethernet/ti/cpsw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 226be2a56c1f..f7753b240ced 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -640,6 +640,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>   
>   			/* Clear all mcast from ALE */
>   			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
> +			__dev_mc_unsync(ndev, NULL);
>   
>   			/* Flood All Unicast Packets to Host port */
>   			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
> 

-- 
regards,
-grygorii
