From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Sat, 10 Jan 2009 12:49:26 -0800
Message-ID: <200901101249.27129.david-b@pacbell.net>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090110155612.GA2601@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:39295 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755016AbZAJVV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2009 16:21:29 -0500
In-Reply-To: <20090110155612.GA2601@sortiz.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Saturday 10 January 2009, Samuel Ortiz wrote:
> > --- a/drivers/mfd/twl4030-core.c
> > +++ b/drivers/mfd/twl4030-core.c
> > @@ -38,6 +38,7 @@
> > =A0#include <linux/i2c.h>
> > =A0#include <linux/i2c/twl4030.h>
> > =A0
> > +#include <mach/cpu.h>
> That will break the build on !ARM for this driver.

What needs to happen with twl4030-core.c is IMO this:

 - Near term:
     * revert 6354ab5c63bc986bf539026a1b289cc142f6e87c
       and just make the driver depend on HAVE_CLK
     * #ifdef CONFIG_ARM do the #include <mach/cpu.h>

 - Longer term:
     * get rid of that remaining OMAP dependency
       somehow (RMK's comment is the right direction,
       but insufficient).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
