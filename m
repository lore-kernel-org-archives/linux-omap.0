From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Tue, 25 Nov 2008 11:19:19 +0200
Message-ID: <1227604759.27458.16.camel@eenurkka-desktop>
References: <12275961701188-git-send-email-ext-eero.nurkkala@nokia.com>
	 <200811242327.12026.david-b@pacbell.net>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44495 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbYKYJWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:22:13 -0500
In-Reply-To: <200811242327.12026.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

Shortly: Restate the introductory header and resend the patches?

On Mon, 2008-11-24 at 23:27 -0800, ext David Brownell wrote:
> On Monday 24 November 2008, ext-eero.nurkkala@nokia.com wrote:
> > From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> > 
> > The amount of bytes to receive is read from wrong
> > place with omap 2430 and omap 3430.
> 
> More simply:  on all OMAPs with highspeed I2C support,
> which involves a FIFO and BUFSTAT_REG.
> 
> 
> > It is the 6 bits 
> > starting from the bit 8 from BUFSTAT_REG that indicate
> > this amount. Not the 8 LSB:s. Only 6 LSB:s are used
> > for the TX buffer. Moreover, only the 6 LSB:s are
> > relevant for XDR.
> > 
> > Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   25 +++++++++++++++++++------
> >  1 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 96f3bed..630702c 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -672,11 +672,19 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> >  			u8 num_bytes = 1;
> >  			if (dev->fifo_size) {
> 
> ... i.e. if (dev->rev >= OMAP_I2C_REV_ON_2430) ..
> 
> > -				if (stat & OMAP_I2C_STAT_RRDY)
> > +				if (stat & OMAP_I2C_STAT_RRDY) {
> >  					num_bytes = dev->fifo_size;
> > -				else
> > -					num_bytes = omap_i2c_read_reg(dev,
> > +				} else {
> > +					if (dev->rev >= OMAP_I2C_REV_ON_2430)
> > +						num_bytes =
> > +							(omap_i2c_read_reg(dev,
> > +							 OMAP_I2C_BUFSTAT_REG)
> > +							 >> 8) & 0x3F;
> > +					else
> > +						num_bytes =
> > +							omap_i2c_read_reg(dev,
> >  							OMAP_I2C_BUFSTAT_REG);
> 
> ... so this "else" branch is not needed, neither is the "if" test defining
> the two branches ...
> 
> 
> > +				}
> >  			}
> >  			while (num_bytes) {
> >  				num_bytes--;
> > @@ -711,11 +719,16 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
> >  			u8 num_bytes = 1;
> >  			if (dev->fifo_size) {
> 
> ... likewise ...
> 
> 
> > -				if (stat & OMAP_I2C_STAT_XRDY)
> > +				if (stat & OMAP_I2C_STAT_XRDY) {
> >  					num_bytes = dev->fifo_size;
> > -				else
> > -					num_bytes = omap_i2c_read_reg(dev,
> > +				} else {
> > +					num_bytes =
> > +						omap_i2c_read_reg(dev,
> >  							OMAP_I2C_BUFSTAT_REG);
> > +
> > +					if (dev->rev >= OMAP_I2C_REV_ON_2430)
> > +						num_bytes &= 0x3F;
> 
> ... and likewise.
> 
> 
> > +				}
> >  			}
> >  			while (num_bytes) {
> >  				num_bytes--;
> > -- 
> > 1.6.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 

