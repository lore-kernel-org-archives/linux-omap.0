From: Tony Lindgren <tony@atomide.com>
Subject: Re: TWL4030 intermittent freakout on boot
Date: Thu, 8 May 2008 11:42:59 -0700
Message-ID: <20080508184258.GF24454@atomide.com>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com> <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl> <20080508182807.GE24454@atomide.com> <alpine.DEB.1.00.0805081229440.27986@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53936 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765489AbYEHSnC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 14:43:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805081229440.27986@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, peter.de-schrijver@nokia.com, Beagle Board <beagleboard@googlegroups.com>

* Paul Walmsley <paul@pwsan.com> [080508 11:33]:
> On Thu, 8 May 2008, Tony Lindgren wrote:
> 
> > This also looks similar to the earlier twl4030 hangs where access
> > to some domains caused twl4030 to hang. If twl4030 hangs, there's
> > no way to reset it as all control is over I2C. When twl4030 hangs,
> > bootloader won't be able to detect the chip either unless devices
> > is power cycled (and USB cable detached).
> > 
> > The reason earlier was that twl4030 internal clock was not being
> > programmed properly, and was fixed by patch
> > 0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d.
> > 
> > Maybe there's some twl4030 register access going on before the
> > internal clock is programmed properly?
> 
> IRQ 56 is the TWL4030 I2C1 IRQ.  Seems strange that there would be no 
> handler for it after i2c_omap has initialized...

Well if the I2C register access hangs, nothing will be able to reset
the twl4030 interrupt registers when an interrupt happens.

Tony
