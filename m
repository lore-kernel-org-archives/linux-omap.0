From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Mon, 10 Aug 2009 10:29:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908100950040.5505@utopia.booyaka.com>
References: <CD8CC2B65FEE304DA95744A5472698F202958D2F89@dlee06.ent.ti.com> <alpine.DEB.2.00.0908030054390.19529@utopia.booyaka.com> <CD8CC2B65FEE304DA95744A5472698F202959C0D61@dlee06.ent.ti.com>
 <CD8CC2B65FEE304DA95744A5472698F20295A89778@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33193 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbZHJQ3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 12:29:33 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F20295A89778@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hello Moiz,

On Mon, 10 Aug 2009, Sonasath, Moiz wrote:

> I did some analysis and testing of the code with threshold set to zero, 
> we cannot make the threshold zero with the present code in place, as 
> this would hamper the functionality of the draining feature because in 
> this case the XDR interrupt will not be triggered.
> 
> XDR-> when TX FIFO level equal/below the XTRSH AND TXSTAT is less than XTRSH
> 
> XRDY-> when TX FIFO level equal/below the XTRSH AND TXSTAT is 
> equal/greater than XTRSH
> 
> This in turn causes XRDY to be triggered always (even when there are 
> only last few bytes left to be transmitted) and therefore the code tries 
> to transmit data when the upper application is out of data.

Thanks for looking into this.  How about just changing

	if (dev->fifo_size) {
		if (stat & OMAP_I2C_STAT_XRDY)
			num_bytes = dev->fifo_size;
		else    /* read TXSTAT on XDR interrupt */
			num_bytes = omap_i2c_read_reg(dev,
					    OMAP_I2C_BUFSTAT_REG)
					    & 0x3F;
	}

to something like:

	if (dev->fifo_size) {   /* 2430 and beyond */
		if (stat & OMAP_I2C_STAT_XRDY)
			num_bytes = clamp(dev->buf_len, 1, dev->fifo_size);
	        else
		        num_bytes = omap_i2c_read_reg(dev,							
                                         OMAP_I2C_BUFSTAT_REG)
		 			 & 0x3F;
        }

in the ISR?

The transmit and receive FIFO thresholds should also be split, so the 
short transmit FIFO threshold doesn't affect the receive FIFO threshold.

> I checked with the I2C IP team, yes the errata applies to the I2C block 
> on OMAP2430 and OMAP2420. I will send out a patch to include OMAP24XX 
> for this erratum.

Great, thanks for checking this.  Might as well combine it with the same 
patch and make it a revision test based on the I2C controller revision 
reg.


- Paul
