From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Wed, 9 Apr 2008 14:02:56 +0300
Message-ID: <20080409110256.GA23681@intune.research.nokia.com>
References: <1207735765-1356-1-git-send-email-felipe.balbi@nokia.com> <1207735765-1356-2-git-send-email-felipe.balbi@nokia.com> <a0580c510804090354m1c01cd60h86d1664390e0606d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55682 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbYDILCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 07:02:03 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510804090354m1c01cd60h86d1664390e0606d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Eduardo Valentin <edubezval@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 09, 2008 at 01:54:16PM +0300, ext Eduardo Valentin wrote:
> ERROR: do not initialise statics to 0 or NULL
> WARNING: braces {} are not necessary for single statement blocks

Yeah, these should be fixed.

> WARNING: consider using strict_strtoul in preference to simple_strtoul
> WARNING: consider using strict_strtoul in preference to simple_strtoul

I don't even know what strict_strtoul is, but okay.

> WARNING: line over 80 characters
> WARNING: do not add new typedefs

Sure.

> daniel.diff has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
>=20
> I'd suggest using some #defines for lots for magic numbers in this code.

'lots'? The only ones I can see are the magic constant needed for reset
(used in one place and commented), and the default/max values for
debounce/active time, and max x/y, both of which are again only used in
a single place.

Cheers,
Daniel

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/KJg68xJuWtYYdURAlUQAKCGvDHvm1DvmmIavnztgedxQj8pfACfVaEJ
GMOOUOVCzTEm7ULxwz5PE/Q=
=U9pC
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
