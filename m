From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 09:54:27 +0200
Message-ID: <1236844467.6478.103.camel@kauppi-desktop>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>
	 <20090310005222.GE19758@fluff.org.uk>
	 <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
	 <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>
	 <1236839178.6478.40.camel@kauppi-desktop>
	 <alpine.DEB.2.00.0903120041020.26959@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40512 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbZCLHzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 03:55:37 -0400
In-Reply-To: <alpine.DEB.2.00.0903120041020.26959@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Ben Dooks <ben@fluff.org.uk>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 2009-03-12 at 07:46 +0100, ext Paul Walmsley wrote:
> Hello Ari,
> 
> On Thu, 12 Mar 2009, Kauppi Ari (EXT-Ixonos/Oulu) wrote:
> 
> > I was seeing some Spurious irq's for the I2C1 (IRQ 56).
> > 
> > I'm aware of flushing posted write and the very first thing I tried was
> > to use read-after-write for OMAP_I2C_STAT_REG (in all applicable
> > places). However, it didn't make any difference.
> 
> Strange.

I agree.

> > Applying Richard Woodruff's patch (mentioned earlier in thread) that
> > disables dev->b_hw hack for 3430 (STT/STP bits written together) and
> > double clears ARDY fixed the spurious IRQ issues for I2C1.
> > 
> > However, with the STT/STP+ARDY patch I was seeing Spurious interrupts
> > all over the place and the IRQF_DISABLED in i2c-omap seemed to tame them
> > quite well. I do agree that my approach might not be the proper one in
> > long term.
> 
> Could you clarify this?  Do Richard's patches fix the spurious IRQs, or 
> cause spurious interrupts to appear?

My process was:

1) Take 2.6.28-based kernel on custom OMAP3430ES3.0 hardware with
CONFIG_DEBUG_LOCKDEP enabled. There are no spurious interrupts and
everything works.

2) Disable CONFIG_DEBUG_LOCKDEP and all other kernel debugging options.
Spurious interrupts start to appear on several IRQs, especially with IRQ
56 (I2C1).

3) Apply Richard's patch. All spurious interrupts for IRQ 56 are gone
but frequency of others increase.

4) Set IRQF_DISABLED in i2c-omap and the frequency of other spurious
interrupts decreases considerably. However, I'm starting to realize that
the real problem is probably elsewhere.

My test setup is pretty systematic, it does not have any user
interaction in it. I have a relay controlling the power to the device
and have taken logs of about 12000 boots with different kernel options
and patches applied.

Best regards,

--
Ari

