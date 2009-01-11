From: David Brownell <david-b@pacbell.net>
Subject: Re: Spurious interrupt warning
Date: Sun, 11 Jan 2009 01:04:25 -0800
Message-ID: <200901110104.25312.david-b@pacbell.net>
References: <20090106110837.GG9752@atomide.com> <20090107171313.GA17855@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D48171F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:33518 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750998AbZAKJE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Jan 2009 04:04:27 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D48171F@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 07 January 2009, Woodruff, Richard wrote:
> I don't mind using a read back dependency. =A0I don't like it but
> that may be necessary in some cases for a given device.=20
>=20
> What I don't like is constantly hitting them and getting a broken
> system. How many of these are out there? =A0If we can remove most
> of them in current software with SO then that isn't a bad tradeoff. =20

The same issue comes up with PCI drivers though ... and there,
it's routinely accepted that critical paths in (some) drivers
need to issue readbacks to flush the relevant posted writes.
That's *especially* true in IRQ paths, and when DMA engines
update state in shared memory.

Which says to me that grumbling about strongly ordered regions
is more of a developer discipline/training problem than any
kind of real technical issue.  Not unlike how to do locking
right; or satisfy coding style guidelines; or follow correct
procedures to merge patches; or synchronize between several
execution contexts; or ... lots of other things that waste
time when folk don't bother doing them right at first.

Good drivers are not easy to do, and this is just one of the
many ways that shows up.  Fortunately *this* class of problem
tends to be easy to address by a careful code audit.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
