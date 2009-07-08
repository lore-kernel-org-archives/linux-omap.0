From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
 errata 1.153
Date: Wed, 8 Jul 2009 13:21:56 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202957C70A0@dlee06.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com>
 <alpine.DEB.2.00.0906221922020.9637@utopia.booyaka.com>
 <alpine.DEB.2.00.0907081043200.18889@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46034 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbZGHSWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jul 2009 14:22:07 -0400
In-Reply-To: <alpine.DEB.2.00.0907081043200.18889@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "Kamat, Nishant" <nskamat@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hello Paul!

I am working on this issue and will get back soon.

Regards
Moiz Sonasath
Linux Baseport Team, Dallas
214-567-5514


-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Wednesday, July 08, 2009 11:51 AM
To: Sonasath, Moiz
Cc: linux-omap@vger.kernel.org; Pakaravoor, Jagadeesh; Kamat, Nishant; Pandita, Vikram
Subject: Re: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon errata 1.153

Hello Moiz, Nishant, Jagadeesh,

Any plans to respond to these comments?  

- Paul

On Mon, 22 Jun 2009, Paul Walmsley wrote:

> Moiz, Nishant, Jagadeesh,
> 
> Looks like this patch has some serious problems.
> 
> On Mon, 22 Jun 2009, Sonasath, Moiz wrote:
> 
> > This patch includes the workarround for I2C Errata 1.153: When an 
> > XRDY/XDR is hit, wait for XUDF before writing data to DATA_REG
> > 
> > Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> > Signed-off by: Nishant Kamat <nskamat@ti.com>
> > Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   54 +++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 50 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index ece0125..e84836b 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -632,6 +632,37 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
> >  #define omap_i2c_rev1_isr		NULL
> >  #endif
> >  
> > +/* I2C Errata 1.153:
> > + * When an XRDY/XDR is hit, wait for XUDF before writing data to DATA_REG.
> > + * Otherwise some data bytes can be lost while transferring them from the
> > + * memory to the I2C interface.
> > + */
> > +
> > +static int omap_i2c_wait_for_xudf(struct omap_i2c_dev *dev)
> > +{
> > +	u16 xudf;
> > +	int counter = 500;
> 
> Shouldn't the timeout threshold depend on the I2C bus speed and transmit 
> FIFO threshold?
> 
> > +
> > +	/* We are in interrupt context. Wait for XUDF for max 7 msec */
> 
> There's no way an interrupt service routine should loop for up to 7 
> milliseconds.  Why does it need to wait this long?  Shouldn't this patch 
> zero the transmit FIFO threshold to minimize the amount of time between 
> XRDY/XDR and XUDF?
> 
> > +	xudf = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> > +	while (!(xudf & OMAP_I2C_STAT_XUDF) && counter--) {
> 
> Why is a separate I2C_STAT loop used here?  Shouldn't this patch just use 
> the existing I2C_STAT loop in the ISR and use a state variable to indicate 
> the current state of the ISR?
> 
> > +		if (xudf & (OMAP_I2C_STAT_ROVR | OMAP_I2C_STAT_NACK |
> > +			    OMAP_I2C_STAT_AL))
> > +			return -EINVAL;
> > +		udelay(10);
> 
> udelay() in an ISR is a big red flag.  Why is this needed?
> 
> > +		xudf = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> > +	}
> > +
> > +	if (!counter) {
> > +		/* Clear Tx FIFO */
> > +		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
> > +				OMAP_I2C_BUF_TXFIF_CLR);
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static irqreturn_t
> >  omap_i2c_isr(int this_irq, void *dev_id)
> >  {
> > @@ -639,6 +670,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  	u16 bits;
> >  	u16 stat, w;
> >  	int err, count = 0;
> > +	int error;
> >  
> >  	if (dev->idle)
> >  		return IRQ_NONE;
> > @@ -647,7 +679,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
> >  		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
> >  		if (count++ == 100) {
> > -			dev_warn(dev->dev, "Too much work in one IRQ\n");
> > +			dev_dbg(dev->dev, "Too much work in one IRQ\n");
> >  			break;
> >  		}
> >  
> > @@ -715,11 +747,22 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  							OMAP_I2C_BUFSTAT_REG);
> >  			}
> >  			while (num_bytes) {
> > -				num_bytes--;
> >  				w = 0;
> >  				if (dev->buf_len) {
> > +					if (cpu_is_omap34xx()) {
> > +						/* OMAP3430 Errata 1.153 */
> 
> What about this I2C IP block on previous chip versions?  Is this problem 
> also present on 2430, which also has FIFO transmit capability?
> 
> > +						error = omap_i2c_wait_for_xudf(dev);
> > +						if (error) {
> > +							omap_i2c_ack_stat(dev, stat &
> > +								(OMAP_I2C_STAT_XRDY |
> > +								 OMAP_I2C_STAT_XDR));
> > +							dev_err(dev->dev, "Transmit error\n");
> > +							omap_i2c_complete_cmd(dev, OMAP_I2C_STAT_XUDF);
> > +
> > +							return IRQ_HANDLED;
> > +						}
> > +					}
> >  					w = *dev->buf++;
> > -					dev->buf_len--;
> >  					/* Data reg from  2430 is 8 bit wide */
> >  					if (!cpu_is_omap2430() &&
> >  							!cpu_is_omap34xx()) {
> > @@ -728,6 +771,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  							dev->buf_len--;
> >  						}
> >  					}
> > +					omap_i2c_write_reg(dev,
> > +						OMAP_I2C_DATA_REG, w);
> > +					num_bytes--;
> > +					dev->buf_len--;
> >  				} else {
> >  					if (stat & OMAP_I2C_STAT_XRDY)
> >  						dev_err(dev->dev,
> > @@ -739,7 +786,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  							"data to send\n");
> >  					break;
> >  				}
> > -				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
> >  			}
> >  			omap_i2c_ack_stat(dev,
> >  				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

