From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 03:58:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903120356230.26959@utopia.booyaka.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>  <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>  <20090310005222.GE19758@fluff.org.uk>  <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
 <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>  <1236839178.6478.40.camel@kauppi-desktop>  <alpine.DEB.2.00.0903120041020.26959@utopia.booyaka.com> <1236844467.6478.103.camel@kauppi-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51049 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZCLJ6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 05:58:25 -0400
In-Reply-To: <1236844467.6478.103.camel@kauppi-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Cc: Ben Dooks <ben@fluff.org.uk>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 12 Mar 2009, Kauppi Ari (EXT-Ixonos/Oulu) wrote:

> My process was:
> 
> 1) Take 2.6.28-based kernel on custom OMAP3430ES3.0 hardware with
> CONFIG_DEBUG_LOCKDEP enabled. There are no spurious interrupts and
> everything works.
> 
> 2) Disable CONFIG_DEBUG_LOCKDEP and all other kernel debugging options.
> Spurious interrupts start to appear on several IRQs, especially with IRQ
> 56 (I2C1).
> 
> 3) Apply Richard's patch. All spurious interrupts for IRQ 56 are gone
> but frequency of others increase.
> 
> 4) Set IRQF_DISABLED in i2c-omap and the frequency of other spurious
> interrupts decreases considerably. However, I'm starting to realize that
> the real problem is probably elsewhere.
> 
> My test setup is pretty systematic, it does not have any user
> interaction in it. I have a relay controlling the power to the device
> and have taken logs of about 12000 boots with different kernel options
> and patches applied.

Thanks for the details.  Can you extract the list of spurious IRQ warnings 
that you're getting, and post them?  I suspect that, like I2C, many of the 
driver ISRs are not reading back the device interrupt status registers 
after they clear them.


- Paul
