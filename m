From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v2 net-next 7/7] net: ethernet: ti: cpsw: add XDP
 support
Date: Fri, 31 May 2019 17:46:43 +0200
Message-ID: <20190531174643.4be8b27f@carbon>
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
        <20190530182039.4945-8-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530182039.4945-8-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net, ast@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com, john.fastabend@gmail.com, brouer@redhat.com
List-Id: linux-omap@vger.kernel.org


Hi Ivan,

>From below code snippets, it looks like you only allocated 1 page_pool
and sharing it with several RX-queues, as I don't have the full context
and don't know this driver, I might be wrong?

To be clear, a page_pool object is needed per RX-queue, as it is
accessing a small RX page cache (which protected by NAPI/softirq).

On Thu, 30 May 2019 21:20:39 +0300
Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:

> @@ -1404,6 +1711,14 @@ static int cpsw_ndo_open(struct net_device *ndev)
>  			enable_irq(cpsw->irqs_table[0]);
>  		}
>  
> +		pool_size = cpdma_get_num_rx_descs(cpsw->dma);
> +		cpsw->page_pool = cpsw_create_page_pool(cpsw, pool_size);
> +		if (IS_ERR(cpsw->page_pool)) {
> +			ret = PTR_ERR(cpsw->page_pool);
> +			cpsw->page_pool = NULL;
> +			goto err_cleanup;
> +		}

On Thu, 30 May 2019 21:20:39 +0300
Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:

> @@ -675,10 +742,33 @@ int cpsw_set_ringparam(struct net_device *ndev,
>  	if (cpsw->usage_count)
>  		cpdma_chan_split_pool(cpsw->dma);
>  
> +	for (i = 0; i < cpsw->data.slaves; i++) {
> +		struct net_device *ndev = cpsw->slaves[i].ndev;
> +
> +		if (!(ndev && netif_running(ndev)))
> +			continue;
> +
> +		cpsw_xdp_unreg_rxqs(netdev_priv(ndev));
> +	}
> +
> +	page_pool_destroy(cpsw->page_pool);
> +	cpsw->page_pool = pool;
> +

On Thu, 30 May 2019 21:20:39 +0300
Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:

> +void cpsw_xdp_unreg_rxqs(struct cpsw_priv *priv)
> +{
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	int i;
> +
> +	for (i = 0; i < cpsw->rx_ch_num; i++)
> +		xdp_rxq_info_unreg(&priv->xdp_rxq[i]);
> +}


On Thu, 30 May 2019 21:20:39 +0300
Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:

> +int cpsw_xdp_reg_rxq(struct cpsw_priv *priv, int ch)
> +{
> +	struct xdp_rxq_info *xdp_rxq = &priv->xdp_rxq[ch];
> +	struct cpsw_common *cpsw = priv->cpsw;
> +	int ret;
> +
> +	ret = xdp_rxq_info_reg(xdp_rxq, priv->ndev, ch);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	ret = xdp_rxq_info_reg_mem_model(xdp_rxq, MEM_TYPE_PAGE_POOL,
> +					 cpsw->page_pool);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	return 0;



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
