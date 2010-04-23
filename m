From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Fri, 23 Apr 2010 16:11:33 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E2897@dbde02.ent.ti.com>
References: <1271167302-17776-1-git-send-email-manjugk@ti.com>
 <20100421214252.GM18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46048 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab0DWKls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 06:41:48 -0400
In-Reply-To: <20100421214252.GM18272@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Menon, Nishanth" <nm@ti.com>


Tony, 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Thursday, April 22, 2010 3:13 AM
> To: G, Manjunath Kondaiah
> Cc: linux-i2c@vger.kernel.org; linux-omap@vger.kernel.org; 
> ben-linux@fluff.org; Kalliguddi, Hema; Menon, Nishanth
> Subject: Re: [PATCH v2] OMAP3: I2C: Errata ID i207: Clear 
> wrong RDR interrupt
> 
> * Manjunatha GK <manjugk@ti.com> [100413 06:32]:
> > Under certain rare conditions, I2C_STAT[13].RDR bit may be set
> > and the corresponding interrupt fire, even there is no data in
> > the receive FIFO, or the I2C data transfer is still ongoing.
> > These spurious RDR events must be ignored by the software.
> > 
> > This patch handles and ignores RDR spurious interrupts.
> > 
> > Patch tested on OMAP zoom3 board.
> > 
> > Signed-off-by: Manjunatha GK <manjugk@ti.com>
> > Cc: linux-omap@vger.kernel.org
> > Cc: linux-i2c@vger.kernel.org
> > Cc: ben-linux@fluff.org
> > Cc: Kalliguddi, Hema <hemahk@ti.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > ---
> > Review comments for earlier post can be found at:
> > https://patchwork.kernel.org/patch/90122/
> > 
> >  drivers/i2c/busses/i2c-omap.c |   32 
> +++++++++++++++++++++++++++++++-
> >  1 files changed, 31 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c 
> b/drivers/i2c/busses/i2c-omap.c
> > index ae6f5c1..d4ec886 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -733,10 +733,40 @@ complete:
> >  		}
> >  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> >  			u8 num_bytes = 1;
> > +
> > +			/*
> > +			 * I2C Errata(Errata Nos. OMAP2: 1.67, 
> OMAP3: 1.8)
> > +			 * Not applicable for OMAP4.
> > +			 * Under certain rare conditions, RDR 
> could be set again
> > +			 * when the bus is busy, then ignore 
> the interrupt and
> > +			 * clear the interrupt.
> > +			 */
> > +			if ((stat & OMAP_I2C_STAT_RDR) && 
> !cpu_is_omap44xx()) {
> > +				/* Step 1: If RDR is set, clear it */
> > +				omap_i2c_ack_stat(dev, stat & 
> OMAP_I2C_STAT_RDR);
> > +
> > +				/* Step 2: */
> > +				if(!(omap_i2c_read_reg(dev, 
> OMAP_I2C_STAT_REG)
> > +							& 
> OMAP_I2C_STAT_BB)) {
> > +					/* Step 3: */
> > +					while(omap_i2c_read_reg(dev,
> > +						OMAP_I2C_STAT_REG)
> > +							& 
> OMAP_I2C_STAT_RDR) {
> > +						
> omap_i2c_ack_stat(dev, stat
> > +							& 
> OMAP_I2C_STAT_RDR);
> > +						dev_err(dev->dev,
> > +						"I2C : RDR when 
> the bus is busy.\n");
> > +						continue;
> > +					}
> > +
> > +				}
> > +				else
> > +					return IRQ_HANDLED;
> > +			}
> 
> Please move these hacks into a separate inline function that 
> you initialize
> during the init. Then in the function you do it if 
> OMAP_I2C_QUIRK_1234 flag
> has been set.
> 
> In general, it seems that a lot of TI omap4 patches just do:
> 
> if (!cpu_is_omap4430()) {
> 	indent_old_code_even_more
> 	...
> } else {
> 	add_hacks_for_omap4
> 	...
> }
> 
> And sprinkle that all over the place.
> 
> This is not a maintainable way of doing things. Please do something
> like this instead:
> 
> #ifdef CONFIG_ARCH_OMAP4
> static inline void omap_i2c_quirk_1234(struct device *dev)
> {
> 	/* Do hacks here */	
> }
> #else
> static inline void omap_i2c_quirk_1234(struct device *dev)
> {
> }
> #endif

This might create issue for multi omap build?

-Manjunath