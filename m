From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/5] arm: omap: don't forcefully runtime
 suspend a device
Date: Thu, 18 Oct 2012 20:05:50 +0300
Message-ID: <20121018170550.GA6641@arwen.pp.htv.fi>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-3-git-send-email-balbi@ti.com>
 <87fw5bg1f7.fsf@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47840 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932391Ab2JRRLY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:11:24 -0400
Content-Disposition: inline
In-Reply-To: <87fw5bg1f7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 10:01:00AM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > device drivers should be smart enough to provide
> > ->suspend/->resume callbacks when needed and they
> > should take care of doing whatever needs to be
> > done in order to allow a device to be suspended.
> >
> > Calling pm_runtime_* from system suspend isn't
> > the right way to achieve that, as it creates a
> > situation where OMAP's PM has different requirements
> > and semantics than all other architectures.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> NAK
>=20
> This support is required to handle some restrictions placed on runtime
> PM and system PM interactions.   Basically, runtime PM transitions are
> disabled part way through system PM (that itself was a much debated
> topic last year, but that's how it works today.)
>=20
> Because of this limitation, drivers that are active during the suspend
> phase (commonly becasue they are used by [late] suspend methods of other
> devices) may have multiple runtime PM transitions during static
> suspend/resume.  These drivers have the problem that after runtime PM
> has been disabled, even when they pm_runtime_put*, they will not
> actually be transitioned (and their runtime PM callbacks will not be
> called.)
>=20
> So these devices are in a "ready to runtime suspend" state, but they
> will not transition because runtime PM is disabled.
>=20
> After your patch, they will still be idled (omap_device_idle), but the
> driver will have no notification that this has happened because you
> removed the calling of the runtime PM callbacks.

to me this only seems like the driver misses some static PM callbacks
and some pm_runtime_disable; pm_runtime_set_active; pm_runtime_enable;
on their system resume methods.

> In the changelog, you seem to be implying that anything the driver
> should be doing should be done in its suspend/resume callbacks instead
> of the runtime suspend/resume callbacks (but don't give your reasoning.)

that's not what I implied at all. What I imply is that if driver needs
to do something during system suspend/resume, then it needs to implement
those methods. Calling runtime_* methods from system PM looks like a
workaround for incomplete drivers.

> Using the current approach (which was actually suggested by Rafael), it
> means many transiactional drivers (like I2C) can be implemented as
> runtime PM only, and don't need to provide suspend/resume callbacks at

to me that sounds bogus :-s what's the problem of using the same
function for system suspend and runtime suspend ? (see the last patch of
the series where I implement I2C system suspend and resume)

> all.  It also means they can be used throughout the suspend/resume path
> (well until noirq methods.)

fair enough...

> The approach in $SUBJECT patch would mean that drivers should not be
> used after their suspend method has been called.  That places some
> severe limitations on drivers like I2C, SPI, HSI, UART etc. that are
> often used by the suspend/resume methods of other drivers.

I can't see the limitation you talk about. Let's use I2C as an example.
In order to suspend RTC we need I2C resume, but driver core guarantees
that parent will only suspend after all children are suspended. If
that's as far as _noirq, then I2C needs to implement _noirq callbacks.

I don't see the issue because RTC is a child of I2C and will suspend
before its parent. No ?

--=20
balbi

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgDbtAAoJEIaOsuA1yqREdKcP/iTtkvovOtLEQEnya+xBWuaS
T+6iGEzG0cu3SprcFGigt1t4jAR8zWVgFsCTdRvpB8cTIrYoe/NxAHWuV4NQG4Gn
T4Q+Nv6225qx91HtABXdflHouWcmIOPkSIhe0X1rUcA51PgP3RXaHMoO0GzZ2FFP
I2u9kmYLZwYd8ZXDWH51WI3N58xgAfKrEFM6p86kv3gwYX51qfibOGBeTxgaLfs8
IYa9KmkBf+ix/FEY3RfuvPYjrI7FIVbcKAzVg5+6Uuh1TCWaaxwUBAj5X6yxptkl
J1s5ZXO8w/aYEGHQMyrwaT7XnRzC4fZ9Z77w6hEOzDXPXMk9HMP2RlOswTqwIK3f
p6SSZJdOWCFsoPsOQzrZlxIevhkMyLJ1tFIlIYPWd2nRNWRruK6SQlwGN8rqJZvu
uzNSDRFGjltcFp3uOwAJFS+XgV+AAaPRF8pG3fB++cPiljRjg0V8zTripDoHUASC
cuHSA+lCTnYIIpzwwwAUa9eBhyITninW6yeksLAlxVPzN1kBPUCQ9FyPnqXfVx+e
PFgqH3VFY0Cws1fNdL46muypcYqae2fm3xUau7Ji/k5GdBHp/Z+iD6qQl4j0sZjK
KH0iqzi/FzcfBXtZSZuchFIeeTgnjqLD/u7WiPK7nFbxVvukEdsLoRlEL18UMeDE
WHOPgWaJBuFi0ug+PCvU
=bCpI
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
