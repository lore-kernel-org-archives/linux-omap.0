From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
 errata 1.153
Date: Tue, 23 Jun 2009 05:05:05 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0115F50ECB@dlee02.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com>
 <87iqin296h.fsf@deeprootsystems.com>
 <DFEF307E035C8647B119E6A60DB62D4A0191CB66B1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55677 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602AbZFWKFK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 06:05:10 -0400
In-Reply-To: <DFEF307E035C8647B119E6A60DB62D4A0191CB66B1@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamat, Nishant" <nskamat@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kamat, Nishant
> Sent: Tuesday, June 23, 2009 12:55 PM
> 
> > > @@ -647,7 +679,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
> > >  	while ((stat = (omap_i2c_read_reg(dev,
> > OMAP_I2C_STAT_REG))) & bits) {
> > >  		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
> > >  		if (count++ == 100) {
> > > -			dev_warn(dev->dev, "Too much work in
> > one IRQ\n");
> > > +			dev_dbg(dev->dev, "Too much work in one IRQ\n");
> >
> > Should stay as dev_warn I think.
> >
> 
> When I2C is used to transfer a large number of bytes continuously (e.g.
> during some camera sensor firmware update), we hit the max count more
> often now (because of the delay introduced by the workaround
> implementation). In this case, its undesirable to see the dev_warn
> messages fill up the console. Changing this to dev_dbg means that this
> message is not printed in the expected case.
Just wondering on this -> cant I do a multibyte write upto 255 bytes? Is count==100 not enough given that we used buffered writes? The real question is this:
Are devices expected to trigger retry logic to the extent where the error condition is triggered?

I think this might be an indication of something else being at fault with the sensor /configuration of sensor - hiding the error messages by moving warn->dbg is not correct IMHO.

Regards,
Nishanth Menon
