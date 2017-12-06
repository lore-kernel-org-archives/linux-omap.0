From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpdma: correct error
 handling for chan create
Date: Wed, 06 Dec 2017 16:38:14 -0500 (EST)
Message-ID: <20171206.163814.2298864765495270615.davem@davemloft.net>
References: <1512572050-13442-1-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512572050-13442-1-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Wed,  6 Dec 2017 16:54:09 +0200

> @@ -3065,10 +3065,16 @@ static int cpsw_probe(struct platform_device *pdev)
>  	}
>  
>  	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_tx_handler, 0);
> +	if (WARN_ON(IS_ERR(cpsw->txv[0].ch))) {
> +		dev_err(priv->dev, "error initializing tx dma channel\n");
> +		ret = PTR_ERR(cpsw->txv[0].ch);
> +		goto clean_dma_ret;
> +	}
> +

You're already emitting a proper dev_err() message, therefore WARN_ON()
is a duplicate notification to the logs and therefore not appropriate.
