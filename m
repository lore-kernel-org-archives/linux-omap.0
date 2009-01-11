From: Samuel Ortiz <sameo@openedhand.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Sun, 11 Jan 2009 01:01:48 +0100
Message-ID: <20090111000147.GB2683@sortiz.org>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090110155612.GA2601@sortiz.org> <200901101249.27129.david-b@pacbell.net>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:50978 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbZAJX7P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2009 18:59:15 -0500
Content-Disposition: inline
In-Reply-To: <200901101249.27129.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Sat, Jan 10, 2009 at 12:49:26PM -0800, David Brownell wrote:
> On Saturday 10 January 2009, Samuel Ortiz wrote:
> > > --- a/drivers/mfd/twl4030-core.c
> > > +++ b/drivers/mfd/twl4030-core.c
> > > @@ -38,6 +38,7 @@
> > > =A0#include <linux/i2c.h>
> > > =A0#include <linux/i2c/twl4030.h>
> > > =A0
> > > +#include <mach/cpu.h>
> > That will break the build on !ARM for this driver.
>=20
> What needs to happen with twl4030-core.c is IMO this:
>=20
>  - Near term:
>      * revert 6354ab5c63bc986bf539026a1b289cc142f6e87c
>        and just make the driver depend on HAVE_CLK
Yep, I'll do that afer the merge window.

>      * #ifdef CONFIG_ARM do the #include <mach/cpu.h>
Not too pretty, but a good enough compromise for me.
I'll push that.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
