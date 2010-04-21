From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR
 interrupt
Date: Wed, 21 Apr 2010 14:52:21 -0700
Message-ID: <20100421215221.GN18272@atomide.com>
References: <1271661262-10538-1-git-send-email-manjugk@ti.com>
 <20100420001633.GM32401@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100420001633.GM32401-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Aaro Koskinen <Aaro.Koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> [100419 17:12]:
> On Mon, Apr 19, 2010 at 12:44:22PM +0530, Manjunatha GK wrote:
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
> 
> If people can give me a yes/no before the end of play tomorrow (ie,
> 2300GMT) then I will get this applied to for-linus/i2c and send it
> for -rc.

This should be done as an inline function based on some flags set
during the init instead of testing for some constantly changing
combination of cpu_is_omapxxxx() macros.

IMHO, let's not keep piling up hacks.

Regards,

Tony

> > Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> > Cc: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
> > Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > Cc: Aaro Koskinen <Aaro.Koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > 
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index f2019d2..8309eac 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -796,6 +796,34 @@ complete:
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
> > +				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
> > +
> > +				/* Step 2: */
> > +				if(!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
> > +							& OMAP_I2C_STAT_BB)) {
> > +					/* Step 3: */
> > +					if(omap_i2c_read_reg(dev,
> > +						OMAP_I2C_STAT_REG)
> > +							& OMAP_I2C_STAT_RDR) {
> > +						omap_i2c_ack_stat(dev,
> > +							OMAP_I2C_STAT_RDR);
> > +						dev_err(dev->dev,
> > +						"RDR when the bus is busy.\n");
> > +						continue;
> > +					}
> > +
> > +				}
> > +			}
> >  			if (dev->fifo_size) {
> >  				if (stat & OMAP_I2C_STAT_RRDY)
> >  					num_bytes = dev->fifo_size;
> > -- 
> > 1.6.0.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
