From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Wed, 9 Apr 2008 23:35:26 +0300
Message-ID: <20080409203526.GY3842@intune.research.nokia.com>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com> <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com> <20080409121124.GS7338@gandalf.research.nokia.com> <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com> <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51450 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbYDIUeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 16:34:14 -0400
Content-Disposition: inline
In-Reply-To: <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: andrzej zaborowski <balrogg@gmail.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2008 at 09:05:58PM +0300, ext Felipe Balbi wrote:
> On Wed, Apr 09, 2008 at 07:26:31PM +0200, andrzej zaborowski wrote:
> > Question not really related to this patchset, but in the TSC2005
> > driver some averaging and limit checks are done to the ADC values.
> > Shouldn't that be done in userspace instead?  (The ADS784x and TSC2301
> > drivers do the same evidently.)
>=20
> Now that's not really up to me, but if we move it now it probably won't
> provide the feature n810 needs. I mean, n810 is designed on top of the
> features provided by driver, the application probably expects the driver
> to do the averaging and limit checks so at least for tsc2005 I think
> it's not a good idea to change due to application requirements.

It's specific to the device (and device _build_): the actual
touchscreen, and how it's working in the device, so a combination of LCD
driver and board files sounds best to me.

Cheers,
Daniel

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/SiO68xJuWtYYdURAi4+AKCZ6A+KIEg1Z5AHmy/wvOEYhbf+ZwCgm4ib
jSzP+hlyJiXzzAQqdwNZT3o=
=/7lG
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
