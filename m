From: Tony Lindgren <tony@atomide.com>
Subject: Re: I2C: Fix unhandled fault in i2c-omap controller
Date: Mon, 17 Mar 2008 08:46:20 +0200
Message-ID: <20080317064619.GO11653@atomide.com>
References: <20080313155123.GI11653@atomide.com> <20080314185218.3fa69d19@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49436 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022AbYCQGq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 02:46:56 -0400
Content-Disposition: inline
In-Reply-To: <20080314185218.3fa69d19@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [080314 19:52]:
> On Thu, 13 Mar 2008 17:51:24 +0200, Tony Lindgren wrote:
> > Hi Jean,
> > 
> > Here's an omap I2C fix that would be nice to get into 2.6.25 if still
> > possible.
> 
> Review:

Thanks for looking throught it.

> 
> > commit 8e4f19286e68d38d589451ad2a10545f2c40032d
> > Author: Tony Lindgren <tony@atomide.com>
> > Date:   Mon Feb 18 20:16:00 2008 -0800
> > 
> >     I2C: Fix unhandled fault in i2c-omap controller
> >     
> >     If an I2C interrupt happens between disabling interface clock
> >     and functional clock, the interrupt handler will produce an
> >     external abort on non-linefetch error when trying to access
> >     driver registers while interface clock is disabled.
> >     
> >     This patch fixes the problem by saving and disabling i2c-omap
> >     interrupt before turning off the clocks. Also disable functional
> >     clock before the interface clock as suggested by Paul Walmsley.
> >     
> >     Patch also renames enable/disable_clocks functions to unidle/idle
> >     functions. Note that the driver is currently not taking advantage
> >     of the idle interrupts. To use the idle interrupts, driver would
> >     have to enable interface clock based on the idle interrupt
> >     and dev->idle flag.
> >     
> >     Cc: Paul Walmsley <paul@pwsan.com>
> >     Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index da66397..862dd69 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -128,6 +128,8 @@ struct omap_i2c_dev {
> >  	size_t			buf_len;
> >  	struct i2c_adapter	adapter;
> >  	unsigned		rev1:1;
> > +	unsigned		idle:1;
> > +	u16			iestate;	/* Saved interrupt register */
> >  };
> >  
> >  static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
> > @@ -174,18 +176,30 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
> >  	}
> >  }
> >  
> > -static void omap_i2c_enable_clocks(struct omap_i2c_dev *dev)
> > +static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> >  {
> >  	if (dev->iclk != NULL)
> >  		clk_enable(dev->iclk);
> >  	clk_enable(dev->fclk);
> > +	if (dev->iestate)
> > +		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> > +	dev->idle = 0;
> >  }
> >  
> > -static void omap_i2c_disable_clocks(struct omap_i2c_dev *dev)
> > +static void omap_i2c_idle(struct omap_i2c_dev *dev)
> >  {
> > +	u16 iv;
> > +
> > +	dev->idle = 1;
> > +	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> > +	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> > +	if (dev->rev1)
> > +		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
> 
> Reading OMAP_I2C_IV_REG but not doing anything with the value? This
> deserves at least a comment if this is done on purpose (but then I
> don't think you need the iv variable at all.)

Yeah for rev1 of the controller reading of IV (Interrupt Vector)
clears the interrupts. I'll add a comment there.

> 
> > +	else
> > +		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
> > +	clk_disable(dev->fclk);
> >  	if (dev->iclk != NULL)
> >  		clk_disable(dev->iclk);
> > -	clk_disable(dev->fclk);
> >  }
> >  
> >  static int omap_i2c_init(struct omap_i2c_dev *dev)
> > @@ -360,7 +374,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >  	int i;
> >  	int r;
> >  
> > -	omap_i2c_enable_clocks(dev);
> > +	omap_i2c_unidle(dev);
> >  
> >  	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
> >  		goto out;
> > @@ -374,7 +388,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >  	if (r == 0)
> >  		r = num;
> >  out:
> > -	omap_i2c_disable_clocks(dev);
> > +	omap_i2c_idle(dev);
> >  	return r;
> >  }
> >  
> > @@ -403,6 +417,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
> >  	struct omap_i2c_dev *dev = dev_id;
> >  	u16 iv, w;
> >  
> > +	if (dev->idle)
> > +		return IRQ_NONE;
> > +
> >  	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
> >  	switch (iv) {
> >  	case 0x00:	/* None */
> > @@ -457,6 +474,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  	u16 stat, w;
> >  	int count = 0;
> >  
> > +	if (dev->idle)
> > +		return IRQ_NONE;
> > +
> >  	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> >  	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
> >  		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
> > @@ -575,7 +595,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  	if ((r = omap_i2c_get_clocks(dev)) != 0)
> >  		goto err_free_mem;
> >  
> > -	omap_i2c_enable_clocks(dev);
> > +	omap_i2c_unidle(dev);
> >  
> >  	if (cpu_is_omap15xx())
> >  		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
> > @@ -610,7 +630,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  		goto err_free_irq;
> >  	}
> >  
> > -	omap_i2c_disable_clocks(dev);
> > +	omap_i2c_idle(dev);
> >  
> >  	return 0;
> >  
> > @@ -618,7 +638,7 @@ err_free_irq:
> >  	free_irq(dev->irq, dev);
> >  err_unuse_clocks:
> >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> > -	omap_i2c_disable_clocks(dev);
> > +	omap_i2c_idle(dev);
> >  	omap_i2c_put_clocks(dev);
> >  err_free_mem:
> >  	platform_set_drvdata(pdev, NULL);
> 
> The rest of the patch looks OK to me.
> 
> -- 
> Jean Delvare
