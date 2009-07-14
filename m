From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Tue, 14 Jul 2009 18:23:25 -0500
Message-ID: <4A5D136D.8030701@ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFE@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39721 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbZGNXXc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jul 2009 19:23:32 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202957C7AFE@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>

Sonasath, Moiz wrote:
> When an XRDY/XDR is hit, wait for XUDF before writing data to DATA_REG.
> Otherwise some data bytes can be lost while transferring them from the
> memory to the I2C interface.
> 
> Do a Busy-wait for XUDF, before writing data to DATA_REG. While waiting
> if there is NACK | AL, set the appropriate error flags, ack the pending
> interrupts and return from the ISR.
> 
> Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
> Signed-off-by: Vikram Pandita<vikram.pandita@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   24 +++++++++++++++++++++++-
>  1 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 05b5e4c..8deaf87 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -672,9 +672,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  			break;
>  		}
>  
> +		err = 0;
> +complete:
cant we rename this label?
>  		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
>  
> -		err = 0;
>  		if (stat & OMAP_I2C_STAT_NACK) {
>  			err |= OMAP_I2C_STAT_NACK;
>  			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> @@ -764,6 +765,27 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  							"data to send\n");
>  					break;
>  				}
> +
> +				/*
> +				 * OMAP3430 Errata 1.153: When an XRDY/XDR
> +				 * is hit, wait for XUDF before writing data
> +				 * to DATA_REG. Otherwise some data bytes can
> +				 * be lost while transferring them from the
> +				 * memory to the I2C interface.
> +				 */
> +
> +				if (cpu_is_omap34xx()) {
> +						while (!(stat & OMAP_I2C_STAT_XUDF)) {
> +							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> +								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
generic comment - code nesting is getting overwhelming - we may like to 
refactor the isr function at a later date I think..
> +								err |= OMAP_I2C_STAT_XUDF;
why set the err if we wantedly force this to happen?
> +								goto complete;

> +							}
> +							cpu_relax();
> +							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +						}
this is an infinite while loop + it tries to handle error cases - 
essentially do another isr routine inside itself.


How about:
Apply [1] and the following?
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ad8d201..e3f21af 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -728,6 +728,12 @@ omap_i2c_isr(int this_irq, void *dev_id)
                 }
                 if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
                         u8 num_bytes = 1;
+                       if (cpu_is_omap34xx() &&
+                               !(stat & OMAP_I2C_STAT_XUDF)){
+                               cpu_relax();
+                               continue;
+                       }
+
                         if (dev->fifo_size) {
                                 if (stat & OMAP_I2C_STAT_XRDY)
                                         num_bytes = dev->fifo_size;


Regards,
Nishanth Menon
Ref:
[1] http://patchwork.kernel.org/patch/32332/
