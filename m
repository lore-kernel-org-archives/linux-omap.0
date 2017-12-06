From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpdma: rate is not changed
 - correct case
Date: Wed, 06 Dec 2017 16:35:45 -0500 (EST)
Message-ID: <20171206.163545.906490902377440615.davem@davemloft.net>
References: <1512571278-13196-1-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1512571278-13196-1-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Wed,  6 Dec 2017 16:41:18 +0200

> If rate is the same as set it's correct case.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> Based on net-next/master
> 
>  drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
> index e4d6edf..dbe9167 100644
> --- a/drivers/net/ethernet/ti/davinci_cpdma.c
> +++ b/drivers/net/ethernet/ti/davinci_cpdma.c
> @@ -841,7 +841,7 @@ int cpdma_chan_set_rate(struct cpdma_chan *ch, u32 rate)
>  		return -EINVAL;
>  
>  	if (ch->rate == rate)
> -		return rate;
> +		return 0;

Looking at the one and only caller of this function, cpsw_ndo_set_tx_maxrate, it
makes sure this can never, ever, happen.

So I would instead remove this check completely since it can never trigger.
