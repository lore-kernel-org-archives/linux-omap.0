From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch twl 1/2] remove <linux/i2c/twl4030-rtc.h>
Date: Tue, 7 Oct 2008 11:03:47 +0300
Message-ID: <20081007080346.GD21037@atomide.com>
References: <200810012342.50866.david-b@pacbell.net> <87hc7pvkj9.fsf@deeprootsystems.com> <200810060939.45259.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56687 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYJGIAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 04:00:50 -0400
Content-Disposition: inline
In-Reply-To: <200810060939.45259.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081006 19:39]:
> On Monday 06 October 2008, Kevin Hilman wrote:
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -40,7 +40,6 @@
> > =A0#include <mach/keypad.h>
> > =A0#include <mach/dma.h>
> > =A0#include <mach/gpmc.h>
> > -#include <linux/i2c/twl4030-rtc.h>
> > =A0
> > =A0#include <asm/io.h>
> > =A0#include <asm/delay.h>
>=20
> Good catch -- my bad. =20

Pushing.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
