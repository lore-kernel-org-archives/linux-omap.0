From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 net-next] net: ethernet: ti: cpdma: correct error
 handling for chan create
Date: Tue, 12 Dec 2017 15:41:22 -0600
Message-ID: <9d420427-3633-2d3c-fa4a-cc4388f3ef1f@ti.com>
References: <1513112795-20045-1-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513112795-20045-1-git-send-email-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/12/2017 03:06 PM, Ivan Khoronzhuk wrote:
> It's not correct to return NULL when that is actually an error and
> function returns errors in any other wrong case. In the same time,
> the cpsw driver and davinci emac doesn't check error case while
> creating channel and it can miss actual error. Also remove WARNs
> replacing them on dev_err msgs.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

> ---
>   drivers/net/ethernet/ti/cpsw.c          | 12 +++++++++---
>   drivers/net/ethernet/ti/davinci_cpdma.c |  2 +-
>   drivers/net/ethernet/ti/davinci_emac.c  | 11 +++++++++--
>   3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index a60a378..3c85a08 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -3065,10 +3065,16 @@ static int cpsw_probe(struct platform_device *pdev)
>   	}
>   
>   	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_tx_handler, 0);
> +	if (IS_ERR(cpsw->txv[0].ch)) {
> +		dev_err(priv->dev, "error initializing tx dma channel\n");
> +		ret = PTR_ERR(cpsw->txv[0].ch);
> +		goto clean_dma_ret;
> +	}
> +
>   	cpsw->rxv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
> -	if (WARN_ON(!cpsw->rxv[0].ch || !cpsw->txv[0].ch)) {
> -		dev_err(priv->dev, "error initializing dma channels\n");
> -		ret = -ENOMEM;
> +	if (IS_ERR(cpsw->rxv[0].ch)) {
> +		dev_err(priv->dev, "error initializing rx dma channel\n");
> +		ret = PTR_ERR(cpsw->rxv[0].ch);
>   		goto clean_dma_ret;
>   	}
>   
> diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
> index e4d6edf..6f9173f 100644
> --- a/drivers/net/ethernet/ti/davinci_cpdma.c
> +++ b/drivers/net/ethernet/ti/davinci_cpdma.c
> @@ -893,7 +893,7 @@ struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr *ctlr, int chan_num,
>   	chan_num = rx_type ? rx_chan_num(chan_num) : tx_chan_num(chan_num);
>   
>   	if (__chan_linear(chan_num) >= ctlr->num_chan)
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>   
>   	chan = devm_kzalloc(ctlr->dev, sizeof(*chan), GFP_KERNEL);
>   	if (!chan)
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index f58c0c6..abceea8 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -1870,10 +1870,17 @@ static int davinci_emac_probe(struct platform_device *pdev)
>   
>   	priv->txchan = cpdma_chan_create(priv->dma, EMAC_DEF_TX_CH,
>   					 emac_tx_handler, 0);
> +	if (IS_ERR(priv->txchan)) {
> +		dev_err(&pdev->dev, "error initializing tx dma channel\n");
> +		rc = PTR_ERR(priv->txchan);
> +		goto no_cpdma_chan;
> +	}
> +
>   	priv->rxchan = cpdma_chan_create(priv->dma, EMAC_DEF_RX_CH,
>   					 emac_rx_handler, 1);
> -	if (WARN_ON(!priv->txchan || !priv->rxchan)) {
> -		rc = -ENOMEM;
> +	if (IS_ERR(priv->rxchan)) {
> +		dev_err(&pdev->dev, "error initializing rx dma channel\n");
> +		rc = PTR_ERR(priv->rxchan);
>   		goto no_cpdma_chan;
>   	}
>   
> 

-- 
regards,
-grygorii
