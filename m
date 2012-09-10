From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: New build warnings
Date: Mon, 10 Sep 2012 08:40:02 +0200
Message-ID: <20120910064002.GW28643@pengutronix.de>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk>
 <20120908083849.GA1603@n2100.arm.linux.org.uk>
 <20120909191240.GV28643@pengutronix.de>
 <20120909233333.GA15911@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49605 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab2IJGkF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 02:40:05 -0400
Content-Disposition: inline
In-Reply-To: <20120909233333.GA15911@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Arnd Bergmann <arnd@arndb.de>

Hi Mark,

On Mon, Sep 10, 2012 at 07:33:34AM +0800, Mark Brown wrote:
> On Sun, Sep 09, 2012 at 09:12:40PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Sat, Sep 08, 2012 at 09:38:49AM +0100, Russell King - ARM Linux =
wrote:
>=20
> > > >     of: add const to struct *of_device_id.data
> > > >=20
> > > >     Drivers should never need to modify the data of a device id=
=2E So it can
> > > >     be const which in turn allows more consts in the driver.
>=20
> > > I notice this one is still present in the kernel.  Uwe, what's ha=
ppening
> > > with it?
>=20
> > Yeah, the warning was introduced by my patch. It's not trivial to f=
ix
> > because the twl-regulator driver modifies the data used to probe de=
vices
> > during probe. That is the result of two probes might depend on thei=
r
> > order. I mentioned that problem in the cover letter of my series bu=
t got
> > no feedback from someone feeling responsible for this driver.
> > Arnd sent a patch for that problem, don't know its state though.
>=20
> I don't recall such a patch being sent to me.  The twl-regulator driv=
er
> is unmaintained so it's unlikely anyone is going to actively work on =
it.
Message-id: 201208141241.51379.arnd@arndb.de

Mark, you even replied that you applied it!? It wasn't sent to a mailin=
g
list though.

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
