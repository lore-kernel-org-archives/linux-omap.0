From: grygorii <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw_ethtool: fix ethtool ring
 param set
Date: Sat, 1 Jun 2019 13:36:20 +0300
Message-ID: <3b1b0ac9-6165-6d59-d3f7-d484705119f2@ti.com>
References: <20190531134725.2054-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190531134725.2054-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 31/05/2019 16:47, Ivan Khoronzhuk wrote:
> Fix ability to set RX descriptor number, the reason - initially
> "tx_max_pending" was set incorrectly, but the issue appears after
> adding sanity check, so fix is for "sanity" patch.
> 
> Fixes: 37e2d99b59c476 ("ethtool: Ensure new ring parameters are within bounds during SRINGPARAM")
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> Based on net/master
> 
>   drivers/net/ethernet/ti/cpsw_ethtool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
> index a4a7ec0d2531..6d1c9ebae7cc 100644
> --- a/drivers/net/ethernet/ti/cpsw_ethtool.c
> +++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
> @@ -643,7 +643,7 @@ void cpsw_get_ringparam(struct net_device *ndev,
>   	struct cpsw_common *cpsw = priv->cpsw;
>   
>   	/* not supported */
> -	ering->tx_max_pending = 0;
> +	ering->tx_max_pending = cpsw->descs_pool_size - CPSW_MAX_QUEUES;
>   	ering->tx_pending = cpdma_get_num_tx_descs(cpsw->dma);
>   	ering->rx_max_pending = cpsw->descs_pool_size - CPSW_MAX_QUEUES;
>   	ering->rx_pending = cpdma_get_num_rx_descs(cpsw->dma);
> 

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
