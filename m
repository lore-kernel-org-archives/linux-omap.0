From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v5] OMAP2/3: I2C: Errata ID i207: Clear wrong RDR
 interrupt
Date: Wed, 28 Apr 2010 10:41:04 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F789D4D@dbde02.ent.ti.com>
References: <1272379645-20523-1-git-send-email-manjugk@ti.com>
 <20100427150034.GZ7225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54080 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab0D1FLa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 01:11:30 -0400
In-Reply-To: <20100427150034.GZ7225@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Menon, Nishanth" <nm@ti.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>


Tony,
Thanks for the inputs and suggestions for handling i2c-omap errata's in
generic way.


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Tuesday, April 27, 2010 8:31 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; linux-i2c@vger.kernel.org; 
> ben-linux@fluff.org; Kalliguddi, Hema; Menon, Nishanth; Aaro Koskinen
> Subject: Re: [PATCH v5] OMAP2/3: I2C: Errata ID i207: Clear 
> wrong RDR interrupt
> 
> * Manjunatha GK <manjugk@ti.com> [100427 07:21]:
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -199,6 +199,7 @@ struct omap_i2c_dev {
> >  	u16			bufstate;
> >  	u16			syscstate;
> >  	u16			westate;
> > +	bool			errata_i207;
> >  };
> 
> Thanks for updating this.
> 
> One more comment though to make this more generic for handling
> the other errata for i2c-omap.
> 
> Can you please make errata_i207 to be just:
> 
> 	u16			errata;
> 
> And then we can use it for handing all the i2c-omap errata.
> 
> You also need something like
> 
> #define I2C_OMAP_ERRATA_I207	(1 << 0)

Agreed. 

>   
> >  const static u8 reg_map[] = {
> > @@ -498,6 +499,12 @@ static int omap_i2c_init(struct 
> omap_i2c_dev *dev)
> >  	/* Take the I2C module out of reset: */
> >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> >  
> > +	dev->errata_i207 = false;
> > +
> > +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> > +		dev->errata_i207 = true;
> > +	}
> > +
> >  	/* Enable interrupts */
> >  	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
> >  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> 
> Then update this for for the bitmask too
> 
> 	dev->errata = 0;
> 
> 	if (cpu_is_omap2430() || cpu_is_omap34xx())
> 		dev->errata |= I2C_OMAP_ERRATA_I207;
> 
Ok. I will incorporate these changes in next version.

-Manjunath

