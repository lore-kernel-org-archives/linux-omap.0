From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU
 latency constraints
Date: Mon, 24 Sep 2012 09:29:48 -0700
Message-ID: <20120924162947.GD28835@atomide.com>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348157283-24119-1-git-send-email-j-pihet-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org> [120920 09:09]:
> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
> 
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
> 
> Signed-off-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>

Good to see this, probably should have an ack from
Kevin Hilman for this. Other than that it's best to
merge this via the i2c tree:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
> Rebased on git://git.pengutronix.de/git/wsa/linux.git, branch
> i2c-embedded/for-next
> ---
>  arch/arm/plat-omap/i2c.c      |   21 ---------------------
>  drivers/i2c/busses/i2c-omap.c |   32 ++++++++++++++++++--------------
>  include/linux/i2c-omap.h      |    1 -
>  3 files changed, 18 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index 40bc06a..d29a2cc 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -26,7 +26,6 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-omap.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> @@ -34,7 +33,6 @@
>  #include <mach/irqs.h>
>  #include <plat/mux.h>
>  #include <plat/i2c.h>
> -#include <plat/omap-pm.h>
>  #include <plat/omap_device.h>
>  
>  #define OMAP_I2C_SIZE		0x3f
> @@ -130,16 +128,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
>  
>  
>  #ifdef CONFIG_ARCH_OMAP2PLUS
> -/*
> - * XXX This function is a temporary compatibility wrapper - only
> - * needed until the I2C driver can be converted to call
> - * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
> - */
> -static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
> -{
> -	omap_pm_set_max_mpu_wakeup_lat(dev, t);
> -}
> -
>  static inline int omap2_i2c_add_bus(int bus_id)
>  {
>  	int l;
> @@ -171,15 +159,6 @@ static inline int omap2_i2c_add_bus(int bus_id)
>  	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
>  	pdata->flags = dev_attr->flags;
>  
> -	/*
> -	 * When waiting for completion of a i2c transfer, we need to
> -	 * set a wake up latency constraint for the MPU. This is to
> -	 * ensure quick enough wakeup from idle, when transfer
> -	 * completes.
> -	 * Only omap3 has support for constraints
> -	 */
> -	if (cpu_is_omap34xx())
> -		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
>  	pdev = omap_device_build(name, bus_id, oh, pdata,
>  			sizeof(struct omap_i2c_bus_platform_data),
>  			NULL, 0, 0);
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0b02543..db31eae 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -43,6 +43,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c-omap.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
>  
>  /* I2C controller revisions */
>  #define OMAP_I2C_OMAP1_REV_2		0x20
> @@ -186,9 +187,8 @@ struct omap_i2c_dev {
>  	int			reg_shift;      /* bit shift for I2C register addresses */
>  	struct completion	cmd_complete;
>  	struct resource		*ioarea;
> -	u32			latency;	/* maximum mpu wkup latency */
> -	void			(*set_mpu_wkup_lat)(struct device *dev,
> -						    long latency);
> +	u32			latency;	/* maximum MPU wkup latency */
> +	struct pm_qos_request	pm_qos_request;
>  	u32			speed;		/* Speed of bus in kHz */
>  	u32			dtrev;		/* extra revision from DT */
>  	u32			flags;
> @@ -494,9 +494,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
>  		dev->b_hw = 1; /* Enable hardware fixes */
>  
>  	/* calculate wakeup latency constraint for MPU */
> -	if (dev->set_mpu_wkup_lat != NULL)
> -		dev->latency = (1000000 * dev->threshold) /
> -			(1000 * dev->speed / 8);
> +	dev->latency = (1000000 * dev->threshold) / (1000 * dev->speed / 8);
>  }
>  
>  /*
> @@ -631,8 +629,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	if (r < 0)
>  		goto out;
>  
> -	if (dev->set_mpu_wkup_lat != NULL)
> -		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
> +	/*
> +	 * When waiting for completion of a i2c transfer, we need to
> +	 * set a wake up latency constraint for the MPU. This is to
> +	 * ensure quick enough wakeup from idle, when transfer
> +	 * completes.
> +	 */
> +	if (dev->latency)
> +		pm_qos_add_request(&dev->pm_qos_request,
> +				   PM_QOS_CPU_DMA_LATENCY,
> +				   dev->latency);
>  
>  	for (i = 0; i < num; i++) {
>  		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
> @@ -640,8 +646,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  			break;
>  	}
>  
> -	if (dev->set_mpu_wkup_lat != NULL)
> -		dev->set_mpu_wkup_lat(dev->dev, -1);
> +	if (dev->latency)
> +		pm_qos_remove_request(&dev->pm_qos_request);
>  
>  	if (r == 0)
>  		r = num;
> @@ -1098,7 +1104,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  	} else if (pdata != NULL) {
>  		dev->speed = pdata->clkrate;
>  		dev->flags = pdata->flags;
> -		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
>  		dev->dtrev = pdata->rev;
>  	}
>  
> @@ -1154,9 +1159,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  			dev->b_hw = 1; /* Enable hardware fixes */
>  
>  		/* calculate wakeup latency constraint for MPU */
> -		if (dev->set_mpu_wkup_lat != NULL)
> -			dev->latency = (1000000 * dev->fifo_size) /
> -				       (1000 * dev->speed / 8);
> +		dev->latency = (1000000 * dev->fifo_size) /
> +			       (1000 * dev->speed / 8);
>  	}
>  
>  	/* reset ASAP, clearing any IRQs */
> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> index 92a0dc7..df804ba 100644
> --- a/include/linux/i2c-omap.h
> +++ b/include/linux/i2c-omap.h
> @@ -34,7 +34,6 @@ struct omap_i2c_bus_platform_data {
>  	u32		clkrate;
>  	u32		rev;
>  	u32		flags;
> -	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
>  };
>  
>  #endif
> -- 
> 1.7.7.6
> 
