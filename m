From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/2] spi: Add hook on suspend/resume for spi master
Date: Wed, 10 Nov 2010 08:58:25 -0700
Message-ID: <20101110155825.GB2266@angua.secretlab.ca>
References: <4CDA74D6.1040107@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57099 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab0KJP62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 10:58:28 -0500
Received: by pzk28 with SMTP id 28so128415pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 07:58:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDA74D6.1040107@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, Nov 10, 2010 at 11:32:54AM +0100, Gregory CLEMENT wrote:
> Some spi masters need to do some actions when system is going to suspend
> or when it will be resumed.
> Spi driver offer possibility to handle suspend and resume only for device.
> Spi master will do its suspend actions after the devices and will do
> its resume action before the devices.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

As stated in my reply to patch 2, this looks to be working around a
bug in the omap spi_master driver.  It does not make sense to hook
into the spi_device suspend/resume path to fix it.

g.

> ---
>  drivers/spi/spi.c       |   14 ++++++++++++++
>  include/linux/spi/spi.h |    5 +++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 709c836..1094aef 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -106,6 +106,11 @@ static int spi_suspend(struct device *dev,
> pm_message_t message)
>  {
>  	int			value = 0;
>  	struct spi_driver	*drv = to_spi_driver(dev->driver);
> +	struct spi_device 	*spi_dev = to_spi_device(dev);
> +	struct spi_master 	*master = NULL;
> +
> +	if (spi_dev)
> +		master = spi_dev->master;
>   	/* suspend will stop irqs and dma; no more i/o */
>  	if (drv) {
> @@ -114,6 +119,9 @@ static int spi_suspend(struct device *dev,
> pm_message_t message)
>  		else
>  			dev_dbg(dev, "... can't suspend\n");
>  	}
> +	if (master && master->suspend )
> +		master->suspend(spi_dev);
> +
>  	return value;
>  }
>  @@ -121,7 +129,11 @@ static int spi_resume(struct device *dev)
>  {
>  	int			value = 0;
>  	struct spi_driver	*drv = to_spi_driver(dev->driver);
> +	struct spi_device 	*spi_dev = to_spi_device(dev);
> +	struct spi_master 	*master = NULL;
>  +	if (spi_dev)
> +		master = spi_dev->master;
>  	/* resume may restart the i/o queue */
>  	if (drv) {
>  		if (drv->resume)
> @@ -129,6 +141,8 @@ static int spi_resume(struct device *dev)
>  		else
>  			dev_dbg(dev, "... can't resume\n");
>  	}
> +	if (master && master->resume )
> +		master->resume(spi_dev);
>  	return value;
>  }
>  diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index b4d7710..e98c630 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -307,6 +307,11 @@ struct spi_master {
>   	/* called on release() to free memory provided by spi_master */
>  	void			(*cleanup)(struct spi_device *spi);
> +
> +	/* called on suspend() and resume() if spi_master has to do
> +	 * some actions */
> +	void (*suspend)(struct spi_device *spi);
> +	void (*resume)(struct spi_device *spi);
>  };
>   static inline void *spi_master_get_devdata(struct spi_master *master)
> -- 
> 1.7.0.4
> 
> 
