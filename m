From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 8/10] HDQ driver:protect the shared flag
Date: Thu, 25 Sep 2008 13:02:46 +0300
Message-ID: <20080925100246.GX24627@gandalf.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EBF@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41140 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYIYK3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:29:17 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EBF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

On Thu, Sep 25, 2008 at 12:28:22PM +0530, ext Gadiyar, Anand wrote:
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> This patch moves the shared variable into the local structure and
> protects its updation.
> 
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/w1/masters/omap_hdq.c |   52 ++++++++++++++++++++++++++++++------------
>  1 files changed, 38 insertions(+), 14 deletions(-)
> 
> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 11:49:45.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 14:41:43.000000000 +0530
> @@ -61,6 +61,12 @@ struct hdq_data {
>  	struct	clk		*hdq_fck;
>  	u8			hdq_irqstatus;
>  	spinlock_t		hdq_spinlock;
> +	/*
> +	 * Used to control the call to omap_hdq_get and omap_hdq_put.
> +	 * HDQ Protocol: Write the CMD|REG_address first, followed by
> +	 * the data wrire or read.
> +	 */
> +	int			init_trans;
>  };
>  
>  static int omap_hdq_get(struct hdq_data *hdq_data);
> @@ -505,13 +511,6 @@ omap_hdq_put(struct hdq_data *hdq_data)
>  }
>  
>  /*
> - * Used to control the call to omap_hdq_get and omap_hdq_put.
> - * HDQ Protocol: Write the CMD|REG_address first, followed by
> - * the data wrire or read.
> - */
> -static int init_trans;
> -
> -/*
>   * Read a byte of data from the device.
>   */
>  static u8 omap_w1_read_byte(void *_hdq)
> @@ -522,14 +521,26 @@ static u8 omap_w1_read_byte(void *_hdq)
>  
>  	ret = hdq_read_byte(hdq_data, &val);
>  	if (ret) {
> -		init_trans = 0;
> +		ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
> +		if (ret < 0) {
> +			dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
> +			return -EINTR;
> +		}
> +		hdq_data->init_trans = 0;
> +		mutex_unlock(&hdq_data->hdq_mutex);
>  		omap_hdq_put(hdq_data);
>  		return -1;
>  	}
>  
>  	/* Write followed by a read, release the module */
> -	if (init_trans) {
> -		init_trans = 0;
> +	if (hdq_data->init_trans) {
> +		ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
> +		if (ret < 0) {
> +			dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
> +			return -EINTR;
> +		}
> +		hdq_data->init_trans = 0;
> +		mutex_unlock(&hdq_data->hdq_mutex);
>  		omap_hdq_put(hdq_data);
>  	}
>  
> @@ -542,21 +553,34 @@ static u8 omap_w1_read_byte(void *_hdq)
>  static void omap_w1_write_byte(void *_hdq, u8 byte)
>  {
>  	struct hdq_data *hdq_data = _hdq;
> +	int ret;
>  	u8 status;
>  
>  	/* First write to initialize the transfer */
> -	if (init_trans == 0)
> +	if (hdq_data->init_trans == 0)
>  		omap_hdq_get(hdq_data);
>  
> -	init_trans++;
> +	ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
> +	if (ret < 0) {
> +		dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
> +		return;
> +	}
> +	hdq_data->init_trans++;
> +	mutex_unlock(&hdq_data->hdq_mutex);
>  
>  	hdq_write_byte(hdq_data, byte, &status);
>  	dev_dbg(hdq_data->dev, "Ctrl status %x\n", status);
>  
>  	/* Second write, data transfered. Release the module */
> -	if (init_trans > 1) {
> +	if (hdq_data->init_trans > 1) {
>  		omap_hdq_put(hdq_data);
> -		init_trans = 0;
> +		ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
> +		if (ret < 0) {
> +			dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
> +			return;
> +		}
> +		hdq_data->init_trans = 0;
> +		mutex_unlock(&hdq_data->hdq_mutex);
>  	}
>  
>  	return;--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
