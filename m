From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Wed, 11 Mar 2009 17:55:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52341 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZCKXzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 19:55:53 -0400
In-Reply-To: <20090310005222.GE19758@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Cc: Ben Dooks <ben@fluff.org.uk>, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Hello Ari et al.,

On Tue, 10 Mar 2009, Ben Dooks wrote:

> On Fri, Mar 06, 2009 at 03:34:54PM +0200, Ari Kauppi wrote:
> > I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
> > (and thus LOCKDEP) are disabled.
> > 
> > Applying Richard Woodruff's 'I2C bug fixes for L-O and L-Z' seems to help
> > but IRQF_DISABLED is needed for proper behaviour.
> > 
> > Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
> > Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 0c3ed41..18af43f 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -847,7 +847,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  	omap_i2c_init(dev);
> >  
> >  	isr = (dev->rev < OMAP_I2C_REV_2) ? omap_i2c_rev1_isr : omap_i2c_isr;
> > -	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
> > +	r = request_irq(dev->irq, isr, IRQF_DISABLED, pdev->name, dev);
> 
> Is disabling all IRQs on the system the right thing to do?

Ben's right, there shouldn't be any need for this.  This patch could cause 
some unnecessary interrupt service latency.

Ari, are you seeing "Spurious irq XX: XXXXXXXX, please flush posted write 
for irq" messages?  If so, the correct fix for this is to read from the 
device interrupt status register immediately after writing to it.  This 
forces the ARM to wait until the write to the device is complete.  Ari, 
could you make this change to i2c-omap.c:omap_i2c_isr() instead, and test 
whether this fixes the problem?

+ u32 tmp;

...

  omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
+ tmp = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG); /* OCP barrier */



- Paul
