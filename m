From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpdma: correct error
 handling for chan create
Date: Thu, 7 Dec 2017 21:56:30 +0200
Message-ID: <20171207195629.GB3022@khorivan>
References: <1512572050-13442-1-git-send-email-ivan.khoronzhuk@linaro.org>
 <20171206.163814.2298864765495270615.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171206.163814.2298864765495270615.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 06, 2017 at 04:38:14PM -0500, David Miller wrote:
> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> Date: Wed,  6 Dec 2017 16:54:09 +0200
> 
> > @@ -3065,10 +3065,16 @@ static int cpsw_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_tx_handler, 0);
> > +	if (WARN_ON(IS_ERR(cpsw->txv[0].ch))) {
> > +		dev_err(priv->dev, "error initializing tx dma channel\n");
> > +		ret = PTR_ERR(cpsw->txv[0].ch);
> > +		goto clean_dma_ret;
> > +	}
> > +
> 
> You're already emitting a proper dev_err() message, therefore WARN_ON()
> is a duplicate notification to the logs and therefore not appropriate.

Yes, will remove unneeded WARNs

-- 
Regards,
Ivan Khoronzhuk
