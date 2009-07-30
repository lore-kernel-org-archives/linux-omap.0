From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 1/3] [OMAP:I2C]Bug in reading the RXSTAT/TXSTAT values
	from the I2C_BUFFSTAT register
Date: Thu, 30 Jul 2009 01:07:51 +0100
Message-ID: <20090730000751.GF8850@fluff.org.uk>
References: <CD8CC2B65FEE304DA95744A5472698F202958D2F87@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:44963 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755602AbZG3AHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 20:07:52 -0400
Content-Disposition: inline
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202958D2F87@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jul 21, 2009 at 10:14:06AM -0500, Sonasath, Moiz wrote:
> Fix bug in reading the I2C_BUFFSTAT register for getting byte count on RX/TX interrupt.
> 
> On Interrupt: I2C_STAT[RDR],
> 	read 'RXSTAT' from I2C_BUFFSTAT[8-13]
> On Interrupt: I2C_STAT[XDR]
> 	read 'TXSTAT' from I2C_BUFFSTAT[0-5]
> 
> Signed-off-by: Jagadeesh Pakaravoor<j-pakaravoor@ti.com>
> Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
> Signed-off-by: Vikram pandita<vikram.pandita@ti.com>

IIRC, email addresses should have a space between the real name
and the address part. I've fixed this when applying as well as
changing all subjects to start i2c-omap:

> ---
>  drivers/i2c/busses/i2c-omap.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ad8d201..d280acf 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -692,9 +692,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  			if (dev->fifo_size) {
>  				if (stat & OMAP_I2C_STAT_RRDY)
>  					num_bytes = dev->fifo_size;
> -				else
> -					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG);
> +				else    /* read RXSTAT on RDR interrupt */
> +					num_bytes = (omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG)
> +							>> 8) & 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
> @@ -731,9 +732,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  			if (dev->fifo_size) {
>  				if (stat & OMAP_I2C_STAT_XRDY)
>  					num_bytes = dev->fifo_size;
> -				else
> -					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG);
> +				else    /* read TXSTAT on XDR interrupt */
> +					num_bytes = omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG)
> +							& 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
