From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP3: I2C: Errata ID i207: Clear wrong RDR interrupt
Date: Wed, 14 Apr 2010 11:19:17 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F501834@dbde02.ent.ti.com>
References: <1271167302-17776-1-git-send-email-manjugk@ti.com>
 <4BC4A049.1090702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33109 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0DNFtg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 01:49:36 -0400
In-Reply-To: <4BC4A049.1090702@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "Kalliguddi, Hema" <hemahk@ti.com>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Tuesday, April 13, 2010 10:18 PM
> To: G, Manjunath Kondaiah
> Cc: linux-i2c@vger.kernel.org; linux-omap@vger.kernel.org; 
> ben-linux@fluff.org; Kalliguddi, Hema
> Subject: Re: [PATCH v2] OMAP3: I2C: Errata ID i207: Clear 
> wrong RDR interrupt
> 
> On 04/13/2010 07:01 AM, G, Manjunath Kondaiah wrote:
> > Under certain rare conditions, I2C_STAT[13].RDR bit may be set
> > and the corresponding interrupt fire, even there is no data in
> > the receive FIFO, or the I2C data transfer is still ongoing.
> > These spurious RDR events must be ignored by the software.
> >
> > This patch handles and ignores RDR spurious interrupts.
> >
> > Patch tested on OMAP zoom3 board.
> >
> > Signed-off-by: Manjunatha GK<manjugk@ti.com>
> > Cc: linux-omap@vger.kernel.org
> > Cc: linux-i2c@vger.kernel.org
> > Cc: ben-linux@fluff.org
> > Cc: Kalliguddi, Hema<hemahk@ti.com>
> > Cc: Nishanth Menon<nm@ti.com>
> > ---
> > Review comments for earlier post can be found at:
> > https://patchwork.kernel.org/patch/90122/
> Overall, the comments have not been implemented, so my NAK continues 
> unfortunately. please review the comments again.

This errata is applicable to OMAP2 and OMAP3 and not applicable to
OMAP4. I will update the same in patch description.

Rest of review comments will be taken care as explained below.

> 
> >
> >   drivers/i2c/busses/i2c-omap.c |   32 
> +++++++++++++++++++++++++++++++-
> >   1 files changed, 31 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c 
> b/drivers/i2c/busses/i2c-omap.c
> > index ae6f5c1..d4ec886 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -733,10 +733,40 @@ complete:
> >   		}
> >   		if (stat&  (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> >   			u8 num_bytes = 1;
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
> > +			if ((stat&  OMAP_I2C_STAT_RDR)&&  
> !cpu_is_omap44xx()) {
> > +				/* Step 1: If RDR is set, clear it */
> > +				omap_i2c_ack_stat(dev, stat&  
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
> continue in the inner while loop? NAK. should have been an if 
> condition 
> here.
It's my bad. I will fix it.
> 
> > +					}
> > +
> > +				}
> > +				else
> > +					return IRQ_HANDLED;
> using a continue is better as commented for patch v1.
Agreed.
> 
> > +			}
> >   			if (dev->fifo_size) {
> >   				if (stat&  OMAP_I2C_STAT_RRDY)
> >   					num_bytes = dev->fifo_size;
> > -				else    /* read RXSTAT on RDR 
> interrupt */
> > +				else  /* Step4: read RXSTAT on 
> RDR interrupt */
> dont really need this..

I have changed only comment. I will revert if it is not required.

-Manjunath