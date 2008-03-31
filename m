From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C: Fix twl4030 timeouts on omap3430
Date: Mon, 31 Mar 2008 17:30:13 +0300
Message-ID: <20080331143011.GO26502@atomide.com>
References: <20080328084139.GJ24896@atomide.com> <20080331104332.GH26502@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54642 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbYCaOad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 10:30:33 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1JgL1s-000HEq-BZ
	for linux-omap@vger.kernel.org; Mon, 31 Mar 2008 14:30:32 +0000
Content-Disposition: inline
In-Reply-To: <20080331104332.GH26502@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080331 13:43]:
> * Tony Lindgren <tony@atomide.com> [080328 10:41]:
> > Hi all,
> > 
> > This helps with the annoying I2C timeouts. Does anybody have an idea
> > why the twl4030 chip does not like doing multiple transfers in a row?
> > 
> > To me the only difference seems to be that clocks are idled between
> > writing the twl4030 register and reading the register value.
> 
> I'll push this today with a REVISIT comment added.

Looks like this kills twl4030 interrupts, so I've reverted it.

Tony

> > From 25c4c8f449819cb6f40b59ed1a9b25ebcc7cd72e Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Thu, 27 Mar 2008 19:05:30 +0200
> > Subject: [PATCH] I2C: Fix twl4030 timeouts on omap3430
> > 
> > For some reason doing a twl4030 write-read cycle can hang the I2C bus
> > on omap3430. And doing the write and read separately in twl4030_i2c_read()
> > seems to fix the problem...
> > 
> > Not intended for applying, just a temporary workaround.
> > 
> > diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
> > index ded86e7..62868b0 100644
> > --- a/drivers/i2c/chips/twl4030-core.c
> > +++ b/drivers/i2c/chips/twl4030-core.c
> > @@ -327,6 +327,7 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
> >  		return -EPERM;
> >  	}
> >  	mutex_lock(&twl->xfer_lock);
> > +
> >  	/* [MSG1] fill the register address data */
> >  	msg = &twl->xfer_msg[0];
> >  	msg->addr = twl->address;
> > @@ -334,18 +335,25 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
> >  	msg->flags = 0;	/* Read the register value */
> >  	val = twl4030_map[mod_no].base + reg;
> >  	msg->buf = &val;
> > +	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 1);
> > +	if (ret < 0)
> > +		goto out;
> > + 
> >  	/* [MSG2] fill the data rx buffer */
> >  	msg = &twl->xfer_msg[1];
> >  	msg->addr = twl->address;
> >  	msg->flags = I2C_M_RD;	/* Read the register value */
> >  	msg->len = num_bytes;	/* only n bytes */
> >  	msg->buf = value;
> > -	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 2);
> > +	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 1);
> > +
> > +out:
> >  	mutex_unlock(&twl->xfer_lock);
> >  
> >  	/* i2cTransfer returns num messages.translate it pls.. */
> >  	if (ret >= 0)
> >  		ret = 0;
> > +
> >  	return ret;
> >  }
> >  
> 
