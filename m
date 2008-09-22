From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Mon, 22 Sep 2008 17:06:21 +0400
Message-ID: <20080922130621.GC30680@2ka.mipt.ru>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay.2ka.mipt.ru ([194.85.80.65]:56361 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbYIVNHP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Sep 2008 09:07:15 -0400
Content-Disposition: inline
In-Reply-To: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi.

On Mon, Sep 22, 2008 at 03:45:57PM +0530, Madhusudhan Chikkature (madhu.cr@ti.com) wrote:
> This patch provides the HDQ driver modifications to use ioremap for the base
> address.

Looks good.
Couple of small comments inline.

> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-08-18
> 14:48:26.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-22 14:56:28.000000000
> +0530
> @@ -53,7 +53,7 @@ DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
>  int W1_ID;
> 
>  struct hdq_data {
> -	resource_size_t		hdq_base;
> +	void __iomem		*hdq_base;
>  	struct	semaphore	hdq_semlock;

Shouldn't it use mutex or it does counting?

> @@ -577,7 +577,7 @@ static int __init omap_hdq_probe(struct
>  		return -ENXIO;
>  	}
> 
> -	hdq_data->hdq_base = res->start;
> +	hdq_data->hdq_base = ioremap(res->start, SZ_4K);

Suppose it does not fail on this arch?

>  	/* get interface & functional clock objects */
>  	hdq_data->hdq_ick = clk_get(&pdev->dev, "hdq_ick");
> @@ -588,12 +588,14 @@ static int __init omap_hdq_probe(struct
>  		if (IS_ERR(hdq_data->hdq_ick)) {
>  			ret = PTR_ERR(hdq_data->hdq_ick);
>  			platform_set_drvdata(pdev, NULL);
> +			iounmap(hdq_data->hdq_base);
>  			kfree(hdq_data);
>  			return ret;
>  		}
>  		if (IS_ERR(hdq_data->hdq_fck)) {
>  			ret = PTR_ERR(hdq_data->hdq_fck);
>  			platform_set_drvdata(pdev, NULL);
> +			iounmap(hdq_data->hdq_base);
>  			kfree(hdq_data);
>  			return ret;
>  		}

Don't you want to use goto and single exit path here and in other places?

-- 
	Evgeniy Polyakov
