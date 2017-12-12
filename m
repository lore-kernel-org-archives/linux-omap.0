From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: cpdma: correct error
 handling for chan create
Date: Tue, 12 Dec 2017 19:50:14 +0200
Message-ID: <20171212175012.GA27096@khorivan>
References: <1513096517-3905-1-git-send-email-ivan.khoronzhuk@linaro.org>
 <871f9995-3442-d07e-a36a-4353042bb860@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871f9995-3442-d07e-a36a-4353042bb860@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 12, 2017 at 11:08:51AM -0600, Grygorii Strashko wrote:
> 
> 
> On 12/12/2017 10:35 AM, Ivan Khoronzhuk wrote:
> > It's not correct to return NULL when that is actually an error and
> > function returns errors in any other wrong case. In the same time,
> > the cpsw driver and davinci emac doesn't check error case while
> > creating channel and it can miss actual error. Also remove WARNs
> > duplicated dev_err msgs.
> > 
> > Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> > ---
> >   drivers/net/ethernet/ti/cpsw.c          | 12 +++++++++---
> >   drivers/net/ethernet/ti/davinci_cpdma.c |  2 +-
> >   drivers/net/ethernet/ti/davinci_emac.c  |  9 +++++++--
> >   3 files changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> > index a60a378..3c85a08 100644
> > --- a/drivers/net/ethernet/ti/cpsw.c
> > +++ b/drivers/net/ethernet/ti/cpsw.c
> > @@ -3065,10 +3065,16 @@ static int cpsw_probe(struct platform_device *pdev)
> >   	}
> >   
> >   	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_tx_handler, 0);
> > +	if (IS_ERR(cpsw->txv[0].ch)) {
> > +		dev_err(priv->dev, "error initializing tx dma channel\n");
> > +		ret = PTR_ERR(cpsw->txv[0].ch);
> > +		goto clean_dma_ret;
> > +	}
> > +
> >   	cpsw->rxv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
> > -	if (WARN_ON(!cpsw->rxv[0].ch || !cpsw->txv[0].ch)) {
> > -		dev_err(priv->dev, "error initializing dma channels\n");
> > -		ret = -ENOMEM;
> > +	if (IS_ERR(cpsw->rxv[0].ch)) {
> > +		dev_err(priv->dev, "error initializing rx dma channel\n");
> > +		ret = PTR_ERR(cpsw->rxv[0].ch);
> >   		goto clean_dma_ret;
> >   	}
> >   
> > diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
> > index e4d6edf..6f9173f 100644
> > --- a/drivers/net/ethernet/ti/davinci_cpdma.c
> > +++ b/drivers/net/ethernet/ti/davinci_cpdma.c
> > @@ -893,7 +893,7 @@ struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr *ctlr, int chan_num,
> >   	chan_num = rx_type ? rx_chan_num(chan_num) : tx_chan_num(chan_num);
> >   
> >   	if (__chan_linear(chan_num) >= ctlr->num_chan)
> > -		return NULL;
> > +		return ERR_PTR(-EINVAL);
> >   
> >   	chan = devm_kzalloc(ctlr->dev, sizeof(*chan), GFP_KERNEL);
> >   	if (!chan)
> > diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> > index f58c0c6..3d4af64 100644
> > --- a/drivers/net/ethernet/ti/davinci_emac.c
> > +++ b/drivers/net/ethernet/ti/davinci_emac.c
> > @@ -1870,10 +1870,15 @@ static int davinci_emac_probe(struct platform_device *pdev)
> >   
> >   	priv->txchan = cpdma_chan_create(priv->dma, EMAC_DEF_TX_CH,
> >   					 emac_tx_handler, 0);
> > +	if (WARN_ON(IS_ERR(priv->txchan))) {
> 
> So, logically WARN_ON() should be removed in  davinci_emac.c also. Right?
It doesn't have dev_err() duplicate, so not very.
But would be better to replace them on dev_err() if no objection.


> 
> > +		rc = PTR_ERR(priv->txchan);
> > +		goto no_cpdma_chan;
> > +	}
> > +
> >   	priv->rxchan = cpdma_chan_create(priv->dma, EMAC_DEF_RX_CH,
> >   					 emac_rx_handler, 1);
> > -	if (WARN_ON(!priv->txchan || !priv->rxchan)) {
> > -		rc = -ENOMEM;
> > +	if (WARN_ON(IS_ERR(priv->rxchan))) {
> > +		rc = PTR_ERR(priv->rxchan);
> >   		goto no_cpdma_chan;
> >   	}
> >   
> > 
> 
> -- 
> regards,
> -grygorii

-- 
Regards,
Ivan Khoronzhuk
