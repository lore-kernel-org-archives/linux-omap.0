From: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 02/13] uio: uio_pruss: use devm_kzalloc()
Date: Mon, 30 Jun 2014 21:42:40 +0200
Message-ID: <20140630194240.GD78749@localhost>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-3-git-send-email-a.heider@gmail.com>
 <20140630093809.GW7262@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37953 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbaF3Tmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 15:42:45 -0400
Content-Disposition: inline
In-Reply-To: <20140630093809.GW7262@leverpostej>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jun 30, 2014 at 10:38:09AM +0100, Mark Rutland wrote:
> On Sun, Jun 29, 2014 at 05:21:36PM +0100, Andre Heider wrote:
> > --- a/drivers/uio/uio_pruss.c
> > +++ b/drivers/uio/uio_pruss.c
> > @@ -109,9 +109,7 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
> >  		gen_pool_free(gdev->sram_pool,
> >  			      gdev->sram_vaddr,
> >  			      sram_pool_sz);
> > -	kfree(gdev->info);
> >  	clk_put(gdev->pruss_clk);
> > -	kfree(gdev);
> >  }
> >  
> >  static int pruss_probe(struct platform_device *pdev)
> > @@ -123,24 +121,19 @@ static int pruss_probe(struct platform_device *pdev)
> >  	int ret = -ENODEV, cnt = 0, len;
> >  	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
> >  
> > -	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
> > +	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
> 
> If this is changing anyway, how about:
> 
> 	gdev = devm_kzalloc(dev, sizeof(*gdev), GFP_KERNEL);
> 

Sounds good, will do just that.

Thanks for having at look at the series, Mark!

Regards,
Andre
