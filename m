From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix tsx210x detection
Date: Thu, 13 Mar 2008 13:31:44 +0200
Message-ID: <20080313113143.GE11653@atomide.com>
References: <20080306005848.GA20807@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:61245 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbYCMLb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 07:31:59 -0400
Content-Disposition: inline
In-Reply-To: <20080306005848.GA20807@party>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [080306 02:59]:
> If the return value is all 0xff, it means there's no device.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/spi/tsc210x.c b/drivers/spi/tsc210x.c
> index df8bcf9..1d2ac94 100644
> --- a/drivers/spi/tsc210x.c
> +++ b/drivers/spi/tsc210x.c
> @@ -1092,6 +1092,11 @@ static int tsc210x_probe(struct spi_device *spi, enum tsc_type type)
>  		dev_dbg(&dev->spi->dev, "revision, err %d\n", err);
>  		goto err_spi;
>  	}
> +	if (reg == 0xffff) {
> +		err = -ENODEV;
> +		dev_dbg(&dev->spi->dev, "no device, err %d\n", err);
> +		goto err_spi;
> +	}
>  	dev_info(&spi->dev, "rev %d, irq %d\n", reg & 0x0007, spi->irq);
>  
>  	err = tsc210x_configure(dev);

Pushing today.

Tony
