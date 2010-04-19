From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v3] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR
 interrupt
Date: Tue, 20 Apr 2010 00:53:42 +0100
Message-ID: <20100419235342.GH32401@fluff.org.uk>
References: <1271330087-26084-1-git-send-email-manjugk@ti.com>
 <4BC701B0.6060309@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BC701B0.6060309-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 15, 2010 at 03:08:16PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> Manjunatha GK wrote:
> > Under certain rare conditions, I2C_STAT[13].RDR bit may be set
> > and the corresponding interrupt fire, even there is no data in
> > the receive FIFO, or the I2C data transfer is still ongoing.
> > These spurious RDR events must be ignored by the software.
> > 
> > This patch handles and ignores RDR spurious interrupts.
> > 
> > The below sequence is required in interrupt handler for
> > handling this errata:
> > 1. If RDR is set to 1, clear RDR
> > 2. Read I2C status register and check for BusBusy bit. If BusBusy
> > bit is set, skip remaining steps.
> > 3. If BusBusy bit is not set, perform read operation on I2C status
> > register.
> > 4. If RDR is set, clear the same. Check RDR again and clear if it sets
> > RDR bit again.
> > 5. Perform I2C Data Read operation N number of times(where N is value
> > read from the register BUFSTAT-RXSTAT bit fields).
> > 
> > Note : This errata is applicable for OMAP2 and OMAP3 platforms only.
> > It is not applicable for OMAP4.
> > 
> > Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> > Cc: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
> > Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > 
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index ae6f5c1..d1648da 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -733,6 +733,34 @@ complete:
> >  		}
> >  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> >  			u8 num_bytes = 1;
> > +
> > +			/*
> > +			 * I2C Errata(Errata Nos. OMAP2: 1.67, OMAP3: 1.8)
> > +			 * Not applicable for OMAP4.
> > +			 * Under certain rare conditions, RDR could be set again
> > +			 * when the bus is busy, then ignore the interrupt and
> > +			 * clear the interrupt.
> > +			 */
> > +			if ((stat & OMAP_I2C_STAT_RDR) && !cpu_is_omap44xx()) {
> > +				/* Step 1: If RDR is set, clear it */
> > +				omap_i2c_ack_stat(dev, stat & OMAP_I2C_STAT_RDR);
> 
> You know the bit is set, so just: omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
> 
> > +
> > +				/* Step 2: */
> > +				if(!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
> > +							& OMAP_I2C_STAT_BB)) {
> > +					/* Step 3: */
> > +					if(omap_i2c_read_reg(dev,
> > +						OMAP_I2C_STAT_REG)
> > +							& OMAP_I2C_STAT_RDR) {
> > +						omap_i2c_ack_stat(dev, stat
> > +							& OMAP_I2C_STAT_RDR);
> 
> Same here.
> 
> > +						dev_err(dev->dev,
> > +						"I2C : RDR when the bus is busy.\n");
> 
> Remove the "I2C : " from the log, it's redundant.

I'd agree, we're already prefixing this with the device name and
driver name from the dev_err() call. No need to add any more.

If it is in use elsewhere in the file, I'd prefer to see it removed
from the other points.
 
> > +						continue;
> > +					}
> > +
> > +				}
> > +			}
> >  			if (dev->fifo_size) {
> >  				if (stat & OMAP_I2C_STAT_RRDY)
> >  					num_bytes = dev->fifo_size;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
