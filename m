From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Thu, 10 Apr 2008 03:12:24 +0300
Message-ID: <20080410001224.GD5897@intune.research.nokia.com>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com> <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com> <20080409121124.GS7338@gandalf.research.nokia.com> <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com> <20080409180557.GA15913@kedavra.cpe.vivax.com.br> <20080409182804.GB24100@pure.research.nokia.com> <fb249edb0804091658i4574e760ye2d6979d9a834d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39569 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbYDJALA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 20:11:00 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0804091658i4574e760ye2d6979d9a834d5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext andrzej zaborowski <balrogg@gmail.com>
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>, ext Felipe Balbi <me@felipebalbi.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2008 at 01:58:51AM +0200, ext andrzej zaborowski wrote:
> On 09/04/2008, Lauri Leukkunen <lauri.leukkunen@nokia.com> wrote:
> > In my opinion kernel should provide "correct" data to user-space, not
> >  some pseudo-random interference from the LCD.
>=20
> I think this is discutible.  There's a number of userspace libraries
> written to talk tightly to the kernel and make that data more
> "correct", one of them is tslib.  Distros that come with tslib often
> have a set of device-specific config files for tslib which load tslib
> plugins for things like averaging, smoothing, checking bounds on the
> values.
>=20
> One of the arguments for doing that in userspace is that of avoiding
> every touchscreen driver redoing the same averaging and/or limit
> checking code.  I agree thought that it may be better to sacrifice
> that for performance.

If everyone's doing the same thing, move it to drivers/input/, not to
userspace.  Why should we be forced to have _two_ drivers and
essentially maintain a stable kernel/userspace ABI between them? Surely
it's better to only have _one_ hardware-specific driver, rather than
half in the kernel, and half hidden behind an abstraction layer that is
meant to let you just deal with input events without knowing stupid
details about the hardware?

I don't see any coherent argument for it being in tslib.

Cheers,
Daniel

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/Vto68xJuWtYYdURArdXAJ40fOnI5oPuNrSQvM9PkhKWhbbMpwCgiSMy
QY7qZwiJfxXiQYseU1XjREo=
=bqqu
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
