From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/3] [OMAP:I2C]Bug in reading the RXSTAT/TXSTAT values
 from the I2C_BUFFSTAT register
Date: Tue, 14 Jul 2009 17:42:08 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C011E5EDA06@dlee02.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AF8@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53291 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755965AbZGNWmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 18:42:17 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202957C7AF8@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sonasath, Moiz
> Sent: Tuesday, July 14, 2009 4:18 PM
> To: linux-omap@vger.kernel.org
> Cc: Kamat, Nishant; Paul Walmsley
> Subject: [PATCH 1/3] [OMAP:I2C]Bug in reading the RXSTAT/TXSTAT values
> from the I2C_BUFFSTAT register
> 
> 
> Fix bug in reading the I2C_BUFFSTAT register for getting byte count on
> RX/TX interrupt.
> 
> On Interrupt: I2C_STAT[RDR],
> 	read 'RXSTAT' from I2C_BUFFSTAT[8-13]
> On Interrupt: I2C_STAT[XDR]
> 	read 'TXSTAT' from I2C_BUFFSTAT[0-5]
> 
> Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
> Signed-off-by: Jagadeesh Pakaravoor<j-pakaravoor@ti.com>
> Signed-off-by: Vikram andita<vikram.pandita@ti.com>
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
> +					num_bytes = (omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG))
Minor - Remove that extra ()..                                 ^^
> +							& 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
Acked-by: Nishanth Menon <nm@ti.com>

Regards,
Nishanth Menon
