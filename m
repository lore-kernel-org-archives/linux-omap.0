From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Tue, 17 Jul 2012 11:08:48 +0100
Message-ID: <WC20120717100848.280191@terrafix.co.uk>
References: <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com> <WC20120712144308.86003F@terrafix.co.uk> <alpine.DEB.2.00.1207121334150.25585@utopia.booyaka.com> <WC20120713105737.0900A2@terrafix.co.uk> <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com> <20120717004010.GA6612@animalcreek.com> <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:57744 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755184Ab2GQKJi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 06:09:38 -0400
In-Reply-To: <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

-----Original Message-----
From: Paul Walmsley <paul@pwsan.com>
To: Joe Woodward <jw@terrafix.co.uk>, "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org
Date: Mon, 16 Jul 2012 18:43:15 -0600 (MDT)
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?

> On Mon, 16 Jul 2012, Mark A. Greer wrote:
> 
> > I'm finally getting around to this...  Unfortunately, I don't have
> the
> > hardware to test it so I can't tell exactly what code needs to run to
> make
> > it work again.   Would you mind identifying the pieces of code need
> to run
> > for it to work?  omap3_has_iva() shows up in just a few places.
> 
> We did a test by removing the two instances in pm34xx.c.  I'm pretty
> sure 
> that the IVAGRPSEL writes are necessary, since the reset values for
> those 
> bits are 1, and those definitely need to be cleared.  Not sure about
> the 
> omap3_iva_idle() call; Joe, maybe you can try with just the first hunk
> of 
> the patch that I sent?

The patch you sent is basically in two halves:
  - the writes to the registers
  - the calling of omap3_iva_idle().

If I patch only the writes to the registers then suspend still fails.
If I patch only the calling of omap3_iva_idle() then suspend works.
If I patch both the writes to the registers and the calling of omap3_iva_idle() then suspend works.

Cheers,
Joe

> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


