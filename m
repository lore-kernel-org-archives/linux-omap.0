From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
 errata 1.153
Date: Tue, 23 Jun 2009 04:55:05 -0500
Message-ID: <DFEF307E035C8647B119E6A60DB62D4A0191CB66B1@dlee02.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com>
 <87iqin296h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57063 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbZFWJzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 05:55:11 -0400
In-Reply-To: <87iqin296h.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

Kevin, 

> -----Original Message-----
> From: Kevin Hilman
>
> "Sonasath, Moiz" <m-sonasath@ti.com> writes:
> 
> > This patch includes the workarround for I2C Errata 1.153: 
[...]

> > +static int omap_i2c_wait_for_xudf(struct omap_i2c_dev *dev)
> > +{
> > +	u16 xudf;
> > +	int counter = 500;
> > +
> > +	/* We are in interrupt context. Wait for XUDF for max 7 msec */
> 
> What does being in interrupt context have to do with how long you
> wait?  Threaded interrupts are now in mainline and will become the
> default, so this ISR may run in thread context.

The interrupt context comment was meant to say that we can't sleep. Perhaps, with threaded interrupts that might not be true (I am not sure). We can remove the interrupt context comment.


> > @@ -647,7 +679,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
> >  	while ((stat = (omap_i2c_read_reg(dev, 
> OMAP_I2C_STAT_REG))) & bits) {
> >  		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
> >  		if (count++ == 100) {
> > -			dev_warn(dev->dev, "Too much work in 
> one IRQ\n");
> > +			dev_dbg(dev->dev, "Too much work in one IRQ\n");
> 
> Should stay as dev_warn I think.
> 

When I2C is used to transfer a large number of bytes continuously (e.g. during some camera sensor firmware update), we hit the max count more often now (because of the delay introduced by the workaround implementation). In this case, its undesirable to see the dev_warn messages fill up the console. Changing this to dev_dbg means that this message is not printed in the expected case.


Regards,
Nishant
