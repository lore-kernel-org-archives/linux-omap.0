From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Mon, 12 Jan 2009 08:31:26 +0200
Message-ID: <20090112063125.GC4968@atomide.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090110155612.GA2601@sortiz.org> <200901101249.27129.david-b@pacbell.net> <20090111000147.GB2683@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51460 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbZALGbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 01:31:32 -0500
Content-Disposition: inline
In-Reply-To: <20090111000147.GB2683@sortiz.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Samuel Ortiz <sameo@openedhand.com> [090111 01:59]:
> On Sat, Jan 10, 2009 at 12:49:26PM -0800, David Brownell wrote:
> > On Saturday 10 January 2009, Samuel Ortiz wrote:
> > > > --- a/drivers/mfd/twl4030-core.c
> > > > +++ b/drivers/mfd/twl4030-core.c
> > > > @@ -38,6 +38,7 @@
> > > > =A0#include <linux/i2c.h>
> > > > =A0#include <linux/i2c/twl4030.h>
> > > > =A0
> > > > +#include <mach/cpu.h>
> > > That will break the build on !ARM for this driver.
> >=20
> > What needs to happen with twl4030-core.c is IMO this:
> >=20
> >  - Near term:
> >      * revert 6354ab5c63bc986bf539026a1b289cc142f6e87c
> >        and just make the driver depend on HAVE_CLK
> Yep, I'll do that afer the merge window.
>=20
> >      * #ifdef CONFIG_ARM do the #include <mach/cpu.h>
> Not too pretty, but a good enough compromise for me.
> I'll push that.

Thanks! I'll rework the other omap build fixes today.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
