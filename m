From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] OMAP3: I2C: Errata i207: Clear wrong RDR interrupt
Date: Wed, 21 Apr 2010 16:09:42 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6476AA@dbde02.ent.ti.com>
References: <1270124427-11208-1-git-send-email-manjugk@ti.com>
 <4BB4A540.9080000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BB4A540.9080000-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "Nataraju, Kiran" <knataraju-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Sorry for reopening closed discussion thread. 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, April 01, 2010 7:23 PM
> To: G, Manjunath Kondaiah
> Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Kalliguddi, Hema
> Subject: Re: [PATCH] OMAP3: I2C: Errata i207: Clear wrong RDR 
> interrupt
> 
> G, Manjunath Kondaiah had written, on 04/01/2010 07:20 AM, 
> the following:
> > Under certain rare conditions, I2C_STAT[13].RDR bit may be set
> > and the corresponding interrupt fire, even there is no data in
> > the receive FIFO, or the I2C data transfer is still ongoing.
> > These spurious RDR events must be ignored by the software.
> > 
> > This patch handles and ignores RDR spurious interrupts.
> > 
> > Reviewed-by: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
> > Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> > Cc: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c 
> b/drivers/i2c/busses/i2c-omap.c
> > index f2019d2..acf4076 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -796,6 +796,19 @@ complete:
> >  		}
> >  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> >  			u8 num_bytes = 1;
> > +
> > +			/*
> > +			 * OMAP3 I2C Errata ID: i207
> > +			 * Under certain rare conditions, RDR 
> could be set again
> > +			 * when the bus is busy, then clear and 
> ignore the interrupt
> > +			 */
> > +			if (!(stat & OMAP_I2C_STAT_RRDY) && (stat &
> > +						OMAP_I2C_STAT_BB)) {
> > +				/* clear RDR */
> > +				omap_i2c_ack_stat(dev, stat & 
> OMAP_I2C_STAT_RDR);
> > +				dev_err(dev->dev, "I2C: RDR 
> when bus is busy.\n");
> > +				return IRQ_HANDLED;
> > +			}
> couple of comments after reading thru the errata:
> a) the sequence in the errata doc is:
> if (stat & OMAP_I2C_STAT_RDR) { /* This is cleaner that using 
> an obtuse 
> check using !(stat & OMAP_I2C_STAT_RRDY) */
> 	omap_i2c_ack_stat(dev, stat & OMAP_I2C_STAT_RDR); /* 
> dummy read - i 
> think this needs clarification as to why */
> 	if (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & 
> OMAP_I2C_STAT_BB) /* 
> reason for the i2c_read_reg is because errata mentions a 
> dummy stat read 
>   which might mean something for BB -> I am not sure may need to be 
> checked with H/w team. */
> 		continue; /* recheck - faster response compared 
> to return and re 
> generate interrupt */

The idea of using "continue" seems to be resulting in losing RDR data when
errata sequence is hit(observed on one of the 3630sdp).

If errata workaround is not mentioning about this "continue" logic, then
why should we use it here?

Thanks to kiran for identifying issue with latest errata fix version(v3/v4).

We need to remove "continue" from this logic. If it is acceptable, I will post
V5 version.

-Manjunath--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
