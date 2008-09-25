From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 9/10] HDQ driver:  Fix indentation and commenting style
Date: Thu, 25 Sep 2008 13:02:50 +0300
Message-ID: <20080925100250.GY24627@gandalf.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EC3@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20782 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbYIYKDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:03:33 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EC3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

On Thu, Sep 25, 2008 at 12:30:48PM +0530, ext Gadiyar, Anand wrote:
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> This patch fixes the indentation, commenting style of a single line comment.
> 
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/w1/masters/omap_hdq.c |   81 +++++++++++++++---------------------------
>  1 files changed, 29 insertions(+), 52 deletions(-)
> 
> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 14:41:43.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 15:37:18.000000000 +0530
> @@ -77,12 +77,12 @@ static int __init omap_hdq_probe(struct 
>  static int omap_hdq_remove(struct platform_device *pdev);
>  
>  static struct platform_driver omap_hdq_driver = {
> -	.probe = omap_hdq_probe,
> -	.remove = omap_hdq_remove,
> -	.suspend = NULL,
> -	.resume = NULL,
> -	.driver = {
> -		.name = "omap_hdq",
> +	.probe =	omap_hdq_probe,
> +	.remove =	omap_hdq_remove,
> +	.suspend =	NULL,
> +	.resume =	NULL,
> +	.driver =	{
> +		.name =	"omap_hdq",
>  	},
>  };
>  
> @@ -100,9 +100,7 @@ static struct w1_bus_master omap_w1_mast
>  	.search		= omap_w1_search_bus,
>  };
>  
> -/*
> - * HDQ register I/O routines
> - */
> +/* HDQ register I/O routines */
>  static inline u8 hdq_reg_in(struct hdq_data *hdq_data, u32 offset)
>  {
>  	return __raw_readb(hdq_data->hdq_base + offset);
> @@ -161,11 +159,8 @@ static int hdq_wait_for_flag(struct hdq_
>  	return ret;
>  }
>  
> -/*
> - * write out a byte and fill *status with HDQ_INT_STATUS
> - */
> -static int
> -hdq_write_byte(struct hdq_data *hdq_data, u8 val, u8 *status)
> +/* write out a byte and fill *status with HDQ_INT_STATUS */
> +static int hdq_write_byte(struct hdq_data *hdq_data, u8 val, u8 *status)
>  {
>  	int ret;
>  	u8 tmp_status;
> @@ -216,9 +211,7 @@ hdq_write_byte(struct hdq_data *hdq_data
>  	return ret;
>  }
>  
> -/*
> - * HDQ Interrupt service routine.
> - */
> +/* HDQ Interrupt service routine */
>  static irqreturn_t hdq_isr(int irq, void *_hdq)
>  {
>  	struct hdq_data *hdq_data = _hdq;
> @@ -239,17 +232,13 @@ static irqreturn_t hdq_isr(int irq, void
>  	return IRQ_HANDLED;
>  }
>  
> -/*
> - * HDQ Mode: always return success.
> - */
> +/* HDQ Mode: always return success */
>  static u8 omap_w1_reset_bus(void *_hdq)
>  {
>  	return 0;
>  }
>  
> -/*
> - * W1 search callback function.
> - */
> +/* W1 search callback function */
>  static void omap_w1_search_bus(void *_hdq, u8 search_type,
>  	w1_slave_found_callback slave_found)
>  {
> @@ -304,11 +293,8 @@ static int _omap_hdq_reset(struct hdq_da
>  	return ret;
>  }
>  
> -/*
> - * Issue break pulse to the device.
> - */
> -static int
> -omap_hdq_break(struct hdq_data *hdq_data)
> +/* Issue break pulse to the device */
> +static int omap_hdq_break(struct hdq_data *hdq_data)
>  {
>  	int ret;
>  	u8 tmp_status;
> @@ -368,6 +354,7 @@ omap_hdq_break(struct hdq_data *hdq_data
>  			"return to zero, %x", tmp_status);
>  
>  	mutex_unlock(&hdq_data->hdq_mutex);
> +
>  	return ret;
>  }
>  
> @@ -376,6 +363,7 @@ static int hdq_read_byte(struct hdq_data
>  	int ret;
>  	u8 status;
>  	unsigned long irqflags;
> +	unsigned long timeout = jiffies + OMAP_HDQ_TIMEOUT;
>  
>  	ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
>  	if (ret < 0)
> @@ -395,14 +383,11 @@ static int hdq_read_byte(struct hdq_data
>  		 * triggers another interrupt before we
>  		 * sleep. So we have to wait for RXCOMPLETE bit.
>  		 */
> -		{
> -			unsigned long timeout = jiffies + OMAP_HDQ_TIMEOUT;
> -			while (!(hdq_data->hdq_irqstatus
> -				& OMAP_HDQ_INT_STATUS_RXCOMPLETE)
> -				&& time_before(jiffies, timeout)) {
> -				set_current_state(TASK_UNINTERRUPTIBLE);
> -				schedule_timeout(1);
> -			}
> +		while (!(hdq_data->hdq_irqstatus
> +			& OMAP_HDQ_INT_STATUS_RXCOMPLETE)
> +			&& time_before(jiffies, timeout)) {
> +			set_current_state(TASK_UNINTERRUPTIBLE);
> +			schedule_timeout(1);
>  		}
>  		hdq_reg_merge(hdq_data, OMAP_HDQ_CTRL_STATUS, 0,
>  			OMAP_HDQ_CTRL_STATUS_DIR);
> @@ -425,11 +410,8 @@ static int hdq_read_byte(struct hdq_data
>  
>  }
>  
> -/*
> - * Enable clocks and set the controller to HDQ mode.
> - */
> -static int
> -omap_hdq_get(struct hdq_data *hdq_data)
> +/* Enable clocks and set the controller to HDQ mode */
> +static int omap_hdq_get(struct hdq_data *hdq_data)
>  {
>  	int ret = 0;
>  
> @@ -479,14 +461,12 @@ omap_hdq_get(struct hdq_data *hdq_data)
>  		}
>  	}
>  	mutex_unlock(&hdq_data->hdq_mutex);
> +
>  	return ret;
>  }
>  
> -/*
> - * Disable clocks to the module.
> - */
> -static int
> -omap_hdq_put(struct hdq_data *hdq_data)
> +/* Disable clocks to the module */
> +static int omap_hdq_put(struct hdq_data *hdq_data)
>  {
>  	int ret = 0;
>  
> @@ -507,12 +487,11 @@ omap_hdq_put(struct hdq_data *hdq_data)
>  		}
>  	}
>  	mutex_unlock(&hdq_data->hdq_mutex);
> +
>  	return ret;
>  }
>  
> -/*
> - * Read a byte of data from the device.
> - */
> +/* Read a byte of data from the device */
>  static u8 omap_w1_read_byte(void *_hdq)
>  {
>  	struct hdq_data *hdq_data = _hdq;
> @@ -547,9 +526,7 @@ static u8 omap_w1_read_byte(void *_hdq)
>  	return val;
>  }
>  
> -/*
> - * Write a byte of data to the device.
> - */
> +/* Write a byte of data to the device */
>  static void omap_w1_write_byte(void *_hdq, u8 byte)
>  {
>  	struct hdq_data *hdq_data = _hdq;
-- 
balbi
