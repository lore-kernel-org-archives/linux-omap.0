From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: New build warnings
Date: Sun, 9 Sep 2012 21:12:40 +0200
Message-ID: <20120909191240.GV28643@pengutronix.de>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk>
 <20120908083849.GA1603@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43310 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2IITMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Sep 2012 15:12:43 -0400
Content-Disposition: inline
In-Reply-To: <20120908083849.GA1603@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>

On Sat, Sep 08, 2012 at 09:38:49AM +0100, Russell King - ARM Linux wrot=
e:
> On Mon, Jul 30, 2012 at 05:44:44PM +0100, Russell King - ARM Linux wr=
ote:
> > Okay, so last night's build run shows some new warnings...
> >=20
> > drivers/regulator/twl-regulator.c: In function 'twlreg_probe':
> > drivers/regulator/twl-regulator.c:1151: warning: assignment discard=
s qualifiers from pointer target type
> > drivers/regulator/twl-regulator.c:1160: warning: assignment discard=
s qualifiers from pointer target type
> >=20
> > These two look like missing const - looks like they were introduced=
 by:
> >=20
> > commit 98d7bbb9929bcc14e11ac8a55245a4f2dc174e17
> > Author: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Date:   Thu Jun 7 12:20:14 2012 +0200
> >=20
> >     of: add const to struct *of_device_id.data
> >=20
> >     Drivers should never need to modify the data of a device id. So=
 it can
> >     be const which in turn allows more consts in the driver.
> >=20
> >     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.=
de>
>=20
> I notice this one is still present in the kernel.  Uwe, what's happen=
ing
> with it?
Yeah, the warning was introduced by my patch. It's not trivial to fix
because the twl-regulator driver modifies the data used to probe device=
s
during probe. That is the result of two probes might depend on their
order. I mentioned that problem in the cover letter of my series but go=
t
no feedback from someone feeling responsible for this driver.
Arnd sent a patch for that problem, don't know its state though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
