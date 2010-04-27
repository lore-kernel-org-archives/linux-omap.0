From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR
 interrupt
Date: Tue, 27 Apr 2010 08:00:34 -0700
Message-ID: <20100427150034.GZ7225@atomide.com>
References: <1272379645-20523-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56287 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab0D0PAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 11:00:35 -0400
Content-Disposition: inline
In-Reply-To: <1272379645-20523-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, "Kalliguddi, Hema" <hemahk@ti.com>, Nishanth Menon <nm@ti.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>

* Manjunatha GK <manjugk@ti.com> [100427 07:21]:
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -199,6 +199,7 @@ struct omap_i2c_dev {
>  	u16			bufstate;
>  	u16			syscstate;
>  	u16			westate;
> +	bool			errata_i207;
>  };

Thanks for updating this.

One more comment though to make this more generic for handling
the other errata for i2c-omap.

Can you please make errata_i207 to be just:

	u16			errata;

And then we can use it for handing all the i2c-omap errata.

You also need something like

#define I2C_OMAP_ERRATA_I207	(1 << 0)
  
>  const static u8 reg_map[] = {
> @@ -498,6 +499,12 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	/* Take the I2C module out of reset: */
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>  
> +	dev->errata_i207 = false;
> +
> +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +		dev->errata_i207 = true;
> +	}
> +
>  	/* Enable interrupts */
>  	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |

Then update this for for the bitmask too

	dev->errata = 0;

	if (cpu_is_omap2430() || cpu_is_omap34xx())
		dev->errata |= I2C_OMAP_ERRATA_I207;


> @@ -695,6 +702,34 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
>  	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
>  }
>  
> +static inline void i2c_omap_errata_i207(struct omap_i2c_dev *dev, u16 stat)
> +{
> +	/*
> +	 * I2C Errata(Errata Nos. OMAP2: 1.67, OMAP3: 1.8)
> +	 * Not applicable for OMAP4.
> +	 * Under certain rare conditions, RDR could be set again
> +	 * when the bus is busy, then ignore the interrupt and
> +	 * clear the interrupt.
> +	 */
> +	if (stat & OMAP_I2C_STAT_RDR) {
> +		/* Step 1: If RDR is set, clear it */
> +		omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
> +
> +		/* Step 2: */
> +		if(!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)

Here you should have a space after if (

> +						& OMAP_I2C_STAT_BB)) {
> +
> +			/* Step 3: */
> +			if(omap_i2c_read_reg(dev,OMAP_I2C_STAT_REG)
> +						& OMAP_I2C_STAT_RDR) {
> +				omap_i2c_ack_stat(dev,OMAP_I2C_STAT_RDR);
> +				dev_dbg(dev->dev,"RDR when the bus is busy.\n");
> +			}
> +
> +		}
> +	}
> +}
> +
>  /* rev1 devices are apparently only on some 15xx */
>  #ifdef CONFIG_ARCH_OMAP15XX
>  
> @@ -826,6 +861,10 @@ complete:
>  		}
>  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
>  			u8 num_bytes = 1;
> +
> +			if (dev->errata_i207)
> +				i2c_omap_errata_i207(dev, stat);
> +
>  			if (dev->fifo_size) {
>  				if (stat & OMAP_I2C_STAT_RRDY)
>  					num_bytes = dev->fifo_size;
> -- 

And here you would need to test for the bitmask instead.

Regards,

Tony
