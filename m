From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Mon, 16 Jul 2012 18:43:15 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com>
References: <WC20120712081507.600002@terrafix.co.uk> <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com> <WC20120712144308.86003F@terrafix.co.uk> <alpine.DEB.2.00.1207121334150.25585@utopia.booyaka.com> <WC20120713105737.0900A2@terrafix.co.uk>
 <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com> <20120717004010.GA6612@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54324 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab2GQAnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 20:43:16 -0400
In-Reply-To: <20120717004010.GA6612@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Mon, 16 Jul 2012, Mark A. Greer wrote:

> I'm finally getting around to this...  Unfortunately, I don't have the
> hardware to test it so I can't tell exactly what code needs to run to make
> it work again.   Would you mind identifying the pieces of code need to run
> for it to work?  omap3_has_iva() shows up in just a few places.

We did a test by removing the two instances in pm34xx.c.  I'm pretty sure 
that the IVAGRPSEL writes are necessary, since the reset values for those 
bits are 1, and those definitely need to be cleared.  Not sure about the 
omap3_iva_idle() call; Joe, maybe you can try with just the first hunk of 
the patch that I sent?


- Paul
