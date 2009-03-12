From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 08:26:18 +0200
Message-ID: <1236839178.6478.40.camel@kauppi-desktop>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <20090310005222.GE19758@fluff.org.uk>
	 <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
	 <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33953 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbZCLG1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 02:27:33 -0400
In-Reply-To: <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Ben Dooks <ben@fluff.org.uk>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 2009-03-12 at 01:04 +0100, ext Paul Walmsley wrote:
Hi Paul,

> On Wed, 11 Mar 2009, Paul Walmsley wrote:
> 
> > > On Fri, Mar 06, 2009 at 03:34:54PM +0200, Ari Kauppi wrote:
> > > > I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
> > > > (and thus LOCKDEP) are disabled.
> > 
> > Ari, are you seeing "Spurious irq XX: XXXXXXXX, please flush posted write 
> > for irq" messages?  If so, the correct fix for this is to read from the 
> > device interrupt status register immediately after writing to it.  This 
> > forces the ARM to wait until the write to the device is complete.  Ari, 
> > could you make this change to i2c-omap.c:omap_i2c_isr() instead, and test 
> > whether this fixes the problem?
> > 
> > + u32 tmp;
> > 
> > ...
> > 
> >   omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
> > + tmp = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG); /* OCP barrier */
> 
> You'll also want to make a similar change in omap_i2c_ack_stat(), to add a 
> read immediately after that write.

I was seeing some Spurious irq's for the I2C1 (IRQ 56).

I'm aware of flushing posted write and the very first thing I tried was
to use read-after-write for OMAP_I2C_STAT_REG (in all applicable
places). However, it didn't make any difference.

Applying Richard Woodruff's patch (mentioned earlier in thread) that
disables dev->b_hw hack for 3430 (STT/STP bits written together) and
double clears ARDY fixed the spurious IRQ issues for I2C1.

However, with the STT/STP+ARDY patch I was seeing Spurious interrupts
all over the place and the IRQF_DISABLED in i2c-omap seemed to tame them
quite well. I do agree that my approach might not be the proper one in
long term.

Best regards,

--
Ari

