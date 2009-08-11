From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Tue, 11 Aug 2009 11:33:11 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F20295A89A21@dlee06.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202958D2F89@dlee06.ent.ti.com>
 <alpine.DEB.2.00.0908030054390.19529@utopia.booyaka.com>
 <CD8CC2B65FEE304DA95744A5472698F202959C0D61@dlee06.ent.ti.com>
 <CD8CC2B65FEE304DA95744A5472698F20295A89778@dlee06.ent.ti.com>
 <alpine.DEB.2.00.0908100950040.5505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49095 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494AbZHKQdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 12:33:18 -0400
In-Reply-To: <alpine.DEB.2.00.0908100950040.5505@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hello Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, August 10, 2009 11:30 AM
> To: Sonasath, Moiz
> Cc: linux-i2c@vger.kernel.org; linux-omap@vger.kernel.org; Menon,
> Nishanth; Pandita, Vikram
> Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
> 
> Hello Moiz,
> 
> On Mon, 10 Aug 2009, Sonasath, Moiz wrote:
> 
> > I did some analysis and testing of the code with threshold set to zero,
> > we cannot make the threshold zero with the present code in place, as
> > this would hamper the functionality of the draining feature because in
> > this case the XDR interrupt will not be triggered.
> >
> > XDR-> when TX FIFO level equal/below the XTRSH AND TXSTAT is less than
> XTRSH
> >
> > XRDY-> when TX FIFO level equal/below the XTRSH AND TXSTAT is
> > equal/greater than XTRSH
> >
> > This in turn causes XRDY to be triggered always (even when there are
> > only last few bytes left to be transmitted) and therefore the code tries
> > to transmit data when the upper application is out of data.
> 
> Thanks for looking into this.  How about just changing
> 
> 	if (dev->fifo_size) {
> 		if (stat & OMAP_I2C_STAT_XRDY)
> 			num_bytes = dev->fifo_size;
> 		else    /* read TXSTAT on XDR interrupt */
> 			num_bytes = omap_i2c_read_reg(dev,
> 					    OMAP_I2C_BUFSTAT_REG)
> 					    & 0x3F;
> 	}
> 
> to something like:
> 
> 	if (dev->fifo_size) {   /* 2430 and beyond */
> 		if (stat & OMAP_I2C_STAT_XRDY)
> 			num_bytes = clamp(dev->buf_len, 1, dev->fifo_size);
> 	        else
> 		        num_bytes = omap_i2c_read_reg(dev,
> 
>                                          OMAP_I2C_BUFSTAT_REG)
> 		 			 & 0x3F;
>         }
> 
> in the ISR?
> 
> The transmit and receive FIFO thresholds should also be split, so the
> short transmit FIFO threshold doesn't affect the receive FIFO threshold.
> 

Thanks Paul for suggesting this, it definitely works. But there are a few things that I would like to discuss:

1. From the code we have in place now, we are writing 
num_bytes=dev->fifosize(=XTRSH+1) bytes in case of XRDY OR
num_bytes=TXSTAT (last few bytes left) in case of XDR (draining feature)

Without the errata we were writing these num_bytes in a while loop one by one into I2C_DATA reg (TXFIFO).

With the errata we are writing num_bytes in a while loop, but now we write one byte wait for XUDF bit to get set and then write another byte. Thereby, we write a byte, wait for it to get out of the TXFIFO and only then we write the second byte and so on. 

	While(num_bytes)
	{
		Write one byte to I2C_DATA Reg
		Wait for XUDF to set
	}
	Ack the interrupt

So irrespective of the XTRSH value, the wait time is actually the same.

2. Now if we see it from the perspective of interrupts, we are generating an interrupt after every chunk of 4 bytes (with XTRSH+1=4) written to the TXFIFO because we ACK the interrupt after writing a chunk of 4 bytes (one byte at a time waiting for the XUDF bit to be set in between each byte). 

>From the TRM Figure-18-31, in the XRDY path:
Write I2Ci.I2C_DATA register for (XTRSH+1) times and then clear XRDY interrupt

Thus, XTRSH is actually driving how many chunks of data you write before generating a next interrupt. So from this point of view it will be more desirable to make the XTRSH=7 and write chunk of 8 bytes before generating a new interrupt. But we end up staying a longer time in the ISR.

Essentially we are looking at a tradeoff between:
1. Lower XTRSH value: More number of interrupts, less time in an ISR  
2. Higher XTRSH value: Less number of interrupts, more time in an ISR 

Please correct me if I am wrong.

> > I checked with the I2C IP team, yes the errata applies to the I2C block
> > on OMAP2430 and OMAP2420. I will send out a patch to include OMAP24XX
> > for this erratum.
> 
> Great, thanks for checking this.  Might as well combine it with the same
> patch and make it a revision test based on the I2C controller revision
> reg.
> 
> 
> - Paul

Regards
Moiz Sonasath
