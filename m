From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 6/10] HDQ driver: use ioremap for HDQ base
Date: Thu, 25 Sep 2008 13:02:37 +0300
Message-ID: <20080925100237.GV24627@gandalf.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EB9@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20942 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbYIYKEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:04:13 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EB9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

On Thu, Sep 25, 2008 at 12:26:17PM +0530, ext Gadiyar, Anand wrote:
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> This patch provides the ioremap related changes to the driver.
> 
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/w1/masters/omap_hdq.c |   21 ++++++++++++++-------
>  1 files changed, 14 insertions(+), 7 deletions(-)
> 
> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 10:46:53.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 11:13:12.000000000 +0530
> @@ -54,7 +54,7 @@ static int w1_id;
>  
>  struct hdq_data {
>  	struct device		*dev;
> -	resource_size_t		hdq_base;
> +	void __iomem		*hdq_base;
>  	struct	semaphore	hdq_semlock;
>  	int			hdq_usecount;
>  	struct	clk		*hdq_ick;
> @@ -99,12 +99,12 @@ static struct w1_bus_master omap_w1_mast
>   */
>  static inline u8 hdq_reg_in(struct hdq_data *hdq_data, u32 offset)
>  {
> -	return omap_readb(hdq_data->hdq_base + offset);
> +	return __raw_readb(hdq_data->hdq_base + offset);
>  }
>  
>  static inline u8 hdq_reg_out(struct hdq_data *hdq_data, u32 offset, u8 val)
>  {
> -	omap_writeb(val, hdq_data->hdq_base + offset);
> +	__raw_writeb(val, hdq_data->hdq_base + offset);
>  
>  	return val;
>  }
> @@ -112,9 +112,9 @@ static inline u8 hdq_reg_out(struct hdq_
>  static inline u8 hdq_reg_merge(struct hdq_data *hdq_data, u32 offset,
>  			u8 val, u8 mask)
>  {
> -	u8 new_val = (omap_readb(hdq_data->hdq_base + offset) & ~mask)
> +	u8 new_val = (__raw_readb(hdq_data->hdq_base + offset) & ~mask)
>  			| (val & mask);
> -	omap_writeb(new_val, hdq_data->hdq_base + offset);
> +	__raw_writeb(new_val, hdq_data->hdq_base + offset);
>  
>  	return new_val;
>  }
> @@ -589,7 +589,12 @@ static int __init omap_hdq_probe(struct 
>  		goto err_resource;
>  	}
>  
> -	hdq_data->hdq_base = res->start;
> +	hdq_data->hdq_base = ioremap(res->start, SZ_4K);
> +	if (!hdq_data->hdq_base) {
> +		dev_dbg(&pdev->dev, "ioremap failed\n");
> +		ret = -EINVAL;
> +		goto err_ioremap;
> +	}
>  
>  	/* get interface & functional clock objects */
>  	hdq_data->hdq_ick = clk_get(&pdev->dev, "hdq_ick");
> @@ -668,8 +673,9 @@ err_ick:
>  	clk_put(hdq_data->hdq_fck);
>  
>  err_clk:
> -	hdq_data->hdq_base = NULL;
> +	iounmap(hdq_data->hdq_base);
>  
> +err_ioremap:
>  err_resource:
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(hdq_data);
> @@ -695,6 +701,7 @@ static int omap_hdq_remove(struct platfo
>  	clk_put(hdq_data->hdq_fck);
>  	free_irq(INT_24XX_HDQ_IRQ, hdq_data);
>  	platform_set_drvdata(pdev, NULL);
> +	iounmap(hdq_data->hdq_base);
>  	kfree(hdq_data);
>  
>  	return 0;
-- 
balbi
