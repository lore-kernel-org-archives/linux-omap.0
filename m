From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: New build warnings
Date: Mon, 10 Sep 2012 09:05:47 +0200
Message-ID: <20120910070547.GX28643@pengutronix.de>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk>
 <20120908083849.GA1603@n2100.arm.linux.org.uk>
 <20120909191240.GV28643@pengutronix.de>
 <20120909233333.GA15911@opensource.wolfsonmicro.com>
 <20120910064002.GW28643@pengutronix.de>
 <20120910064236.GB8482@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49306 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2IJHFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 03:05:49 -0400
Content-Disposition: inline
In-Reply-To: <20120910064236.GB8482@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Arnd Bergmann <arnd@arndb.de>

On Mon, Sep 10, 2012 at 02:42:37PM +0800, Mark Brown wrote:
> On Mon, Sep 10, 2012 at 08:40:02AM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> > Message-id: 201208141241.51379.arnd@arndb.de
>=20
> This is illegible, did the message have a subject line or other conte=
nt
> that a human might understand?  Just as with commit IDs you should
> *always* provide a human readable version, message IDs are even worse
> than commit IDs in this respect.
The full headers are:

Date: Tue, 14 Aug 2012 12:41:50 +0000
=46rom: Arnd Bergmann <arnd@arndb.de>
To: Axel Lin <axel.lin@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Rajendra Nayak <r=
nayak@ti.com>, Tero Kristo <t-kristo@ti.com>, Uwe  Kleine-K=F6nig <u.kl=
eine-koenig@pengutronix.de>=20
Subject: [PATCH] regulator: twl: make twl_info tables const
Message-Id: <201208141241.51379.arnd@arndb.de>

It used to be possible to get a posting by message id via:

	http://mid.gmane.org/201208141241.51379.arnd@arndb.de

but as this message was not send to a mailing list this doesn't work
here and even for public mails this failed most of the time for me in
the past.

Other than that in Mutt you can search using

	~i 201208141241.51379.arnd@arndb.de

as search string, for notmuch it's

	id:201208141241.51379.arnd@arndb.de

=2E

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
